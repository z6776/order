<template>
	<view class="content p20">
		
	      <image  :src="$util.cdnurl('maincoupon.png')"  @click="$util.navTo('/pages/components/pages/balance/getcoupon')"  mode="aspectFill" class="maincoupon m-b-30"></image>
		  
		
		  <u-tabs :list="tablist" @change="change" :is-scroll="false" active-color="#000000" inactive-color="#606266" font-size="30" :current="current"></u-tabs>
		  
		  <view class="m-b-30">
		  	
		  </view>
		  <mescroll-body @init="mescrollInit" @down="downCallback" @up="upCallback">
		  <view class="couponlist d-flex radius-20 p-relative m-b-30" v-for="(item,index) in list" :key="index">
			  <image  :src="$util.cdnurl('couponbg.png')" class="couponbg" mode=""></image>
		  	    <view class="price d-c-flex fs-0 j-center">
					<block v-if="item.ctype=='reduce'">	
						  <view class="">
							 <text class="fz-28 fz-fff">￥</text>
							 <text class="fz-64 fz-fff fz-weight">{{ sumfn(item.value) || "0.00"}}</text>
						  </view>
					</block>
					<block v-else>
					  <view class="">
						 <text class="fz-64 fz-fff fz-weight">{{  item.discount*10 +"折" }}</text>
					  </view>
					</block>
					
				    <!-- 满减券 -->
					<block v-if="item.ctype=='reduce'">
						<view class="fz-24 fz-fff m-b-30" v-if="item.least<=0">
							无金额门槛
						</view>
						<view class="fz-20 fz-fff m-b-10" v-else>
							<block v-if="item.product_scope=='product'">指定商品可用</block>满{{ item.least }}可用
						</view>
					</block>
					
						<!-- 折扣券 -->
					<block v-if="item.ctype=='discount'">
						<view class="fz-24 fz-fff m-b-30" v-if="item.least<=0">
							无金额门槛
						</view>
						<view class="fz-20 fz-fff m-b-10" v-else>
							<block v-if="item.product_scope=='product'">指定商品可用</block>
						</view>
					</block>
				
					
					
					<view class="fz-24 fz-fff m-b-30 line1 w80" v-if="item.instructions">
					   <rich-text :nodes="item.instructions | filterdetail"></rich-text>
					</view>
		  	    </view>
				
				<view class="introduce flex-1">
					 <view class="title">
					 	 {{item.title || ""}}
					 </view>
					 <view class="d-flex row">
					 	  <view class="msg">
					 	  	   适用于{{item.shop_name}}
					 	  </view>
						  <view class="btn" @click="selectItem(item)" v-if="current===0 && params.pagetype!='mine'">
						  	   立即使用
						  </view>
					 </view>
					<!-- <view class="p-b-20 borderbottom">
					 	
					 </view> -->
					 
					 <view class="qx">
					 	   有效期限：{{ item.endtime_text || "" }}
					 </view>
					 
				</view>
		  </view>
		  </mescroll-body>
		  
	</view>
</template>

<script>
	import MescrollMixin from "@/utils/mescroll.js";
	import { mapState, mapMutations } from 'vuex';
	 export default{
		  mixins:[MescrollMixin],
		 data(){
			 return {
				 list:[],
				 	tablist: [{
						name: '未使用',
						type:1
					}, {
						name: '已使用',
						type:2
					}, {
						name: '已过期',
						type:3
					}],
				 	current: 0,
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				 params:{}
			 }
		 },
		 onLoad(query){
			 
			 this.params = query;
		 },
		 onShow() {
		 	this.initList();
		 },
		 methods:{
			 ...mapMutations(['SET_COUPON']),
			 mescrollInit(mescroll) {
			 	this.mescroll = mescroll;
			 	this.mescroll.optUp.toTop.bottom = 240;
			 	this.mescroll.optUp.empty.zIndex = 9999;
			 	this.mescroll.optUp.auto = false;
			 	this.mescroll.optDown.auto = false;
			 },
			 selectItem(item){
				 // type=getcoupon&status=3&ids=69,68,67,70
				 if(this.current>0){
					 return;
				 };
				 if(this.params.status==4 && this.params.type=='getcoupon'){
						 this.$util.prePage().coupon = item;
						 uni.navigateBack(); 
					 return;
				 }
				 // 满减券
				 let shoplist = uni.getStorageSync("shoplist");
				 if(item.ctype=='reduce'){
					 // 全场通用
					 if(item.product_scope=='all'){
						  if(this.params.price < Number(item.least)){
							  return this.$u.toast("未达到指定消费");
						  }
					 }
					 // 指定商品
					 if(item.product_scope=='product'){
						 // 支持的商品id
						 let arr = item.product_ids.split(",");
						 // 订单的商品id
						 let brr = [];
						 for (let i = 0; i < shoplist.length; i++) {
						     brr.push(shoplist[i].id+'');
						 }
						
						 let flag = brr.some(id=>arr.includes(id));
						
						 if(!flag){
							  return this.$u.toast("该订单不存在适用商品");
						 };
						 // 指定商品满多少可用
						 // 订单存在的指定商品id;
						 let isincludearr = shoplist.map(value=>{
							 if(arr.includes(value.id+'')){
								 return value;
							 }
						 }).filter(v=>v!=undefined);
						 let total = this.total(isincludearr);
						
						 if(Number(total) < Number(item.least)){
							   return this.$u.toast("指定商品金额未达到");
						} 
					 }
				 };
				 // 折扣券
				 if(item.ctype=='discount'){
					 // if(item.product_scope=='all'){
						//   if(this.params.price < Number(item.least)){
						// 	  return this.$u.toast("未达到指定消费");
						//   }
					 // }
					 // 指定商品  指定商品满多少可用
					 if(item.product_scope=='product'){
						 // 支持的商品id
						 let arr = item.product_ids.split(",");
						 // 订单的商品id
						 let brr = [];
						 for (let i = 0; i < shoplist.length; i++) {
						     brr.push(shoplist[i].id+'');
						 }							
						 let flag = brr.some(id=>arr.includes(id)); 
						 if(!flag){
							  return this.$u.toast("该订单存在优惠券不适用商品");
						 };
					 }
				 };
				 
				 if(this.params.type=='getcoupon'){
					 this.$util.prePage().coupon = item;
					 uni.navigateBack(); 
				 }
			},
			// 总金额
			total(isincludearr){
				// 满减券
				console.log(isincludearr,"isincludearrisincludearr");
				
			   let total = isincludearr.reduce((cur,item)=>{
				   if(!item.number){
					   item.number = 1
				   }
				   return (cur+(Number(item.sales_price) * item.number))
			   },0);
			   return total.toFixed(2);
			},
			 sumfn(value){
			 	return value ? Number(value).toFixed(0) : '0.00'
			 },
			 // 初始化列表
			 initList(){
			 	 this.list = [];
			 	 this.mescroll.resetUpScroll();
			 },
			 // 搜索列表
			 searchtit(e){
			 	this.keyword = e;
			 	this.initList();
			 },
			 async upCallback(page){
				 // status 3 2是外卖  1 是自取  item.type 1是自取  2是外卖
				 let type = 0;
				 if((this.params.status==3 || this.params.status==2)){
				 		type = 2
				 }else if(this.params.status==1){
				 	type = 1;
				 }else if(this.params.status==4){
				 	type = 3;
				 }
				 // type	integer	否	可用类型:0=通用,1=自取,2=外卖,3=服务
			 	let data = await this.$u.api.mine({
					type,
			 		status:this.tablist[this.current].type || "",
			 		page:page.num,
			 		pagesize:page.size
			 	});
			 	console.log(data,"datatata");
			 	if(page.num==1){
			 		this.list = [];
			 	}
			 	this.list =  [...this.list,...data];
			 	this.mescroll.endSuccess(data.length, page.size == data.length);
			  },
			 change(index) {
			 	this.current = index;
				this.initList();
			}
			 
		 }
	 }
</script>

<style scoped lang="scss">
	::v-deep.u-tabs{
		background: transparent !important;
	}
	.content{
		min-height: 100vh;
		padding: 20rpx 20rpx 20rpx 20rpx;
		.w80{
		  width: 80%;
		}
		.maincoupon{
			width: 714rpx;
			height: 204rpx;
		}
		
		.couponlist{
			height: 200rpx;
			.couponbg{
				position: absolute;
				inset: 0;
				width: 100%;
				height: 100%;
				z-index: -1;
			}
			.price{
				width: 222rpx;
				height: 100%;
			}
			.introduce{
				padding-left: 30rpx;
				padding-right: 30rpx;
				.title{
					font-weight: 500;
					font-size: 32rpx;
					color: #000000;
				}
				.row{
					.msg{
						font-weight: 500;
						font-size: 28rpx;
						color: #979797;
					}
					.btn{
						width: 140rpx;
						height: 60rpx;
						line-height: 60rpx;
						font-weight: 500;
						font-size: 28rpx;
						color: #FFFFFF;
						text-align: center;
						background-color: #FACE51;
						border-radius: 90rpx;
					}
				}
				.qx{
					font-weight: 500;
					font-size: 24rpx;
					color: #979797;
					margin-top: 10rpx;
				}
				
			}
		}
	}
	.fz-64{
		font-size: 64rpx;
	}
	
</style>