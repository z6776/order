<?php

namespace app\admin\model\hyyl;

use app\common\model\User;
use think\Model;
use traits\model\SoftDelete;

class Family extends Model
{

    use SoftDelete;

    

    // 表名
    protected $name = 'hyyl_family';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = 'deletetime';

    // 追加属性
    protected $append = [
        'status_text',
        'sex_text',
        'approvestatus_text',
        'approvetime_text',
        'relationship_text'
    ];
    

    
    public function getStatusList()
    {
        return ['1' => __('Status 1'), '2' => __('Status 2')];
    }

    public function getSexList()
    {
        return ['1' => __('男'), '2' => __('女')];
    }

    public function getApprovestatusList()
    {
        return ['1' => __('Approvestatus 1'), '2' => __('Approvestatus 2'), '3' => __('Approvestatus 3')];
    }

    public function getRelationshipList()
    {
        return ['1' => __('配偶/子女'), '2' => __('父母/兄妹'), '3' => __('员工')];
    }


    public function getStatusTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['status']) ? $data['status'] : '');
        $list = $this->getStatusList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getRelationshipTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['relationship']) ? $data['relationship'] : '');
        $list = $this->getRelationshipList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getSexTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['sex']) ? $data['sex'] : '');
        $list = $this->getSexList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getApprovestatusTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['approvestatus']) ? $data['approvestatus'] : '');
        $list = $this->getApprovestatusList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getApprovetimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['approvetime']) ? $data['approvetime'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }

    protected function setApprovetimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }

    public function user()
    {
        return $this->hasOne(User::class,'id','user_id')->setEagerlyType(0);
    }
    //审核状态
    const APPROVESTATUS_YES="1";
    const APPROVESTATUS_ING="2";
    const APPROVESTATUS_NO="3";
    //状态
    const STATUS_YES = '1';
    const STATUS_NO = '2';
    //关系
    const RELATIONSHIP_family = '1';//配偶，子女
    const RELATIONSHIP_relative = '2';//父母，兄弟
    const RELATIONSHIP_staff = '3';//员工

}
