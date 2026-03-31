// 
const install = (Vue, vm) => {
	// 获取收货地址列表
	let getAddressList = (params = {}) => vm.$u.post('/api/Address/getAddressList', params);
	// 添加收货地址 
	let addressAdd = (params = {}) => vm.$u.post('/api/Address/add', params);
	// 修改收货地址 
	let addressEdit = (params = {}) => vm.$u.post('/api/Address/edit', params);
	// 删除收货地址
	let addressDelete = (params = {}) => vm.$u.post('/api/Address/delete', params);
	// 获取产品类型 
	let getProductType = (params = {}) => vm.$u.post('/api/Product/getProductType', params);
	// 获取产品列表 
	let getProductList = (params = {}) => vm.$u.post('/api/Product/getProductList', params);
	// 获取今日秒杀，拼团列表 
	let getMarketingList = (params = {}) => vm.$u.post('/api/Product/getMarketingList', params);
	//  产品详情 
	let getProductInfo = (params = {}) => vm.$u.post('/api/Product/getProductInfo', params);
	//  我的评价 
	let myEvaluate = (params = {}) => vm.$u.post('/api/Product/myEvaluate', params);
	//  删除评价 
	let deleteEvaluate = (params = {}) => vm.$u.post('/api/Product/deleteEvaluate', params);
	//  等级列表/我的等级 
	let getUserlevel = (params = {}) => vm.$u.post('/api/userlevel/getUserlevel', params);
	// POST 销售客服 
	let getSale = (params = {}) => vm.$u.post('/api/statistics/getSale', params);
	// POST 销售客服订单列表 
	let getSaleOrder = (params = {}) => vm.$u.post('/api/statistics/getSaleOrder', params);
	// POST 销售客服产品汇总/生产人员/配送主管 
	let getSummary = (params = {}) => vm.$u.post('/api/statistics/getSummary', params);
	// POST 积分记录 
	let scorelog = (params = {}) => vm.$u.post('/api/score/log', params);
	// POST 积分记录GET add 
	let scoreadd = (params = {}) => vm.$u.post('/api/score/add', params);
	// POST 积分统计
	let scoreStatistics = (params = {}) => vm.$u.post('/api/score/scoreStatistics', params);
	// POST 充值列表
	let getMoneyList = (params = {}) => vm.$u.post('/api/balance/getMoneyList', params);
	// POST 充值
	let recharge = (params = {}) => vm.$u.post('/api/balance/recharge', params);
	// POST 账单列表 
	let getBillList = (params = {}) => vm.$u.post('/api/balance/getBillList', params);
	//POST 创建订单 
	let submit = (params = {}) => vm.$u.post('/api/order/submit', params);
	// POST 获取订单列表 
	let getOrders = (params = {}) => vm.$u.post('/api/order/getOrders', params);
	// POST 发表评论 
	let comment = (params = {}) => vm.$u.post('/api/order/comment', params);
	// POST POST 订单详情 
	let orderdetail = (params = {}) => vm.$u.post('/api/order/detail', params);
	// 	POST 取餐列表 
	let takeFoods = (params = {}) => vm.$u.post('/api/order/takeFoods', params);
	// 	POST 确认收到 
	let receive = (params = {}) => vm.$u.post('/api/order/receive', params);
	// 	POST 收藏
	let addCollect = (params = {}) => vm.$u.post('/api/operation/addCollect', params);
	// POST 收藏
	let isCollect = (params = {}) => vm.$u.post('/api/operation/isCollect', params);
	// POST 删除 
	let operationdeletes = (params = {}) => vm.$u.post('/api/operation/deletes', params);
	// POST 我的收藏 
	let getCollect = (params = {}) => vm.$u.post('/api/operation/getCollect', params);

	// POST 配送员/获取配送订单 
	let getDeliveryOrders = (params = {}) => vm.$u.post('/api/delivery/getDeliveryOrders', params);
	// POST 人员列表 
	let getAdminList = (params = {}) => vm.$u.post('/api/delivery/getAdminList', params);
	//POST 人员编辑 
	let setAdmin = (params = {}) => vm.$u.post('/api/delivery/setAdmin', params);
	//POST 申请转单 
	let toChange = (params = {}) => vm.$u.post('/api/delivery/toChange', params);
	//POST 转单审核 
	let getChange = (params = {}) => vm.$u.post('/api/delivery/getChange', params);
	// POST 确认送达 
	let received = (params = {}) => vm.$u.post('/api/delivery/received', params);
	// POST 指派 
	let assign = (params = {}) => vm.$u.post('/api/delivery/assign', params);
	//POST 默认优惠券 
	let authCoupon = (params = {}) => vm.$u.post('/api/coupon/authCoupon', params);
	// POST 我的优惠券 
	let mine = (params = {}) => vm.$u.post('/api/coupon/mine', params);
	//POST 优惠券可用数量 
	let count = (params = {}) => vm.$u.post('/api/coupon/count', params);
	// POST 未领取优惠券
	let couponindex = (params = {}) => vm.$u.post('/api/coupon/index', params);
	// POST 兑换记录 
	let exchangeLog = (params = {}) => vm.$u.post('/api/coupon/exchangeLog', params);
	// POST 领取/兑换优惠券
	let couponreceive = (params = {}) => vm.$u.post('/api/coupon/receive', params);
	// POST 获取广告图 
	let adsList = (params = {}) => vm.$u.post('/api/Common/adsList', params);
	// POST 问题反馈 
	let feedback = (params = {}) => vm.$u.post('/api/Common/feedback', params);
	// POST 获取小区列表 
	let getVillageList = (params = {}) => vm.$u.post('/api/village/getVillageList', params);
	// POST 获取自提点列表 
	let getSelfpickupList = (params = {}) => vm.$u.post('/api/village/getSelfpickupList', params);
	// POST 获取客服电话列表
	let getkfphoneList = (params = {}) => vm.$u.post('/api/village/getkfphoneList', params);
	// 获取用户信息
	let userindex = (params = {}) => vm.$u.get('/api/user/index', {
		params: params
	});

	// POST 收货地址
	let getAddressInfo = (params = {}) => vm.$u.post('/api/address/getAddressInfo', params);

	// 获取系统配置
	let getVillage = (params = {}) => vm.$u.post('/api/village/getVillage', params);
	//
	// 获取系统配置
	let addAftersale = (params = {}) => vm.$u.post('/api/aftersale/addAftersale', params);

	// 获取系统配置
	let cancelOrder = (params = {}) => vm.$u.post('/api/order/cancelOrder', params);

	// 加密订单 /api/order/haOrder
	let haOrder = (params = {}) => vm.$u.post('/api/order/haOrder', params);

	// 转单信息详情
	let getDeliveryInfo = (params = {}) => vm.$u.post('/api/delivery/getDeliveryInfo', params);
	//
	// 转单信息详情
	let assignTool = (params = {}) => vm.$u.post('/api/delivery/assignTool', params);

	// 转单信息详情
	let profile = (params = {}) => vm.$u.post('/api/user/profile', params);

	// 转单信息详情
	let destroyOrder = (params = {}) => vm.$u.post('/api/order/destroyOrder', params);

	// 余额账单列表
	let getMoneyLog = (params = {}) => vm.$u.post('/api/balance/getMoneyLog', params);

	// 获取养老服务类型 
	let getYanglaoType = (params = {}) => vm.$u.post('/api/yanglao/getYanglaoType', params);

	//  获取养老服务列表 
	let getYanglaoList = (params = {}) => vm.$u.post('/api/yanglao/getYanglaoList', params);

	// 养老服务详情 
	let getYanglaoInfo = (params = {}) => vm.$u.post('/api/yanglao/getYanglaoInfo', params);

	// 获取养老活动列表 
	let getYanglaoActivity = (params = {}) => vm.$u.post('/api/yanglao/getYanglaoActivity', params);

	// 养老活动详情 
	let getYanglaoActivityInfo = (params = {}) => vm.$u.post('/api/yanglao/getYanglaoActivityInfo', params);

	// 养老活动报名 
	let addApply = (params = {}) => vm.$u.post('/api/yanglao/addApply', params);
	
	// 我的评价 or all 
	let yanglaomyEvaluate = (params = {}) => vm.$u.post('/api/yanglao/myEvaluate', params);

	// 我的评价 or all
	let deleteyanglaoEvaluate = (params = {}) => vm.$u.post('/api/yanglao/deleteEvaluate', params);
	
	// 获取小区-自提点列表 
	let getVillageSe = (params = {}) => vm.$u.post('/api/village/getVillageSe', params);
	
	// 获取小区人员
	let subscript = (params = {}) => vm.$u.post('/api/common/subscript', params);
	// POST 管理申请售后 
	 let aftersaleAll = (params = {}) => vm.$u.post('/api/aftersale/aftersaleAll', params);
	 
	 // POST 管理申请售后
	  let ylorderSubmit = (params = {}) => vm.$u.post('/api/ylorder/submit', params);
	  
	  
	  // POST 获取养老服务订单列表 
	  let ylpeoplegetOrders = (params = {}) => vm.$u.post('/api/ylpeople/getOrders', params);
	  
	  // POST 获取养老服务订单列表
	  let goto = (params = {}) => vm.$u.post('/api/ylpeople/goto', params);
	  
	  // POST 服务未进行 
	  let ylpeoplecancelOrder = (params = {}) => vm.$u.post('/api/ylpeople/cancelOrder', params);
	  
	  // POST 完成服务 /api/ylpeople/complete
	   let ylpeoplecomplete = (params = {}) => vm.$u.post('/api/ylpeople/complete', params);
	   
	   // POST 订单详情 
	   let ylpeopledetail = (params = {}) => vm.$u.post('/api/ylpeople/detail', params);
	   
	   // POST 服务人员列表
	    let ylcoregetAdminList = (params = {}) => vm.$u.post('/api/ylcore/getAdminList', params);
		
		// POST 指派 
		let ylcorecomplete = (params = {}) => vm.$u.post('/api/ylcore/complete', params);
		
		// POST 获取订单列表
		let ylcoregetOrders = (params = {}) => vm.$u.post('/api/ylcore/getOrders', params);
		
		// POST 订单详情 /api/ylcore/detail
		let ylcoredetail = (params = {}) => vm.$u.post('/api/ylcore/detail', params);
		
	    // POST 统计 /api/ylcore/statistics
		let ylcorestatistics = (params = {}) => vm.$u.post('/api/ylcore/statistics', params);
	
	// 支付接口-微信统一下单接口
	let ylpayUnify = (params = {}) => vm.$u.post('/api/ylpay/unify', params);
	// POST 余额支付 
	let ylpaybalance = (params = {}) => vm.$u.post('/api/ylpay/balance', params);
	// POST 获取订单列表 /api/ylorder/getOrders
	let ylordergetOrders = (params = {}) => vm.$u.post('/api/ylorder/getOrders', params);
	 // 取消订单
	let ylordercancelOrder = (params = {}) => vm.$u.post('/api/ylorder/cancelOrder', params);
	// 订单详情 
	let ylorderdetail = (params = {}) => vm.$u.post('/api/ylorder/detail', params);
	// 获取小区列表
	let getCommunityList = (params = {}) => vm.$u.post('/api/village/getCommunityList', params);
	// 计算订单金额
	let calculation = (params = {}) => vm.$u.post('/api/order/calculation', params);
	// 计算订单金额
	let ylorderdestroyOrder = (params = {}) => vm.$u.post('/api/ylorder/destroyOrder', params);
	// 养老评价
	let ylordercomment = (params = {}) => vm.$u.post('/api/ylorder/comment', params);
	// 配送主管列表
	let deliverygetOrders = (params = {}) => vm.$u.post('/api/delivery/getOrders', params);
	
	// 计算价格
	let couponUsage = (params = {}) => vm.$u.post('/api/ylorder/couponUsage', params);
	
	// 计算积分
	let scoretotal = (params = {}) => vm.$u.post('/api/score/scoretotal', params);
	
	// 微信登录
	let loginWechat = (params = {}) => vm.$u.post('/api/user/loginWechat', params);
	// 
	// 微信登录
	let shcalculation = (params = {}) => vm.$u.post('/api/aftersale/calculation', params);
	
	// 混合支付
	let blendapi = (params = {}) => vm.$u.post('/api/pay/blend', params);
	
	
	// 更换商户号
	let generate = (params = {}) => vm.$u.post('/api/pay/generate', params);
	
	
	// 将各个定义的接口名称，统一放进对象挂载到vm.$u.api(因为vm就是this，也即this.$u.api)下
	return {
		generate,
		blendapi,
		shcalculation,
		loginWechat,
		scoretotal,
		couponUsage,
		deliverygetOrders,
		ylordercomment,
		ylorderdestroyOrder,
		calculation,
		getCommunityList,
		ylorderdetail,
		ylordercancelOrder,
		ylordergetOrders,ylpayUnify,ylpaybalance,
		ylcorestatistics,
		ylcoredetail,
		ylcorecomplete,
		ylcoregetOrders,
		ylcoregetAdminList,
		ylpeopledetail,
		ylpeoplecomplete,
		ylpeoplecancelOrder,
		goto,
		ylpeoplegetOrders,
		ylorderSubmit,
		aftersaleAll,
		subscript,
		getVillageSe,
		getYanglaoType,
		getYanglaoList,
		getYanglaoInfo,
		getYanglaoActivity,
		getYanglaoActivityInfo,
		addApply,
		yanglaomyEvaluate,
		deleteyanglaoEvaluate,
		getMoneyLog,
		destroyOrder,
		profile,
		assignTool,
		getDeliveryInfo,
		haOrder,
		cancelOrder,
		addAftersale,
		getVillage,
		getAddressInfo,
		userindex,
		getkfphoneList,
		getSelfpickupList,
		getVillageList,
		feedback,
		adsList,
		couponreceive,
		exchangeLog,
		couponindex,
		count,
		mine,
		authCoupon,
		assign,
		received,
		getChange,
		toChange,
		setAdmin,
		getAdminList,
		getDeliveryOrders,
		getCollect,
		operationdeletes,
		isCollect,
		addCollect,
		receive,
		takeFoods,
		orderdetail,
		comment,
		getOrders,
		submit,
		getBillList,
		recharge,
		getMoneyList,
		scoreStatistics,
		scoreadd,
		scorelog,
		getSummary,
		getSaleOrder,
		getSale,
		getUserlevel,
		deleteEvaluate,
		myEvaluate,
		getProductInfo,
		getMarketingList,
		getProductList,
		getProductType,
		addressDelete,
		addressEdit,
		addressAdd,
		getAddressList
	}
}


export default install