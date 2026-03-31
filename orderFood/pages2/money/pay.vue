<template>
	<view class="app">
		
		<view class="price-box">
			<text class="price">{{ order.total_price }}</text>
			<view class="d-flex j-center m-t-20" v-if="!params.timeno">
				<text class="fz-707070 fz-32">剩余支付时间</text>
				<countdown :min_time="10" :createtime="order.createtime"></countdown>
				<text class="fz-707070 fz-32">订单自动取消</text>
			</view>
		</view>
		<view class="pay-type-list">
			<view class="paytype">
				请选择支付方式
			</view>
			<view class="type-item b-b" @click="payType=3" v-if="!isshowtotal_price">
				<image :src="$util.cdnurl('wpay.png')"  mode="" class="wh32"></image>
				<view class="con">
					<text class="tit">微信支付</text>
				</view>
				<label class="radio">
					<radio value="" color="#FACE51" :checked='payType == 3' />
					</radio>
				</label>
			</view>
			
			<view class="type-item b-b" @click="payType=5"> 
				<image :src="$util.cdnurl('bpay.png')"  mode="aspectFill" class="wh32"></image>
				<view class="con">
					<text class="tit">余额支付</text>
				</view>
				<label class="radio">
					<text class="balance m-r-30">可用余额  {{ position.money || "0" }}元</text>
					<radio value="" color="#FACE51" :checked='payType == 5' />
					</radio>
				</label>
			</view>
			
			<view class="type-item b-b" @click="payType=4" v-if="position.money && Number(position.money) < Number(order.total_price) && params.type!='yl'">
				<image src="../../static/images/pay.png"  mode="" class="wh32"></image>
				<view class="con">
					<text class="tit">混合支付</text>
				</view>
				<label class="radio">
					<radio value="" color="#FACE51" :checked='payType == 4' />
					</radio>
				</label>
			</view>
			
			
			<text class="mix-btn" :class="{'classpay':loading}" @click="confirm">立即支付</text>
		</view>
		
	</view>
</template>

<script>
    import { transformVNodeArgs } from "vue";
import countdown from "@/components/countdown";
	import { mapState } from "vuex";
	export default {
		components:{
			countdown
		},
		computed:{
			createtime(){
				return (new Date().getTime())/1000
			}
		},
		data() {
			return {
				loading:false,
				position:{},
				timestamp:86400,
				payType: 3,
				orderInfo: {},
				orderId: '',
				payTypeList: {
					wxpay: false,
					alipay: false
				},
				total: 0.00,
				order:{},
				order_id:"",
				params:{},
				isshowtotal_price:false
			};
		},
		async onLoad(options) {
			this.params = options;
			// this.total = options.total;
			// this.orderId = options.order_id;
			// await this.getPayType();
			// // 如果传这个参数就直接支付了，（默认第一个是微信支付）
			// if (options.pay) {
			// 	this.confirm()
			// }
			
			let order = uni.getStorageSync("order");
			this.order = order;
			if(Number(order.total_price) <=0 ){
				this.isshowtotal_price = true;
				this.payType = 5;
			}else{
				this.isshowtotal_price = false;
			}
		},
		onUnload() {
			console.log("返回页面");
			if (this.$util.prePage()?.hasOwnProperty('refresh')){
				this.$util.prePage().refresh = true;
			}
		},
		onHide() {
			if (this.$util.prePage()?.hasOwnProperty('refresh')){
				this.$util.prePage().refresh = true;
			}
		},
		onShow(){
			this.getUserInfo();
		},
		methods:{
			async getUserInfo() {
					let data = await this.$u.api.userindex();
				    this.position = data;
			},
			// 获取支付方式
			async getPayType() {
				let type = await PayGetPayType();
				if (type) {
					this.payTypeList = type;
				}
			},
			//选择支付方式
			changePayType(type) {
				this.payType = type;
				switch (type) {
					case 1: // 微信支付

						break;
					case 2: // 支付宝支付

						break;
					case 3: // 货到付款
						break;
				}
			},
			//确认支付
			async confirm() {
				if(this.loading)return;
				uni.showLoading({
					mask:true
				});
				this.loading = true;
				// 微信支付
				if(this.payType==3){
						let data ={};
					if(this.params.type=='yl'){
						let order = {
							out_trade_no_d:this.order.out_trade_no_d || "",
							out_trade_no:this.order.out_trade_no || "",
						}
						data = await this.$u.api.ylpayUnify(order);
					}else{
						data = await this.$u.api.payUnify({
							out_trade_no:this.order.out_trade_no
						});
					}
					this.$util.xhpay(data).then(res=>{
						  console.log(res,"支付参数");
						  // 继续支付的直接返回
						  this.loading = false;
						  if(this.params.pagetype=='contiute'){
							  this.$util.success('支付成功','back');
							  // 继续支付的直接返回
							  this.loading = false;
						  }else{
							  uni.redirectTo({
							  	url:"/pages2/money/paySuccess?type="+this.params.type
							  });
							  // 继续支付的直接返回
							  this.loading = false;
						  } 
					},(err)=>{
						// 更换商户号
							uni.showLoading({
								mask:true
							})
							this.$u.api.generate({
								out_trade_no:this.order.out_trade_no
							}).then(res=>{
								this.order.out_trade_no = res;
								// 继续支付的直接返回
								this.loading = false;
								uni.hideLoading();
							});
							
						});
						}
				// 混合支付
				else if(this.payType==4){
					let data ={};
					if(this.params.type=='yl'){
						let order = {
							out_trade_no_d:this.order.out_trade_no_d || "",
							out_trade_no:this.order.out_trade_no || "",
						}
						data = await this.$u.api.ylpayUnify(order);
					}else{
						data = await this.$u.api.blendapi({
							out_trade_no:this.order.out_trade_no
						});
					}
					this.$util.xhpay(data).then(async res=>{
						  console.log(res,"支付参数");
						  // 继续支付的直接返回
						  // 继续支付的直接返回
						  this.loading = false;
						  if(this.params.pagetype=='contiute'){
							  this.$util.success('支付成功','back');
						  }else{
							  uni.redirectTo({
							  	url:"/pages2/money/paySuccess?type="+this.params.type
							  });
						  } 
					}).catch(err=>{
						// 更换商户号
						uni.showLoading({
							mask:true
						})
						this.$u.api.generate({
							out_trade_no:this.order.out_trade_no
						}).then(res=>{
							this.order.out_trade_no = res;
							// 继续支付的直接返回
							this.loading = false;
							uni.hideLoading()
						});
					});
					  return;
				}
				// 余额支付
				else{
					let data ={};
					if(this.params.type=='yl'){
						let order = {
							out_trade_no_d:this.order.out_trade_no_d || "",
							out_trade_no:this.order.out_trade_no || "",
						}
						data = await this.$u.api.ylpaybalance(order);
					}else{
							data = await this.$u.api.payBalance({
								out_trade_no:this.order.out_trade_no
							});
					}	
					if(this.params.pagetype=='contiute'){
						this.$util.success('支付成功','back');
						// 继续支付的直接返回
						this.loading = false;
					}else{
					  uni.redirectTo({
						url:"/pages2/money/paySuccess?type="+this.params.type
					  });
					  // 继续支付的直接返回
					  this.loading = false;
					}
					
					
				}
			},
			async alipay() {
				
				// #ifdef H5
				window.open(this.$unishow + '/pay/alipay?order_id='+this.orderId);
				
				setTimeout(function() {
					uni.showModal({
						title: '提示',
						content: '是否已支付?',
						cancelText: '否',
						confirmText: '是',
						success: function(res) {
							if (res.confirm) {
								uni.redirectTo({
									url: '/pages/order/order?state=0'
								});
							} else if (res.cancel) {
								//console.log('用户点击取消');
							}
						},
						fail: function(res) {
							//console.log(res)
						}
					});
				}, 3000);
				// #endif

				// #ifdef APP-PLUS
				let orderInfo = await PayAlipay({
					order_id : this.orderId
				});
				if (orderInfo) {
					//console.log(orderInfo);
					uni.requestPayment({
						provider: 'alipay',
						orderInfo: orderInfo,
						success: function (res) {
							console.log('success:' + JSON.stringify(res));
							uni.redirectTo({
								url: '/pages/money/paySuccess'
							})
						},
						fail: function (err) {
							console.log('fail:' + JSON.stringify(err));
							that.$api.msg('支付失败');
						}
					});
				}
				
				// #endif
				
			},
			async weixinPay() {
				let data = await PayUnify({
					order_id: this.orderId
				});
				let that = this;
				if (data) {

					if (data.trade_type == 'MWEB') {
						// #ifdef H5
						// 微信外的H5
						location.href = data.mweb_url;
						// #endif

						// #ifdef APP-PLUS
						// app 使用h5支付
						var wv; //计划创建的webview 
						wv = plus.webview.create("", "custom-webview", {
							'uni-app': 'none', //不加载uni-app渲染层框架，避免样式冲突
						})
						wv.loadURL(data.mweb_url, {
							Referer: data.referer
						});

						setTimeout(function() {
							uni.showModal({
								title: '提示',
								content: '是否已支付?',
								cancelText: '否',
								confirmText: '是',
								success: function(res) {
									if (res.confirm) {
										uni.redirectTo({
											url: '/pages/order/order?state=0'
										});
									} else if (res.cancel) {
										//console.log('用户点击取消');
									}
								},
								fail: function(res) {
									//console.log(res)
								}
							});
						}, 3000);
						// #endif

					} else if (data.trade_type == 'JSAPI') {
						if (data.weixinOauth2) {
							// 微信oauth2授权（主要用来拿openid）
							location.href = data.weixinOauth2
							return;
						}

						// #ifdef H5
						// 微信内的H5
						let config = await PayJssdkBuildConfig();
						if (config) {
							jweixin.config(config);
							jweixin.ready(function() {
								jweixin.chooseWXPay({
									timestamp: data.timeStamp, // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
									nonceStr: data.nonce_str, // 支付签名随机串，不长于 32 位
									package: 'prepay_id=' + data.prepay_id, // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=\*\*\*）
									signType: 'MD5', // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
									paySign: data.paySign, // 支付签名
									success: function(res) {
										// 支付成功后的回调函数
										uni.redirectTo({
											url: '/pages/money/paySuccess'
										})
									},
									fail: function(err) {
										//console.log('fail:' + JSON.stringify(err));
										//that.$api.msg('fail:' + JSON.stringify(err))
										that.$api.msg('支付失败');
									}
								})
							});
							jweixin.error(function(res) {
								//that.$api.msg(JSON.stringify(res));
								that.$api.msg('支付失败');
							});
						} else {
							that.$api.msg('支付失败');
						}
						// #endif

						// #ifdef MP-WEIXIN
						uni.requestPayment({
							provider: 'wxpay',
							timeStamp: data.timeStamp,
							nonceStr: data.nonce_str,
							package: 'prepay_id=' + data.prepay_id,
							signType: 'MD5',
							paySign: data.paySign,
							success: function(res) {
								uni.redirectTo({
									url: '/pages/money/paySuccess'
								})
							},
							fail: function(err) {
								//console.log('fail:' + JSON.stringify(err));
								//that.$api.msg('fail:' + JSON.stringify(err))
								that.$api.msg('支付失败');
							}
						});
						// #endif
					} else if (data.trade_type == 'APP') { 
						console.log('app支付');
						console.log(data);
						//App端，微信支付 orderInfo 为 Object 类型。
						
						uni.requestPayment({
							provider:'wxpay',
							orderInfo:data.orderInfo,
							success (res) {
								//console.log('支付成功');
								//console.log(res);
								uni.redirectTo({
									url: '/pages/money/paySuccess'
								})
							},
							fail(res){
								//console.log('支付失败');
								//console.log(res)
								that.$api.msg('支付失败');
							},
						});
					}
				}
			},

			async offlinePay() {
				let data = await PayOffline({
					order_id: this.orderId
				});
				if (data) {
					uni.redirectTo({
						url: '/pages/money/paySuccess'
					});
				}
			}
		}
	}
</script>

<style lang='scss'>
	.app {
		width: 100%;
	}
	
	.balance{
		font-weight: 500;
		font-size: 28rpx;
		color: #707070;
	}
	
	.classpay{
		background-color: #ccc !important;
		color: #000000 !important;
	}
	
	.paytype{
		 font-weight: 500;
		 font-size: 28rpx;
		 color: #707070;
	}
	
	.price-box {
		background-color: #fff;
		height: 265upx;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		font-size: 28upx;
		color: #909399;

		.price {
			font-size: 56upx;
			color: #000000;
			margin-top: 12upx;

			&:before {
				content: '￥';
				font-size: 40upx;
			}
		}
	}
	
	.wh32{
		width: 32rpx;
		height: 32rpx;
		margin-right: 30rpx;
	}

	.pay-type-list {
		background-color: #fff;
        padding-bottom: 30rpx;
		padding: 20rpx 30rpx;
		.type-item {
			height: 120upx;
			padding: 20upx 0;
			display: flex;
			justify-content: space-between;
			align-items: center;
			font-size: 30upx;
			position: relative;
		}

		.icon {
			width: 100upx;
			font-size: 52upx;
		}

		.icon-pay {
			color: #fe8e2e;
		}

		.icon-wxpay {
			color: #36cb59;
		}

		.icon-alipay {
			color: #01aaef;
		}

		.tit {
			margin-bottom: 4upx;
		}

		.con {
			flex: 1;
			display: flex;
			flex-direction: column;
		}
	}

	.mix-btn {
		display: flex;
		align-items: center;
		justify-content: center;
		width: 630upx;
		height: 80upx;
		margin: 10upx auto;
		color: #000000;
		background-color: #FACE51;
		border-radius: 10upx;
		border-radius: 80rpx;
	}
</style>
