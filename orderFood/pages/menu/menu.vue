<template>
	<view class="container">
		<view class="bgf7bf35">
			<u-navbar title="文文点餐" :is-back="false"  :background="bgColorOpa" :border-bottom="false">
			</u-navbar>
			<!-- 搜索 -->
			<view class="">
				<u-search  @change="searchtit"  placeholder="请输入菜品名称" v-model="keyword" :show-action="false"></u-search>
			</view>
		</view>
		
		<view class="main">
			<block v-if="false">
			<view class="nav">
				<view class="header">
					<view class="left" v-if="orderType == 'takein'">
						<view class="store-name" @click="selectShop()">
							<text>{{ store.name }}</text>
							<view class="iconfont iconarrow-right"></view>
						</view>
						<view class="store-location">
							<!-- <image src='/static/images/order/location.png' style="width: 30rpx; height: 30rpx;" class="mr-10"></image> -->
							<text>距离您 {{ store.far_text }}</text>
						</view>
					</view>
					<view class="left overflow-hidden" v-else>
						<!-- <view class="d-flex align-items-center overflow-hidden">
							<image src='/static/images/order/location.png' style="width: 30rpx; height: 30rpx;" class="mr-10"></image>
							<view class="font-size-extra-lg text-color-base font-weight-bold text-truncate">
								{{ address.address }}
							</view>
						</view>
						<view class="font-size-sm text-color-assist overflow-hidden text-truncate">
							由<text class="text-color-base" style="margin: 0 10rpx">{{ store.name }}</text>配送
						</view> -->
						<view class="store-name" @click="selectShop()">
							<view>{{ store.name }}
								<text class="small" v-if="store.distance > 0 && orderType == 'takeout'">(配送距离:
									{{store.distance}}km)</text>
								<text class="small" v-else-if="orderType == 'takeout'">(本店不支持外卖)</text>
							</view>
							<view class="iconfont iconarrow-right"></view>
						</view>
						<view class="store-location" @tap="takout(true)">
							<image src='/static/images/order/location.png' style="width: 30rpx; height: 30rpx;"
								class="mr-10"></image>
							<text>{{ address.address ? address.address : '请选择收货地址' }} ,距离您 {{ store.far_text }}</text>
						</view>
					</view>
					<view class="right">
						<view class="dinein" :class="{active: orderType == 'takein'}" @tap="SET_ORDER_TYPE('takein')">
							<text>自取</text>
						</view>
						<view class="takeout" :class="{active: orderType == 'takeout'}" @tap="takout">
							<text>外卖</text>
						</view>
						<!-- <view v-if="store.distance > 0">配送距离:{{store.distance}}km</view>
						<view v-else>外卖不配送</view> -->
					</view>
				</view>
				<!-- <view class="coupon">
					<text class="title">"霸气mini卡"超级购券活动，赶紧去购买</text>
					<view class="iconfont iconarrow-right"></view>
				</view> -->
			</view>
			<view style="height: 60rpx" v-if="store.notice">
				<!-- 文字滚动 -->
				<uni-notice-bar style="margin-top: 14upx;" color="#5A5B5C;" backgroundColor="" scrollable="true"
					single="true" :text="store.notice"></uni-notice-bar>
			</view>
			
			</block>
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
										<view class="good" v-for="(good, key) in products" :key="good.id" @click="$util.navTo('/pages2/shopdetail/index?id='+good.id,false)">
											<view class="image radius-20"  @tap.stop="showGoodDetailModal(good)">
												 <u-image :src="$util.getImgurl(good.image)" width="100%" height="100%" border-radius="20rpx" mode="aspectFill" ></u-image>
												<!-- <zimg :src='$util.getImgurl(good.image)' width="100%" height="100%" borderRadius="20rpx"/> -->
											</view>
											<!-- <image mode="aspectFill" :src="$util.getImgurl(good.image)" class=""></image> -->
											<view class="right">
												<text class="name">{{ good.title }}</text>
												<text class="tips">{{ good.desc }}</text>
												<view class="price_and_action">
													<text class="price fz-FF2525">￥{{ good.sales_price }}</text>
													
													<view class="btn-group skubtn" v-if="good.use_spec && good.stock > 0" @tap.stop="showGoodDetailModal(good)">
															选规格
														<view class="dot" v-show="goodCartNum(good.id)"> {{ goodCartNum(good.id) }}</view>
													</view>
													
													<view class="btn-group" v-if="!good.use_spec && good.stock > 0">
														<button type="" v-show="goodCartNum(good.id)" plain
															class="btn reduce_btn u-reset" size="mini" hover-class="none"
															@tap.stop="handleReduceFromCart(good)">
															<image :src="$util.cdnurl('reduce.png')"  class="wh44" mode=""></image>
														</button>
														<view class="number" v-show="goodCartNum(good.id)">
															{{ goodCartNum(good.id) }}</view>
														<button type="" class="btn add_btn u-reset" size="min" hover-class="none" @tap.stop="handleAddToCart(good, 1)">
															<image  :src="$util.cdnurl('add.png')"   class="wh44" mode=""></image>
														</button>
													</view>

													<view v-if="good.stock == 0">已售罄</view>
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
				<view class="cart-box">
					<view class="mark" @tap="openCartPopup">
						<image src="/static/images/menu/cart.png" class="cart-img" ></image>
						<view class="tag" v-if="isLogin">{{ getCartGoodsNumber }}</view>
					</view>
					<view @tap="openCartPopup" class="price">￥{{ getCartGoodsPrice }}</view>
					<button type="" class="pay-btn" @tap="toPay">
						去结算
						<!-- {{ disabledPay ? `差${spread}元起送` : '去结算' }} -->
					</button>
				</view>
				<!-- 购物车栏 end -->
			</view>
			<!-- 商品详情模态框 begin -->
			<modal :show="goodDetailModalVisible" class="good-detail-modal" color="#5A5B5C" width="90%" custom
				padding="0rpx" radius="12rpx">
				<view class="cover">
					<view class="btn-group" @tap="closeGoodDetailModal">
						<!-- @tap="closeGoodDetailModal"  <image src="/static/images/menu/share-good.png"></image> -->
						<image src="/static/images/menu/close.png"></image>
					</view>
				</view>
				<scroll-view class="detail" scroll-y>
					<view v-if="good.image" class="image m-b-10">
						<image :src="$util.getImgurl(good.image)"></image>
					</view>

					<view class="wrapper">
						<view class="basic">
							<view class="name">{{ good.title ||  "" }}</view>
							<view class="tips">{{ good.desc || "" }}</view>
						</view>
						
						<view class="properties" v-if="good.use_spec">
							<view class="property" v-for="(item, index) in good.specList" :key="index">
								<view class="title">
									<text class="name">{{ item.name }}</text>
									<view class="desc" v-if="item.desc">({{ item.desc }})</view>
								</view>
								<view class="values">
									<view class="value" v-for="(value, key) in item.child" :key="key"
										:class="{'default': item.default == value}"
										@tap="changePropertyDefault(index, key)">
										{{ value }}
									</view>
								</view>
							</view>
						</view>
					</view>
				</scroll-view>
				
				<view class="action">
					<view class="left">
						<view class="price">￥{{ good.sales_price }}</view>
						<view class="props" v-if="getGoodSelectedProps(good)">
							{{ getGoodSelectedProps(good) }}
						</view>
					</view>
					<view class="btn-group">
						<text style="margin-right: 20rpx;">库存：{{good.stock}} </text>
						
						<button type="" plain
							class="btn reduce_btn u-reset" size="mini" hover-class="none"
							@tap.stop="handlePropertyReduce">
							<image :src="$util.cdnurl('reduce.png')"  class="wh44" mode=""></image>
						</button>
						<view class="number">{{ good.number }}</view>
						<button type="" class="btn add_btn u-reset" size="min" hover-class="none" @tap.stop="handlePropertyAdd">
							<image  :src="$util.cdnurl('add.png')"   class="wh44" mode=""></image>
						</button>
					
					</view>
				</view>
				<view class="add-to-cart-btn" @tap="handleAddToCartInModal">
					<view>加入购物车</view>
				</view>
			</modal>
			<!-- 商品详情模态框 end -->
			<!-- 购物车详情popup -->
			<popup-layer direction="top" :show-pop="cartPopupVisible" class="cart-popup" @closeCallBack="openCartPopup">
				<template slot="content">
					<view class="top">
						<text @tap="handleCartClear">清空</text>
					</view>
					<scroll-view class="cart-list" scroll-y>
						<view class="wrapper">
							
							<view class="item" v-for="(item, index) in cart" :key="index">
								<view class="left">
									<view class="name d-flex f-start">
									   <view class="tagStyle m-r-10" v-if="item.isAc==1">福利抢购</view>
									   <view class=""> {{ item.title }} </view>  
									 </view>
									<view class="props">{{ item.props_text }}</view>
								</view>
								<view class="center">
									<text>￥{{ item.sales_price }}</text>
								</view>
								<view class="right">
									<button type="" plain size="mini" class="btn reduce_btn u-reset" hover-class="none"
										@tap="handleCartItemReduce(index)">
										<image  :src="$util.cdnurl('reduce.png')"  class="wh44" mode=""></image>
									</button>
									<view class="number">{{ item.number }}</view>
									<button type="" class="btn" size="min" hover-class="none"
										@tap="handleCartItemAdd(index)">
											<image  :src="$util.cdnurl('add.png')"  class="wh44" mode=""></image>
									</button>
								</view>
							</view>
							
							<view class="item" v-if="orderType == 'takeout' && store.packing_fee">
								<view class="left">
									<view class="name">包装费</view>
								</view>
								<view class="center">
									<text>￥{{ parseFloat(store.packing_fee) }}</text>
								</view>
								<view class="right invisible">
									<button type="default" plain size="mini" class="btn" hover-class="none">
										<view class="iconfont iconsami-select"></view>
									</button>
									<view class="number">1</view>
									<button type="primary" class="btn" size="min" hover-class="none">
										<view class="iconfont iconadd-select"></view>
									</button>
								</view>
							</view>
						</view>
					</scroll-view>
				</template>
			</popup-layer>
			<!-- 购物车详情popup -->
			<u-toast ref="uToast"></u-toast>
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
	import modal from '@/components/modal/modal'
	import popupLayer from '@/components/popup-layer/popup-layer';
	import zimg from "@/components/imageLazy/index.vue";
	import {
		mapState,
		mapMutations,
		mapActions,
		mapGetters
	} from 'vuex'
	import uniNoticeBar from '@/components/uni-notice-bar/uni-notice-bar.vue'
	import ourLoading from '@/components/our-loading/our-loading.vue'
    import menu from "./menu.js";  // 新功能都在这个里面请看
	export default {
		mixins:[menu],
		components: {
			zimg,
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
			getCartGoodsNumber(){ //计算购物车总数
				return this.cart.reduce((acc, cur) =>{
					return cur.number ? acc + cur.number :  acc+1 
				},0)
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
			async init() { //页面初始化
				this.loading = true;

				let error = {},
					res = this.location
				if (!this.location.hasOwnProperty('latitude')) {
					[error, res] = await uni.getLocation({
						type: 'wgs84'
					});
					if (error) {
						this.$refs.uToast.show({
							title: '获取位置失败，请检查是否开启相关权限',
							type: 'error'
						});
						// 默认地为你为北京地址
						res = {
							latitude: 39.919990,
							longitude: 116.456270
						};
					}
				}

				if (res) {
					console.log('当前位置的经度：' + res.longitude);
					console.log('当前位置的纬度：' + res.latitude);
					this.SET_LOCATION(res);

					let shop_id = 0;
					if (this.store.id) {
						shop_id = this.store.id;
					}

					let shop = await this.$u.api.shopNearby({
						lat: res.latitude,
						lng: res.longitude,
						shop_id: shop_id
					});
					if (shop) {
						//广告图
						this.getAds(shop.id);

						shop.notice = shop.status == 1 ? shop.notice : '店铺营业时间为:' + shop.bussines_time +
						'，不在营业时间内无法下单';
						// 设置店铺信息
						this.SET_STORE(shop);
						//await this.getStore()

						//this.goods = await this.$api('goods')
						let goods = await this.$u.api.menuGoods({
							shop_id: shop.id
						});
						if (goods) {
							this.goods = goods;
							this.refreshCart();
						}

						this.loading = false;
						uni.stopPullDownRefresh();
					}
				}
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
			if (!this.isLogin) {
								return this.$util.navTo("/pages/components/pages/login/newlogin");
							}
			      let cate = this.typelist.find(v=>v.id==this.currentCateId);
				const index = this.cart.findIndex(item => {
					if (good.use_spec) {
						//有规格的  id  规格 是否秒杀商品都相同 item.is_activity!=1 活动商品都属于新加的
						return (item.id === good.id) && (item.props_text === this.getGoodSelectedProps(good) && item.isAc!=1);
					} else {
						return item.id === good.id && item.isAc!=1;
					}
				});
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
				if (!this.isLogin) {
									return this.$util.navTo("/pages/components/pages/login/newlogin");
								}
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
			if (!this.isLogin) {
								return this.$util.navTo("/pages/components/pages/login/newlogin");
							}
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
					uni.setStorageSync("shopcart",this.cart);
					this.$util.navTo('/pages2/orderconfirm/index?iscart=1');
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
	.tagStyle{
		width: fit-content;
		height: 40rpx;
		background: #FFE2BE;
		border-radius: 10rpx 10rpx 10rpx 10rpx;
		font-weight: 500;
		font-size: 20rpx;
		color: #FB7A35;
		padding: 8rpx 10rpx;
	}
</style>
