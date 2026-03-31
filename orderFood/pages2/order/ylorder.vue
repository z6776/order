<template>
	<view class="content">
		<!--  -->
		<view class="bgf7bf35">
			<u-navbar title="养老服务" :is-back="false" :background="bgColorOpa" :border-bottom="false">
				<view class="p-l-20" @click="$util.back()">
					<u-icon name="arrow-left" size="32" color="#000000" bold></u-icon>
				</view>
			</u-navbar>
			<!-- 搜索 -->
			<view class="d-flex search">
				<input class="ints" type="text" placeholder="请输入服务名称" v-model="keyword" @input="searchtit" />
				<view class="rightslot" @click.stop="initList">
					<image :src="$util.cdnurl('search.png')" mode="" class="wh38"></image>
					<text class="fz-32">搜索</text>
				</view>
			</view>
		</view>
		
		<view class="pbox m-b-10 m-t-10">
			<v-tabs paddingItem="0 12rpx" :scroll="true" color="#999999" lineColor="#FACE51" lineHeight="6rpx" bold activeColor="#FACE51"
				v-model="tabCurrentIndex" field="text" :lineScale="0.3" bgColor="transparent" :tabs="navList"
				@change="changeTab"></v-tabs>
		</view>

		<mescroll-body @init="mescrollInit" @down="downCallback" @up="upCallback">
			<view class="p20 p-t-0">
				
				<!-- 列表项 -->
				<view class="p20 m-b-30 bg-fff radius-20 p-relative" v-for="(item,index) in list" @click="godetail(item)" :key="index">
					<view class="d-flex f-start m-b-20">
						<text class="fz-500 fz-24 fz-494949">订单编号：</text>
						<text class="m-r-auto fz-500 fz-24 fz-494949">{{ item.out_trade_no || "" }}</text>
					</view>

					<view class="h130 d-flex f-start m-b-24">
						<image :src="$util.getImgurl($util.isNull(item.product,'coverimage'))" class="wh130 radius-20 fs-0" mode="aspectFill"></image>
						<view class="h100 d-c-flex a-start m-l-20 w-100">
							<view class="fz-500 fz-32 fz-000000">
								{{ $util.isNull(item.product,'name') }}
							</view>
							<view class="fz-28 fz-500 fz-707070">
								{{ item.expecttime_text || "" }}
							</view>
							<view class="d-flex f-start w-100">
								<text class="fz-494949">¥{{ $util.isNull(item.product,'price') }}</text>
								<text class="fz-24 fz-999999 m-r-auto">/{{ $util.isNull(item.product,'unit') }}</text>
								<block v-if="item.number">
									<text class="fz-ff0000 fz-28 fz-32">{{Number(item.number)}}{{$util.isNull(item.product,"unit")}}</text>
									<text class="fz-ff0000 fz-28 fz-32">-</text>
									<text class="fz-ff0000 fz-28 fz-32">￥{{item.totalprice || ""}}</text>
								</block>
							</view>
						</view>
					</view>

					<view class="d-flex f-start m-b-10">
						<block v-if="item.status==4">
							<text class="m-r-auto fz-000000 fz-28">已出发</text>
						</block>
						<block v-if="item.totalprice">
							<text class="fz-707070 fz-28 m-r-10">总金额:</text>
							<text class="m-r-auto fz-ff0000 fz-28">￥{{ item.totalprice }}</text>
						</block>
						<text class="fz-24 fz-500 m-r-10 m-l-auto" style="color: rgba(0, 0, 0, .5);">{{ item.order_status_text=='待预约' ? '待' : '已' }}缴纳保证金</text>
						<text class="fz-28 fz-bold fz-ff0000">¥{{ item.deposit_price || "0" }}</text>
					</view>
					
					<!--  -->
					<view class="m-t-10 d-flex f-end m-t-30">
						<block v-if="item.order_status_text=='待预约'">
							<view class="transbtn" @click.stop="showCancel(item)">
								  取消订单
							</view>
							<view class="pbtn m-l-20" @click.stop="contiuted(item)" v-if="$util.isShowcon(item)">
								 继续支付
							</view>
						</block>
						<block v-if="item.order_status_text=='待支付'">
							 <!-- @click.stop="contiute(item)" -->
							<view class="pbtn m-l-20">
								 立即支付
							</view>
						</block>
						<!-- 退款 -->
						<block v-if="item.status=='3' || item.status=='2' ||  item.status=='4'">
							<view class="pbtn m-l-20" @click.stop="showCancel(item,2)">
								 取消订单
							</view>
						</block>
						<block v-if="item.order_status_text=='待评价'">
							<view class="pbtn m-l-20" @click.stop="pjfn(item)">
								 去评价
							</view>
						</block>
						<block v-if="item.order_status_text=='已取消'">
							<view class="pbtn m-l-20" @click.stop="godetail(item)">
								 查看
							</view>
						</block>
					</view>
					
					<view class="tagnum" :style="[tagStyle(item.order_status_text)]">
						{{ item.order_status_text || "" }}
					</view>
				</view>
			</view>
		</mescroll-body>
		<!--    -->
		<orderpop :show.sync="cancelList[currentpop]['show']" :content="cancelList[currentpop]['msg']" @confirm="confirm" :isShowSlot="false">
		</orderpop>
	</view>
</template>

<script>
	// 养老流程
	// 1. 待预约 
	     // 1.取消订单  好的
		 // 2.继续支付  
	// 2.待服务
	     // 1.未出发前取消订单
		 // 2.已出发字段服务人员出发后显示,其他不显示
	
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
				show: false, // 显示弹窗
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
				// 类型:	类型: -1.已取消 1.待预约 234.待服务 5.待支付 6.待评价 ,7.已完成
				navList: [{
						state: "",
						text: '全部',
						loadingType: 'more',
						orderList: [],
						page: 1
					},
					{
						state: 1,
						text: '待预约',
						loadingType: 'more',
						orderList: [],
						page: 1,
						color: "#FB7A35",
						backgroundColor: "#FEE8C7"

					},
					{
						state: 2,
						text: '待服务',
						loadingType: 'more',
						orderList: [],
						page: 1,
						color: "#FB7A35",
						backgroundColor: "#FEE8C7"
					},
					{
						state: 5,
						text: '待支付',
						loadingType: 'more',
						orderList: [],
						page: 1,
						color: "#FB7A35",
						backgroundColor: "#FEE8C7"
					},
					{
						state: 6,
						text: '待评价',
						loadingType: 'more',
						orderList: [],
						page: 1,
						color: "#FB7A35",
						backgroundColor: "#FEE8C7"
					},
					{
						state: 7,
						text: '已完成',
						loadingType: 'more',
						orderList: [],
						page: 1,
						color: "#FB7A35",
						backgroundColor: "#FEE8C7"
					}, {
						state: -1,
						text: '已取消',
						loadingType: 'more',
						orderList: [],
						page: 1,
						color: "#494949",
						backgroundColor: "#D9D9D9"
					}
				],
				src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				alltotalsel: 0,
				allChoose: false,
				tabCurrentIndex: 0,
				keyword: "",
				order_id: "",
				refresh: false,
				isqx:0
			}
		},
		onLoad(options) {
			this.tabCurrentIndex = options.state || 0;
			
			
			// this.getlist()
		},
		onShow() {
			uni.removeStorageSync("order");
			if (!this.refresh) return;
			this.initList()
		},
		methods: {
			pjfn(item) {
				uni.setStorageSync("evaluate",  {...item?.product,number:item?.number });
				this.$util.navTo('/pages2/order/evaluateyl?id=' + item.id);
			},
			tagStyle(status) {
				let index = this.navList.findIndex(v => v.text == status);
				return index > -1 ? {
					'color': this.navList[index].color,
					'backgroundColor': this.navList[index].backgroundColor
				} : {};
			},
			contiuted(item){
				const { createtime,out_trade_no_d,total_price=item.deposit_price } = item;
				uni.setStorageSync("order", { createtime,out_trade_no_d,total_price});
				this.$util.navTo('/pages2/money/pay?type=yl&pagetype=contiute');
			},
			contiute(item){
				// const { createtime,out_trade_no,total_price=item.totalprice } = item;
				// uni.setStorageSync("order", { createtime,out_trade_no,total_price});
				// this.$util.navTo('/pages2/money/pay?type=yl&pagetype=contiute&timeno=yes');
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
				   let list = await this.$u.api.ylordergetOrders({
					   type:this.navList[this.tabCurrentIndex].state, //	
				       page:page.num,
				       pagesize:page.size,
				       title:this.keyword
				   });
				   if(page.num==1){
				       this.list = [];
				   }
				// for (let s of data) {
				// 	if(s.order_order_status_text=='配送中'){
				// 		s.order_order_status_text='待取餐'
				// 	}
				// }
				   this.list =  [...this.list,...list];
				this.mescroll.endSuccess(list.length, page.size == list.length);
			},
			changeTab(e) {
				console.log(e, "eee");
				this.tabCurrentIndex = e;
				this.initList();
			},
			// 查看详情
			godetail(item) {
			  this.$util.navTo('/pages2/centeradministrator/detail?status='+item.order_status_text+'&pagetype=orderyl&title=订单详情'+"&id="+item.id);
			},
			// 取消弹窗
			showCancel(item,type){
			   if(item.status==4){
				   this.cancelList[0]['msg'] = "是否确认取消该订单，服务人员已出发，取消订单会扣除您一定的保证金"
			   }
				this.isqx = type;
				this.order_id = item.id;
				this.cancelList[0].show = true;
			},
			// 确认时间
			async confirm(e) {
				this.cancelList[this.currentpop].show = false;
				switch (this.currentpop) {
					case 0:
						let r = await this.$u.api.ylordercancelOrder({
							id:this.order_id || "",
							type:this.isqx ? "2" : "1"
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

	.pbtn {
		width: 140rpx;
		height: 50rpx;
		background: #FACE51;
		border-radius: 100rpx 100rpx 100rpx 100rpx;
		font-weight: 500;
		font-size: 28rpx;
		color: #000000;
		text-align: center;
		line-height: 50rpx;
	}

	.transbtn {
		width: 140rpx;
		height: 50rpx;
		border-radius: 100rpx 100rpx 100rpx 100rpx;
		border: 2rpx solid #FACE51;
		font-weight: 500;
		font-size: 28rpx;
		color: #FACE51;
		text-align: center;
		line-height: 50rpx;
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
		padding-top: 0;
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

	.linethrough {
		text-decoration: line-through;
	}

	.popupcon {
		width: 700rpx;
		height: 400rpx;
		padding: 20rpx;

		.title {
			font-size: 32rpx;
			font-weight: 800;
			color: #000000;
		}

		.line80 {
			line-height: 80rpx;
			text-align: center;
			font-size: 32rpx;
			font-weight: 800;

		}
	}

	.statusbtn {
		right: 0;
		bottom: 30rpx;
		position: absolute;
		width: 120rpx;
		height: 60rpx;
		border-radius: 90rpx 0 0 90rpx;
		font-weight: 800;
		font-size: 32rpx;
		color: #FB7A35;
		text-align: center;
		line-height: 60rpx;
		background-color: #FCE7D1;
	}

	.tagnum {
		top: 0;
		right: 0;
		position: absolute;
		width: 120rpx;
		height: 60rpx;
		border-radius: 0rpx 20rpx 0rpx 20rpx;
		font-weight: 500;
		font-size: 32rpx;
		text-align: center;
		line-height: 60rpx;
		text-align: center;
		line-height: 60rpx;
	}

	.m-b-24 {
		margin-bottom: 24rpx;
	}

	.h130 {
		height: 130rpx;

		.wh130 {
			width: 130rpx;
			height: 130rpx;
		}
	}

	::v-deep.tabs {
		background-color: transparent !important;
	}

	.wh170 {
		width: 120rpx;
		height: 120rpx;
		border-radius: 50%;
		margin-right: 20rpx;
	}

	.wh80 {
		border-radius: 20rpx;
		width: 180rpx;
		height: 180rpx;
	}

	.wh40 {
		width: 50rpx;
		height: 50rpx;
	}

	.wh48 {
		width: 48%;
		height: 200rpx;
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