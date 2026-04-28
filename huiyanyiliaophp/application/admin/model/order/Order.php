<?php

namespace app\admin\model\order;

use think\Model;


class
Order extends Model
{

    

    

    // 表名
    protected $name = 'order';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    // 定义时间戳字段名
    protected $createTime = false;
    protected $updateTime = false;
    protected $deleteTime = false;

    // 追加属性
    protected $append = [];
    const DINING_TYPE_TS = 1;
    const DINING_TYPE_ZQ = 2;
    public $dining_type_status = ["1"=>"堂食","2"=>"自取"];
    public $orstatus = ["0"=>"待支付","1"=>"备餐中","2"=>"待取餐","3"=>"已取餐","4"=>"已取消","5"=>"申请退款"];
    const Tobepaid = 0;
    const Inpreparation = 1;
    const Tobepickedup = 2;
    const Mealstaken = 3;
    const Canceled = 4;
    const Applyforrefund = 5;


    







}
