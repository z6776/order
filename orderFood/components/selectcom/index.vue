<template>
	<view class="dropmenu" >
	      <view class="bgtime d-flex m-b-20" @click="open" :style="[{maxHeight:maxHeight+'rpx'}]">
	      	<text class="fz-28 fz-979797 m-r-auto">{{  msg || defaultmsg}}</text>
	      	<image src="../../static/yxyp.png" class="wh30" mode="" v-if="!msg"></image>
			<view class="d-flex j-center wh40"  v-else @click.stop="close">
				<image src="../../static/images/pay/close.png" class="wh20" mode=""></image>
			</view>
			
			<view scroll-y class="drop" :class="{'left':align=='left','right':align=='right'}" v-if="show">
					<view  class=" d-c-flex j-center h80 line1 fz-28 fz-000000" @click.stop="selItem(item)" v-for="(item,i) in list" hover-class="common-hover" hover-stay-time="50">
						   {{ item.title || "" }}
					</view>
			</view>
					 
	      </view> 
		 
		 
	</view>
</template>

<script>
	 export default{
		 props:{
			 defaultmsg:{
				 type:String,
				 default:""
			 },
			 list:{
				type:Array,
				default:[{
					title:"取餐点",
					value:"1"
				},{
					title:"取餐点2",
					value:"2"
				}]  
			 },
			 align:{
				type:String,
				default:"" 
			 },
			 msg:{
				 type:String,
				 default:""
			 }
		 },
		 data(){
			 return {
				 show:false,
				 maxHeight:60,
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg'
			 }
		 },
		 mounted(){
			 const area = uni.createSelectorQuery().in(this);
			 this.$nextTick(()=>{
			 	area.select('.content').boundingClientRect(B=>{
					console.log(B,"nnnnnnnnn");
			 		 // this.minheight = B.bottom+"px";
			 		 // this.$emit("getBottom",B.top);
			 	}).exec();
			 })	
		 },
		 methods:{
			 // 确认时间
			 selItem(e){
				 this.show = false;
				 this.$emit("update:msg",e.title);
				 this.$emit("update:timevalue",e.value);
				 this.$emit("init");
			 },
			 close(){
				this.$emit("update:msg","");
				this.$emit("update:timevalue","");
				this.$emit("init");
			 },
			 open(){
				this.show = !this.show;
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
	.left{
		left: 0;
	}
	.right{
		right: 0;
	}
	
	.h80{
		max-width: 100%;
		color: #000000;
		height: 80rpx;
		line-height: 80rpx;
	}
	.wh20{
		width: 20rpx;
		height: 20rpx;
	}
	.dropmenu{
		
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
		
	transition: max-height .3s linear;
	// overflow: hidden;
	position: relative;
	.drop{
		position: absolute;
		top: 60rpx;
		width:347rpx;
		// height: 600rpx;
		background-color: #fff;
		z-index: 99999;
	}
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