<template>
	<view class="container">
		<view class="bgf7bf35">
			<u-navbar title="养老服务" :is-back="false"  :background="bgColorOpa" :border-bottom="false">
			</u-navbar>
			<!-- 搜索 -->
			<view class="">
				<u-search  @change="searchtit"  placeholder="请输入服务名称" v-model="keyword" :show-action="false"></u-search>
			</view>
		</view>
		
		<view class="main">
				<!-- #ifndef H5 -->
				<view class="content" :style="{height: 'calc(100vh - 200rpx + '+(store.notice ? '0rpx':'60rpx')+')'}">
					<!-- #endif -->
					<scroll-view class="menus" :scroll-into-view="menuScrollIntoView" scroll-with-animation scroll-y>
						<view class="wrapper">
							<view class="menu" :id="`menu-${item.id}`"
								v-for="(item, index) in typelist"  :class="{'current': item.id === currentCateId}" :key="index" @tap="handleMenuTap(item.id)">
								<text>{{ item.name }}</text>
								<!-- <view class="dot" v-show="menuCartNum(item.id)">{{ menuCartNum(item.id) }}</view> -->
							</view>
						</view>
					</scroll-view>
					<!-- goods list begin -->
					<!-- <scroll-view class="goods" scroll-with-animation scroll-y :scroll-top="cateScrollTop"
						@scroll="handleGoodsScroll"> -->
						<view class="goods">
						 <mescroll-uni :fixed="false" @init="mescrollInit" @down="downCallback" @up="upCallback">
						<view class="wrapper" v-if="products && products.length">
							<view class="list">
								<view class="category">
									<view class="items">
										<!-- 商品 begin -->
										<view class="good" v-for="(good, key) in products" :key="good.id" @click="$util.navTo('/pages/careservices/detail?id='+good.id+'&pagetype=yl',false)">
											<image mode="aspectFill" :src="$util.getImgurl(good.coverimage)" class="image radius-20"></image>
											<view class="right">
												<text class="name">{{ good.name }}</text>
												<!-- <text class="tips">{{ good.desc }}</text> -->
												<view class="price_and_action d-flex f-start">
													<text class="price fz-FF2525">￥{{ good.price }}</text>
													<text class="fz-28 fz-FF2525">/{{ good.unit }}</text>
												</view>

											</view>
										</view>
										<!-- 商品 end -->
									</view>
								</view>
								<!-- category end -->
							</view>
						</view>
						</mescroll-uni>
						</view>
					<!-- </scroll-view> -->
					<!-- goods list end -->
				</view>
				<!-- content end -->
				 <!-- v-if="cart.length > 0" -->
				<!-- 购物车栏 begin -->
				<view class="cart-box" v-if="false">
					<view class="mark" @tap="openCartPopup">
						<image src="/static/images/menu/cart.png" class="cart-img" ></image>
						<view class="tag">{{ getCartGoodsNumber }}</view>
					</view>
					<view @tap="openCartPopup" class="price">￥{{ getCartGoodsPrice }}</view>
					<button type="" class="pay-btn" @tap="toPay">
						去结算
						<!-- {{ disabledPay ? `差${spread}元起送` : '去结算' }} -->
					</button>
				</view>
				<!-- 购物车栏 end -->
			</view>
		</view>
		<!--轻提示-->
	<!-- 	<view class="loading" v-else>
			<ourLoading active background-color="" color="#00b1b7" text=" " />
			<button type="primary" style="z-index: 3001;position: absolute;top: 650rpx;" @click="init"
				v-if="!store.id">定位最近的门店</button>
			<u-toast ref="uToast"></u-toast>
		</view> -->
</template>

<script>
	import modal from '@/components/modal/modal';
	import popupLayer from '@/components/popup-layer/popup-layer';
	import {
		mapState,
		mapMutations,
		mapActions,
		mapGetters
	} from 'vuex';
	import uniNoticeBar from '@/components/uni-notice-bar/uni-notice-bar.vue'
	import ourLoading from '@/components/our-loading/our-loading.vue'
    import menu from "./menu.js";  // 新功能都在这个里面请看
	export default {
		mixins:[menu],
		components: {
			modal,
			popupLayer,
			uniNoticeBar,
			ourLoading
		},
		data() {
			return {
				keyword:"",
				goods: [], //所有商品
				ads: [],
				loading: true,
				currentCateId: "", //默认分类
				cateScrollTop: 0,
				menuScrollIntoView: '',
				cart: [], //购物车
				goodDetailModalVisible: false, //是否饮品详情模态框
				good: {}, //当前饮品
				category: {}, //当前饮品所在分类
				cartPopupVisible: false,
				sizeCalcState: false
			}
		},
		onPullDownRefresh() {
			// this.init()
		},
		onLoad() {
			// this.init();
		},
		onHide() {
			// 重新进入要重新计算页面高度，否则有问题
			this.sizeCalcState = false;
		},
		onShow() {
			this.refreshCart();
		},
		computed: {
			...mapState(['orderType', 'address', 'store', 'location']),
			...mapGetters(['isLogin']),
			goodCartNum() { //计算单个饮品添加到购物车的数量
				return (id) => this.cart.reduce((acc, cur) => {
					if (cur.id === id) {
						return acc += cur.number
					}
					return acc
				}, 0)
			},
			menuCartNum() {
				return (id) => this.cart.reduce((acc, cur) => {
					if (cur.cate_id === id) {
						return acc += cur.number
					}
					return acc
				}, 0)
			},
			getCartGoodsNumber() { //计算购物车总数
				return this.cart.reduce((acc, cur) => acc + cur.number, 0)
			},
			getCartGoodsPrice() { //计算购物车总价
			    for (let s of this.cart) {
			    	if(!s.number){
						s.number = 1
					}
			    }
				let price = this.cart.reduce((acc, cur) => acc + cur.number * cur.sales_price, 0);
				return parseFloat(price).toFixed(2);
			},
			disabledPay() { //是否达到起送价
				return this.orderType == 'takeout' && (this.getCartGoodsPrice < parseFloat(this.store.min_price)) ? true : false
			},
			spread() { //差多少元起送
				if (this.orderType != 'takeout') return
				return parseFloat((this.store.min_price - this.getCartGoodsPrice).toFixed(2))
			}
		},
		methods: {
			...mapMutations(['SET_ORDER_TYPE', 'SET_STORE', 'SET_LOCATION']),
			...mapActions(['getStore']),
			// 模仿php
			in_array(search, array) {
				for (var i in array) {
					if (array[i] == search) {
						return true;
					}
				}
				return false;
			},
			initList(){
				 this.products = [];
				 this.mescroll.resetUpScroll();
			},
			
			selectShop() {
				uni.navigateTo({
					url: '/pages/components/pages/shop/shop'
				})
			},
			refreshCart()
			{
				let cart = uni.getStorageSync('cart') || [];
				// debugger;
			    this.cart = cart;
			},
			async getAds(shop_id) {
				let data = await this.$u.api.menuAds({
					shop_id: shop_id
				});
				if (data) {
					this.ads = data;
				}
			},
			takout(force = false) {
				if (this.orderType == 'takeout' && force == false) return

				if (!this.isLogin) {
					uni.navigateTo({
						url: '/pages/components/pages/login/login'
					})
					return
				} else {
					if (!this.address.hasOwnProperty('address') || force == true) {
						uni.navigateTo({
							url: '/pages/components/pages/address/address?is_choose=true'
						})
					} else {
						this.SET_ORDER_TYPE('takeout');
					}
				}

			},
			handleMenuTap(id) { //点击菜单项事件
				this.currentCateId = id;
				this.initList();
				// this.$nextTick(() => this.cateScrollTop = this.goods.find(item => item.id == id).top)
			},
			handleGoodsScroll({
				detail
			}) { //商品列表滚动事件
				if (!this.sizeCalcState) {
					this.calcSize()
				}
				const {
					scrollTop
				} = detail
				let tabs = this.goods.filter(item => item.top <= scrollTop).reverse()
				if (tabs.length > 0) {
					this.currentCateId = tabs[0].id
				}
			},
			calcSize() {
				let h = 10
				let view = uni.createSelectorQuery().select('#ads')
				if (view) {
					view.fields({
						size: true
					}, data => {
						if (data) {
							h += Math.floor(data.height)
						}
					}).exec()
				}

				this.goods.forEach(item => {
					let view = uni.createSelectorQuery().select(`#cate-${item.id}`)
					view.fields({
						size: true
					}, data => {
						item.top = h
						h += data.height
						item.bottom = h
					}).exec()
				})
				this.sizeCalcState = true
			},
			handleAddToCart(good,num){ //添加到购物车
			      let cate = this.typelist.find(v=>v.id==this.currentCateId);
				const index = this.cart.findIndex(item => {
					if (good.use_spec) {
						return (item.id === good.id) && (item.props_text === this.getGoodSelectedProps(good));
						
					} else {
						return item.id === good.id
					}
				})
				if (index > -1) {
					this.cart[index].number += num
				} else {
					this.cart.push({
						...good,
						cate_id: cate.id,
						number: num,
						use_property: good.use_spec,
						props_text: good.use_spec ? this.getGoodSelectedProps(good) : ''
					})
				}
				uni.setStorageSync('cart', JSON.parse(JSON.stringify(this.cart)))
			},
						
			// handleAddToCart(good, num) { //添加到购物车
			//    let cate = this.typelist.find(v=>v.id==this.currentCateId);
			// 	const index = this.cart.findIndex(item => {
			// 			return  item.id === good.id
			// 	})
			// 	if (index > -1) {
			// 		this.cart[index].number += num
			// 	} else {
			// 		this.cart.push({
			// 			...good,
			// 			cate_id: cate.id,
			// 			number: num,
			// 			props_text: good.use_spec ? this.getGoodSelectedProps(good) : ''
			// 		})
			// 	}
			// 	uni.setStorageSync('cart', JSON.parse(JSON.stringify(this.cart)))
			// },
			handleReduceFromCart(good) {
				const index = this.cart.findIndex(item => item.id === good.id)
				this.cart[index].number -= 1
				if (this.cart[index].number <= 0) {
					this.cart.splice(index, 1)
				}
				uni.setStorageSync('cart', JSON.parse(JSON.stringify(this.cart)))
			},
			showGoodDetailModal(good) {
				this.good = JSON.parse(JSON.stringify({
					...good,
					number: 1
				}));
				 let item = this.typelist.find(v=>v.id==this.currentCateId);
				this.category = JSON.parse(JSON.stringify(item))
				this.goodDetailModalVisible = true;
				if(!Array.isArray(this.good.specList)){
					this.good.specList = JSON.parse(this.good.specList);
				}
				for (let i = 0; i < this.good.specList.length; i++) {
					this.changePropertyDefault(i, 0);
				}
			},
			closeGoodDetailModal() { //关闭饮品详情模态框
				this.goodDetailModalVisible = false
				this.category = {}
				this.good = {}
			},
			changePropertyDefault(index, key) { //改变默认属性值
				if(!Array.isArray(this.good.specList)){
					this.good.specList = JSON.parse(this.good.specList);
				}
				if(!Array.isArray(this.good.specTableList)){
					this.good.specTableList = JSON.parse(this.good.specTableList);
				}
				console.log(typeof this.good.specList);
				// 
				if (this.in_array(this.good.specList[index].child[key], this.good.specList[index].disable)) {
					console.log(11)
					return;
				}
				
				if (!this.good.specList[index] || !this.good.specList[index].child[key]) {
					return;
				}

				this.good.specList[index].default = this.good.specList[index].child[key];
				this.good.number = 1;

				let specSelectedName = [];
				
				for (let item of this.good.specList) {
					if (item.default != '') {
						specSelectedName.push(item.default);
					}
				}
          
				for (let item of this.good.specTableList) {
					if (item.value.join(' ') == specSelectedName.join(' ')) {
						this.good.market_price = parseFloat(item.market_price).toFixed(2);
						this.good.sales_price = parseFloat(item.sales_price).toFixed(2);
						this.good.stock = item.stock;
						this.good.image = item.image ? item.image : this.good.image;
					}
				}
				this.$forceUpdate();
			},
			getGoodSelectedProps(good, type = 'text') { //计算当前饮品所选属性
				if (good.use_spec) {
					let props = [];
					if(!Array.isArray(good.specList)){
						good.specList = JSON.parse(good.specList);
					}
					good.specList.forEach(values => {	
						if (type === 'text' && values.default) {
							props.push(values.default)
						}
					});
					return type === 'text' ? props.join(',') : props
				}
				return ''
			},
			handlePropertyAdd() {
				this.good.number += 1
			},
			handlePropertyReduce() {
				if (this.good.number === 1) return
				this.good.number -= 1
			},
			handleAddToCartInModal() {
				if (this.good.stock <= 0) {
					this.$u.toast('商品库存不足');
					return;
				}
				this.handleAddToCart(this.good, this.good.number)
				this.closeGoodDetailModal()
			},
			openCartPopup() { //打开/关闭购物车列表popup
				this.cartPopupVisible = !this.cartPopupVisible;
			},
			handleCartClear() { //清空购物车
				uni.showModal({
					title: '提示',
					content: '确定清空购物车么',
					success: ({
						confirm
					}) => {
						if (confirm) {
							this.cartPopupVisible = false
							this.cart = []
							uni.setStorageSync('cart', JSON.parse(JSON.stringify(this.cart)))
						}
					}
				})
			},
			handleCartItemAdd(index) {
				this.cart[index].number += 1
				uni.setStorageSync('cart', JSON.parse(JSON.stringify(this.cart)))
			},
			handleCartItemReduce(index) {
				if (this.cart[index].number === 1) {
					this.cart.splice(index, 1)
				} else {
					this.cart[index].number -= 1
				}
				if (!this.cart.length) {
					this.cartPopupVisible = false
				}
				uni.setStorageSync('cart', JSON.parse(JSON.stringify(this.cart)))
			},
			toPay() {
				if(!this.cart.length){
					return this.$u.toast("请选择商品");
				}
                   this.$util.navTo("/pages2/orderconfirm/index")
				  return;
				if (!this.isLogin) {
					uni.navigateTo({
						url: '/pages/components/pages/login/login'
					})
					return
				} else {
					if (this.store.status == 0) {
						this.$u.toast('不在店铺营业时间内');
						return;
					}
					// 判断当前是否在配送范围内
					if (this.orderType == 'takeout' && this.store.distance < this.store.far) {
						this.$u.toast('选中的地址不在配送范围');
						return;
					}

					uni.showLoading({
						title: '加载中'
					});
					if(!this.cart.length){
						return this.$u.toast("请选择商品");
					}
					uni.setStorageSync('cart', JSON.parse(JSON.stringify(this.cart)))

					uni.navigateTo({
						url: '/pages/components/pages/pay/pay'
					})
				}

				uni.hideLoading()
			}
		}
	};
</script>

<style lang="scss" scoped>
	@import '~@/pages/menu/menu.scss';
	// 顶部输入框样式
	::v-deep.u-content{
		background-color: rgba(255,255,255,0.25) !important;
		input{
			background-color: initial !important;
		}
	}
	.skubtn{
		width: fit-content;
		height: 60rpx;
		padding: 0 20rpx 0;
		line-height: 60rpx;
		text-align: center;
		border-radius: 20rpx;
		background-color: #FACE51;
		border-radius: 90rpx;
		color: #000;
		font-size: 28rpx;
		.dot {
			position: absolute;
			background-color: #ffffff;
			border: 1px solid #FACE51 !important;
			color: #000000 !important;
			font-size: $font-size-sm;
			width: 36rpx;
			height: 36rpx;
			line-height: 36rpx;
			text-align: center;
			border-radius: 100%;
			right: -12rpx;
			top: -10rpx;
		}
	}
	.bgf7bf35{
		box-sizing: border-box;
		background: linear-gradient(to bottom,#F9DA77,#F7BF35 30%);
		padding: 20rpx;
	}
	
	.wh44{
		width: 44rpx;
		height: 44rpx;
	}
</style>
