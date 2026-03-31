<?php
namespace  app\common\service;

use app\admin\model\hyyl\Hospital as HospitalModel;

class HospitalService
{
    /**
     * 获取医院列表
     */
    public static function getlist(){
        $list=HospitalModel::where("status",1)
            ->order("weigh","asc")
            ->field("id,name,coverimage,address,shordesc")
            ->select();

        return $list;
    }


    /**
     * 根据id查医院详情
     * @param $id
     * @return void
     */
    public static function getbyid($id)
    {
        $model=HospitalModel::where("id",$id)->find();
        return $model;
    }

}