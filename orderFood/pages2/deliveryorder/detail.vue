<template>
	<view class="content">
		<view class="supermarket bg-fff radius-20">
			<view class="m-b-20 d-flex">
				<text class="fz-32 fz-333333 fz-weight m-r-10">商品信息</text>
				<text class="fz-28 fz-000000 m-r-10" v-if="info.subtype==2">配送到家</text>
				<text class="fz-28 fz-000000 m-r-10" v-if="info.subtype==1">堂食</text>
				<text class="fz-28 fz-000000 m-r-10" v-if="info.subtype==3">配送点自提</text>
			</view>
			<view class="m-b-30" v-for="(v,i) in info.products" :key="v.id">
				<view class="cart-item" :class="{'endclass':i==1}">
					<view class="image-wrapper m-l-20">
						<image :src="$util.getImgurl(v.image)" class="loaded" mode="aspectFill"></image>
					</view>
					<view class="item-right p-t-10 p-b-10">
						<text class="clamp fz-bold fz-28 fz-000000">{{ v.title || "" }}</text>
						<view class="d-flex f-start m-t-10 m-b-10">
							<text class="fz-28 basecolor">￥ {{ orderpriceone(v) || "" }}x{{ v.number || "1" }} </text>
							<text
								class="fz-24 basecolor">(另需打包费:￥{{ v.package_price || v.packing_price || "0" }}元)</text>
						</view>

						<view class="fz-28 basecolor m-b-10" v-if="v.spec || v.desc">
							{{ v.spec || "" }}{{v.desc || ""}}
						</view>
						<view class="d-flex">
							<text class="price fz-24 fz-000000 m-r-auto">商品金额￥{{orderpriceone(v)}}元 </text>
							<text class="fz-979797 fz-28 fz-weight" v-if="info.status==1 && info.have_paid">实付：</text>
							<text class="basecolor fz-28 fz-weight"
								v-if="info.status==1 && info.have_paid">￥{{orderpricefn(v)|| ""}}</text>
						</view>
					</view>
				</view>
				<view class="d-flex f-end">
					<view class="getOther" v-if="v.aftersale_status!='2' && info.status==1 && info.have_paid"
						@click.stop="$util.navTo('/pages2/aftersales/index?id='+order_id+'&price='+orderpricefn(v)+'&product_id='+v.product_id+'&pagetype=xs')">
						申请售后
					</view>
					
					<view class="tgOther" v-if="!(v.aftersale_status!='2' && info.status==1) && info.have_paid">
						已退款
					</view>
					
					<!-- 
					<view class="getOther m-l-20" @click.stop="$util.navTo('/pages2/shopdetail/index?id='+v.id)">
						再来一件
					</view> -->
				</view>

			</view>

			<view class="form bg-fff radius-20 p-30-20 d-c-start-flex m-t-30">
				<view class="formitem d-flex">
					<text class="fz-28 fz-weight basecolor">商品总额</text>
					<text class="fz-28  fz-000000">￥{{ info.total_price || "" }}元</text>
				</view>
				<view class="formitem d-flex">
					<text class="fz-28 fz-weight basecolor">优惠金额</text>
					<text class="fz-28  fz-000000">￥{{ info.discount_price || "" }}元</text>
				</view>
				<view class="formitem d-flex">
					<text class="fz-28 fz-weight basecolor">福豆抵扣金额</text>
					<text class="fz-28  fz-000000">￥{{ info.score_discount_price }}元</text>
				</view>

				<block v-if="info.subtype==2">
					<view class="formitem d-flex">
						<text class="fz-28 fz-weight basecolor">配送费</text>
						<text class="fz-28  fz-000000">￥{{ info.delivery_price || "" }}元</text>
					</view>
				</block>

				<block v-if="info.subtype!=1">
					<view class="formitem d-flex">
						<text class="fz-28 fz-weight basecolor">打包费</text>
						<text class="fz-28  fz-000000">￥{{ info.packing_price || "" }}元</text>
					</view>
				</block>

				<view class="formitem d-flex">
					<text class="fz-32 fz-weight fz-333333">合计支付</text>
					<text class="fz-32  fz-333333">￥{{ info.total_price|| "" }}元</text>
				</view>
			</view>
		</view>

		<view class="form bg-fff radius-20 p-30-20 d-c-start-flex m-t-30">
			<view class="formitem d-flex">
				<text class="fz-32 fz-weight fz-333333">配送信息</text>
			</view>
			<view class="formitem d-flex f-start">
				<image :src="$util.cdnurl('ztaddress.png')" class="wh40 m-r-10" mode=""></image>
				<text class="fz-000000 fz-28 m-r-auto fs-0">自提点</text>
				<!-- 金东方海棠花园 - -->
				<text class="basecolor fz-28" v-if="info.village">{{ info.village.name || "" }}</text>
				<text class="basecolor fz-28" v-if="info.selfpcikup">{{ info.selfpcikup.name || "" }}</text>
			</view>

			<view class="formitem d-flex f-start" @click.stop="$util.makePhone(info.address.mobile)"
				v-if="info.subtype==2">
				<image :src="$util.cdnurl('phone.png')" class="wh40 m-r-10" mode=""></image>
				<text class="fz-000000 fz-28 m-r-auto">联系人</text>
				<text class="fz-28 basecolor m-r-20">{{ info.address.name || "" }}</text>
				<text class="fz-28 basecolor"
					v-if="info.address && info.address.mobile">{{ $util.hideMiddleFourOfPhoneNumber(info.address.mobile)  || "" }}</text>
			</view>

			<view class="formitem d-flex f-start" @click.stop="$util.makePhone(info.extend.phone)"
				v-if="info.subtype==3">
				<image :src="$util.cdnurl('phone.png')" class="wh40 m-r-10" mode=""></image>
				<text class="fz-000000 fz-28 m-r-auto">联系人</text>
				<text class="fz-28 basecolor m-r-20">{{ info.extend.usernmae || "" }}</text>
				<text class="fz-28 basecolor"
					v-if="info.extend && info.extend.phone">{{ $util.hideMiddleFourOfPhoneNumber(info.extend.phone)  || "" }}</text>
			</view>

			<!-- 
			<view class="formitem d-flex f-start">
				<image :src="$util.cdnurl('phone.png')"  class="wh40 m-r-10" mode=""></image>
				<text class="fz-000000 fz-28 m-r-auto">联系人</text>
				<text class="fz-28 basecolor m-r-20">{{ info.extend.usernmae || "" }}</text>
				<text class="fz-28 basecolor" v-if="info.extend">{{ $util.hideMiddleFourOfPhoneNumber(info.extend.phone)  || "" }}</text>
			</view> -->

			<view class="d-flex f-start">
				<image :src="$util.cdnurl('ztclock.png')" mode="" class="wh40 m-r-10"></image>
				<text class="m-r-auto fz-000000 fz-28">配送时间:</text>
				<text class="fz-28 basecolor">{{ $util.parseTime(info.getdate,"{y}-{m}-{d}") }}</text>
				<text class="fz-28 basecolor">{{ $util.isam(info.isam) }}</text>
			</view>

			<view class="d-flex f-start">
				<image :src="$util.cdnurl('psicon.png')" mode="" class="wh40 m-r-10"></image>
				<text class="m-r-auto fz-000000 fz-28">配送员:</text>
				<text class="fz-28 basecolor">{{ $util.isNull(info.admin,"username")  || "" }}</text>
				<text class="fz-28 basecolor"
					v-if="$util.isNull(info.admin,'mobile') ">({{ $util.isNull(info.admin,"mobile")  || ""   }})</text>
			</view>

			<view class="basecolor breakword">
				<text>备注:</text>
				<text>{{ info.remark || "" }}</text>
			</view>
		</view>

		<view class="form bg-fff radius-20 p-30-20 d-c-start-flex m-t-30">
			<view class="formitem d-flex">
				<text class="  fz-333333">订单信息</text>
			</view>
			<view class="formitem d-flex f-start">
				<text class="  fz-333333">订单号:</text>
				<text class="m-r-auto">{{ info.out_trade_no || "" }}</text>
				<view class="copy" @click="$util.makeCopy(info.out_trade_no)">复制</view>
			</view>

			<view class="formitem d-flex f-start">
				<text class="  fz-333333">下单时间:</text>
				<text class="m-r-auto">{{ info.createtime || "" }}</text>
			</view>

			<view class="formitem d-flex f-start">
				<text class="  fz-333333">支付时间:</text>
				<text class="m-r-auto">{{ $util.parseTime(info.have_paid,"{y}-{m}-{d} {h}:{i}:{s}")  }}</text>
			</view>

		</view>

		<view class="form m-t-30 p20 bg-fff" v-if="info.subtype!=1 && info.receivedtime">
			<view class="">
				送达信息
			</view>
			<view class="">
				<text>送达时间:</text>
				<text>{{ $util.parseTime(info.receivedtime,"{y}-{m}-{d} {h}:{i}") }}</text>
			</view>

			<view class="d-flex f-start f-warp">
				<image v-for="(item,i) in $util.toarr(info.received_url)"
					@click.stop="$util.lookimgarr(i,info.received_url)" :src="$util.getImgurl(item)" mode=""
					class="wh150 radius-20"></image>
			</view>
		</view>
		<view class="boxFixed" v-if="title=='配送中' && info.status==1 && info.have_paid">

			<view class="btn shbtn" @click.stop="btnclick(1)" v-if="!info.have_received">
				确认取餐
			</view>


			<view class="btn shbtn" @click.stop="shfn()" v-if="info.order_status_text!='退款/售后'">
				申请售后
			</view>
			<view class="btn m-l-auto" @click="open()">
				指派
			</view>
		</view>

		<orderpop :show.sync="cancelList[currentpop]['show']" :content="cancelList[currentpop]['msg']"
			@confirm="confirm" :isShowSlot="false">
		</orderpop>


		<uni-popup ref="popup" type="center" background-color="#fff">
			<view class="p20 bg-fff radius-20 wh500">
				<view class="d-flex j-center fz-000000 fz-32 m-b-20">
					指派
				</view>
				<view style="width: 300rpx;" class="border w-100">
					<!-- :keyId="1" -->
					<qiaoSelect ref="qiaoSelect" showField="username" :dataList="orgArray" phText="选择配送人员"
						phColor="#999999" searchKey="username" :showObj="showObj" :disabled="false"
						@change="selectChange"></qiaoSelect>
				</view>


				<mybtn msg="确认" @handclick="confirmzp" marginTop="100rpx" width="300rpx" height="60rpx" />
			</view>
		</uni-popup>





	</view>
</template>

<script>
	import orderpop from "@/components/orderpop/index.vue";
	import qiaoSelect from "../../uni_modules/qiao-select/components/qiao-select/qiaoSelect.vue";
	import {
		mapState
	} from "vuex";
	export default {
		components: {
			orderpop,
			qiaoSelect
		},
		data() {
			return {
				currentpop: 0,
				showObj: {},
				orgArray: [],
				info: {},
				title: "",
				timestamp: 86400,
				form: {},
				showApply: false,
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
				order_id: "",
				src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				mechId: ""
			}
		},
		onLoad(query) {
			this.title = query.title;
			let status = query.status == 1 && query.have_paid!='0'  ? query.title : "订单详情";
			uni.setNavigationBarTitle({
				title: status
			});
			this.order_id = query.id;
		
		},
       onShow() {
       	  this.getdetail();
       	  this.getlist()
       },
		methods: {
			// 申请售后
			shfn(item) {
				let d = new Date();
				let aftertime = this.$store.state.aftertime;
				d.setHours(aftertime[0], aftertime[1] || "0", aftertime[2] || '0');
				// 大于晚上23点需要联系客服
				// if(new Date() > d){
				// 	return this.$u.toast("请前往首页联系客服");
				// };
				this.$util.navTo('/pages2/aftersales/index?id=' + this.order_id + '&price=' + this.info.total_price +'&pagetype=xs');
			},
			orderpriceone(v) {
				if (this.info.activity_type == 'seckill' || this.info.activity_type == 'groupon') {
					return v.activityProduct?.price;
				}
				return v?.price;
			},
			orderpricefn(v) {
				let number = v.number ? Number(v.number) : 1;
				if (this.info.activity_type == 'seckill' || this.info.activity_type == 'groupon') {
					return (Number(v.activityProduct?.price) * number).toFixed(2);
				}
				return (Number(v?.price) * number).toFixed(2);
			},
			open() {
				this.$refs.qiaoSelect.clickClear();
				this.$refs.popup.open();
			},
			async getlist() {
				// /api/delivery/getAdminList
				let data = await this.$u.api.getAdminList();
				if (data && data.length) {
					this.orgArray = data.map(v => {
						return {
							id: v.id,
							username: v.user?.username
						}
					});
				}

			},
			selectChange(e) { //返回选择的对象，如果输入框清空，返回null
				if (e) {
					this.mechId = e.id;

					// /api/delivery/assign
				} else {
					this.mechId = ''
				}
			},
			async confirmzp() {
				if (!this.mechId) {
					return this.$u.toast("请选择人员!")
				}
				uni.showLoading({

				})
				await this.$u.api.assign({
					admin_id: this.mechId,
					id: this.order_id
				});
				this.$refs.popup.close();
				this.$util.success("指派成功", "back");
			},
			// /api/order/detail
			async getdetail() {
				let data = await this.$u.api.orderDetail({
					id: this.order_id || ""
				});
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
				if (!this.info?.extend?.user_id) {
					return this.$u.toast("未找到用户信息");
				}
				this.cancelList[this.currentpop].show = false;
				switch (this.currentpop) {
					case 0:
						let r = await this.$u.api.cancelOrder({
							id: this.id || ""
						});
						this.$util.success("取消成功", "back");
						break;
					case 1:
						let {
							data
						} = await this.$u.api.receive({
							user_id: this.info?.extend?.user_id,
							id: this.order_id || ""
						});
						this.$util.success("取餐成功", "back");
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
	.intform {
		width: 100%;
		border: 2rpx solid #999999;
		padding-left: 20rpx;
		border-radius: 20rpx;
		height: 80rpx;
		line-height: 80rpx;
		margin-top: 30rpx;
	}

	.wh500 {
		width: 700rpx;
		height: 400rpx;
	}

	.line32 {
		line-height: 32rpx;
	}

	.wh150 {
		width: 150rpx;
		height: 150rpx;
		margin-right: 30rpx;
	}

	.copy {
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

	::v-deep.placeholderClass {
		color: #999999;
		font-size: 28rpx;
	}
	.tgOther{
		width: fit-content;
		padding: 0 30rpx;
		color: #FF0000;
		text-align: center;
		border: 2rpx solid #FF0000;
		border-radius: 70rpx;
		margin-top: 10rpx;
	}

	.content {
		min-height: 100vh;
		padding: 30rpx 20rpx;
		// background: linear-gradient(to bottom, #4DD88D, #F9F9F9 300rpx);
		padding-bottom: calc(240rpx + env(safe-area-inset-bottom));
		padding-top: 20rpx;

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
		background: #FACE51;
		;
		border-radius: 40rpx 40rpx 40rpx 40rpx;
		margin-left: auto;
		margin-top: 40rpx;
		margin-right: 20rpx;
	}

	.button {
		height: 100rpx;
	}
</style>