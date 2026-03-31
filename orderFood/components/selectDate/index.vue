<template>
	<view class="content">
	      <view class="bgtime d-flex m-b-20" @click="open">
	      	<text class="fz-28 fz-979797 m-r-auto">{{ time || msg}}</text>
	      	<image src="../../static/yxyp.png" class="wh30" mode="" v-if="!time"></image>
			<view class="d-flex j-center wh40"  v-else @click.stop="close">
				<image src="../../static/images/pay/close.png" class="wh20" mode=""></image>
			</view>
	      </view>  
		  
		  
		  <uni-calendar
		  	   range
			   :endDate="endDate"
		  		ref="calendar"
		  		:insert="false"
		  		@confirm="confirm"
		  		 />
	</view>
</template>

<script>
	 export default{
		 props:{
			 endDate:{
				type:String,
				default:"" 
			 },
			 time:{
				type:String,
				default:"" 
			 },
			 msg:{
				 type:String,
				 default:"请选择日期"
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
			 // 确认时间
			 confirm(e){
				 this.$emit("update:time",e.fulldate);
				 this.$emit("init");
			 },
			 close(){
				this.$emit("update:time","");
				this.$emit("init");
			 },
			 open(){
				this.$refs.calendar.open();
			 }
		 }
	 }
</script>

<style scoped lang="scss">
	.content{
		// min-height: 100vh;
		// background-color: #FAFAFA;
		// padding: 30rpx 20rpx 20rpx 20rpx;
	}
	.wh20{
		width: 20rpx;
		height: 20rpx;
	}
	.bgtime{
		padding: 0 40rpx;
		width: 347rpx;
		height: 60rpx;
		border-radius: 60rpx;
		background-color: #FFFFFF;
		font-weight: 500;
		font-size: 32rpx;
		color: #979797;
		.wh30{
			width: 35rpx;
			height: 35rpx;
		}
		.wh40{
			height: 60rpx;
			width: 60rpx;
		}
	}
	
</style>