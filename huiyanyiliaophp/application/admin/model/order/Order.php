<?php

namespace app\admin\model\order;

use think\Model;


class Order extends Model
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
    public $dining_type_status = ["1"=>"堂食","2"=>"自取"];
    public $orstatus = ["0"=>"待支付","1"=>"已支付","2"=>"已完成","3"=>"已取消"];


    







}
