import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate';
Vue.use(Vuex);
const store = new Vuex.Store({
	plugins:[  
	    // 可以有多个持久化实例  
	    createPersistedState({  
	      key: 'app_config_data',  // 状态保存到本地的 key   
	      paths: ['member', 'cookieKey',"indexaddress","delivery_price",'position','canceltime'],  // 要持久化的状态，在state里面取，如果有嵌套，可以  a.b.c   
	      storage: {  // 存储方式定义  
	        getItem: (key) => uni.getStorageSync(key), // 获取  
	        setItem: (key, value) => uni.setStorageSync(key, value), // 存储  
	        removeItem: (key) => uni.removeStorageSync(key) // 删除  
	      }  
	    })  
	],  
	state:{
		isYL:false,  // 社区养老的开关
		store:{},
		cart: [],
		orderType: 'takein',
		address: {},
		addresses: {},
		membercopy:{},  // 
		member: {
			// token:"0d3c85de-694d-4f92-8844-f777bd22ba99"
		},
		indexaddress:{},  
		shaddress:{},
		coupon:{},
		delivery_price:"", // 获取配送费
		position:{},  // 职位信息
		openid:"",
		lang: 'zh-cn',
		cookieKey:'PHPSESSID=e4dk4o2utr3c0n95tp42p745ai',
		// 默认为最近地址
		location: {},
		latlng:{},
		aftertime:[],
		canceltime:"",
		showcz:""
	},
	getters: {
		isLogin: state => Object.keys(state.member).length > 0	//是否登录
	},
	mutations: {
		// 是否显示充值时间
		SET_CZ(state,showcz){
			state.showcz = showcz;
		},
		// 订单自动取消时间
		SET_CANCELTIME(state,time){
			state.canceltime = time;
		},
		// 设置退款最后时间
		SET_AFTERSALE(state,after){
			state.aftertime = after;
		},
		// 获取登录页默认的姓名头像
		SET_MEMBERCOPY(state,copy){
			state.membercopy = copy
		},
		// 设置用户最近经纬度
		SET_LATLNG(state, data){
			state.latlng = data;
		},
		// 配送费
		SET_PEISONG(state, delivery_price){
			state.delivery_price = delivery_price
		},
		// 设置优惠券
		SET_COUPON(state, coupon){
			state.coupon = coupon
		},
		// 删除优惠券
		DEL_COUPON(state,coupon){
			state.coupon = {}
		},
		// 选择收货地址的地址存储
		seladdress(state, shaddress){
			state.shaddress = shaddress
		},
		// 主页小区的地址存储
		valiageaddress(state, indexaddress){
			state.indexaddress = indexaddress
		},
		SET_POSITION(state, position){
			state.position = position
		},
		SET_ORDER_TYPE(state, type) {
			state.orderType = type
		},
		SET_MEMBER(state, member) {
			state.member = member
		},
		SET_ADDRESS(state, address) {
			state.address = address
		},
		SET_ADDRESSES(state, addresses) {
			state.addresses = addresses
		},
		SET_STORE(state, store) {
			state.store = store
		},
		SET_CART(state, cart) {
			state.cart = cart
		},
		REMOVE_CART(state) {
			state.cart = []
		},
		setCookie(state, provider) {
			state.cookie = provider;
			uni.setStorage({
				key: 'cookieKey',
				data: provider
			});
		},
		SET_LOCATION(state, location) {
			state.location = location;
		},
		SET_OPENID(state, openid) {
			state.openid = openid;
		}
	},
	actions: {
		
	}
})

export default store