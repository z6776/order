<?php

namespace app\api\controller;

use app\common\controller\Api;
use app\common\service\OrderService;
use app\admin\model\order\Order as OrderModel;
/**
 *
 */
class Order extends Api
{

    //如果$noNeedLogin为空表示所有接口都需要登录才能请求
    //如果$noNeedRight为空表示所有接口都需要验证权限才能请求
    //如果接口已经设置无需登录,那也就无需鉴权了
    //
    // 无需登录的接口,*表示全部
    protected $noNeedLogin = ['test', 'test1'];
    // 无需鉴权的接口,*表示全部
    protected $noNeedRight = ['test2'];

    /**
     * 测试方法
     *
     * @ApiTitle    (测试名称)
     * @ApiSummary  (测试描述信息)
     * @ApiMethod   (POST)
     * @ApiRoute    (/api/create/order)
     * @ApiHeaders  (name=token, type=string, required=true, description="请求的Token")
     * @ApiParams   (name="ids", type="string", required=true, description="菜品ids")
     * @ApiParams   (name="dining_type", type="number", required=true, description="就餐方式：1-堂食 2-自取")
     * @ApiReturnParams   (name="code", type="integer", required=true, sample="0")
     * @ApiReturnParams   (name="msg", type="string", required=true, sample="返回成功")
     * @ApiReturnParams   (name="data", type="object", sample="{'user_id':'int','user_name':'string','profile':{'email':'string','age':'integer'}}", description="扩展数据返回")
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function createOrder()
    {
        $goodIds = $this->request->post("goodIds"); // 商品ids
        $dining_type =  $this->request->post("dining_type"); // 就餐类型
        $table_no = $this->request->post("table_no");
        $remark = $this->request->post("remark");

        //订单id不能为空
         if(empty($goodIds)){
            return ["code"=>0,"msg"=>"订单id不能为空","data"=>null];
         }
         //就餐方式不能为空
        if(empty($dining_type)){
            return ["code"=>0,"msg"=>"就餐方式不能为空","data"=>null];
        }
        // 就餐方式无效
        if(!in_array($dining_type,[1,2])){
            return ["code"=>0,"msg"=>"就餐方式无效","data"=>null];
        }
        // 堂食没有桌号
        if(empty($table_no)  && $dining_type==OrderModel::DINING_TYPE_TS){
            return ["code"=>0,"msg"=>"请填写桌号","data"=>null];
        }
        $orderService = new OrderService();
        $user = $this->auth->getUser();
        $data = ['goodIds'=>$goodIds,"dingType"=>$dining_type,"user_id"=>$user->id,'table_no'=>$table_no,"remark"=>$remark];
        $result = $orderService->createOrder($data);

    }


}
