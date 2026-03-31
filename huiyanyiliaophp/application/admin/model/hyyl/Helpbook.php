<?php

namespace app\admin\model\hyyl;

use think\Model;


class Helpbook extends Model
{

    

    

    // 表名
    protected $name = 'hyyl_helpbook';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';
    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = false;

    // 追加属性
    protected $append = [
        'status_text',
        'publishtime_text',
        'homeshowdata_text'
    ];
    const HOMESHOWDATA_YES="1";
    const HOMESHOWDATA_NO="2";
    const STATUS_YES="1";
    const STATUS_NO="2";


    protected static function init()
    {
        self::afterInsert(function ($row) {
            $pk = $row->getPk();
            $row->getQuery()->where($pk, $row[$pk])->update(['weigh' => $row[$pk]]);
        });
    }

    
    public function getStatusList()
    {
        return ['1' => __('Status 1'), '2' => __('Status 2')];
    }

    public function getHomeshowdataList()
    {
        return ['1' => __('Homeshowdata 1'), '2' => __('Homeshowdata 2')];
    }


    public function getStatusTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['status']) ? $data['status'] : '');
        $list = $this->getStatusList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getPublishtimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['publishtime']) ? $data['publishtime'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }


    public function getHomeshowdataTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['homeshowdata']) ? $data['homeshowdata'] : '');
        $list = $this->getHomeshowdataList();
        return isset($list[$value]) ? $list[$value] : '';
    }

    protected function setPublishtimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }


}
