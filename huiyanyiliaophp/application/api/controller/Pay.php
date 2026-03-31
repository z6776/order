<?php

namespace app\api\controller;
use addons\epay\library\Service;
use app\admin\controller\hyyl\Cooperate;
use app\admin\model\hyyl\Order;
use app\admin\model\hyyl\Viplevel;
use app\admin\model\hyyl\Viporder;
use app\admin\model\User as UserModel;
use app\common\controller\Api;
use app\common\service\VipOrderServices;
use think\Session;
use Yansongda\Pay\Exceptions\GatewayException;
use think\Log;

/**
 * 支付接口
 */
class Pay extends Api
{
    protected $noNeedLogin = ["notifyx"];
    protected $noNeedRight = ['*'];


    /**
     * 拉起支付
     *
     * @ApiTitle    (拉起支付)
     * @ApiMethod   (POST)
     * @ApiParams   (name="out_trade_no", type="string", required=true, description="订单号")
     * @ApiRoute    (/api/pay/wxpay)
     * @ApiReturn   ({
            'code':'1',
            'msg':'返回成功'
       })
     */
    public function wxpay()
    {

        $out_trade_no = $this->request->post('out_trade_no');
        $order = Viporder::get(['out_trade_no'=>$out_trade_no]);
        if(isset($order) && !empty($order)){
            $amount = $order->pay_fee;
        }else{
            $this->error("订单不存在");
        }
        $openid = $this->auth->openid;
        if (!$amount || $amount < 0) {
            $this->error("支付金额必须大于0");
        }
        $type = "wechat";
        $method = "miniapp";
        if (in_array($method, ['miniapp', 'mp']) && !$openid) {
            $this->error("openid不能为空");
        }
        //回调链接
        $notifyurl = config('base_url').'/api/pay/notifyx/paytype/'.$type;
        $response = Service::submitOrder($amount, $out_trade_no, $type, '会员订单', $notifyurl, null, $method, $openid);
        $this->success("",$response);
    }

    /**
     * 支付回调地址
     */
    public function notifyx()
    {
        $paytype = $this->request->param('paytype');
        $pay = Service::checkNotify($paytype);
        if (!$pay) {
            return json(['code' => 'FAIL', 'message' => '失败'], 500, ['Content-Type' => 'application/json']);
        }

        // 获取回调数据，V3和V2的回调接收不同
        $data = Service::isVersionV3() ? $pay->callback() : $pay->verify();

        try {
            //微信支付V3返回和V2不同
            if (Service::isVersionV3() && $paytype === 'wechat') {
                $data = $data['resource']['ciphertext'];
                $data['total_fee'] = $data['amount']['total'];
            }
            \think\Log::record($data."我的订单报错");
            //获取支付金额、订单号
            $payamount = $paytype == 'alipay' ? $data['total_amount'] : $data['total_fee'] / 100;
            $out_trade_no = $data['out_trade_no'];
            \think\Log::record("回调成功，订单号：{$out_trade_no}，金额：{$payamount}");


            //你可以在此编写订单逻辑
            if(isset($out_trade_no) && !empty($out_trade_no)){
                VipOrderServices::updatestatus($out_trade_no);
            };
        } catch (\Exception $e) {
            \think\Log::record("回调逻辑处理错误:" . $e->getMessage(), "error");
            $this->error($e->getMessage());
        }

        //下面这句必须要执行,且在此之前不能有任何输出
        if (Service::isVersionV3()) {
            return $pay->success()->getBody()->getContents();
        } else {
            return $pay->success()->send();
        }
    }
}