<template>
	<view class="content">
	    <view class="zichan">
			<image  :src="$util.cdnurl('yuebg.png')" class="bgye" mode=""></image>
	    	  <view class="d-c-flex">
	    	  	    <text class="fz-B85724">总资产(元)</text>
					<text class="fz-56 fz-weight fz-B85724">{{ position.money || "0.00" }}</text>
	    	  </view>
			  
			  <view class="d-flex m-t-30">
			  	   <view class="d-c-flex">
			  	   	    <text class="fz-B85724">累计充值(元)</text>
						<text class="fz-56 fz-weight fz-B85724">{{ info.yearSum || '0.00' }}</text>
			  	   </view>
				   
				   <view class="d-c-flex">
				   	    <text class="fz-B85724">月度消费(元)</text>
				   	    <text class="fz-56 fz-weight fz-B85724">{{ info.monthSum || '0.00' }}</text>
				   </view>
			  </view>
			  <mybtn msg="充值" @handclick="navfn" marginTop="70rpx" v-if="showcz==1" />
	    </view>
		<view class="title">
			  账单明细
		</view>
		<view class="bg-fff radius-20">
			<mescroll-body @init="mescrollInit" @down="downCallback" @up="upCallback">
			<u-tabs  active-color="#FACE51" inactive-color="#707070"  :list="tablist" :is-scroll="false" :current="current" @change="change"></u-tabs>
				<view class="p20 radius-20">
				<view class="d-flex p-b-20 p-t-20 borderbottom" v-for="item in list" :key="item.id" @click.stop="godetail(item)">
					 <view class="d-c-flex a-start">
						 <text class="fz-454545 fz-28 fz-weight m-b-10">{{item.memo}}</text>
						 <text class="fz-979797">{{item.createtime_text || ""}}</text>
					 </view>
					 <view class="d-flex f-start">
						 <text  class="fz-F8B300 fz-500" v-if="Number(item.after)>Number(item.before)">+</text>
						  <text  class="fz-F8B300 fz-500" v-else>-</text>
						<text class="fz-F8B300 fz-500">{{item.money}}</text>
						<u-icon name="arrow-right" v-if="item.type && item.order_id"></u-icon>
					 </view>
				</view>
				</view>
			</mescroll-body>
		</view>
	</view>
</template>

<script>
	import { mapState } from "vuex";
	import MescrollMixin from "@/utils/mescroll.js";
	 export default{
		 mixins:[MescrollMixin],
		 data(){
			 return {
				 list:[],
				 tablist: [{
				 					name: '全部',
									type:1
				 				}, {
				 					name: '消费',
									type:2
				 				}, {
				 					name: '充值',
									type:3
				 				}],
				 				current: 0,
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				 info:{},
				 money:""
			 }
		 },
		 computed:{
			 ...mapState(["position",'showcz'])
		 },
		 onLoad(){
			 this.getUserInfo();
		 },
		 methods:{
			 showFn(item){
				return (item.type=='shop' && item.order_id) || (item.type=='shop' && item.order_id) 
			 },
			 // 
			async godetail(item){
				 // 食堂
				 if(item.type=='shop' && item.order_id){
					 const res = await this.$u.api.haOrder({
					 	 id:item.order_id
					 });
					 this.$util.navTo("/pages2/order/orderdetail?id="+res);
					 return;
				 }
				 // 养老
				 if(item.type=='yanglao' && item.order_id){
					 // const res = await this.$u.api.haOrder({
						//  id:item.order_id
					 // });
					 this.$util.navTo("/pages2/centeradministrator/detail?id="+item.order_id+"&title=订单详情&pagetype=orderyl");
					 return;
				 }
				 
				 
			 },
			 async getUserInfo(){
				 const res = await this.$u.api.userindex();
				 this.money = res.money;
			 },
			 async upCallback(page){
			    let res = await this.$u.api.getMoneyLog({
			 	 type:this.tablist[this.current].type, //	string	否	类型:1.待付款 2.待取餐 3.待评价 4，已完成 5.已取消 6.退款 ,7.拼团中
			        page:page.num,
			        pagesize:page.size,
			    });
			  this.info = res;
			    if(page.num==1){
			        this.list = [];
			    }
			 				// 
			    this.list =  [...this.list,...res.list];
			    this.mescroll.endSuccess(res.list.length, page.size == res.list.length);
			 },
			 // 初始化列表
			  initList(){
			     this.list = [];
			     this.mescroll.resetUpScroll();
			 },
			 // 
			 change(index) {
			 	this.current = index;
				this.initList();
			 },
			  navfn(e){
				  this.$util.navTo("/pages/components/pages/balance/newbalance");
			  }
		 }
	 }
</script>

<style scoped lang="scss">
	::v-deep.u-tabs{
		border-radius: 20rpx !important;
	}
	.fz-B85724{
		color: #B85724;
	}
	.fz-56{
		font-size: 56rpx;
	}
	
	.content{
		min-height: 100vh;
		padding: 30rpx 20rpx 20rpx 20rpx;
		.title{
			font-weight: 800;
			font-size: 32rpx;
			color: #000000;
			margin-top: 20rpx;
			margin-bottom: 20rpx;
		}
		.zichan{
			width: 714rpx;
			height: 500rpx;
			position: relative;
			padding: 38rpx 28rpx;
			border-radius: 20rpx;
			margin-bottom: 30rpx;
			.bgye{
				border-radius: 20rpx;
				width: 100%;
				height: 100%;
				z-index: -1;
				inset: 0;
				position: absolute;
			}
		}
	}
	
</style>