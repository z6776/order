<?php
namespace app\common\service;

use app\admin\model\Admin as AdminModel;
use app\common\library\Auth as AuthModel;
use fast\Random;

class AdminService
{
    /**
     * 修改个人信息
     */
    public static function updatePwdByName($name,$password){
        $admin = AdminModel::get(["username"=>$name]);
        if(!empty($admin)){
           $newAuth = new AuthModel();
           $salt = Random::alnum();
           $pwd = $newAuth->getEncryptPassword($password,$salt);
           $admin->salt = $salt;
           $admin->password = $pwd;
           $admin->save();
           return true;
        }
        return false;
    }
}