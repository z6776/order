<?php

namespace app\admin\controller\hyyl;

use app\common\controller\Backend;
use think\exception\DbException;
use think\response\Json;

/**
 * 订单
 *
 * @icon fa fa-circle-o
 */
class Order extends Backend
{
    /**
     * 无需鉴权的方法,但需要登录
     * @var array
     */
    protected $noNeedRight = ['service'];
    /**
     * Order模型对象
     * @var \app\admin\model\hyyl\Order
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\hyyl\Order;
        $this->view->assign("typedataList", $this->model->getTypedataList());
        $this->view->assign("statusList", $this->model->getStatusList());
        $this->view->assign("statusList1", $this->model->getStatusList1());
    }

    protected $relationSearch = true;

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
            ->with(['user','hospital','family'])
            ->where($where)
            ->order($sort, $order)
            ->paginate($limit);
        $result = ['total' => $list->total(), 'rows' => $list->items()];
        return json($result);
    }

    //开始服务
    public function service($ids = null){
        if ($ids) {
            $row = $this->model->get($ids);
            if (!$row) {
                $this->error(__('No Results were found'));
            }
            $row->status = '2';
            $row->save();
            $this->success(__('Operation successfully'));
        }
    }


}
