<?php

namespace app\api\controller;

use app\common\controller\Api;
use app\api\services;

/**
 *
 */
class Order extends Api
{

    //如果$noNeedLogin为空表示所有接口都需要登录才能请求
    //如果$noNeedRight为空表示所有接口都需要验证权限才能请求
    //如果接口已经设置无需登录,那也就无需鉴权了
    //
    // 无需登录的接口,*表示全部
    protected $noNeedLogin = ['test', 'test1'];
    // 无需鉴权的接口,*表示全部
    protected $noNeedRight = ['test2'];

    /**
     * 测试方法
     *
     * @ApiTitle    (测试名称)
     * @ApiSummary  (测试描述信息)
     * @ApiMethod   (POST)
     * @ApiRoute    (/api/create/order)
     * @ApiHeaders  (name=token, type=string, required=true, description="请求的Token")
     * @ApiParams   (name="ids", type="string", required=true, description="菜品ids")
     * @ApiParams   (name="dining_type", type="number", required=true, description="就餐方式：1-堂食 2-自取")
     * @ApiReturnParams   (name="code", type="integer", required=true, sample="0")
     * @ApiReturnParams   (name="msg", type="string", required=true, sample="返回成功")
     * @ApiReturnParams   (name="data", type="object", sample="{'user_id':'int','user_name':'string','profile':{'email':'string','age':'integer'}}", description="扩展数据返回")
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function createOrder()
    {
         $orderId = $this->request->post("ids");
         $dining_type =  $this->request->post("dining_type");
         if(empty($orderId) || !isset($orderId)){
            return ["code"=>0,"msg"=>"订单id不能为空","data"=>null];
         }
        if(empty($dining_type) || !isset($dining_type)){
            return ["code"=>0,"msg"=>"就餐方式不能为空","data"=>null];
        }
        $orderService = new app\api\services\order\orderService();
        $result = $orderService->createOrder();

    }


}
