<template>
	<view class="content">
		<u-navbar title="退款详情" :is-back="false" :background="bgColorOpa" :border-bottom="false">
			<view class="p-l-20" @click="$util.back()">
				<u-icon name="arrow-left" size="32" color="#000000" bold></u-icon>
			</view>
		</u-navbar>
		
		<image :src="$util.cdnurl('returnmoney.png')"   class="h400" mode=""></image>
		
		<view class="d-c-flex p-b-30">
			<image  :src="$util.cdnurl('gouicon.png')"     mode="" class="gouicon"></image>
			<text class="tgtxt">退款成功</text>
		</view>
		
			<view class="p20 bg-fff m-t-30">
				<view class="m-b-20 basecolor">
					{{ $util.parseTime(info.createtime,"{y}-{m}-{d} {h}:{i}") }}
				</view>
				<!--  -->
				<view class="cart-item  d-flex f-start" v-for="(item,index) in info.products">
					<view class="image-wrapper endclass m-r-20">
						<image :src="$util.getImgurl(item.image)" class="loaded" mode="aspectFill"></image>
					</view>
					<view class="item-right p-t-10 p-b-10 flex-1">
						<text class="title">{{ item.title || "" }}</text>
						<view class="d-flex m-t-20 m-b-20 basecolor">
							￥ {{ item.price || "" }} x {{  item.number || ""  }}
						</view>
						<view class="d-flex">
							<text class="fz-000000 fz-28 fz-weight">实付￥{{ info.total_price || "" }}</text>
						</view>
					</view>
				</view>
				
				<view class="p-b-30 borderbottom">
					
				</view>
				
				<view class="form bg-fff radius-20 p-30-20 d-c-start-flex">
					<view class="formitem d-flex ">
						<text class="m-r-auto fz-333333 fs-0">订单编号:</text>
						<text class="">{{ info.out_trade_no || "" }}</text>
						<text class="m-l-20 m-r-20">|</text>
						<view class="copy" @click.stop="$util.makeCopy(info.out_trade_no)">复制</view>
					</view>
					<block v-for="(ele,j) in info.aftersale">
						<view class="formitem d-flex">
							<text class="fz-333333">申请金额:</text>
							<text class="">¥{{ $util.isNull(ele,'refund_fee') ||  "" }}</text>
						</view>
						<view class="formitem d-flex ">
							<text class="fz-333333">退款原因:</text>
							<text class="">{{ $util.isNull(ele,'reason')  }}</text>
						</view>
						<view class="formitem d-flex">
							<text class="fz-333333">申请时间:</text>
							<text class="">{{ $util.parseTime($util.isNull(ele,'createtime'),"{y}-{m}-{d} {h}:{i}") }}</text>
						</view>
					</block>
					
				</view>
			</view>
			<view class="boxFixed">
				<view class="delbtn" @click="show = true">
					 删除订单
				</view>
			</view>
			<orderpop :show.sync="show" content="确认删除?"  @confirm="confirm" :isShowSlot="false">
			</orderpop>
	</view>
</template>
<script>
	// import {
	// 	labelList
	// } from "./datajs.js";
	import orderpop from "@/components/orderpop/index.vue";
	export default {
		components: {
			orderpop
		},
		data() {
			return {
				show:false,
				timestamp:86400,
				form: {},
				showApply: false,
				currentpop: 0,
				cancelList: [{
					msg: "确认取消?",
					show: false
				}, {
					msg: "确认收货?",
					show: false
				}, {
					msg: "申请换货?",
					show: false
				}, {
					msg: "上传单号",
					show: false
				}],
				status: "",
				src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				title:"",
				id:"",
				info:{}
			}
		},
		onLoad(query) {
			this.title = query.title;
			uni.setNavigationBarTitle({
				title:query.title
			});
			this.id = query.id;
			this.getdetail();
		},
		methods: {
			// 订单详情
			async getdetail(){
				let data = await this.$u.api.orderDetail({
					id:this.id
				});
				if(data.order_status_text=='配送中'){
					data.order_status_text='待取餐';
				}
				this.info = data;
			},
			// 点击按钮
			btnclick(e) {
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
				let data = await this.$u.api.destroyOrder({
					order_id:this.id
				});
				this.show = false;
				this.$util.success("删除成功","back")
			}
		}
	}
</script>

<style scoped lang="scss">
	.intform {
		width: 100%;
		border: 2rpx solid #999999;
		padding-left: 20rpx;
		border-radius: 20rpx;
		height: 80rpx;
		line-height: 80rpx;
		margin-top: 30rpx;
	}
	
	.gouicon{
		width: 120rpx;
		height: 120rpx;
	}
	
	.delbtn{
		width: 630rpx;
		height: 80rpx;
		background: #FFFFFF;
		border-radius: 100rpx 100rpx 100rpx 100rpx;
		border: 2rpx solid #979797;
		font-weight: 500;
		font-size: 32rpx;
		color: #000000;
		text-align: center;
		line-height: 80rpx;
	}
	
	.tgtxt{
		 font-weight: 500;
		 font-size: 36rpx;
		 color: #975D00;
		 margin-top: 30rpx;
	}
	
	
	.line32{
		line-height: 32rpx;
	}
	
	.wh150{
		width: 150rpx;
		height: 150rpx;
		margin-right: 30rpx;
	}
	
	.copy{
		flex-shrink: 0;
		width: fit-content;
		padding: 0 10rpx;
		height: 40rpx;
		text-align: center;
		// padding: 5rpx 20rpx;
		border-radius: 50rpx;
		// font-size: 28rpx;
		line-height: 40rpx;
		border: 1rpx solid #666666;
	}

	.getOther {
		width: fit-content;
		padding: 0 30rpx;
		color: #000000;
		text-align: center;
		margin-left: auto;
		border: 2rpx solid #666666;
		border-radius: 10rpx;
	}
	
	.bordertop99{
		border-top: 2rpx solid #999999;
	}
	.borderbottom99{
		border-bottom: 2rpx solid #999999;
	}

	::v-deep.placeholderClass {
		color: #999999;
		font-size: 28rpx;
	}
	
	.image-wrapper {
		width: 160upx;
		height: 160upx;
		flex-shrink: 0;
		position: relative;

		image {
			border-radius: 8upx;
		}
	}
				
	.content {
		min-height: 100vh;
		padding: 30rpx 20rpx;
		// background: linear-gradient(to bottom, #4DD88D, #F9F9F9 300rpx);
		padding-bottom: calc(240rpx + env(safe-area-inset-bottom));
        padding-top: 20rpx;
		.h400{
			width: 100%;
			top: 0;
			position: fixed;
			left: 0;
			right: 0;
			height: 440rpx;
			border-radius: 0 0 20rpx 20rpx;
			z-index: -1;
		}
		.form {
			line-height: 60rpx;
			padding-top: 15rpx;
			padding-bottom: 15rpx;
		}

		.wh46 {
			width: 46rpx;
			height: 46rpx;
		}

		.person {
			padding: 20rpx 30rpx 40rpx 20rpx;
		}

		.supermarket {
			padding: 30rpx 20rpx 30rpx 20rpx;

			.endclass {
				// border-bottom: 2rpx solid #F9F9F9;
				// padding-bottom: 30rpx;
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
					padding-left: 20upx;

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
	}

	.btn {
		font-weight: 800;
		font-size: 28rpx;
		color: #FFFFFF;
		text-align: center;
		line-height: 80rpx;
		width: 300rpx;
		height: 80rpx;
		background: #4DD88D;
		border-radius: 40rpx 40rpx 40rpx 40rpx;
		margin-left: auto;
		margin-top: 40rpx;
		margin-right: 20rpx;
	}

	.button {
		height: 100rpx;
	}
</style>