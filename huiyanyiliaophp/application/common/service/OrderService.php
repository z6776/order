<?php

namespace app\common\service;
use app\admin\model\hyyl\Family;
use app\admin\model\hyyl\Hospital as HospitalModel;
use app\admin\model\hyyl\Order;
use app\admin\model\hyyl\Order as OrderModel;
use app\admin\model\hyyl\Viplevel as ViplevelModel;
use app\admin\model\hyyl\Viporder as ViporderModel;
use app\admin\model\User as UserModel;
use app\admin\model\hyyl\Family as FamilyModel;
use fast\Random;
use think\Db;
use function fast\e;
use app\admin\model\order\Order as OrderNewModel;
use app\admin\model\goods\Dish as DishModel;
class OrderService
{
    /**
     * 发布信息
     * @return void
     */
    public static function addorder($uid,$params)
    {
        $params['visit_time'] = strtotime($params['visit_time']);
        $params['user_id'] = $uid;
        $params['status'] = OrderModel::STATUS_DAIJIEDAN;
        return (new Order())->save($params);
    }

   // 计算订单金额
    public function calculateOrderAmount($goodIds)
    {
        $order = DishModel::with('items')->find($goodIds);
        // 1. 计算小计
        $subtotal = $order->items->sum(function ($item){
            return $item->price * $item->quantity;
        });
        //
        return $subtotal;
    }

    /**
     * 创建订单
     * @return \app\api\controller\Order
     */
    public static function createOrder(array $data){
        $order = [
            "order_no"=>Random::alnum(8).time(),
            "user_id"=>$data["userId"],
            "dining_type"=>$data["dingType"],
        ];
        if($order["dining_type"]==OrderNewModel::DINING_TYPE_TS){
            $order['table_no'] = $data["table_no"];
        }
        if($order["dining_type"]==OrderNewModel::DINING_TYPE_ZQ){
            $order['takeaway_code'] =  Random::alnum(8).time();
        }
        $goods =  json_decode($data["goods"],true);
        $order["total_amount"] = self::calculateOrderAmount($goods);
        $order["status"] = OrderNewModel::Tobepaid;
        $order["remark"] = $data["remark"];
        $order["created_at"] = time();
        DB::startTrans();
        try {
         $order = OrderNewModel::create($order);
            DB::commit();
           return $order;
        }catch(\Exception $exception){
            DB::rollback();
            throw $exception;
        }

    }




    /**
     * 我的订单
     * @param $uid
     * @param $status
     * @param $page
     * @param $pagesize
     * @return void
     */
    public static function getorderlist($uid,$status,$pages)
    {
        //获取他们的订单,和本人的订单
//        return OrderModel::with(['family','hospital']
//            ->where(function ($query) use ($uid,$status){
//                $query->where('user_id',$uid);
//                if(empty($status)){
//                    $query->where('status',$status);
//                }
//            })->order('order.'.$pages[0], $pages[1])//排序
//            ->page($pages[4], $pages[3])
//            ->select();
    }

    /**
     * 订单详情
     * @param $id
     * @return void
     */
    public static function getorderbyid($id)
    {
        $order = OrderModel::where('order.id',$id)
            ->field('id,typedata,status,out_trade_no,phone,expert,finishtime,paytime,pay_fee,beddata,depart,visit_time,createtime,total_amount,pay_fee,finishtime')
            ->with(['family'=>function($query){
                $query->withField('name');
            },'hospital'=>function($query){
                $query->withField('name');
            }])
            ->find();
        return $order;
    }

    /**
     * 取消发布订单
     * @param $id
     * @return void
     */
    public static function deleteorder($id)
    {
        $order = OrderModel::get($id);
        //订单是否存在
        if (!isset($order))
        {
            error_stop('订单不存在');
        }
        //订单是否是待接单状态
        if ($order->status != OrderModel::STATUS_DAIJIEDAN)
        {
            error_stop('该订单不能取消');
        }
        $order->status = OrderModel::STATUS_YIQUXIAO;
        $order->save();
        return $order;
    }
    /**
     * 管理员接单
     * @param $id
     * @return void
     */
    public static function receivingorder($id)
    {
        $order = OrderModel::get($id);
        //订单是否存在
        if (!isset($order))
        {
            error_stop('订单不存在');
        }
        //订单是否是待接单状态
        if ($order->status != OrderModel::STATUS_DAIJIEDAN)
        {
            error_stop('该订单不能接单');
        }
        $order->status = OrderModel::STATUS_DAIDINGJIA;
        $order->taketime = time();
        $order->save();
        return $order;
    }
    /**
     * 管理员发送服务费
     * @param $id
     * @param $money
     * @return void
     */
    public static function sendservicefee($id,$money)
    {
        $order = OrderModel::get($id);
        //订单是否存在
        if (!isset($order))
        {
            error_stop('订单不存在');
        }
        if (!isset($money))
        {
            error_stop('请输入服务价格');
        }
        //订单是否是待接单状态
        if ($order->status != OrderModel::STATUS_DAIDINGJIA)
        {
            error_stop('订单状态有误');
        };
        $order->pricetime = time();
        $order->status = OrderModel::STATUS_DAIFUKUANG;
        $order->total_amount = $money;
        $order->save();
        return $order;
    }




    /**
     * 创建vip订单
     * @param $user_id
     * @param ordertype
     * @param orderprice
     * @return
     */
    public static function creatviporder($user_id,$id)
    {
        $tc=ViplevelModel::where('id',$id)->where("status",ViplevelModel::STATUS_YES)->find();
        if(empty($tc)){
            error_stop("没有此套餐");
        }
        $order=new ViporderModel();
        $user = UserModel::get($user_id);

        $pay_fee = $tc->yprice;
        if ($user->level != $order->viplevel_id) {
            $yuanlevel = ViplevelModel::get($user->level);
            if($user->level > $order->viplevel_id){
                error_stop("无法降级处理");
            }
            $pay_fee = bcsub($pay_fee,$yuanlevel->yprice,2);
        }
        $data=[
            'createtime'=>time(),
            'status'=>ViporderModel::STATUS_NO,
            'out_trade_no'=>generatecode("V"),
            'user_id'=>$user_id,
            'viplevel_id'=>$id,
            'pay_fee'=>$pay_fee,
            'paytype'=>'wechat'
        ];
        $order->save($data);
        return $order;
    }


}