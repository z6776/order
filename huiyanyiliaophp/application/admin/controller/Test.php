<?php

namespace app\admin\controller;

use app\admin\model\AdminLog;
use app\common\controller\Backend;
use think\Config;
use think\Hook;
use think\Session;
use think\Validate;

/**
 * 测试
 * @internal
 */
class Test extends Backend
{
    /**
     * 测试
     */
      public function index()
      {
          var_dump(empty([]));
      }
}

