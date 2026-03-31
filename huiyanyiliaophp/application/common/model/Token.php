<?php

namespace app\common\model;

use think\Model;

/**
 * Token存储
 */
class Token extends Model
{

    protected $name = 'user_token';
    // 开启自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = false;
    // 追加属性
    protected $append = [
    ];
    public const expires_at = 5*24*60*60;
    const token_type_w = 1;
    const token_type_b = 2;
}
