<?php

namespace app\common\service;

use app\admin\model\hyyl\Family;
use app\admin\model\hyyl\Hospital as HospitalModel;
use app\admin\model\hyyl\Order;
use app\admin\model\hyyl\Order as OrderModel;
use app\admin\model\hyyl\Viplevel as ViplevelModel;
use app\admin\model\hyyl\Viporder as ViporderModel;
use app\admin\model\User as UserModel;
use app\admin\model\hyyl\Family as FamilyModel;
use app\admin\model\hyyl\Viporder;
use function fast\e;


class VipOrderServices
{
    // 更新用户会员状态
    public static function updatestatus($out_trade_no)
    {
        $order = Viporder::get(['out_trade_no' => $out_trade_no]);
        $order->status = Viporder::STATUS_YES;
        $order->paytime = time();
        $order->save();
        self::updatetime($out_trade_no);
    }


    // 更新会员到期时间
    public static function updatetime($out_trade_no)
    {
        $order = Viporder::get(['out_trade_no' => $out_trade_no]);
        // 获取当前时间的时间戳
        $currentTimeStamp = time();
        // 计算一年后的时间戳
        $yearLaterTimeStamp = strtotime("+365 days", $currentTimeStamp);
        $user = UserModel::get(['id' => $order->user_id]);
        // 年套餐  // 到期的
        if ((isset($user->vipendtime) && !empty($user->vipendtime) && $user->vipendtime < $currentTimeStamp) || empty($user->vipendtime)) {
            $user->vipendtime = $yearLaterTimeStamp;
        } else {
            // 没到期的
            //  买的不同会员从现在开始
            if ($user->level != $order->viplevel_id) {
                $user->vipendtime = $yearLaterTimeStamp;
            } else {
                //  买的相同会员从到期时间开始
                $t = strtotime("+365 days", $user->vipendtime);
                $user->vipendtime = $t;
            }
        };
        $user->level = $order->viplevel_id;
        $user->save();
    }
}


