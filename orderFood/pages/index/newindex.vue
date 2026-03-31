<template>
	<view class="p-t-0">
		<view class="bgf7bf35">
			<u-navbar title="首页" :is-back="false" :background="bgColorOpa" :border-bottom="false">
				<view class="u-nav-slot d-flex f-start p-l-20" hover-class="op9"
					@click.stop="$util.navTo('/pages/index/choosecommunity?type=index&id='+valiage.id)">
					<u-icon name="map-fill" size="40" color="#000000"></u-icon>
					<text class="fz-000000 fz-32 m-l-10 m-r-10 maxwidth200 line1">{{ valiage.name ||  "选择小区" }}</text>
					<!-- valiage.name || -->
					<u-icon name="arrow-right" size="28" color="#000000"></u-icon>
				</view>
			</u-navbar>
			<!-- 搜索 -->
			<view class="">
				<u-search disabled placeholder="请输入幸福食堂商品名称/养老服务项目名称" @click="$util.navTo('/pages/index/history',false)"
					v-model="keyword" :show-action="false"></u-search>
			</view>
		</view>
		<view class="p20">
			<!-- 轮播图 -->
			<view class="">
				<u-swiper :showDot="swiperlist && swiperlist.length > 1" :list="swiperlist" height="370"
					@click="clickswiper"></u-swiper>
			</view>

			<view class="jsts d-flex m-b-30 m-t-30">
				<!--  -->
				<view class="jstsleft imgl" @click="isYL ? switchtab('yl')  : $u.toast('服务待开放')" v-if="isSh==='1'">
					<u-image :src="$util.cdnurl('yanglao.png')" width="100%" height="100%" mode="aspectFill"></u-image>
					<!-- <image :src="$util.cdnurl('yanglao.png')"  mode="" class="wh100"></image> -->
				</view>
				<view class="jstsright d-c-flex a-start">
					<view class="" @click.stop="switchtab()">
						<u-image :src="$util.cdnurl('shitang.png')" width="100%" height="100%"
							mode="aspectFill"></u-image>
						<!-- <image :src="$util.cdnurl('shitang.png')"  mode="" class="wh100"></image> -->
					</view>
					<view class="" @click.stop="isYL ? $util.navTo('/pages3/communitylife/index')  : $u.toast('服务待开放')"
						v-if="isSh==='1'">
						<u-image :src="$util.cdnurl('shequ.png')" width="100%" height="100%"
							mode="aspectFill"></u-image>
						<!-- <image :src="$util.cdnurl('shequ.png')"   class="wh100" mode=""></image> -->
					</view>
				</view>
			</view>

			<view class="money p20 p-relative radius-20">
				<image :src="$util.cdnurl('balancebg.png')" mode="" class="bgmoney radius-20"></image>
				<view class="d-flex f-start">
					<image :src="$util.cdnurl('balanceIcon.png')" mode="aspectFill" class="wh52 m-r-20"></image>
					<text class="balance">我的余额</text>
				</view>

				<view class="row m-t-30 d-flex m-l-20">
					<view class="d-flex f-start">
						<view class="pas m-r-10" v-if="isOpen">{{ position.money || "0.00" }}</view>
						<view class="pas m-r-10" v-else>* * * * * *</view>
						<image @click="openbalance()"
							:src="isOpen ?   $util.cdnurl('passwordopen.png')  :  $util.cdnurl('passwordclose.png') "
							mode="aspectFill" class="wh40 v-m"></image>
					</view>
					<mybtn msg='立即充值' v-if="showcz==1" width="200rpx" height="80rpx" @handclick="czfn" />
				</view>
			</view>

			<!-- 拼团组件 seckill mslist ptlist groupon-->
			<groupbuying @lookmany="(e)=>lookmany(e,'seckill')" type="seckill" :list="mslist" :openprice="openprice" v-if="mslist && mslist.length">
				<view class="d-flex">
					<text class="fz-32 fltxt">{{ seckill || "秒杀" }}</text>
					<view class="line"></view>
					<text class="fz-28">每日</text>
					<!-- m-l-20 -->
					<text class="fz-28 fz-ff0000 "> {{ titleqg }} </text>
					<text class="fz-28 fz-979797">进行抢购</text>
				</view>
			</groupbuying>

			<!-- 超值拼团 -->
			<groupbuying @lookmany="(e)=>lookmany(e,'groupon')"  :openprice="openprice" type="groupon" :list="ptlist"
				v-if="ptlist && ptlist.length">
				<view class="d-flex">
					<text class="fz-32 fltxt">超值拼团</text>
					<view class="line m-r-20"></view>
					<view class="d-flex avatargroup">
						<image :src="$util.isNull(item.user1,'avatar')"
							:style="{'zindex':index,'transform':'translateX('+-(10*index)+'rpx)'}" class="avatar"
							v-for="(item,index) in userList" :key="index" mode=""></image>
					</view>
					<text class="fz-28 fz-979797">{{ pttoal }}人拼团成功</text>
				</view>
			</groupbuying>



			<!-- 幸福食堂 -->
			<view class="d-flex m-b-30 m-t-20">
				<view class="fz-32 fz-000000 fz-weight subline">
					<view class="lineBorder">

					</view>
					<image :src="$util.cdnurl('xinfu.png')" class="subtitle"></image>
				</view>
				<view class="d-flex f-start" @click="switchtab()">
					<text class="fz-666666">查看更多</text>
					<u-icon name="arrow-right" color="#999999" size="24"></u-icon>
				</view>
			</view>
			<view class="tabbox">
				<ntab :list="typelist" @change="changetype" />
			</view>
			<view class="content">
				<view class="d-flex w100 j-center" v-if="!products || !products.length">
					<mescroll-empty />
				</view>
				<block v-else>
					<!-- <scroll-view scroll-y :style="[{'height': products.length>2 ?'1170rpx' : '570rpx'}]"  @scrolltolower="scrolltolower"> -->
					<!-- <view class="d-flex f-warp"> -->
					<view class="wh49" :class="{'m-0':index>products.length-3}" v-for="(item,index) in products"
						@click="$util.navTo('/pages2/shopdetail/index?id='+item.id,false)" :key="item.id">
						<view class="wh170">
							<u-image :src="$util.getImgurl(item.image)" width="100%" height="340rpx"
								border-radius="20rpx 20rpx 0 0" mode="aspectFill"></u-image>
							<!-- <zimg :src='$util.getImgurl(item.image)' width="100%" height="340rpx" borderRadius="20rpx 20rpx 0 0"/> -->
						</view>
						<view class="listbox">
							<view class="fz-32 fz-000000 u-line-1 text-align-left">{{item.title || ""}}</view>
							<view class="fz-24 fz-999999 u-line-1 m-t-30 m-b-30 text-align-left mar-bottom-30">
								{{item.desc || ""}}</view>
							<view class="zhuanfatxt d-flex m-t-10">
								<view class="d-flex f-start">
									<text class="fz-32 fz-ff0000">￥</text>
									<text class="fz-32 fz-ff0000 m-r-auto">{{item.sales_price || ""}}</text>
								</view>
								<view class="fz-24 fz-999999" v-if="item.real_sales>0">
									已售{{item.real_sales}}+
								</view>
								<image @click.stop="addCart(item,1)" src="../../static/shopcar.png" mode=""
									class="wh60"></image>
							</view>
						</view>
					</view>
					<!-- </view> -->
					<!-- <view class="m-t-30">
							
						</view>
						<u-loadmore :status="isxfend ? 'nomore' : 'loading'"  nomoreText="没有更多了哦~" />
					</scroll-view> -->

				</block>
			</view>
			<block v-if="isYL">
				<!-- 养老服务 -->
				<view class="d-flex m-b-30 m-t-30">
					<view class="fz-32 fz-000000 fz-weight subline">
						<view class="lineBorder">

						</view>
						<image src="../../static/images/newStatic/yl1.png" class="yltitle"></image>
					</view>
					<view class="d-flex f-start" @click="switchtab('yl')">
						<text class="fz-666666">查看更多</text>
						<u-icon name="arrow-right" color="#999999" size="24"></u-icon>
					</view>
				</view>

				<view class="tabbox">
					<ntab :list="ylcategory" @change="changeYltype" />
				</view>

				<view class="content">
					<view class="d-flex w100 j-center" v-if="!yllist || !yllist.length">
						<mescroll-empty />
					</view>
					<block v-else>
						<view class="wh49" v-for="(item,index) in yllist"
							@click="$util.navTo('/pages/careservices/detail?id='+item.id,false)" :key="item.id">
							<view class="wh170">
								<!-- <zimg :src='$util.getImgurl(item.image)' width="340rpx" height="340rpx" /> -->
								<u-image :src="$util.getImgurl(item.coverimage)" width="100%" height="340rpx"
									border-radius="20rpx 20rpx 0 0" mode="aspectFill"></u-image>
							</view>

							<view class="listbox">
								<view class="fz-32 fz-000000 u-line-1 text-align-left">{{item.name || ""}}</view>
								<view class="fz-24 fz-999999 u-line-1 m-t-30 m-b-30 text-align-left mar-bottom-30">
									{{item.shortdesc || ""}}</view>
								<view class="zhuanfatxt d-flex m-t-10">
									<view class="d-flex f-start">
										<text class="fz-32 fz-ff0000">￥</text>
										<text class="fz-32 fz-ff0000">{{item.price || ""}}</text>
									</view>
									<view class="fz-24 fz-999999" v-if="item.sales>0">
										已售{{item.sales}}+
									</view>
								</view>
							</view>
						</view>
					</block>
				</view>

			</block>
		</view>
		<u-mask :show="show" @click="show = false">
			<view class="pre" @tap.stop>
				<u-image radius="20" :show-loading="false" :src="$util.cdnurl('yhjlq.png')" width="637rpx"
					height="703rpx"></u-image>
				<view class="lq" @click.stop="linqu()">
					<u-image radius="20" :show-loading="false" :src="$util.cdnurl('btnlq.png')" width="270rpx"
						height="80rpx"></u-image>
				</view>
				<image src="../../static/close.png" class="wh48 icon-x" mode="" @click="show=false"></image>
			</view>
		</u-mask>
		<!-- 	<u-popup v-model="show" @close="show=false" mode="center" :round="20" :safeAreaInsetBottom="false" @touchmove.stop :safe-area="false">
			
		</u-popup> -->
		<u-modal v-model="showlogin" confirm-color="#FACE51" show-cancel-button :content="content"
			@confirm="navTologin"></u-modal>
		<phonecom />
		<!-- <secCon v-if="loading" /> -->
	</view>
</template>
<script>
	import ntab from "@/components/ntab/index.vue";
	import groupbuying from "@/components/groupbuying";
	import {
		mapGetters,
		mapState,
		mapMutations
	} from "vuex";
	import zimg from "@/components/imageLazy/index.vue";
	import ylmixins from "./listmix.js";
	import secCon from "./indexg.vue";
	export default {
		// 养老服务的列表代码以及幸福食堂的分页
		mixins: [ylmixins],
		components: {
			secCon,
			zimg,
			ntab,
			groupbuying
		},
		data() {
			return {
				loading:true,
				showlogin: false,
				content: "请先登录",
				show: false,
				current: 0,
				isOpen: false,
				swiperlist: [],
				keyword: "",
				background: {
					background: "transparent"
				},
				mslist: [],
				ptlist: [], // 拼团列表
				typelist: [], // 食堂类别列表
				products: [], // 产品列表
				valiage: {},
				pttoal: 0,
				userList: [],
				isSh: 0,
				currentCateId: "", // 当前选中的分类id
				seckill: "",
				coupon:[],
				openprice:""  ,// 是否开启销售价显示
				showcz:""   // 是否显示充值按钮
			}
		},
		computed: {
			...mapState(['position', "indexaddress", "isYL"]),
			...mapGetters(["isLogin"]),
			// mslist[0].activityin.starthour + "-"+ mslist[0].activityin.endhour
			titleqg() {
				let arr = this.mslist;
				if (arr && arr.length && arr[0].activityin) {
					return arr[0].activityin.starthour + "-" + arr[0].activityin.endhour
				};
				return "";
			}
		},
		onLoad() {
			this.getList();
		},
		onShow() {
			// 过审用
			this.getIsSh();
			this.getUserInfo();
			this.getBanner();
		},
		methods: {
			...mapMutations(["SET_POSITION", "SET_PEISONG", "SET_LATLNG", "SET_AFTERSALE","SET_CANCELTIME",'SET_CZ']),
			// 领取
			async linqu() {
				this.$util.navTo('/pages/components/pages/balance/getcoupon');
				this.show = false;
			},
			async getIsSh() {
				if (this.isLogin) {
					let coupon = await this.$u.api.couponindex({});
					if (coupon && coupon.length) {
						this.coupon = coupon;
						this.show = true
					}
				}


				let data = await this.$u.api.attentionOrder({
					key: "wxsh"
				});
				// order_endtime
				let seckill = await this.$u.api.attentionOrder({
					key: "seckill"
				});
				
				let openprice = await this.$u.api.attentionOrder({
					key: "openprice"
				});
				
				let aftersale_direct = await this.$u.api.attentionOrder({
					key: "aftersale_direct"
				});
				if (aftersale_direct) {
					let a = aftersale_direct.split(":");
					this.SET_AFTERSALE(a);
				};
				
				// 
				let auth_cancel = await this.$u.api.attentionOrder({
					key: "auth_cancel"
				});
				if (auth_cancel) {
					this.SET_CANCELTIME(auth_cancel);
				};
				
				//
				let showcz = await this.$u.api.attentionOrder({
					key: "showcz"
				});
				if (showcz) {
					this.showcz = showcz;
					this.SET_CZ(showcz);
				};
				
				if(openprice){
					this.openprice = openprice;
				}
				this.seckill = seckill;
				this.isSh = data;
			},
			// 获取配送费存储
			async getPs() {
				let data = await this.$u.api.attentionOrder({
					key: "delivery_price"
				});
				this.SET_PEISONG(data)
			},
			// 
			switchtab(type) {
				return type ? uni.switchTab({
						url: "/pages/careservices/index"
					}) :
					uni.switchTab({
						url: "/pages/menu/menu"
					})
			},
			async getUserInfo() {
				this.getPs();
				if (this.isLogin) {
					let data = await this.$u.api.userindex();
					if (data) {
						this.SET_POSITION(data);
					}
				};
			},
			// 
			czfn() {
				this.$util.navTo('/pages/components/pages/balance/newbalance')
			},
			// 
			openbalance() {
				if (!this.isLogin) {
					this.showlogin = true;
					return;
				}
				this.isOpen = !this.isOpen;
			},
			navTologin() {
				this.$u.route('/pages/components/pages/login/newlogin');
			},
			//添加购物车
			async addCart(good, num) {
				if (!this.isLogin) {
					return this.$util.navTo("/pages/components/pages/login/newlogin");
				}
				let cate = this.typelist.find(v => v.id == this.currentCateId);
				let cart = uni.getStorageSync("cart") || [];
				const index = cart.findIndex(item => {
					if (good.use_spec) {
						//有规格的  id  规格 是否秒杀商品都相同 item.is_activity!=1 活动商品都属于新加的
						return (item.id === good.id) && (item.props_text === this.getGoodSelectedProps(good) &&
							item.isAc != 1);
					} else {
						return item.id === good.id && item.isAc != 1;
					}
				});
				if (index > -1) {
					cart[index].number += num;
				} else {
					cart.push({
						...good,
						cate_id: cate.id,
						number: num,
						use_property: good.use_spec,
						props_text: good.use_spec ? this.getGoodSelectedProps(good) : ''
					})
				}
				uni.setStorageSync('cart', JSON.parse(JSON.stringify(cart)));
				this.$u.toast("加入成功");
			},
			getGoodSelectedProps(good, type = 'text') { //计算当前饮品所选属性
				if (good.use_spec) {
					let props = [];
					if (!Array.isArray(good.specList)) {
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
			// 点击幸福食堂tab
			changetype(id) {
				this.currentCateId = id;
				this.pagexf = 1;
				this.products = [];
				this.getProduct();
			},
			// 获取首页秒杀拼团列表
			async getList() {
				let _d = {
					atype: "seckill" //	string	是	活动类型;seckill=秒杀groupon=拼团
				}
				const typelist = await this.$u.api.getProductType();
				this.typelist = typelist;
				let id = typelist[0]?.id;
				this.currentCateId = id;
				this.getProduct();

				const data = await this.$u.api.getMarketingList(_d);
				_d.atype = "groupon";
				const ptlist = await this.$u.api.getMarketingList(_d);
				this.mslist = data?.data || [];
				this.ptlist = ptlist?.list?.data;
				this.pttoal = ptlist?.total;
				this.userList = ptlist?.userList;
			},
			async getProduct() {
				let _d = {
					category_id: this.currentCateId || "",
					page: this.pagexf,
					pagesize: 9999
				}
				const list = await this.$u.api.getProductList(_d);
				// 没有更多了
				if (list.data.length < 10) {
					this.isxfend = true;
				} else {
					this.isxfend = false;
				}
				this.products = [...this.products, ...list.data];
			},
			// 跳转公众号链接
			clickswiper(e) {
				let url = this.swiperlist[e].url;
				if (!url) {
					return;
				}
				uni.navigateTo({
					url: "/pages/components/pages/webview/index?url=" + url
				})
			},
			// 获取首页轮播图
			async getBanner() {
				// 获取最近小区
				this.getAddress(async (lat, lng) => {
					// 没有选过小区获取最近的
					if (!Object.keys(this.indexaddress).length) {
						const valiage = await this.$u.api.getVillage({
							lat,
							lng
						});
						let p = valiage.kfphone && valiage.kfphone.length ? valiage.kfphone[0]?.phone : "";
						this.SET_LATLNG({
							lat,
							lng,
							valiagephone: p
						});
						this.valiage = valiage;
							this.loading = false;
					} else {
						let phone = await this.$u.api.getkfphoneList({
							village_id: this.indexaddress.id
						});
						let _p = "";
						if (phone && phone.length) {
							_p = phone[0].phone
						};
						this.SET_LATLNG({
							lat: this.indexaddress.latitude || "",
							lng: this.indexaddress.longitude || "",
							valiagephone: _p || ""
						});
						this.valiage = this.indexaddress;
							this.loading = false;
					}

				});
				const res = await this.$u.api.adsList();
				this.swiperlist = res.data;
				for (let s of this.swiperlist) {
					s.image = this.$util.getImgurl(s.image);
				};
			},
			// 获取首页定位
			async getAddress(fn) {
				// 检查用户是否开启过权限
				let _t = this;
				uni.authorize({
					scope: "scope.userLocation",
					success() {
						uni.getLocation({
							success: (res) => {
								let latitude, longitude;
								latitude = res.latitude.toString();
								longitude = res.longitude.toString();
								fn(latitude, longitude)
							},
							fail(err) {
								wx.showModal({
									title: '提示', //提示的标题,
									content: '请打开手机定位以获取最近小区', //提示的内容,
									showCancel: true, //是否显示取消按钮,
									cancelText: '取消', //取消按钮的文字，默认为取消，最多 4 个字符,
									cancelColor: '#000000', //取消按钮的文字颜色,
									confirmText: '确定', //确定按钮的文字，默认为取消，最多 4 个字符,
									confirmColor: ' #FAB714', //确定按钮的文字颜色,
									success: res => {
										if (res.confirm) {
											// _t.getBanner();
											// uni.hideLoading();
											// wx.openSetting();
										} else if (res.cancel) {
											wx.showToast({
												title: '需要开启手机定位',
												icon: 'none',
												duration: 3000,
											})
										}
									}
								});
							}
						})
					},
					fail() {
						wx.showModal({
							title: '提示', //提示的标题,
							content: '请打开位置权限以获取最近小区', //提示的内容,
							showCancel: true, //是否显示取消按钮,
							cancelText: '取消', //取消按钮的文字，默认为取消，最多 4 个字符,
							cancelColor: '#000000', //取消按钮的文字颜色,
							confirmText: '确定', //确定按钮的文字，默认为取消，最多 4 个字符,
							confirmColor: ' #FAB714', //确定按钮的文字颜色,
							success: res => {
								if (res.confirm) {
									wx.openSetting()
								} else if (res.cancel) {
									wx.showToast({
										title: '需要位置权限',
										icon: 'none',
										duration: 2000,
									})
								}
							}
						});
					}
				})
			},
			// 显示更多
			lookmany(e, type) {
				this.$util.navTo("/pages2/flashsale/index?type=" + type);
			}
		}
	}
</script>
<style lang="scss" scoped>
	// 顶部输入框样式
	::v-deep.u-content {
		background-color: rgba(255, 255, 255, 0.25) !important;

		input {
			background-color: initial !important;
		}
	}

	// 轮播图激活样式
	::v-deep.u-indicator-item-round-active {
		background: #FACE51 !important;
	}

	.tabbox {
		margin-bottom: 30rpx;
		border-radius: 20rpx 20rpx 0;
		margin-bottom: 30rpx;
	}

	.maxwidth200 {
		max-width: 160rpx;
	}



	.money {
		.bgmoney {
			height: 100%;
			width: 100%;
			inset: 0;
			position: absolute;
			z-index: -1;
		}

		.balance {
			font-weight: 500;
			font-size: 32rpx;
			color: rgba(0, 0, 0, 0.5);
		}

		.wh52 {
			width: 52rpx;
			height: 48rpx;
		}
	}

	.wh60 {
		width: 40rpx;
		height: 40rpx;
	}

	.avatargroup {
		position: relative;

		.avatar {
			width: 40rpx;
			height: 40rpx;
			border-radius: 50%;
			position: relative;
		}
	}

	.subline {
		position: relative;

		.lineBorder {
			width: 6rpx;
			height: 36rpx;
			border-radius: 30rpx;
			left: 0;
			background: linear-gradient(to bottom, #F9DA77, #F7BF35 30%);
			position: absolute;
		}

		padding-left: 20rpx;
	}

	.subtitle {
		width: 128rpx;
		height: 28rpx;
	}

	.bgf7bf35 {
		box-sizing: border-box;
		background: linear-gradient(to bottom, #F9DA77, #F7BF35 30%);
		padding: 20rpx;
	}

	.wh48 {
		width: 48rpx;
		height: 48rpx;
	}

	.pas {
		min-width: 100rpx;
		color: #000000;
		font-size: 56rpx;
		font-weight: bold;
	}

	.pre {
		position: relative;
		width: 637rpx;
		left: 50%;
		top: 40%;
		transform: translate(-50%, -50%);

		.lq {
			position: absolute;
			bottom: 40rpx;
			left: 50%;
			transform: translateX(-50%);
		}

		.icon-x {
			position: absolute;
			bottom: -50rpx;
			left: 50%;
			transform: translateX(-50%);
			font-size: 38rpx;
			color: #999999;
		}
	}

	.fltxt {
		font-weight: 800;
		color: #FACE51;
	}

	.line {
		width: 4rpx;
		height: 40rpx;
		background-color: #FACE51;
		margin: 0 20rpx;
	}

	.jsts {
		.jstsleft {
			width: 350rpx;
			height: 360rpx;
			border-radius: 20rpx;
		}

		.jstsright {
			width: 350rpx;
			height: 360rpx;

			view {
				width: 344rpx;
				height: 172rpx;
				border-radius: 20rpx;
			}
		}
	}


	.content {
		display: flex;
		justify-content: space-between;
		flex-wrap: wrap;
	}


	.zhuanfatxt {
		color: rgba(255, 210, 61, 1);
		font-size: 28rpx;
		text-align: center;

		.linethough {
			font-size: 24rpx;
			color: #999999;
			text-decoration: line-through;
		}
	}

	.wh170 {
		width: 100%;
		height: 340rpx;
	}

	.listbox {
		border-radius: 20rpx;
		padding: 20rpx;

		.boxshop {
			padding: 20rpx;
			background-color: rgba(250, 250, 250, 1);
		}
	}

	.tit {
		font-size: 24rpx;
		color: #333333;
		font-weight: bold;
		text-align: center;
		min-height: 32rpx;
	}

	.wh49 {
		background-color: #fff;
		width: 49%;
		border-radius: 20rpx;
		height: 570rpx;
		padding-bottom: 20rpx;
		margin-bottom: 30rpx;
	}

	.h80 {
		height: 80rpx;
	}

	.wh80 {
		width: 100rpx;
		height: 100rpx;
		border-radius: 20rpx;
		margin-right: 20rpx;
		flex-shrink: 0;
	}

	.yltitle {
		width: 137rpx;
		height: 37rpx;
	}
</style>