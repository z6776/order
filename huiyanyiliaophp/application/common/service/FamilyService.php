<?php


namespace app\common\service;
use app\admin\model\hyyl\Family as FamilyModel;



class FamilyService
{
    /**
     * 获取当前用户的成员列表
     * @param $id
     * @return void
     */
    public static function getmemberlist($id,$person='')
    {
        //成员表的user_id关联用户表的id
        $query = FamilyModel::where('user_id',$id)
            ->where('status',FamilyModel::STATUS_YES)
            ->where('approvestatus',FamilyModel::APPROVESTATUS_YES)
            ->order("id", "asc")
            ->field('id,name,relationship,sex,phone');
        if (!empty($person)) {
            switch ($person) {
                case 1: // 个人会员只能看配偶，子女
                    $query->where("relationship", FamilyModel::RELATIONSHIP_family);
                    break;
                case 2: // 家庭会员不能看员工
                    $query->where("relationship", '<>', FamilyModel::RELATIONSHIP_staff);
                    break;
                case 3: // 企业会员只能看员工
                    $query->where("relationship", FamilyModel::RELATIONSHIP_staff);
                    break;
                case 4: // 商务会员业务暂无（这里假设也是不能看员工）
                    $query->where("relationship", '<>', FamilyModel::RELATIONSHIP_staff);
                    break;
                default:
            }
        }
        $list = $query->select();
        return $list;
    }


    /**
     * 添加/修改成员信息
     * @param
     * @param $id
     * @param $name
     * @param $sex
     * @param $phone
     * @param $relationship
     * @param $sbimages
     * @return void
     */
    public static function eidtaddmember($id,$name,$sex,$phone,$relationship,$sbimages,$user_id)
    {
        //若id不存在，则申请新成员
        if (empty($id))
        {
            $member = new FamilyModel();
            $member->user_id = $user_id;
            $member->status = FamilyModel::STATUS_YES;
        }
        //id存在，修改成员信息
        else{
            $member = FamilyModel::get($id);
            if (!isset($member)){
                error_stop('成员不存在');
            }
        }
        //设置姓名
        if (empty($name))
        {
            error_stop('姓名不能为空');
        }
        $member->name = $name;
        //设置性别
        if (empty($sex))
        {
            error_stop('性别未设置');
        }
        $member->sex = $sex;
        //添加电话
        if (empty($phone))
        {
            error_stop('电话号码未设置');
        }
        $member->phone = $phone;
        //添加用户与成员的关系
        if (empty($relationship))
        {
            error_stop('用户和成员的关系未设置');
        }
        $member->relationship = $relationship;
        //判断关系是否为员工则需要设置医保图片 RELATIONSHIP_staff=3是员工
        if ($relationship == FamilyModel::RELATIONSHIP_staff)
        {
            if (empty($sbimages))
            {
                error_stop('医保图片为空  ');
            }
            $member->sbimages = $sbimages;
        }
        //设置审核状态为：审核中
        $member->approvestatus = FamilyModel::APPROVESTATUS_ING;
        //保存成员
        $member->save();
        return $member;
    }

    /**
     * 删除成员
     * @param
     * @param $id
     * @return void
     */
    public static function deletemember($id)
    {
        //删除
        $member = FamilyModel::get($id);
        if ($member->status == FamilyModel::STATUS_NO)
        {
            error_stop('该成员已经被删除');
        }
        if (!isset($member))
        {
            error_stop('成员不存在');
        }
        $member->status = FamilyModel::STATUS_NO;
        $member->save();
       return $member;
    }



    /**
     * 成员详情
     * @param
     * @param $id
     * @return void
     */
    public static function getmemberbyid($id)
    {
        $member = FamilyModel::where('id',$id)
            ->field('id,name,phone,sex,relationship,sbimages')
            ->find();
        if (!isset($member))
        {
            error_stop('该成员不存在');
        }
        return $member;
    }


}