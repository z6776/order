<template>
	<view class="content">
		<view class="d-flex j-center fz-36 fz-weight fz-000000 radius-20 m-b-20 box p-relative" @click="$util.navTo('/pages2/orderstatistics/index')">
			订单统计	
			<image  :src="$util.cdnurl('ordersum.png')" class="ordersum" mode=""></image>
		</view>
		
		<view class="d-flex j-center fz-36 fz-weight fz-000000 radius-20 m-b-20 box p-relative" @click="$util.navTo('/pages2/productionpersonnel/index')">
			  产品汇总
			  <image  :src="$util.cdnurl('productsumm.png')" class="ordersum" mode=""></image>
		</view>
		
	</view>
</template>

<script>
	 export default{
		 data(){
			 return {
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg'
			 }
		 },
		 onLoad(){
			 
		 },
		 methods:{
			 
		 }
	 }
</script>

<style scoped lang="scss">
	.content{
		min-height: 100vh;
		padding: 30rpx 20rpx 20rpx 20rpx;
	}
	.ordersum{
		position: absolute;
		inset: 0;
		width: 100%;
		height: 100%;
		z-index: -1;
	}
	.box{
		width: 100%;
		height: 220rpx;
	}
</style>