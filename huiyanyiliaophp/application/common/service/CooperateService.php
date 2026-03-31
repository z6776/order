<?php


namespace app\common\service;
use app\admin\model\hyyl\Cooperate as CooperateModel;
use app\admin\model\hyyl\Hospital as HospitalModel;
use app\admin\model\User as UserModel;
use think\queue\command\Work;

class CooperateService
{

    /**
     * 发布合作
     * @param $uid
     * @param $hospital_id
     * @param $expert
     * @param $phone
     * @param $remark
     * @return void
     */
    public static function addcooperate($uid,$hospital_id,$expert,$phone,$remark)
    {
        $user = UserModel::get($uid);
        if ($user->level != UserModel::LEVELNAME_shangwuvip)
        {
            error_stop('您不是商务会员，无法发布合作');
        }
        $cooperate = new CooperateModel();
        //添加医院
        if (empty($hospital_id))
        {
            error_stop('医院名称不能为空');
        }
        $hospital = HospitalModel::get($hospital_id);
        if (!isset($hospital))
        {
            error_stop('医院不存在');
        }
        $cooperate->hospital_id =$hospital_id;
        //添加专家
        if (empty($expert))
        {
            error_stop('专家姓名不能为空');
        }
        $cooperate->expert_id = $expert;
        //添加电话
        if (empty($phone))
        {
            error_stop('电话号码不能为空');
        }
        $cooperate->phone = $phone;
        //添加备注
        if (strlen($remark)>500)
        {
            error_stop('备注字数过长');
        }
        if (empty($remark))
        {
            error_stop('备注不能为空');
        }
        $cooperate->remark = $remark;
        //用户id赋值
        $cooperate->user_id = $uid;
        //状态设为启用
        $cooperate->status = CooperateModel::STATUS_YES;
        $cooperate->save();
        return $cooperate;
    }


    /**
     * 我的合作
     * @param $uid
     * @param $page
     * @param $pagesize
     * @return void
     */
    public static function getcooperatelist($uid,$page,$pagesize)
    {
        //根据用户id去搜索，获取本表的id，专家姓名，创建时间，备注；关联表hospital的id和name字段
        $list = CooperateModel::where('user_id',$uid)
            ->where('cooperate.status',CooperateModel::STATUS_YES)
            ->field('id,expert_id,createtime,remark,phone')
            ->with(['hospital' => function($query){
            $query->withField('id,name');
        }])->paginate($pagesize,false,['page'=>$page]);
        return $list->items();
    }


    /**
     * 合作详情
     * @param $id
     * @return void
     */
    public static function  getcooperatebyid($id)
    {
        $model = CooperateModel::where('cooperate.id',$id)
            ->field('id,expert_id,createtime,phone,remark')
            ->with(['hospital' => function($query){
                $query->withField('name');
            }])
            ->find();
        return $model;
    }


    /**
     * 取消合作发布
     * @param $id
     * @return void
     */
    public static function deletecooperate($id)
    {
        $model = CooperateModel::get($id);
        if (!isset($model))
        {
            error_stop('合作不存在');
        }
        if ($model->status == CooperateModel::STATUS_NO)
        {
            error_stop('该用户已经被删');
        }
        //改变状态
        $model->status = CooperateModel::STATUS_NO;
        $model->save();
        return $model;
    }


    /**
     * 管理员合作列表
     * @param $uid
     * @param $page
     * @param $pagesize
     * @return void
     */
    public static function getadmincooperatelist($uid,$pagesize,$page)
    {
        // 查绑定的自己的或没有绑定的
        $ids = UserModel::where('work_user_id',$uid)->whereor('work_user_id',null)->where("id","<>",$uid)->column('id');
        // 管理员是查看绑定的会员的发布合作和未绑定任何管理员的用户发布的合作
        $list = CooperateModel::where('cooperate.status',CooperateModel::STATUS_YES)
            ->where('user_id',"in",$ids)
            ->with(['hospital'])
            ->order('id','asc')
            ->page($page,$pagesize);
        return $list->select();
    }

}