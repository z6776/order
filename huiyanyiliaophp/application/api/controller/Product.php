<?php

namespace app\api\controller;

use app\common\controller\Api;
use app\common\library\Sms as Smslib;
use app\common\model\User;
use think\Hook;


class Product {

    /**
     * 
     *
     * @ApiTitle    (获取商品分类信息)
     * @ApiSummary  (测试描述信息)
     * @ApiMethod   (GET)
     * @ApiRoute    (/api/Product/getProductType)
     * @ApiHeaders  (name=token, type=string, required=true, description="请求的Token")
     * @ApiReturnParams   (name="code", type="integer", required=true, sample="0")
     * @ApiReturnParams   (name="msg", type="string", required=true, sample="返回成功")
     * @ApiReturn   ({
            'code':'1',
            'msg':'返回成功'
     })
     */
    public function getProductType(){

    }

}