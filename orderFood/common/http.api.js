// /common/http.api.js

import apis from "./newapi";
import { baseUrl } from "./const.js";
// 此处第二个参数vm，就是我们在页面使用的this，你可以通过vm获取vuex等操作，更多内容详见uView对拦截器的介绍部分：
// https://uviewui.com/js/http.html#%E4%BD%95%E8%B0%93%E8%AF%B7%E6%B1%82%E6%8B%A6%E6%88%AA%EF%BC%9F
const install = (Vue, vm) => {
    let suburl = '/api';
	 // baseUrl.includes('9002') ? '/api' : "/addons/unidrink";
	// 收货地址-全部
	let addressAll = (params = {}) => vm.$u.post(suburl+'/Address/all', params);
	// 收货地址-添加
	let addressAdd = (params = {}) => vm.$u.post(suburl+'/Address/add', params);
	// 收货地址-编辑
	let addressEdit = (params = {}) => vm.$u.post(suburl+'/Address/edit', params);
	// 收货地址-删除
	let addressDelete = (params = {}) => vm.$u.post(suburl+'/Address/delete', params);
	// 我的钱包-充值列表
	let balanceGetMoneyList = (params = {}) => vm.$u.post(suburl+'/Balance/getMoneyList', params);
	// 我的钱包-充值
	let balanceRecharge = (params = {}) => vm.$u.post(suburl+'/Balance/recharge', params);
	// 我的钱包-充值
	let balanceGetBillList = (params = {}) => vm.$u.post(suburl+'/Balance/getBillList', params);
	
	// 优惠券-我的优惠券
	let couponMine = (params = {}) => vm.$u.post(suburl+'/Coupon/mine', params);
	// 优惠券-优惠券可用数量
	let couponCount = (params = {}) => vm.$u.post(suburl+'/Coupon/count', params);
	// 优惠券-未领取优惠券
	let couponIndex = (params = {}) => vm.$u.post(suburl+'/Coupon/index', params);
	// 优惠券-兑换列表
	let couponExchangeLog = (params = {}) => vm.$u.post(suburl+'/Coupon/exchangeLog', params);
	// 优惠券-领取/兑换优惠券
	let couponReceive = (params = {}) => vm.$u.post(suburl+'/Coupon/receive', params);
	
	// 菜单-全部菜品
	let menuGoods = (params = {}) => vm.$u.post(suburl+'/Menu/goods', params);
	// 菜单-广告图
	let menuAds = (params = {}) => vm.$u.post(suburl+'/Menu/ads', params);
	
	// 个人中心-我的服务
	let mineService = (params = {}) => vm.$u.post(suburl+'/Mine/service', params);
	// 个人中心-我的服务详情
	let mineServiceContent = (params = {}) => vm.$u.post(suburl+'/Mine/serviceContent', params);
	
	// 订单-创建订单
	let orderSubmit = (params = {}) => vm.$u.post(suburl+'/Order/submit', params);
	// 订单-订单列表
	let orderGetOrders = (params = {}) => vm.$u.post(suburl+'/Order/getOrders', params);
	// 订单-订单详情
	let orderDetail = (params = {}) => vm.$u.post(suburl+'/order/detail', params);
	// 订单-取餐列表
	let orderTakeFoods = (params = {}) => vm.$u.post(suburl+'/Order/takeFoods', params);
	// 订单-确认收到
	let orderReceive = (params = {}) => vm.$u.post(suburl+'/Order/receive', params);
	
	// 支付接口-微信统一下单接口
	let payUnify = (params = {}) => vm.$u.post(suburl+'/pay/unify', params);

	
	
	// 支付接口-微信内H5-JSAPI支付
	let payJssdkBuildConfig = (params = {}) => vm.$u.post(suburl+'/Pay/jssdkBuildConfig', params);
	// 支付接口-余额支付
	let payBalance = (params = {}) => vm.$u.post(suburl+'/Pay/balance', params);
	// 支付接口-支付宝支付（暂时无用）
	let payAlipay = (params = {}) => vm.$u.post(suburl+'/Pay/alipay', params);
	
	// 积分接口-签到的首页
	let scoreIndex = (params = {}) => vm.$u.post(suburl+'/Score/index', params);
	// 积分接口-立即签到
	let scoreDosign = (params = {}) => vm.$u.post(suburl+'/Score/dosign', params);
	// 积分接口-立即签到
	let scoreFillup = (params = {}) => vm.$u.post(suburl+'/Score/fillup', params);
	// 积分接口-积分记录
	let scoreLog = (params = {}) => vm.$u.post(suburl+'/Score/log', params);
	
	// 获取积分商城产品列表
	let scoreShopIndex = (params = {}) => vm.$u.post(suburl+'/score_shop/index', params);
	// 获取积分商城产品详情
	let scoreShopDetail = (params = {}) => vm.$u.post(suburl+'/score_shop/detail', params);
	// 积分兑换产品
	let scoreShopExchange = (params = {}) => vm.$u.post(suburl+'/score_shop/exchange', params);
	// 积分订单列表
	let scoreShopOrder = (params = {}) => vm.$u.post(suburl+'/score_shop/order', params);
	// 确认收到
	let scoreShopReceive = (params = {}) => vm.$u.post(suburl+'/score_shop/receive', params);
	// 订单详情
	let scoreShopOrderDetail = (params = {}) => vm.$u.post(suburl+'/score_shop/orderDetail', params);
	// 物流接口
	let scoreShopExpress = (params = {}) => vm.$u.post(suburl+'/score_shop/express', params);
	
	// 店铺接口-附近最近的门店
	let shopNearby = (params = {}) => vm.$u.post(suburl+'/Shop/nearby', params);
	// 店铺接口-获取所有店铺
	let shopGetList = (params = {}) => vm.$u.post(suburl+'/Shop/getList', params);
	// 店铺接口-获取两个经纬度之间的距离
	let shopGetDistanceFromLocation = (params = {}) => vm.$u.post(suburl+'/Shop/getDistanceFromLocation', params);
	
	// 信息接口-发送验证码
	let smsSend = (params = {}) => vm.$u.post(suburl+'/Sms/send', params);
	// 信息接口-微信小程序订阅信息
	let smsSubscribeMsg = (params = {}) => vm.$u.post(suburl+'/Sms/subscribeMsg', params);
	
	// 用户接口-会员登录
	let userLogin = (params = {}) => vm.$u.post(suburl+'/User/login', params);
	// 用户接口-重置密码
	let userResetpwd = (params = {}) => vm.$u.post(suburl+'/User/resetpwd', params);
	// 用户接口-更改用户信息
	let userEdit = (params = {}) => vm.$u.post(suburl+'/User/edit', params);
	// 用户接口-登录状态
	let userStatus = (params = {}) => vm.$u.post(suburl+'/User/status', params);
	// 用户接口-微信小程序登录
	let userAuthSession = (params = {}) => vm.$u.post(suburl+'/User/authSession', params);
	// 用户接口-微信小程序消息解密
	let userDecryptData = (params = {}) => vm.$u.post(suburl+'/User/decryptData', params);
	// 用户接口-微信小程序通过授权手机号登录
	let userLoginForWechatMini = (params = {}) => vm.$u.post(suburl+'/User/loginForWechatMini', params);
	// 用户接口-获取用户基础信息
	let userGetUserInfo = (params = {}) => vm.$u.post(suburl+'/User/getUserInfo', params);
	// 用户接口-获取用户基础信息
	let getDefaultsAddress = (params = {}) => vm.$u.post(suburl+'/address/getDefaultsAddress', params);
	// 获取系统配置
	let attentionOrder = (params = {}) => vm.$u.post(suburl+'/common/attentionOrder', params);
	
	// 获取充值配置
	let vipProgress = (params = {}) => vm.$u.post('/api/user/vipProgress', params);
	
	// 获取充值配置
	let MyYanglaoActivity = (params = {}) => vm.$u.post('/api/yanglao/MyYanglaoActivity', params);
	
	// 取消报名
	let cancelApply = (params = {}) => vm.$u.post('/api/yanglao/cancelApply', params);
	
	// 用户列表
	let userList = (params = {}) => vm.$u.post('/api/order/userList', params);
	
	// 用户代下单
	let daisub = (params = {}) => vm.$u.post('/api/order/daisub', params);
	
	// 将各个定义的接口名称，统一放进对象挂载到vm.$u.api(因为vm就是this，也即this.$u.api)下
	 
	vm.$u.api = {
		daisub,
		userList,
		cancelApply,
		MyYanglaoActivity,
	vipProgress,
		attentionOrder,
		getDefaultsAddress,
		addressAll, addressAdd, addressEdit, addressDelete,
		balanceGetMoneyList, balanceRecharge, balanceGetBillList,
		couponMine, couponCount, couponIndex, couponExchangeLog, couponReceive,
		menuGoods, menuAds,
		mineService, mineServiceContent,
		orderSubmit, orderGetOrders, orderDetail, orderTakeFoods, orderReceive,
		payUnify, payJssdkBuildConfig, payBalance, payAlipay,
		scoreIndex, scoreDosign, scoreFillup, scoreLog,
		scoreShopIndex, scoreShopDetail, scoreShopExchange, scoreShopOrder, scoreShopReceive, scoreShopOrderDetail, scoreShopExpress,
		shopNearby, shopGetList, shopGetDistanceFromLocation,
		smsSend, smsSubscribeMsg,
		userLogin, userResetpwd, userEdit, userStatus, userAuthSession, userDecryptData, userLoginForWechatMini, userGetUserInfo,
		...apis(Vue,vm)
	};
}

export default {
	install
}