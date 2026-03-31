<?php

namespace app\admin\model\hyyl;

use think\Model;
use app\admin\model\User;
use app\admin\model\hyyl\Hospital;


class Cooperate extends Model
{

    

    

    // 表名
    protected $name = 'hyyl_cooperate';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = false;

    // 追加属性
    protected $append = [
        'status_text'
    ];
    

    
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


    public function user()
    {
        return $this->hasOne(User::class,'id','user_id')->setEagerlyType(0);
    }

    public function hospital()
    {
        return $this->hasOne(Hospital::class,'id','hospital_id')->setEagerlyType(0);
    }

    const STATUS_YES="1";
    const STATUS_NO="2";


}
