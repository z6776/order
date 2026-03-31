<?php
namespace app\common\service;

use app\admin\model\hyyl\Banner as BannerModel;

class BannerService
{
    /**
     * 获取宣传图列表
     */
    public static function getlist(){
        //数字越小越在前，只获取启用的图片
        $list = BannerModel::where('status',BannerModel::STATUS_YES)
            ->order("weigh","asc")
            ->field('coverimage')
            ->select();
        return $list;
    }
}