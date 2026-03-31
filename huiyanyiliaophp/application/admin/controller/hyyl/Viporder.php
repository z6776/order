<?php

namespace app\admin\controller\hyyl;

use app\common\controller\Backend;
use think\exception\DbException;
use think\response\Json;

/**
 * 会员订单
 *
 * @icon fa fa-circle-o
 */
class Viporder extends Backend
{

    /**
     * Viporder模型对象
     * @var \app\admin\model\hyyl\Viporder
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\hyyl\Viporder;
        $this->view->assign("statusList", $this->model->getStatusList());
    }



    /**
     * 查看
     *
     * @return string|Json
     * @throws \think\Exception
     * @throws DbException
     */
    public function index()
    {
        //设置过滤方法
        $this->request->filter(['strip_tags', 'trim']);
        if (false === $this->request->isAjax()) {
            return $this->view->fetch();
        }
        //如果发送的来源是 Selectpage，则转发到 Selectpage
        if ($this->request->request('keyField')) {
            return $this->selectpage();
        }
        [$where, $sort, $order, $offset, $limit] = $this->buildparams();
        $list = $this->model
            ->with(['viplevel','user'])
            ->where($where)
            ->order($sort, $order)
            ->paginate($limit);
        $result = ['total' => $list->total(), 'rows' => $list->items()];
        return json($result);
    }


}
