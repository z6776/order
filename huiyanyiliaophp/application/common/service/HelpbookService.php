<?php


namespace app\common\service;
use app\admin\model\hyyl\Helpbook as HelpbookModel;

class HelpbookService
{
    /**
     * 获取首页展示的急救方法
     */
    public static function gethomelist()
    {
        $model = HelpbookModel::where('homeshowdata',HelpbookModel::HOMESHOWDATA_YES)
            ->field('id,name,shortdesc,publishtime,viewcount,coverimage')
            ->find();
        return $model;
    }


    /**
     * 急救手册列表
     * @param $name
     * @param $page
     * @param $pagesize
     * @return void
     */
    public static function gethelpbooklist($name,$page,$pagesize,$homeshowdata)
    {
        //对标题进行模糊查询
        $query = HelpbookModel::where('status', HelpbookModel::STATUS_YES);
        //判断参数是否为空
        if (!empty($name)) {
            $query->where('name', 'like', "%" . $name . "%");
        }
        if (!empty($homeshowdata)) {
            $query->where('homeshowdata', $homeshowdata);
        }
        $list = $query
            ->order("id", "desc")
            ->field('id,name,shortdesc,publishtime,viewcount,coverimage')
            ->paginate($pagesize,false,['page'=>$page]);
        return $list->items();
    }


    /**
     *急救详情
     * @param $id
     * @return void
     */
    public static function gethelpbookbyid($id){
        //浏览量+1
        HelpbookModel::where('id',$id)->setInc('viewcount',1);
        $model = HelpbookModel::where('id',$id)
            ->field('id,detailcontent,name,publishtime,viewcount')
            ->select();
        return $model;
    }
}