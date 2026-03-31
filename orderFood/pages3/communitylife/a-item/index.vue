<template>
	<view class="item p-b-30" @click="$util.navTo('/pages3/communitylife/detail?id='+info.id)">
		<u-image :src="$util.getImgurl(info.coverimage)" width="100%" height="260rpx" border-radius="20rpx 20rpx 0 0" mode="aspectFill" ></u-image>
		<!-- <image :src="../../../static/emptyCart.jpg" mode="aspectFill" class="wh260"></image> -->
		<view class="p-t-20 p-l-20">
			<view class="fz-32 fz-000000 fz-bold m-b-10">{{ info.name || "" }}</view>
			<view class="line1 fz-28 fz-500 fz-979797 m-b-10">
				{{ info.shortdesc || "" }}
			</view>
			<view class="">
				<text class="fz-24 fz-500" style="color: rgba(0, 0, 0, 0.7);">时间:</text>
				<text class="fz-24 fz-500" style="color: rgba(0, 0, 0, 0.7);">{{ this.$util.parseTime(info.starttime,"{m}/{d} {h}:{i}") || ""}}-{{ this.$util.parseTime(info.endtime,"{m}/{d} {h}:{i}") || ""}}</text>
			</view>
			<view class="m-t-10">
				<text class="fz-24 fz-500 fz-000000">地址:</text>
				<text class="fz-24 fz-500 fz-000000">{{ info.address || "" }}</text>
			</view>
			<view class="m-t-10">
				<text class="fz-24 fz-500" style="color: rgba(0, 0, 0, 0.7);">社区:</text>
				<text class="fz-24 fz-500" style="color: rgba(0, 0, 0, 0.7);">{{ $util.isNull(info.community,"name")|| "" }}</text>
			</view>
			
			<view class="d-flex m-t-30 p-r-30">
				 <view class="tagnum">
				 	  限{{ info.maxcount }}人
				 </view>
				 <image src="../../../static/images/newStatic/arrowright.png" mode="aspectFill" class="wh48"></image>
			</view>
		</view>
		
		<view class="btnCancel m-t-10 " @click.stop="show = true" v-if="isme">
			取消
		</view>
		
		<orderpop :show.sync="show" content="取消参加?" @confirm="confirm" :isShowSlot="false">
		
		</orderpop>
		
		<view class="tag" :style="[{'backgroundColor':tagStyle}]">
			{{ $util.ylStatus(info.status || "")  }}
		</view>
	</view>
</template>

<script>
	import orderpop from "@/components/orderpop/index.vue";
	 export default{
		 components:{
			 orderpop
		 },
		 computed:{
			 tagStyle(){
				 let bg = [{
					 title:"未开始",
					 color:"#FB7A35"
				 },{
					 title:"进行中",
					 color:"#9EF98A"
				 },
				 {
					 title:"已结束",
					 color:"#979797"
				 },
				 {
					 title:"已取消",
					 color:"#979797"
				 }];
				 let index = bg.findIndex(v=>v.title==this.info.status_text);
				 return index>-1 ? bg[index].color : "#979797";
				 
			 }
		 },
		 props:{
			 isme:{
				 type:Boolean,
				 default:false
			 },
			 info:{
				 type:Object,
				 default:{}
			 }
		 },
		 data(){
			 return {
				 show:false,
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg'
			 }
		 },
		 onLoad(){
			 
		 },
		 methods:{
			 // 取消订单
			 async confirm(){
				 let data = await this.$u.api.cancelApply({
				     id:this.info?.id
				 });
				 this.$emit("initList")
			 }
		 }
	 }
</script>

<style scoped lang="scss">
	.btnCancel{
		width: 100%;
		height: 60rpx;
		    line-height: 60rpx;
		text-align: center;
		background-color: #FACE51;
		border-radius: 80rpx;
	}
	.item{
		position: relative;
		width: 100%;
		background-color: #ffffff;
		border-radius: 20rpx;
		.tag{
			width: 100rpx;
			height: 50rpx;
			border-radius: 20rpx 0rpx 20rpx 0rpx;
			text-align: center;
			line-height: 50rpx;
			position: absolute;
			top: 0;
			left: 0;
			border-radius: 20rpx 0 20rpx 0;
		}
	}
	.tagnum{
		width: 140rpx;
		height: 40rpx;
		background: #FFCEC4;
		border-radius: 8rpx 8rpx 8rpx 8rpx;
		font-weight: 500;
		font-size: 24rpx;
		color: rgba(0,0,0,0.5);
		text-align: center;
		line-height: 40rpx;
	}
	.wh48{
		width: 48rpx;
		height: 48rpx;
	}
	.wh260{
		width: 100%;
		border-radius: 20rpx 20rpx 0 0;
		height: 260rpx;
	}
	
</style>