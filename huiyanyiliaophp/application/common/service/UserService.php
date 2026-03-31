<?php


namespace app\common\service;

use app\admin\model\hyyl\Cooperate as CooperateModel;
use app\admin\model\User as UserModel;
use app\common\library\Auth;
use EasyWeChat\Factory;
use think\helper\Time;
use think\Log;
use function fast\e;
use think\Response;

class UserService
{

    public static function getUserInfo($params = [])
    {
        if (isset($params['code']) && !empty($params['code']))
        {
                $config = [
                    'app_id' => 'wxd24893997e96d580',
                    'secret' => 'd4808dc45ddfd4f4b79e12ccbf99fac8',
                    'http' => [
                        'verify' => 'D:\WorkMl\Environment\cacert.pem'
                    ]
                ];
                $app = Factory::miniProgram($config);
                $sns = $app->auth->session($params['code']);
                if (isset($sns['openid'])){
                    return $sns;
                }
            return [];
        }
        return [];
    }

    /**
     * 修改个人信息
     * @param $id
     * @param $nickname
     * @param $avatar
     * @param $gender
     * @param $mobile
     * @param $idcardno
     * @return void
     */

    public static function edituser($id, $nickname, $avatar, $gender, $mobile = '', $idcardno = '')
    {
        //获取当前用户
        $user = UserModel::get($id);
        //修改用户名
        if (empty($nickname)) {
            error_stop('未设置姓名');
        }
        $user->nickname = $nickname;
        //修改头像
        if (empty($avatar)) {
            error_stop('未设置头像');
        }
        $user->avatar = $avatar;
        //修改性别
        if (!isset($gender)) {
            error_stop('未设置性别');
        }
        $user->gender = $gender;
        $user->mobile = $mobile;
        $user->idcardno = $idcardno;
        //保存
        $user->save();
        return $user;
    }

    /**
     * 管理员详情
     * @param $id
     * @return void
     */
    public static function getadministrators($id)
    {
        $administrators = UserModel::get($id);
        //若不是管理员
        if ($administrators->approvestatus != UserModel::APPROVESTATUS_YES) {
            error_stop('您还不是管理员');
        }
        //显示头像，姓名，电话
//        $administrators = $administrators
//            ->field('id,nickname,mobile,avatar,gender,idcart_frontimage,idcart_backimage')
//            ->find();
        return $administrators;
    }

    /**
     * 显示我的会员详情
     * @param $id
     * @return void
     */
    public static function getvipbyid($id)
    {
        $model = UserModel::where('user.id', $id)
            ->field('id,nickname,avatar,vipendtime')
            ->with(['viplevel' => function ($query) {
                $query->withField('name,desccontent');
            }])->find();
        return $model;
    }

    /**
     * 会员是否到期
     * @param $id
     * @return void
     */
    public static function cancelLevel($id)
    {
        $model = UserModel::get('user.id', $id);
        $nowtime = time();
        $isend = false;
        if (isset($model['level']) && $model['level'] > 0) {
            if (isset($model['vipendtime']) && !empty($model['vipendtime'])) {
                if ($nowtime > $model->vipendtime) {
                    $model->level = 0;
                    $isend = true;
                    $model->save();
                }
            }
        }
        return $isend;
    }


    /**
     * 添加/修改管理员
     * @param $id
     * @param $nickname
     * @param $gender
     * @param $mobile
     * @param $idcart_frontimage
     * @param $idcart_backimage
     * @param $avatar
     * @return void
     */

    public static function editaddadministrators($id, $nickname, $gender, $mobile, $idcart_frontimage, $idcart_backimage, $avatar)
    {
        $administrators = UserModel::get($id);


        //申请和修改都需要修改姓名和电话
        if (empty($nickname)) {
            error_stop('未设置姓名');
        }
        $administrators->nickname = $nickname;
        if (empty($mobile)) {
            error_stop('未设置电话号码');
        }
//        $mobile_lenght = strlen($mobile);
//        if ($mobile_lenght != 11)
//        {
//            error_stop('电话号码长度不符合要求');
//        }
        $administrators->mobile = $mobile;
        //状态为1，已经是管理员则修改管理员信息
        //只有修改信息才能设置头像
        if ($administrators->approvestatus == UserModel::APPROVESTATUS_YES) {
            if (empty($avatar)) {
                error_stop('未设置头像');
            }
            $administrators->avatar = $avatar;

        } else {
            if (!isset($gender)) {
                error_stop('未设置性别');
            }
            $administrators->gender = $gender;

            //设置身份证正面
            if (empty($idcart_frontimage)) {
                error_stop('未设置身份证正面');
            }
            $administrators->idcart_frontimage = $idcart_frontimage;
            //设置身份证反面
            if (empty($idcart_backimage)) {
                error_stop('未设置身份证反面');
            }
            $administrators->idcart_backimage = $idcart_backimage;
            //申请时间
            $time = time();
            $administrators->applytime = $time;
            //修改状态为审核中
            $administrators->approvestatus = UserModel::APPROVESTATUS_ING;
            //生成用户二维码
            $url = config('base_url');
            $text = $url . '/h5/#/pages/publishinformation/index?parent_code=' . $administrators->id;
            $qrInfo = UserService::buildQrcode($text);
            $result = substr($qrInfo, strpos($qrInfo, '/uploads'));
            $administrators->barcodeimage = $result;
        }
        //保存数据
        $administrators->save();
        return $administrators;
    }

    /**
     * 我的客户列表
     * @param $uid
     * @param $name
     * @param $pagesize
     * @param $page
     * @return void
     */
    public static function getworkuserlist($uid, $name, $pagesize, $page)
    {
        $user = UserModel::get($uid);
        if ($user->approvestatus != UserModel::APPROVESTATUS_YES) {
            error_stop('您不是管理员');
        }
        $list = UserModel::where('work_user_id', $uid);
        //根据name搜索
        if (!empty($name)) {
            $list = $list->where('nickname', 'like', '%' . $name . '%');
        }
        $list = $list->field('id,nickname,mobile,avatar')
            ->paginate($pagesize, false, ['page' => $page]);
        return $list;
    }

    /**
     * 解绑客户
     * @param $id
     * @return void
     */
    public static function unbindworkuser($id)
    {
        //获取用户
        $workuser = UserModel::get($id);
        if (!isset($workuser)) {
            error_stop('该客户不存在');
        }
        if ($workuser->work_user_id == null) {
            error_stop('该客户没有绑定');
        }
        //将绑定的work_user_id设置为null
        $workuser->work_user_id = null;
        $workuser->save();
        return $workuser;
    }

    /**
     * 绑定
     * @param $id
     * @return void
     */
    public static function bindworkuser($id, $uid)
    {
        // 获取管理员信息
        $workuser = UserModel::get($id);
        $user = UserModel::get($uid);
        if (!isset($workuser)) {
            error_stop('该管理员不存在');
        }
        if ($workuser->approvestatus != 1) {
            error_stop('绑定用户不为管理员');
        }
        if ($workuser->id == $uid) {
            error_stop('不可自己与自己绑定');
        }
        if (isset($user->work_user_id) && !empty($user->work_user_id)) {
            error_stop('您已绑定管理员,请联系解绑');
        }
//    work_user_id 是管理员的id
        $user->work_user_id = $id;
        $user->save();
        return $user;
    }


    /**
     * 新用户列表
     * @return void
     */
    public static function getnewuserlist()
    {
        // 获取当前时间的时间戳
        //$nowTimestamp = time();
        // 计算七天前的时间戳
        //$sevenDaysAgoTimestamp = $nowTimestamp - (7 * 24 * 60 * 60);
        $list = UserModel::where('status', 'normal')
            ->order('id', 'asc')
            ->field('id,nickname')
            ->select();
        return $list;
    }

    /**
     * 我的详情
     * @param $id
     * @return void
     */
    public static function getuserbyid($id)
    {
        $user = UserModel::where('id', $id)
            ->field('id,nickname,avatar,gender,mobile,idcardno,approvestatus,level,levelname')
            ->find();
        return $user;
    }

    // 生成管理员二维码
    public static function buildQrcode($text)
    {
        $params = [
            'text' => $text,
            'size' => 350,    //大小
            'padding' => 15,    //内边距
            'errorlevel' => 'medium',   //容错级别:low-低   medium-中等   quartile-高   high-超高
            'foreground' => "#000000",     //前景色
            'background' => "#ffffff",  //背景色
            'logo' => 0,    //Logo:1-显示，0-不显示
            'logosize' => '',  //Logo大小
            'label' => '', //标签
            'labelfontsize' => 14, //标签大小
            'labelalignment' => 'center',    //标签水平位置:left-左  center-中   right-右
        ];

        $qrCode = \addons\qrcode\library\Service::qrcode($params);

        $response = Response::create()->header("Content-Type", "image/png");

        // 直接显示二维码
        header('Content-Type: ' . $qrCode->getContentType());
        $response->content($qrCode->writeString());

        // 写入到文件
        $fileUrl = '/uploads/qrcode/' . md5(implode('', $params)) . '.png';
        $filePath = ROOT_PATH . 'public' . $fileUrl;
        if (!file_exists(ROOT_PATH . 'public/uploads/qrcode/')) mkdir(ROOT_PATH . 'public/uploads/qrcode/', 0777, true);
        $qrCode->writeFile($filePath);

        return $filePath;
    }
}