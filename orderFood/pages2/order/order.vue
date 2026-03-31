<template>
	<view class="content">
		<view class="bgf7bf35">
			<u-navbar title="幸福食堂订单" :is-back="false" :background="bgColorOpa" :border-bottom="false">
				<view class="p-l-20" @click="$util.back()">
					<u-icon name="arrow-left" size="32" color="#000000" bold></u-icon>
				</view>
			</u-navbar>
			<!-- 搜索 -->
			<view class="d-flex search">
				<input class="ints" type="text" placeholder="请输入菜品名称" v-model="keyword" @input="searchtit" />
				<view class="rightslot" @click.stop="initList">
					<image :src="$util.cdnurl('search.png')" mode="" class="wh38"></image>
					<text class="fz-32">搜索</text>
				</view>
			</view>
		</view>

		<view class="pbox">
			<v-tabs paddingItem="0 12rpx" :scroll="true" color="#999999" lineColor="#FACE51" lineHeight="6rpx" bold
				activeColor="#FACE51" v-model="tabCurrentIndex" field="text" :lineScale="0.3" bgColor="transparent"
				:tabs="navList" @change="changeTab"></v-tabs>
		</view>
		<mescroll-body @init="mescrollInit" @down="downCallback" @up="upCallback">
			<view class="p20 p-t-0">
				<block v-for="(item,index) in list" :key="item.order_id">
					<view class="cart-box radius-20 m-t-20" @click="godetail(item)">
						<view class="d-flex f-start p-b-30">
							<!-- v-if="tabCurrentIndex==1 || tabCurrentIndex==0" -->
							<text
								class="fz-28 fz-494949 m-r-auto">{{ $util.parseTime(item.createtime,"{y}-{m}-{d}") }}</text>
							<text class="fz-32 fz-000000">{{ item.order_status_text || "" }}</text>
							<!-- <text v-if="tabCurrentIndex==2" class="fz-32 fz-weight fz-000000">待取餐</text>
					<text v-if="tabCurrentIndex==3" class="fz-32 fz-weight fz-000000">待评价</text>
					<text v-if="tabCurrentIndex==4" class="fz-32 fz-weight fz-000000">已完成</text>
					<text v-if="tabCurrentIndex==5" class="fz-32 fz-weight fz-000000">已取消</text>
					<text v-if="tabCurrentIndex==6" class="fz-32 fz-weight fz-000000">退款/售后</text> -->
						</view>
						<view class="d-flex">
							<scroll-view scroll-x class="scrollx flex-1">
								<image :src="$util.getImgurl(v.image)" class="loaded" mode="aspectFill" :key="i" v-for="(v,i) in item.products"></image>
							</scroll-view>
							<view class="d-flex fs-0 scrollright f-end">
								<view class="fz-28 fz-454545">
									共 {{ item.products.length || "0" }} 件
								</view>
								<u-icon name="arrow-right" size="28" color="#000000"></u-icon>
							</view>
						</view>

						<view class="d-flex m-t-30">
							<text class="fz-28 fz-000000 m-r-10" v-if="item.subtype==2">配送到家</text>
							<text class="fz-28 fz-000000 m-r-10" v-if="item.subtype==1">堂食</text>
							<text class="fz-28 fz-000000 m-r-10" v-if="item.subtype==3">配送点自提</text>

							<view class="" v-if="item.order_status_text=='待付款'">
								<text class="fz-24 basecolor">待支付金额 </text>
								<text class="fz-28 fz-ff0000">￥{{ item.total_price || "" }}</text>
							</view>

							<view class="fz-28 fz-FF2727 fz-weight" v-if="item.order_status_text!='待付款'">
								<text class="fz-24 basecolor"> 支付金额 </text>
								<text class="fz-28 fz-ff0000">￥{{ item.total_price || "" }}</text>
							</view>

						</view>
						<!-- btn 按钮 -->
						<view class="d-flex f-end">
							<view class="btn trans" v-if="item.order_status_text=='待付款'" @click.stop="btnclick(0,item)">
								取消订单
							</view>
							<view class="btn" v-if="item.order_status_text=='待付款' && $util.isShowcon(item)" @click.stop="contiute(item)">
								继续支付
							</view>
							<view class="btn trans" v-if="shstatus(item)" @click.stop="shfn(item)">
								申请售后
							</view>
							<view class="btn" v-if="item.order_status_text=='待取餐'" @click.stop="btnclick(1,item)">
								确认取餐
							</view>
							<view class="btn" v-if="item.order_status_text=='待评价'" @click.stop="pjfn(item)">
								去评价
							</view>
							<!-- <view class="btn" v-if="item.status==3" @click.stop="$util.navTo('/pages2/order/orderdetail')">
						查看订单
					</view> -->
						</view>

					</view>
				</block>
			</view>
		</mescroll-body>
		<!--    -->
		<orderpop :show.sync="cancelList[currentpop]['show']" :content="cancelList[currentpop]['msg']"
			@confirm="confirm" :isShowSlot="false">
		</orderpop>


	</view>
</template>

<script>
	// import {
	// 	CartIndex
	// } from '@/config/api.js';
	import MescrollMixin from "@/utils/mescroll.js";
	import orderpop from "@/components/orderpop/index.vue";
	export default {
		mixins: [MescrollMixin],
		components: {
			orderpop
		},
		data() {
			return {
				list: [],
				form: {},
				showApply: false,
				currentpop: 0,
				cancelList: [{
					msg: "确认取消?",
					show: false
				}, {
					msg: "确认取餐?",
					show: false
				}, {
					msg: "申请换货?",
					show: false
				}, {
					msg: "上传单号",
					show: false
				}],
				show: false, // 显示弹窗
				// 类型:1.待付款 2.待取餐 3.待评价 4，已完成 5.已取消 6.退款 ,7.拼团中
				navList: [{
						state: 0,
						text: '全部',
						loadingType: 'more',
						orderList: [],
						page: 1
					},
					{
						state: 1,
						text: '待付款',
						loadingType: 'more',
						orderList: [],
						page: 1
					},
					{
						state: 7,
						text: '拼团中',
						loadingType: 'more',
						orderList: [],
						page: 1
					},
					{
						state: 2,
						text: '待取餐',
						loadingType: 'more',
						orderList: [],
						page: 1
					},
					{
						state: 3,
						text: '待评价',
						loadingType: 'more',
						orderList: [],
						page: 1
					},
					{
						state: 4,
						text: '已完成',
						loadingType: 'more',
						orderList: [],
						page: 1
					}, {
						state: 5,
						text: '已取消',
						loadingType: 'more',
						orderList: [],
						page: 1
					},
					{
						state: 6,
						text: '退款/售后',
						loadingType: 'more',
						orderList: [],
						page: 1
					}
				],
				src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				alltotalsel: 0,
				allChoose: false,
				tabCurrentIndex: 0,
				keyword: "",
				order_id: "",
				refresh: false
			}
		},
		onLoad(options) {
			this.tabCurrentIndex = options.state || 0;
			// this.getlist()
		},
		onShow() {
			if (!this.refresh) return;
			this.initList();
			uni.removeStorageSync("order");
		},
		methods: {
			
			// 申请售后
			shfn(item){
				let d = new Date();
				let aftertime = this.$store.state.aftertime;
				console.log(aftertime);
				d.setHours(aftertime[0],aftertime[1] || "0",aftertime[2] || '0');
				console.log(d,"dddddddddd");
				// 大于晚上23点需要联系客服
				if(new Date() > d){
					return this.$u.toast("请前往首页联系客服");
				};
				this.$util.navTo('/pages2/aftersales/index?id='+item.order_id+'&price='+item.total_price);
			},
			// 
			contiute(item) {
				console.log(item, "w89218794789");
				let createtime = "";
				if (item.createtime) {
					createtime = (new Date(item.createtime).getTime()) / 1000;
				}
				uni.setStorageSync("order", {
					...item,
					createtime
				});
				this.$util.navTo('/pages2/money/pay?pagetype=contiute')
			},
			pjfn(item) {
				uni.setStorageSync("evaluate", item.products);
				this.$util.navTo('/pages2/order/evaluate?id=' + item.order_id);
			},
			shstatus(item) {
				return item.order_status_text == '待取餐' || item.order_status_text == '待评价' || item.order_status_text =='已完成';
			},
			// 初始化列表
			initList() {
				this.list = [];
				this.mescroll.resetUpScroll();
			},
			// 搜索列表
			searchtit(e) {
				this.keyword = e.detail.value;
				this.initList();
			},
			async upCallback(page) {
				let data = await this.$u.api.getOrders({
					type: this.navList[this.tabCurrentIndex]
					.state, //	string	否	类型:1.待付款 2.待取餐 3.待评价 4，已完成 5.已取消 6.退款 ,7.拼团中
					page: page.num,
					pagesize: page.size,
					title: this.keyword
				});
				console.log(data, "datatata");
				if (page.num == 1) {
					this.list = [];
				}
				for (let s of data) {
					if (s.order_status_text == '配送中') {
						s.order_status_text = '待取餐'
					}
				}
				// 
				this.list = [...this.list, ...data];
				this.mescroll.endSuccess(data.length, page.size == data.length);
			},
			changeTab(e) {
				this.tabCurrentIndex = e;
				this.initList();
			},
			// 查看详情
			godetail(item) {
				if (item.order_status_text == '退款/售后') {
					this.$util.navTo('/pages2/order/returndetail?id=' + item.order_id);
				} else {
					this.$util.navTo('/pages2/order/orderdetail?id=' + item.order_id);
				}
			},
			// 点击按钮
			btnclick(e, item) {
				if (item.order_id) {
					this.order_id = item.order_id;
				}
				if (e == 3) {
					this.currentpop = e;
					this.showApply = true;
					return;
				}
				this.currentpop = e;
				this.cancelList[e].show = true;
			},
			// 确认时间
			async confirm(e) {
				console.log("我的确认按钮");
				this.cancelList[this.currentpop].show = false;
				switch (this.currentpop) {
					case 0:
						let r = await this.$u.api.cancelOrder({
							id: this.order_id || ""
						});
						this.initList();

						uni.showToast({
							icon: "success",
							title: "取消成功"
						})
						break;
					case 1:
						let {
							data
						} = await this.$u.api.receive({
							id: this.order_id || ""
						});
						uni.showToast({
							icon: "success",
							title: "取餐成功"
						});
						this.initList();
						break;
					case 2:
						uni.showToast({
							icon: "success",
							title: "申请成功"
						})
						break;
					case 3:
						this.showApply = false;
						break;
					default:
						break;
				}
			},
			async getlist() {
				let data = await CartIndex();
				if (data) {
					this.cartList = [...data, ...data, ...data];
					this.cartList[0].shopname = "水果生鲜超市";
				}
			}

		}
	}
</script>

<style scoped lang="scss">
	.content {
		min-height: 100vh;
		background-color: #F5F5F5;
		padding-bottom: calc(50rpx + env(safe-area-inset-bottom));
	}

	.trans {
		color: #F7BF35 !important;
		border: 2rpx solid #F7BF35;
		background-color: transparent !important;
	}

	.intform {
		width: 100%;
		border: 2rpx solid #999999;
		padding-left: 20rpx;
		border-radius: 20rpx;
		height: 80rpx;
		line-height: 80rpx;
		margin-top: 30rpx;
	}

	::v-deep.placeholderClass {
		color: #999999;
		font-size: 28rpx;
	}

	.bgf7bf35 {
		box-sizing: border-box;
		background: linear-gradient(to bottom, #F9DA77, #F7BF35 30%);
		padding: 20rpx;
	}

	.totalclass {
		position: fixed;
		z-index: 95;
		width: 100%;
		padding: 16rpx 20upx;
		background: #fff;
		bottom: 0;
		left: 0;
		right: 0;
		padding-top: 30rpx;
		padding-bottom: env(safe-area-inset-bottom);

		.totaltxt {
			font-size: 32rpx;
			font-weight: bold;
			padding: 10rpx 0 33rpx 0rpx;
		}

		/* 底部栏 */
		.action-section {
			padding-top: 24rpx;
			display: flex;
			align-items: center;


			.checkbox {
				height: 52upx;
				position: relative;

				image {
					width: 52upx;
					height: 100%;
					position: relative;
					z-index: 5;
				}
			}

			.clear-btn {
				position: absolute;
				left: 26upx;
				top: 0;
				z-index: 4;
				width: 0;
				height: 52upx;
				line-height: 52upx;
				padding-left: 38upx;
				color: #fff;
				border-radius: 0 50px 50px 0;
				opacity: 0;
				transition: .2s;

				&.show {
					opacity: 1;
					width: 120upx;
				}
			}

			.total-box {
				flex: 1;
				display: flex;
				flex-direction: column;
				text-align: right;
				padding-right: 40upx;

				.price {
					font-weight: bold;
					font-size: 32rpx;
					color: #FF2727;
				}

			}

			.confirm-btn {
				margin: 0;
				width: 240rpx;
				height: 80rpx;
				background: #4DD88D;
				border-radius: 40rpx 40rpx 40rpx 40rpx;
				font-weight: bold;
				font-size: 32rpx;
				color: #FFFFFF;
			}
		}
	}

	.pbox {
		padding: 10rpx;
		padding-bottom: 0;
	}

	.search {
		position: relative;
		height: 60rpx;
		border-radius: 90rpx;

		.ints {
			border-radius: 90rpx;
			padding-left: 20rpx;
			padding-right: 140rpx;
			height: 100%;
			background-color: rgba(255, 255, 255, 0.25);
			width: 100%;
		}

		.rightslot {
			min-width: 140rpx;
			border-radius: 90rpx;
			height: 100%;
			bottom: 0;
			top: 0;
			padding-left: 10rpx;
			padding-right: 10rpx;
			background: linear-gradient(to left, #DD4D00, #FFD05B 90%);
			right: 0;
			position: absolute;
			font-weight: 500;
			font-size: 28rpx;
			display: flex;
			justify-content: center;
			align-items: center;
			color: #FFFFFF;
			line-height: 60rpx;

			.wh38 {
				width: 38rpx;
				height: 38rpx;
			}
		}
	}

	.cart-box {
		padding: 30upx 20upx;
		background-color: #FFFFFF;
		margin-bottom: 20rpx;

		.btn {
			font-weight: 800;
			font-size: 28rpx;
			color: #FFFFFF;
			text-align: center;
			line-height: 60rpx;
			width: 200rpx;
			height: 60rpx;
			background: #FACE51;
			border-radius: 40rpx 40rpx 40rpx 40rpx;
			margin-left: 30rpx;
			margin-top: 40rpx;
		}

		/* 购物车列表项 */
		.scrollx {
			white-space: nowrap;
			width: 520rpx;

			.loaded {
				width: 140rpx;
				height: 140rpx;
				margin-right: 30rpx;
				border-radius: 20rpx;
			}
		}

		.scrollright {
			width: 150rpx;
		}

		.cart-item {
			display: flex;
			position: relative;
			align-items: center;

			.image-wrapper {
				width: 160upx;
				height: 160upx;
				flex-shrink: 0;
				position: relative;

				image {
					border-radius: 8upx;
				}
			}

			.checkbox {
				position: absolute;
				left: -16upx;
				top: -16upx;
				z-index: 8;
				font-size: 44upx;
				line-height: 1;
				padding: 4upx;
				background: #fff;
				border-radius: 50px;
			}

			.item-right {
				display: flex;
				flex-direction: column;
				flex: 1;
				overflow: hidden;
				position: relative;
				padding-left: 30upx;

				.title,
				.price {
					height: 40upx;
					line-height: 40upx;
				}

				.attr {
					font-weight: bold;
					font-size: 24rpx;
					color: #999999;
					height: 50upx;
					line-height: 50upx;
				}

				.price {
					height: 50upx;
					line-height: 50upx;
				}
			}

			.del-btn {
				padding: 4upx 10upx;
				font-size: 34upx;
				height: 50upx;
			}

			.invalid {
				position: absolute;
				right: 0;
				bottom: 0;
				background: #999999;
				color: #ffffff;
				padding: 6upx 12upx;
				border-radius: 10upx;
				font-size: 26upx;
				margin-right: 50upx;
				margin-bottom: 32upx;
			}
		}
	}
</style>