<?php

namespace addons\third\library;

use fast\Http;
use think\Config;
use think\Log;
use think\Session;
// use EasyWeChat\Foundation\Application;
use EasyWeChat\Factory;

/**
 * 微信
 */
class Wechatmini
{

    /**
     * 配置信息
     * @var array
     */
    private $config = [
        'app_id' => 'wxa13f531ac61b2724',
        'secret' => 'd220e92c0fa6bb5d3b01c9f1d6e84630',
        'scope' => 'get_user_info',
    ];

    public function __construct($options = [])
    {
        if ($config = Config::get('third.wechatmini'))
        {
            $this->config = array_merge($this->config, $config);
        }
        $this->config = array_merge($this->config, is_array($options) ? $options : []);
    }



    /**
     * 获取用户信息
     * @param array $params
     * @return array
     */
    public function getUserInfo($params = [])
    {
        $params = $params ? $params : $_POST;
        Log::alert($params);
        if (isset($params['code']))
        {
            if ($params['code'])
            {
                Log::alert('code'.$params['code']);
                $config = $this->config;
                Log::alert('=============');
                Log::alert($config);
                $app = Factory::miniProgram($config);

                Log::alert('=============');
                Log::alert($app);
                $sns = $app->auth->session($params['code']);

                Log::alert('=============');
                Log::alert($sns);
                if (isset($sns['openid'])){
                    if($sns['openid']){
                        $userinfo = $params['rawData'] ? json_decode(stripslashes(html_entity_decode($params['rawData'])),true) : [];
                        $userinfo['avatar'] = isset($userinfo['avatarUrl']) ? $userinfo['avatarUrl'] : '';
                        $userinfo['nickname'] = isset($userinfo['nickName']) ? $userinfo['nickName'] : '';
                        $result = [
                            'access_token'  => '',
                            'refresh_token' => '',
                            'expires_in'    => 0,
                            'openid'        => $sns['openid'],
                            'unionid'       => '',
                            'userinfo'      => $userinfo
                        ];
                        return $result;
                    }
                }
            }
        }
        return [];
    }
}
