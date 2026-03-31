<?php

namespace app\admin\model;

use app\common\model\MoneyLog;
use app\common\model\ScoreLog;
use think\Model;
use app\admin\model\hyyl\Viplevel;

class User extends Model
{

    // 表名
    protected $name = 'user';
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    // 追加属性
    protected $append = [
        'prevtime_text',
        'logintime_text',
        'jointime_text',
        'approvetime_text',
        'applytime_text',
    ];

    public function getOriginData()
    {
        return $this->origin;
    }

    protected static function init()
    {
        self::beforeUpdate(function ($row) {
            $changed = $row->getChangedData();
            //如果有修改密码
            if (isset($changed['password'])) {
                if ($changed['password']) {
                    $salt = \fast\Random::alnum();
                    $row->password = \app\common\library\Auth::instance()->getEncryptPassword($changed['password'], $salt);
                    $row->salt = $salt;
                } else {
                    unset($row->password);
                }
            }
        });


        self::beforeUpdate(function ($row) {
            $changedata = $row->getChangedData();
            $origin = $row->getOriginData();
            if (isset($changedata['money']) && (function_exists('bccomp') ? bccomp($changedata['money'], $origin['money'], 2) !== 0 : (double)$changedata['money'] !== (double)$origin['money'])) {
                MoneyLog::create(['user_id' => $row['id'], 'money' => $changedata['money'] - $origin['money'], 'before' => $origin['money'], 'after' => $changedata['money'], 'memo' => '管理员变更金额']);
            }
            if (isset($changedata['score']) && (int)$changedata['score'] !== (int)$origin['score']) {
                ScoreLog::create(['user_id' => $row['id'], 'score' => $changedata['score'] - $origin['score'], 'before' => $origin['score'], 'after' => $changedata['score'], 'memo' => '管理员变更积分']);
            }
        });
    }

    public function getGenderList()
    {
        return ['0' => __('男'), '1' => __('女')];
    }

    public function getStatusList()
    {
        return ['normal' => __('Normal'), 'hidden' => __('Hidden')];
    }


    public function getPrevtimeTextAttr($value, $data)
    {
        $value = $value ? $value : ($data['prevtime'] ?? "");
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }

    public function getLogintimeTextAttr($value, $data)
    {
        $value = $value ? $value : ($data['logintime'] ?? "");
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }

    public function getJointimeTextAttr($value, $data)
    {
        $value = $value ? $value : ($data['jointime'] ?? "");
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }

    protected function setPrevtimeAttr($value)
    {
        return $value && !is_numeric($value) ? strtotime($value) : $value;
    }

    protected function setLogintimeAttr($value)
    {
        return $value && !is_numeric($value) ? strtotime($value) : $value;
    }

    protected function setJointimeAttr($value)
    {
        return $value && !is_numeric($value) ? strtotime($value) : $value;
    }

    protected function setBirthdayAttr($value)
    {
        return $value ? $value : null;
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

    public function group()
    {
        return $this->belongsTo('UserGroup', 'group_id', 'id', [], 'LEFT')->setEagerlyType(0);
    }


    public function getApplytimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['approvetime']) ? $data['approvetime'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }

    protected function setApplytimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }




    //审核状态
    const APPROVESTATUS_YES="1";
    const APPROVESTATUS_ING="2";
    const APPROVESTATUS_NO="3";
    //会员等级
    const LEVELNAME_gerenvip = '1';//个人会员
    const LEVELNAME_jiatingvip = '2';//家庭会员
    const LEVELNAME_qiyevip = '3';//企业会员
    const LEVELNAME_shangwuvip = '4';//商务会员

    const STATUS_YES="normal";
    const STATUS_NO="hidden";

    public function viplevel()
    {
        return $this->hasOne(Viplevel::class,'id','level',[],'LEFT')->setEagerlyType(0);
    }





}
