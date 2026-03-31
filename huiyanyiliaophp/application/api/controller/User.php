<?php

namespace app\api\controller;

use addons\third\library\Wechatmini;
use app\common\controller\Api;
use app\common\library\Auth;
use app\common\library\Ems;
use app\common\library\Sms;
use app\common\service\FamilyService;
use app\common\model\User as UserModel;
use app\common\service\UserService;

use fast\Random;
use think\Config;
use think\Log;
use think\Validate;

/**
 * 会员接口
 */
class User extends Api
{
    protected $noNeedLogin = ['login', "callback",'mobilelogin', 'register', 'resetpwd', 'changeemail', 'changemobile', 'third','loginmini',"authSession"];
    protected $noNeedRight = '*';
    protected $APPID = 'wxa13f531ac61b2724';
    protected $APPSECRET = 'd220e92c0fa6bb5d3b01c9f1d6e84630';

    public function _initialize()
    {
        parent::_initialize();

        if (!Config::get('fastadmin.usercenter')) {
            $this->error(__('User center already closed'));
        }

    }

    /**
     * 会员中心
     */
    public function index()
    {
        $this->success('', ['welcome' => $this->auth->nickname]);
    }


    /**
     * 会员登录
     *
     * @ApiMethod (POST)
     * @param string $account  账号
     * @param string $password 密码
     */
    public function login()
    {
        $account = $this->request->post('account');
        $password = $this->request->post('password');
        if (!$account || !$password) {
            $this->error(__('Invalid parameters'));
        }
        $ret = $this->auth->login($account, $password);
        if ($ret) {
            $data = ['userinfo' => $this->auth->getUserinfo()];
            $this->success(__('Logged in successful'), $data);
        } else {
            $this->error($this->auth->getError());
        }
    }

    /**
     * 小程序获取openid
     *
     * @ApiTitle    (小程序获取openid)
     * @ApiSummary  (小程序获取openid)
     * @ApiMethod   (POST)
     * @ApiRoute    (/api/user/authSession)
     * @ApiParams   (name="code", type="string", required=true, description="小程序登录code")
     * @ApiReturnParams   (name="code", type="string", required=true, sample="0")
     * @ApiReturnParams   (name="msg", type="string", required=true, sample="返回成功")
     * @ApiReturn   ({
            'code':'1',
            'msg':'返回成功'
            })
     */
     public function authSession(){
         $param = $this->request->param();
         $result = UserService::getUserInfo($param);

         if(isset($result["openid"]) && !empty($result["openid"])){
              return $this->success("获取成功",$result);
         }
         return $this->error("服务错误");
     }

    /**
     * 小程序登录
     *
     * @ApiMethod (POST)
     * @param string $openid  openid
     */
    public function loginWechat()
    {
        $param = $this->request->param();
        $openid = $param['openid'];
        $user = (new \app\admin\model\User())->where('openid', $openid)->find();

        if (empty($user)){
            $nickname = '新用户' . time();
            $ret = $this->auth->registerwx($nickname, $openid);
        }else{
            $ret = $this->auth->direct($user['id']);

        }
        if ($ret) {
            $this->success('', $ret);
        } else {

            $this->error($this->auth->getError());
        }
    }

    /**
     * 手机验证码登录
     *
     * @ApiMethod (POST)
     * @param string $mobile  手机号
     * @param string $captcha 验证码
     */
    public function mobilelogin()
    {
        $mobile = $this->request->post('mobile');
        $captcha = $this->request->post('captcha');
        if (!$mobile || !$captcha) {
            $this->error(__('Invalid parameters'));
        }
        if (!Validate::regex($mobile, "^1\d{10}$")) {
            $this->error(__('Mobile is incorrect'));
        }
        if (!Sms::check($mobile, $captcha, 'mobilelogin')) {
            $this->error(__('Captcha is incorrect'));
        }
        $user = \app\common\model\User::getByMobile($mobile);
        if ($user) {
            if ($user->status != 'normal') {
                $this->error(__('Account is locked'));
            }
            //如果已经有账号则直接登录
            $ret = $this->auth->direct($user->id);
        } else {
            $ret = $this->auth->register($mobile, Random::alnum(), '', $mobile, []);
        }
        if ($ret) {
            Sms::flush($mobile, 'mobilelogin');
            $data = ['userinfo' => $this->auth->getUserinfo()];
            $this->success(__('Logged in successful'), $data);
        } else {
            $this->error($this->auth->getError());
        }
    }

    /**
     * 注册会员
     *
     * @ApiMethod (POST)
     * @param string $username 用户名
     * @param string $password 密码
     * @param string $email    邮箱
     * @param string $mobile   手机号
     * @param string $code     验证码
     */
    public function register()
    {
        $username = $this->request->post('username');
        $password = $this->request->post('password');
        $email = $this->request->post('email');
        $mobile = $this->request->post('mobile');
        $code = $this->request->post('code');
        if (!$username || !$password) {
            $this->error(__('Invalid parameters'));
        }
        if ($email && !Validate::is($email, "email")) {
            $this->error(__('Email is incorrect'));
        }
        if ($mobile && !Validate::regex($mobile, "^1\d{10}$")) {
            $this->error(__('Mobile is incorrect'));
        }
        $ret = Sms::check($mobile, $code, 'register');
        if (!$ret) {
            $this->error(__('Captcha is incorrect'));
        }
        $ret = $this->auth->register($username, $password, $email, $mobile, []);
        if ($ret) {
            $data = ['userinfo' => $this->auth->getUserinfo()];
            $this->success(__('Sign up successful'), $data);
        } else {
            $this->error($this->auth->getError());
        }
    }

    /**
     * 退出登录
     * @ApiMethod (POST)
     */
    public function logout()
    {
        if (!$this->request->isPost()) {
            $this->error(__('Invalid parameters'));
        }
        $this->auth->logout();
        $this->success(__('Logout successful'));
    }



    /**
     * 修改个人信息
     * @ApiTitle    (修改个人信息)
     * @ApiSummary  (修改个人信息)
     * @ApiMethod   (POST)
     * @ApiRoute    (/api/user/edituser)
     * @ApiParams   (name="nickname", type="string", required=true, description="用户姓名")
     * @ApiParams   (name="avatar", type="string", required=true, description="用户头像")
     * @ApiParams   (name="gender", type="string", required=true, description="用户性别：1是男，2是女")
     * @ApiParams   (name="mobile", type="string", required=true, description="电话号码")
     * @ApiParams   (name="idcardno", type="string", required=true, description="身份证号")
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function edituser()
    {
        //获取当前用户id
        $id=$this->auth->id;
        //获取姓名，头像.....
        $params = $this->request->post();
        extract($params);
        //调用函数
        $model = UserService::edituser($id,$nickname,$avatar,$gender,$mobile,$idcardno);
        $this->success('',$model);
    }



    /**
     *发送请求
     * @ApiTitle    (发送请求-废弃)
     * @ApiSummary  (发送请求)
     */
    public function http_curl($url, $type = 'get', $res = 'json', $arr = ''){
        $cl = curl_init();
        curl_setopt($cl, CURLOPT_URL, $url);
        curl_setopt($cl, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($cl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($cl, CURLOPT_SSL_VERIFYHOST, false);
        if($type == 'post'){
            curl_setopt($cl, CURLOPT_POST, 1);
            curl_setopt($cl, CURLOPT_POSTFIELDS, $arr);
        }
        $output = curl_exec($cl);
        curl_close($cl);
        return json_decode($output, true);
        if($res == 'json'){
            if( curl_error($cl)){
                return curl_error($cl);
            }else{
                return json_decode($output, true);
            }
        }
    }
    /**
     *网页授权的回调
     * @ApiTitle    (网页授权的回调-废弃)
     * @ApiSummary  (网页授权的回调)
     */
    public function callback(){
        $APPID = $this->APPID;
        $APPSECRET = $this->APPSECRET;
        // 拆分成数组 得到code
        $code = $this->request->get("code");
        // 二、通过code获取网页授权access_token 有效期7200s,过期需要重新获取，这里暂不处理过期的问题
        $url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=$APPID&secret=$APPSECRET&code=$code&grant_type=authorization_code";
        $res = $this->http_curl($url,'post');

        // 三、获取用户信息
        $url2 = "https://api.weixin.qq.com/sns/userinfo?access_token=".$res['access_token']."&openid=".$res['openid']."&lang=zh_CN";
        $userinfo = $this->http_curl($url2);
        // 检查是否为错误响应
        if (isset($userinfo['errcode']) && $userinfo['errcode'] != 0) {
            return $this->error("获取用户信息失败: " . $userinfo['errmsg']);
        }

        if (!isset($userinfo['openid'])) {
            return $this->error("登陆失败: 缺少openid");
        }
        $user = new \app\admin\model\User();
        // 检查用户是否已存在
        $isold = $user->where('openid', $userinfo['openid'])->count();
        if ($isold==0) {
//            新用户走注册
            $ret = $this->auth->registerwx($userinfo['nickname'], $userinfo['openid'], $userinfo['headimgurl'], $userinfo['sex'],[]);
            if ($ret) {
                $data = ['userinfo' => $this->auth->getUserinfo()];
                $this->success(__('Sign up successful'), $data);
            } else {
                $this->error($this->auth->getError());
            }
        } else {
            $nowuser = $user->where('openid',$userinfo['openid'])->find();
            // 用户已存在
            $ret = $this->auth->direct($nowuser->id);
            if($ret){
                $data = ['userinfo' => $this->auth->getUserinfo()];
                $this->success(__('Sign up successful'), $data);
            }else{
                $this->error($this->auth->getError());
            }
        }
    }
    /**
     * 申请/修改管理员
     * @ApiTitle    (申请/修改管理员-废弃)
     * @ApiSummary  (申请/修改管理员)
     * @ApiMethod   (POST)
     * @ApiRoute    (/api/user/editaddadministrators)
     * @ApiParams   (name="nickname", type="string", required=true, description="用户姓名")
     * @ApiParams   (name="gender", type="string", required=true, description="用户性别：1是男，2是女")
     * @ApiParams   (name="mobile", type="string", required=true, description="电话号码")
     * @ApiParams   (name="idcart_frontimage", type="string", required=true, description="身份证正面")
     * @ApiParams   (name="idcart_backimage", type="string", required=true, description="身份证反面")
     * @ApiParams   (name="avatar", type="string", required=true, description="头像")
     * @ApiParams   (name="type", type="int", required=false, description="2详情 1申请")
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function editaddadministrators()
    {
        //接参
        $id = $this->auth->id;
        $type = $this->request->post("type");
        if(isset($type) && $type==2){
            $administrators = UserModel::get($id);
            $this->success('修改成功',$administrators);
        }
        $params = $this->request->post();
        extract($params);
        //调函数
        $administrators = UserService::editaddadministrators($id,$nickname,$gender,$mobile,$idcart_frontimage,$idcart_backimage,$avatar);
        //输出
        $this->success('修改成功',$administrators);
    }


    /**
     * 管理员详情
     * @ApiTitle    (管理员详情-废弃)
     * @ApiSummary  (管理员详情)
     * @ApiRoute    (/api/user/getadministrators)
     * @ApiMethod   (GET)
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function getadministrators()
    {
        //接参
        $id = $this->auth->id;
        //调方法
        if (isset($id))
        {
            $administrators = UserService::getadministrators($id);
            //输出
            $this->success('',$administrators);
        }else{
            $this->error('参数错误');
        }
    }

    /**
     * 申请/修改成员信息
     * @ApiTitle    (申请/修改成员信息)
     * @ApiSummary  (申请/修改成员信息)
     * @ApiMethod   (POST)
     * @ApiRoute    (/api/user/eidtaddmember)
     * @ApiParams   (name="id", type="integer", required=true, description="成员id(有id是修改，没有id是添加)")
     * @ApiParams   (name="name", type="string", required=true, description="成员姓名")
     * @ApiParams   (name="sex", type="string", required=true, description="成员性别：1是男，2是女")
     * @ApiParams   (name="phone", type="string", required=true, description="成员电话")
     * @ApiParams   (name="relationship", type="string", required=true, description="关系:1是配偶/子女，2是亲戚/朋友，3是员工")
     * @ApiParams   (name="sbimages", type="string", required=true, description="只有员工才需要社保图片")
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function eidtaddmember()
    {
        $user_id = $this->auth->id;
        $params = $this->request->post();
        extract($params);
        //调用函数
        FamilyService::eidtaddmember($id,$name,$sex,$phone,$relationship,$sbimages,$user_id);
        //输出
        $this->success('修改/添加成功');
    }

    /**
     * 删除成员
     * @ApiTitle    (删除成员)
     * @ApiSummary  (删除成员)
     * @ApiMethod   (GET)
     * @ApiRoute    (/api/user/deletemember)
     * @ApiParams   (name="id", type="integer", required=true, description="成员id")
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function deletemember()
    {
        //接参
        $params = $this->request->param();
        extract($params);
        //调用函数
        if (isset($id)) {
            FamilyService::deletemember($id);
            $this->success('删除成功');
        }
    }

    /**
     * 获取我的成员列表
     * @ApiTitle    (获取我的成员列表)
     * @ApiSummary  (获取成员列表)
     * @ApiMethod   (GET)
     * @ApiRoute    (/api/user/getmemberlist)
     * @ApiParams   (name="pagesize", type="string", required=true, description="大小")
     * @ApiParams   (name="page", type="string", required=true, description="第几页")
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function getmemberlist()
    {
        //获取当前用户的id
        $id = $this->auth->id;
        $params = $this->request->param();
        extract($params);
        if (isset($id))
        {
            $list = FamilyService::getmemberlist($id,$person);
            $this->success('',$list);
        }else{
            $this->error('未获取到用户信息');
        }
    }


    /**
     * 显示我的会员详情
     * @ApiTitle    (我的会员详情)
     * @ApiSummary  (我的会员详情)
     * @ApiMethod   (GET)
     * @ApiRoute    (/api/user/getvipbyid)
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function getvipbyid()
    {
        //接参
        $id = $this->auth->id;
        //调函数
        if (isset($id)) {
            $model = UserService::getvipbyid($id);
            //输出
            $this->success('', $model);
        }else{
            $this->error('参数错误');
        }
    }

    /**
     * 我的客户列表
     * @ApiTitle    (我的客户列表-废弃)
     * @ApiSummary  (我的客户列表)
     * @ApiMethod   (POST)
     * @ApiRoute    (/api/user/getworkuserlist)
     * @ApiParams   (name="name", type="string", required=true, description="成员姓名")
     * @ApiParams   (name="pagesize", type="string", required=true, description="大小")
     * @ApiParams   (name="page", type="string", required=true, description="第几页")
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function getworkuserlist()
    {
        //接参
        $uid = $this->auth->id;
        $params = $this->request->param();
        extract($params);
        if(isset($uid))
        {
            //调函数
            $list = UserService::getworkuserlist($uid,$name,$pagesize,$page);
            //输出
            $this->success('',$list);
        }
        else{
            $this->error('参数错误');
        }
    }

    /**
     * 扫码绑定客户
     * @ApiTitle    (扫码绑定客户-废弃)
     * @ApiSummary  (扫码绑定客户)
     * @ApiMethod   (POST)
     * @ApiRoute    (/api/user/bindworkuser)
     * @ApiParams   (name="id", type="integer", required=true, description="成员id")
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function bindworkuser()
    {
        $uid = $this->auth->id;
        //接参
        $params = $this->request->param();
        extract($params);
        //调函数
        UserService::bindworkuser($id,$uid);
        //输出
        $this->success('绑定成功');
    }

    /**
     * 解绑客户
     * @ApiTitle    (解绑客户-废弃)
     * @ApiSummary  (解绑客户)
     * @ApiMethod   (POST)
     * @ApiRoute    (/api/user/unbindworkuser)
     * @ApiParams   (name="id", type="integer", required=true, description="成员id")
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function unbindworkuser()
    {
        //接参
        $params = $this->request->param();
        extract($params);
        //调函数
        UserService::unbindworkuser($id);
        //输出
        $this->success('解绑成功');
    }


    /**
     * 我的成员详情
     * @ApiTitle    (我的成员详情)
     * @ApiSummary  (我的成员详情)
     * @ApiMethod   (POST)
     * @ApiRoute    (/api/user/getmemberbyid)
     * @ApiParams   (name="id", type="integer", required=true, description="成员id")
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function getmemberbyid()
    {
        //接参
        $params = $this->request->param();
        extract($params);
        //调函数
        $member = FamilyService::getmemberbyid($id);
        //输出
        $this->success('',$member);

    }

    /**
     * 我的详情
     * @ApiTitle    (我的详情)
     * @ApiSummary  (我的详情)
     * @ApiMethod   (GET)
     * @ApiRoute    (/api/user/getuserbyid)
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function getuserbyid()
    {
        //接参
        $id = $this->auth->id;
        //调函数
//        $user = UserService::getuserbyid($id);
        $data = ['userinfo' => $this->auth->getUserinfo()];
        //输出
        $this->success('',$data);
    }


}
