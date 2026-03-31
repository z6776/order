<?php

namespace app\admin\model\hyyl;

use app\admin\model\User;
use think\Model;


class Viporder extends Model
{


    // 表名
    protected $name = 'hyyl_viporder';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = false;

    // 追加属性
    protected $append = [
        'status_text',
        'paytime_text'
    ];
    
    const STATUS_YES=2; // 已支付
    const STATUS_NO=1; // 未支付

    const MON_ORDER=1; // 月套餐
    const YEAR_ORDER=2; // 年套餐

    public function getStatusList()
    {
        return ['1' => __('Status 1'), '2' => __('Status 2')];
    }


    public function getStatusTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['status']) ? $data['status'] : '');
        $list = $this->getStatusList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getPaytimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['paytime']) ? $data['paytime'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }

    protected function setPaytimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }

    public function viplevel()
    {
        return $this->hasOne(Viplevel::class,'id','viplevel_id')->setEagerlyType(0);
    }

    public function user()
    {
        return $this->hasOne(User::class,'id','user_id')->setEagerlyType(0);
    }

}
