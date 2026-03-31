<template>
	<view class="content p20">
	    <view class="image m-b-20">
	    	<view class="tag" :style="[{'backgroundColor':tagStyle}]">
	    		{{ $util.ylStatus(info.status) }}
	    	</view>
			<image :src="$util.getImgurl(info.coverimage)" class="h540 radius-20 w-100" mode=""></image>
	    </view>
		
		<view class="p30 bg-fff radius-20">
			<view class="d-flex m-b-30">
				<view class="fz-32 fz-000000 fz-bold">{{ info.name || "" }}</view>
				<view class="tagnum">
					  限{{ info.maxcount }}人
				</view>
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
			<view class="m-t-10">
				<text class="fz-24 fz-500 fz-000000">简介:</text>
				<text class="fz-24 fz-500 fz-000000">{{ info.shortdesc || "" }}</text>
			</view>
		</view>
		
		<view class="p30 bg-fff radius-20 m-t-20">
			<view class="">
				<text class="fz-000000 fz-32 fz-bold m-r-20">已报名人数</text>
				<text class="fz-FACE51  fz-28">{{ apply.length }}</text>
				<text class="fz-979797  fz-28">/{{ info.maxcount }}</text>
			</view>
			<view class="d-flex m-t-20 f-start">
				<view class="avataritem d-c-flex" v-for="(item,index) in apply">
					<image :src="$util.getImgurl($util.isNull(item.user,'avatar'))" class="wh80" mode=""></image>
					<text class="fz-500 fz-28 clamp w120" style="color: rgba(0, 0, 0, .5);">{{ $util.isNull(item.user,'username') || "" }}</text>
				</view>
				 <!--  -->
				<view class="rightslot"  v-if="apply.length>5" @click="$util.navTo('/pages3/communitylife/userlist?id='+options.id)">
					<image src="../../static/images/newStatic/dot.png"  class="wh40"  mode=""></image>
				</view>
			</view>
		</view>
		
		<view class="p30 bg-fff radius-20 m-t-20">
			 <view class="fz-500 fz-28 fz-000000 fz-center">
			 	图文内容
			 </view>
			 <view class="">
			 	<rich-text :nodes="info.birefcontent | filterdetail"></rich-text>
			 </view>
		</view>
		
		<view class="boxFixed bgt">
			<mybtn msg="已报名" background='#BCBCBC' color="#000000" v-if="isMe"/>
			<mybtn msg="立即报名" @handclick="bmfn" v-else />
		</view>
	</view>
</template>

<script>
	 export default{
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
			 		 				 
			 },
			 isMe(){
				 let user_id = this.$store.state.member.id;
				 return this.apply.findIndex(v=>v.user_id==user_id) > -1;
			 }
		 },
		 data(){
			 return {
				 apply:[],
				 info:{
					 //    status:"未开始",
						// image: "../../static/emptyCart.jpg",
						// title: "健康之源",
						// desc: "健康的重要性，如何保持强健的体魄，最重要的健康的重要性，每日的锻炼和规律的饮食作息",
						// time: "08/30 08:30-09:00",
						// address: "新创福养老中心",
						// sq:"新创福养老中心社区",
						// pnum: 500
				 },
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				 options:{}
			 }
		 },
		 onLoad(options){
			 this.options = options;
		 },
		 onShow() {
		 	 this.getDetail();
		 },
		 methods:{
			 // 
			 async getDetail(){
				 let {info,apply} = await this.$u.api.getYanglaoActivityInfo({
				    id:this.options.id
				 });
				 if(apply){
					 this.apply = apply;
				 }
				 this.info = info;
			 },
			 async bmfn(){
				 uni.showLoading({
				 	mask:true
				 })
				 let res = await this.$u.api.addApply({
				    id:this.options.id
				 });
				 this.$util.navTo('/pages3/communitylife/success');
			 }
		 }
	 }
</script>

<style scoped lang="scss">
	.content{
		min-height: 100vh;
		background-color: #FAFAFA;
		padding: 30rpx 20rpx 20rpx 20rpx;
		padding-bottom: 220rpx;
	}
	.w120{
		width: 120rpx;
	}
	.wh40{
		width: 40rpx;
		height: 40rpx;
	}
	.wh80{
		width: 80rpx;
		height: 80rpx;
		border-radius: 50%;
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
	.image{
		position: relative;
		.tag{
			width: 100rpx;
			height: 50rpx;
			background: #FB7A35;
			border-radius: 20rpx 0rpx 20rpx 0rpx;
			font-weight: 500;
			font-size: 28rpx;
			color: #000000;
			text-align: center;
			line-height: 50rpx;
			position: absolute;
			
		}
	}
	.h540{
		height: 540rpx;
	}
	
</style>