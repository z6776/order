<template>
	<view class="content">
	        <view class="d-flex search">
	        	<input class="ints" type="text" placeholder="请输入活动名称" :value="value" @input="searchtit"/>
	        	<view class="rightslot" @click.stop="initList">
	        		<image  src="../../static/images/newStatic/search.png" mode="" class="wh38"></image>
	        	</view>
	        </view>
	</view>
</template>

<script>
	 export default{
		 props:{
		    value:{
				type:[Number,String],
				default:""
			} 
		 },
		 data(){
			 return {
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg'
			 }
		 },
		 onLoad(){
			 
		 },
		 methods:{
			 initList(){
				 this.$emit("search",this.value);
			 },
			 searchtit(e){
				 // this.initList();
				 this.$emit("input",e.detail.value);
				 this.$emit("search",this.value);
			 }
		 }
	 }
</script>

<style scoped lang="scss">
	.search{
		position: relative;
		height: 60rpx;
		border-radius: 90rpx;
		.ints{
			border-radius: 90rpx;
			padding-left: 28rpx;
			padding-right: 140rpx;
			height: 100%;
			background-color: rgba(255, 255, 255, 0.25);
			width: 100%;
		}
		.rightslot{
			min-width: 140rpx;
			border-radius: 90rpx;
			height: 100%;
			bottom: 0;
			top: 0;
			padding-left: 10rpx;
			padding-right: 28rpx;
			right: 0;
			position: absolute;
			font-weight: 500;
			font-size: 28rpx;
			display: flex;
			justify-content: flex-end;
			align-items: center;
			color: #FFFFFF;
			line-height: 60rpx;
			.wh38{
				width: 38rpx;
				height: 38rpx;
			}
		}
	}
</style>