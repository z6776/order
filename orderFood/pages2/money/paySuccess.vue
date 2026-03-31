<template>
	<view class="content">
			<image  :src="$util.cdnurl('wpay2.png')"  mode="" class="wh200"></image>
		<view class="tit">支付成功</view>
		<view class="btn-group" @click="back()">
			 <!-- url="/pages/order/order?state=0" -->
			<view class="mix-btn">返回</view>
			<!-- <navigator url="/pages/index/index" open-type="navigate" class="mix-btn hollow">返回首页</navigator> -->
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				options:{}
			}
		},
		onLoad(query) {
		    this.options = query;
		},
		methods: {
			 back(){
				 // this.params.type
				 if(this.$util.prePage().initList){
				 	this.$util.prePage().initList();
				 }
				 uni.redirectTo({
				 	url: this.options.type=='yl' ? "/pages2/order/ylorder" : "/pages2/order/order"
				 })
			 }
		}
	}
</script>

<style lang='scss'>
	.content{
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		padding-top: 80rpx;
	}
	.wh200{
		display: block;
		width: 150rpx;
		height: 150rpx;
		margin: 0 auto;
		margin-bottom: 30rpx;
	}
	.success-icon{
		font-size: 160upx;
		color: #fa436a;
		margin-top: 100upx;
	}
	.tit{
		text-align: center;
		margin-top: 20rpx;
		margin-bottom: 20rpx;
		font-size: 32upx;
		color: #707070;
	}
	.btn-group{
		padding-top: 100upx;
	}
	.mix-btn {
		width: 630rpx;
		height: 80rpx;
		background: #FACE51;
		border-radius: 100rpx 100rpx 100rpx 100rpx;
		font-weight: 500;
		font-size: 32rpx;
		color: #000000;
		text-align: center;
		line-height: 80rpx;
		
	}
</style>
