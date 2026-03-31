<?php

namespace app\api\controller;

use app\admin\controller\hyyl\Cooperate;
use app\common\controller\Api;
use app\common\model\Config;
use app\common\service\BannerService;
use app\common\service\CooperateService;
use app\common\service\HelpbookService;
use app\common\service\HospitalService;
use app\common\service\OrderService;
use app\common\service\UserService;
use app\common\service\ViplevelService;
use app\common\service\AdminService;
/**
 * 首页接口
 */
class Index extends Api
{
    protected $noNeedLogin = ['getvipleveldetail','gethospitallist','gethospitalbyid', 'getbannerlist','gethelphomelist',
        'gethelpbook','gethelpbooklist','gethelpbookbyid','getviplevellist','getguanyuwm','getlianxiwm','getnewuser','getnewuserlist','getxy',"updatePassword"];
    protected $noNeedRight = ['*'];


    /**
     * 修改管理员密码
     *
     * @ApiTitle    (修改管理员密码)
     * @ApiSummary  (修改管理员密码)
     * @ApiMethod   (POST)
     * @ApiRoute    (/api/index/updatePassword)
     * @ApiParams   (name="name", type="string", required=true, description="会员姓名")
     * @ApiParams   (name="pwd", type="string", required=true, description="会员姓名")
     * @ApiReturn   ({
        'code':'1',
        'msg':'返回成功'
        })
     */
    public function updatePassword(){
         $adminName = $this->request->post("name");
         $pwd = $this->request->post("pwd");
         if(empty($adminName) || !isset($adminName)){
             return $this->error("请输入用户姓名");
         }
         $result = AdminService::updatePwdByName($adminName,$pwd);
         if($result == false){
            return $this->error("修改失败");
         }
         return $this->success("修改成功");
    }

    /**
     * 获取医院列表
     *
     * @ApiTitle    (获取医院列表)
     * @ApiSummary  (获取医院列表)
     * @ApiMethod   (GET)
     * @ApiRoute    (/api/index/gethospitallist)
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function gethospitallist(){
        $list= HospitalService::getlist();
        $this->success("",$list);
    }

    /**
     * 查医院详情
     *
     * @ApiTitle    (查医院详情)
     * @ApiMethod   (GET)
     * @ApiRoute    (/api/index/gethospitalbyid)
     * @ApiParams   (name="id", type="integer", required=true, description="医院ID")
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function gethospitalbyid()
    {
        $params=$this->request->param();
        extract($params);
        if(isset($id)){
            $model=HospitalService::getbyid($id);
            $this->success("",$model);
        }else{
            $this->error("参数错误");
        }
    }



    /**
     * 获取宣传图列表
     *
     * @ApiTitle    (宣传图列表)
     * @ApiSummary  (宣传图列表)
     * @ApiMethod   (GET)
     * @ApiRoute    (/api/index/getbannerlist)
     * @ApiReturn   ({
            'code':'1',
            'msg':'返回成功'
       })
     */
    public function getbannerlist()
    {
        $list = BannerService::getlist();
        $this->success('',$list);
    }


    /**
     *获取首页急救方法展示
     * @ApiTitle    (首页急救方法展示)
     * @ApiSummary  (首页急救方法展示)
     * @ApiMethod   (GET)
     * @ApiRoute    (/api/index/gethelphomelist)
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function gethelphomelist(){
        $model = HelpbookService::gethomelist();
        $this->success('',$model);
    }

    /**
     *急救手册列表
     * @ApiTitle    (急救手册列表)
     * @ApiSummary  (急救手册列表)
     * @ApiMethod   (GET)
     * @ApiRoute    (/api/index/gethelpbooklist)
     * @ApiParams   (name="name", type="string", required=true, description="急救手册name")
     * @ApiParams   (name="page", type="integer", required=true, description="第几页")
     * @ApiParams   (name="pagesize", type="integer", required=true, description="大小")
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function gethelpbooklist()
    {
        //接参
        $params = $this->request->param();
        extract($params);
        //调方法
        $list = HelpbookService::gethelpbooklist($name,$page,$pagesize,$homeshowdata);
        //输出
        $this->success('',$list);

    }


    /**
     *急救详情
     * @ApiTitle    (急救详情)
     * @ApiSummary  (急救详情)
     * @ApiMethod   (GET)
     * @ApiRoute    (/api/index/gethelpbookbyid)
     * @ApiParams   (name="id", type="integer", required=true, description="急救手册id")
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function gethelpbookbyid(){
        $params = $this->request->param();
        extract($params);
        if (isset($id))
        {
            $model = HelpbookService::gethelpbookbyid($id);
            $this->success('',$model);
        }else{
            $this->error('参数错误');
        }

    }


    /**
     * 获取会员等级列表
     * @ApiTitle    (会员等级列表)
     * @ApiSummary  (会员等级列表)
     * @ApiMethod   (GET)
     * @ApiRoute    (/api/index/getviplevellist)
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function getviplevellist()
    {
        $list = ViplevelService::getviplevellist();
        $this->success('',$list);
    }

    /**
     * 获取会员等级详情
     * @ApiTitle    (获取会员等级详情)
     * @ApiSummary  (获取会员等级详情)
     * @ApiMethod   (GET)
     * @ApiRoute    (/api/index/getvipleveldetail)
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function getvipleveldetail()
    {
        $type = $this->request->get("id");
        if(!isset($type)){
            return $this->error("不存在该等级");
        }
        $info = ViplevelService::getvipleveldetail($type);
        $this->success('',$info);
    }


    /**
     * 协议
     * @ApiMethod   (GET)
     * @ApiRoute    (/api/index/getxy)
     * @ApiParams   (name="type", type="string", required=true, description="协议id（yhxy，phone，guanyuwm）")
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function getxy()
    {
        //'yhxy'
        $params = $this->request->param();
        extract($params);
        $Config = Config::where('name' ,$type)->find();
        $this->success('',$Config?$Config["value"]:"");
    }


    /**
     * 发布合作
     * @ApiTitle    (发布合作-暂时废弃)
     * @ApiSummary  (发布合作)
     * @ApiMethod   (POST)
     * @ApiRoute    (/api/index/addcooperate)
     * @ApiParams   (name="hospital_id", type="string", required=true, description="医院id")
     * @ApiParams   (name="expert", type="string", required=true, description="专家姓名")
     * @ApiParams   (name="phone", type="string", required=true, description="电话")
     * @ApiParams   (name="remark", type="string", required=true, description="备注")
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function addcooperate()
    {
        //接参
        $uid = $this->auth->id;
        $params = $this->request->param();
        extract($params);
        //调方法
        $model = CooperateService::addcooperate($uid,$hospital_id,$expert,$phone,$remark);
        $this->success('发布成功',$model);
    }


    /**
     * 我的合作
     * @ApiTitle    (我的合作-暂时废弃)
     * @ApiSummary  (我的合作)
     * @ApiMethod   (GET)
     * @ApiRoute    (/api/index/getcooperatelist)
     * @ApiParams   (name="page", type="integer", required=true, description="第几页")
     * @ApiParams   (name="pagesize", type="integer", required=true, description="大小")
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function getcooperatelist()
    {
        //接参
        $uid = $this->auth->id;
        $params = $this->request->param();
        extract($params);
        //调方法
        $list = CooperateService::getcooperatelist($uid,$page,$pagesize);
        if (isset($list))
        {
            //输出
            $this->success('',$list);
        }else{
            $this->error('您没有合作');
        }
    }

    /**
     * 管理员合作列表
     * @ApiTitle    (管理员合作列表-废弃)
     * @ApiSummary  (管理员合作列表)
     * @ApiMethod   (GET)
     * @ApiRoute    (/api/index/getadmincooperatelist)
     * @ApiParams   (name="page", type="integer", required=true, description="第几页")
     * @ApiParams   (name="pagesize", type="integer", required=true, description="大小")
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function getadmincooperatelist()
    {
        $uid = $this->auth->id;
        $params = $this->request->param();
        extract($params);
        $list = CooperateService::getadmincooperatelist($uid,$pagesize,$page);
        $this->success('',$list);
    }

    /**
     * 合作详情
     * @ApiTitle    (合作详情-废弃)
     * @ApiSummary  (合作详情)
     * @ApiMethod   (GET)
     * @ApiRoute    (/api/index/getcooperatebyid)
     * @ApiParams   (name="id", type="integer", required=true, description="合作id")
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function getcooperatebyid()
    {
        //接参
        $params = $this->request->param();
        extract($params);
        if (isset($id))
        {
            //调函数
            $model = CooperateService::getcooperatebyid($id);
            //输出
            $this->success('',$model);
        }else{
            $this->error('参数错误');
        }
    }

    /**
     * 取消合作发布
     * @ApiTitle    (取消合作发布-废弃)
     * @ApiSummary  (取消合作发布)
     * @ApiMethod   (GET)
     * @ApiRoute    (/api/index/deletecooperate)
     * @ApiParams   (name="id", type="integer", required=true, description="合作id")
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function deletecooperate()
    {
        //接参
        $params = $this->request->param();
        extract($params);
        //调方法
        CooperateService::deletecooperate($id);
        $this->success('删除成功');
    }

    /**
     * 发布订单信息
     * @ApiTitle    (发布订单信息)
     * @ApiSummary  (发布信息)
     * @ApiMethod   (POST)
     * @ApiRoute    (/api/index/addorder)
     * @ApiParams   (name="typedata", type="string", required=true, description="陪诊类型;1=自行问诊2=专人陪诊")
     * @ApiParams   (name="hospital_id", type="string", required=true, description="医院ID")
     * @ApiParams   (name="family_id", type="integer", required=true, description="就诊人id")
     * @ApiParams   (name="is_me", type="string", required=true, description="是否本人:0否1是")
     * @ApiParams   (name="visit_time", type="string", required=true, description="就诊时间")
     * @ApiParams   (name="type", type="integer", required=true, description="预约服务:1问诊2专家3体检4住院")
     * @ApiParams   (name="describe", type="string", required=true, description="描述")
     * @ApiParams   (name="annex", type="string", required=true, description="附件")
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function addorder()
    {
        if (empty($this->auth->level))
        {
            $this->error('您不是会员无法发布信息');
        }
        //接参
        $uid = $this->auth->id;
        $params = $this->request->post([
            'typedata',
            'hospital_id',
            'family_id',
            'is_me',
            'visit_time',
            'type',
            'describe',
            'annex'
        ]);
        //调函数
        $order = OrderService::addorder($uid,$params);
        //输出
        $this->success('',$order);
    }


    /**
     * 我的全部订单
     * @ApiTitle    (我的全部订单)
     * @ApiSummary  (我的全部订单)
     * @ApiMethod   (GET)
     * @ApiRoute    (/api/index/getorderlist)
     * @ApiParams   (name="status", type="string", required=true, description="状态：1=需求发布2=服务中3=已完成4=已取消")
     * @ApiParams   (name="page", type="integer", required=true, description="第几页")
     * @ApiParams   (name="pagesize", type="integer", required=true, description="大小")
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function getorderlist()
    {
        //接参
        $uid = $this->auth->id;

        $status = $this->request->post("status");
        $pages = $this->buildPageParams();
        //调函数
        $list = OrderService::getorderlist($uid,$status,$pages);
        $this->success('',$list);
    }
//

    /**
     * 订单详情
     * @ApiTitle    (订单详情)
     * @ApiSummary  (订单详情)
     * @ApiMethod   (GET)
     * @ApiRoute    (/api/index/getorderbyid)
     * @ApiParams   (name="id", type="integer", required=true, description="订单id")
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function getorderbyid()
    {
        //解参
        $params = $this->request->param();
        extract($params);
        //调方法
        $order = OrderService::getorderbyid($id);
        $this->success('',$order);
    }

    /**
     * 取消发布订单
     * @ApiTitle    (取消发布订单)
     * @ApiSummary  (取消发布订单)
     * @ApiMethod   (GET)
     * @ApiRoute    (/api/index/deleteorder)
     * @ApiParams   (name="id", type="integer", required=true, description="订单id")
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function deleteorder()
    {
        $params=$this->request->param();
        extract($params);
        if(isset($id)){
        OrderService::deleteorder($id);
        $this->success('取消成功');
        }else{
            $this->error("参数错误");
        }
    }

    /**
     * 管理员接单
     * @ApiTitle    (管理员接单-废弃)
     * @ApiSummary  (管理员接单)
     * @ApiMethod   (GET)
     * @ApiRoute    (/api/index/receivingorders)
     * @ApiParams   (name="id", type="integer", required=true, description="订单id")
     * @ApiReturn   ({
            'code':'1',
            'msg':'返回成功'
            })
     */
    public function receivingorders()
    {
        $params=$this->request->param();
        extract($params);
        if(isset($id)){
            OrderService::receivingorder($id);
            $this->success('接单成功');
        }else{
            $this->error("参数错误");
        }
    }
    /**
     * 管理员发送服务费
     * @ApiTitle    (管理员发送服务费-废弃)
     * @ApiSummary  (管理员发送服务费)
     * @ApiMethod   (POST)
     * @ApiRoute    (/api/index/sendservicefee)
     * @ApiParams   (name="id", type="integer", required=true, description="订单id")
     * @ApiParams   (name="money", type="integer", required=true, description="服务费金额")
     * @ApiReturn   ({
            'code':'1',
            'msg':'返回成功'
            })
     */
    public function sendservicefee()
    {
        $params=$this->request->param();
        extract($params);
        if(isset($id) && !empty($id)){
            OrderService::sendservicefee($id,$money);
            $this->success('发送成功');
        }else{
            $this->error("订单不存在");
        }
    }
    /**
     * 新用户列表
     * @ApiTitle    (新用户列表)
     * @ApiSummary  (新用户列表)
     * @ApiMethod   (GET)
     * @ApiRoute    (/api/index/getnewuserlist)
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function getnewuserlist()
    {
        $list = UserService::getnewuserlist();
        $this->success('',$list);
    }

    /**
     * 创建vip订单
     * @ApiTitle    (vip订单)
     * @ApiSummary  (vip订单)
     * @ApiMethod   (post)
     * @ApiRoute    (/api/index/creatviporder)
     * @ApiParams   (name="id", type="integer", required=true, description="id")
     * @ApiReturn   ({
            'code':'1',
            'msg':'返回成功'
       })
     */
    public function creatviporder()
    {
        $user_id=$this->auth->id;
        $id = $this->request->request('id');
        if(empty($id)){
            $this->error("参数错误");
        }
        $list = OrderService::creatviporder($user_id,$id);
        $this->success('',$list);
    }


    /**
     * 会员到期取消会员资格
     * @ApiTitle    (会员到期取消会员资格)
     * @ApiSummary  (会员到期取消会员资格)
     * @ApiMethod   (post)
     * @ApiRoute    (/api/index/creatorder)
     * @ApiReturn   ({
    'code':'1',
    'msg':'返回成功'
    })
     */
    public function cancelLevel()
    {
        $user_id=$this->auth->id;
        $isend=UserService::cancelLevel($user_id);
        return $this->success('',$isend);
    }



}
