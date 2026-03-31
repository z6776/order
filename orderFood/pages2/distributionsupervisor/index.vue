<template>
	<view class="content p-t-10">
		<view class="d-flex f-warp">
			<!--  -->
			<view class="wh200 p10 p-relative" @click="$util.navTo('/pages2/deliveryorder/index')">
				<view class="wh100 radius-20 d-flex  j-center ">
					配送订单
				</view>
				<image  :src="$util.cdnurl('psorder.png')"   class="tabbg" mode=""></image>
			</view>
			<!--  -->
			<view class="wh200 p-relative  p10" @click="$util.navTo('/pages2/productionpersonnel/index?title=产品汇总')">
				<view class="wh100 radius-20 d-flex   j-center ">
					产品汇总
				</view>
				<image :src="$util.cdnurl('hzorder.png')"  class="tabbg" mode=""></image>
			</view>
			<!--  -->
			<view class="wh200 p-relative p10" @click="$util.navTo('/pages2/orderreview/index')">
				<view class="wh100 radius-20 d-flex j-center  ">
					订单审核
				</view>
				<image :src="$util.cdnurl('shorder.png')"  class="tabbg" mode=""></image>
			</view>
			<!--  -->
			<view class="wh200 p-relative p10" @click="$util.navTo('/pages2/deliveryorder/management')">
				<view class="wh100 radius-20 d-flex j-center  ">
					人员管理
				</view>
				<image :src="$util.cdnurl('personmage.png')"   class="tabbg" mode=""></image>
			</view>
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
	.tabbg{
		width: 100%;
		height: 100%;
		position: absolute;
		width: 100%;
		height: 100%;
		border-radius: 20rpx;
		inset: 0;
		z-index: -1;
	}
    .p10{
		padding: 10rpx;
	}
	.wh200{
		// background-color: red;
		width: 50%;
		height: 250rpx;
	}
	
</style>