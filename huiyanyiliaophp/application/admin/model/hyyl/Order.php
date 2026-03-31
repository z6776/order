<?php

namespace app\admin\model\hyyl;

use app\admin\model\User;
use think\Model;
use app\admin\model\hyyl\Hospital;

class Order extends Model
{
    // 表名
    protected $name = 'hyyl_order';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = false;

    // 追加属性
    protected $append = [
        'typedata_text',
        'status_text',
        'canceltime_text',
        'taketime_text',
        'pricetime_text',
        'paytime_text',
        'finishtime_text'
    ];

    //订单类型
    const TYPEDATA_XC ='1';//自行问诊
    const TYPEDATA_YD ='2';//专人陪诊
    //状态
    const STATUS_DAIJIEDAN = '1';//需求发布
    const STATUS_DAIDINGJIA = '2';//服务中
    const STATUS_YIWANCHENG = '3';//已完成
    const STATUS_YIQUXIAO = '4';//已取消


    public function getTypedataList()
    {
        return ['1' => __('自行问诊'), '2' => __('专人陪诊')];
    }

    public function getStatusList()
    {
        return ['1' => __('需求发布'), '2' => __('服务中'), '3' => __('已完成'), '4' => __('已取消')];
    }
    public function getStatusList1()
    {
        return ['3' => __('已完成'), '4' => __('已取消')];
    }


    public function getTypedataTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['typedata']) ? $data['typedata'] : '');
        $list = $this->getTypedataList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getStatusTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['status']) ? $data['status'] : '');
        $list = $this->getStatusList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getCanceltimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['canceltime']) ? $data['canceltime'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }


    public function getTaketimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['taketime']) ? $data['taketime'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }


    public function getPricetimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['pricetime']) ? $data['pricetime'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }


    public function getPaytimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['paytime']) ? $data['paytime'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }


    public function getFinishtimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['finishtime']) ? $data['finishtime'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }

    protected function setCanceltimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }

    protected function setTaketimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }

    protected function setPricetimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }

    protected function setPaytimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }

    protected function setFinishtimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }


    public function user()
    {
        return $this->hasOne(User::class,'id','user_id')->setEagerlyType(0);
    }

    public function hospital()
    {
        return $this->hasOne(Hospital::class,'id','hospital_id',[], 'LEFT')->setEagerlyType(0);

    }

    public function family()
    {
        return $this->hasOne(Family::class,'id','family_id')->setEagerlyType(0);
    }


}
