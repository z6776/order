<?php


namespace app\common\service;
use app\admin\model\hyyl\Viplevel as ViplevelModel;

class ViplevelService
{
    /**
     * 获取会员等级列表
     */

    public static function getviplevellist()
    {
        //显示id，名称，简介，使用范围,月度和年度价格
        $list = ViplevelModel::where('status',ViplevelModel::STATUS_YES)
            ->order("weigh","asc")
            ->select();
        return $list;
    }

    /**
     * 获取会员详情
     */
    public static function getvipleveldetail($level)
    {
        $list = ViplevelModel::where('id',$level)
            ->find();
        return $list;
    }
}