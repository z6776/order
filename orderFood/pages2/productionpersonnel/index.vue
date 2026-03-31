<template>
	<view class="content">
	     <view class="d-flex">
			 <view class="flex-1">
			 	<u-tabs active-color="#FACE51" inactive-color="#979797"  :list="tablist"  :is-scroll="false" :current="current" @change="change"></u-tabs>
			 </view>
			<selectDate  msg="请选择开始日期" :time.sync="startTime" @init="initList" :endDate="endDate"/>
					<!-- 
					<text class="fz-28 fz-979797 m-r-20">{{startTime ||  '请选择开始日期'}}</text>
					<image src="../../static/yxyp.png" class="wh30" mode=""></image> -->
	     </view>
		 
		 <view class="d-flex f-start m-b-10 m-t-10">
		 	 <text class="fz-ff0000 fz-32 fz-weight m-r-10">合计:</text>
			 <text class="fz-ff0000 fz-32 fz-weight">{{ total || "0" }}</text>
		 </view>
		 
		 <mescroll-body @init="mescrollInit" @down="downCallback" @up="upCallback">
		 <view class="item d-flex f-start" v-for="(item,index) in list">
		 	  <view class="num m-r-10">
		 	  	  {{ index+1}}
		 	  </view>
			  <view class="dou m-r-auto fz-32 basecolor">
				 {{ item.category }}-{{item.title || ""}} {{item.spec || ""}}
			  </view>
			  <view class="fs-0">
				  <text class="fz-28 basecolor m-r-10">数量</text>
				  <text class="fz-32 fz-FF2525">{{item.number || ""}}</text>
			  </view>
		 </view>
		<!-- <view class="item d-flex j-center fz-979797 fz-28">
		 	  ---没有了---
		 </view> -->
		 </mescroll-body>
		 
		<!-- <uni-calendar
		 	   range
		 		ref="calendar"
		 		:insert="false"
		 		@confirm="confirm"
		 		 /> -->
				 
	</view>
</template>

<script>
	import MescrollMixin from "@/utils/mescroll.js";
	import selectDate from "@/components/selectDate";
	 export default{
		 mixins:[MescrollMixin],
		 components:{
			 selectDate
		 },
		 computed:{
			 endDate(){
				 let date = new Date().toLocaleDateString();
				 return this.$util.parseTime(date.split('-')[0],"{y}-{m}-{d}") ;
			 }
		 },
		 data(){
			 return {
				 total:"",  // 合计
				 datetimerange:"",
				 tablist: [{
					name: '全天',
					isam:""
				}, {
					name: '上午',
					isam:1
				}, {
					name: '下午',
					isam:2
				}],
				list:[],
				current: 0,
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				 startTime:""
			 }
		 },
		 onLoad(query){
			 uni.setNavigationBarTitle({
			 	title:query.title ? query.title :'生产人员'
			 });
			 this.startTime = this.endDate; 
		 },
		 methods:{
			 // 初始化列表
			  initList(){
			     this.list = [];
			     this.mescroll.resetUpScroll();
			 },
			 async upCallback(page){
				 // isam	integer	否	1=上午2=下午
				 // selfpcikup_id	integer	否	自提点id
				 // date	string	否	日期
			    let data = await this.$u.api.getSummary({
					isam:this.tablist[this.current].isam || "",
			        selfpcikup_id: "",
			        page:page.num,
			        pagesize:page.size,
			        date:this.startTime
			    });
			    console.log(data,"datatata");
			    if(page.num==1){
			        this.list = [];
			    }
				this.total = data.total;
			    this.list =  [...this.list,...data.list];
			    this.mescroll.endSuccess(data.list?.length, page.size == data.list?.length);
			 },
			 change(index) {
			    this.current = index;
			   this.initList();
			 },
			 // 确认时间
			 confirm(e){
				 this.startTime = e.fulldate;
			 	this.initList()
			 	console.log(e,"eeeeeeee")
			 },
			 open(type){
			 	this.$refs.calendar.open();
			 }
		 }
	 }
</script>

<style scoped lang="scss">
	::v-deep.u-tabs{
		background-color: transparent !important;
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
	}
	.content{
		min-height: 100vh;
		background-color: #FAFAFA;
		padding: 20rpx;
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
	}
	.item{
		border-radius: 20rpx;
		padding: 20rpx;
		background-color: #fff;
		margin-bottom: 20rpx;
	}
	.num{
		width: 40rpx;
		height: 40rpx;
		display: flex;
		border-radius: 10rpx;
		justify-content: center;
		align-items: center;
	}
	
</style>