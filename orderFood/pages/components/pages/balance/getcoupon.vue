<template>
	<view class="content">
		<view class="btnall" @click="linquall()" v-if="list && list.length">
			   领取全部
		</view>
		<mescroll-body @init="mescrollInit" @down="downCallback" @up="upCallback">
	        <view class="couponlist d-flex radius-20 p-relative m-b-30" v-for="(item,index) in list" :key="index">
	        			  <image  :src="$util.cdnurl('couponbg.png')"   class="couponbg" mode=""></image>
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
							  
	        					<view class="fz-24 fz-fff m-b-30" v-if="item.least<=0">
	        						无金额门槛
	        					</view>
								<view class="fz-20 fz-fff m-b-10" v-else>
									<block v-if="item.product_scope=='product'">指定商品</block>满{{ item.least }} 可用
								</view>
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
	        						  <view class="btn" @click="linqu(item)">
	        						  	   立即领取
	        						  </view>
	        					 </view>
	        					 <view class="p-b-20 borderbottom">
	        					 	
	        					 </view>
	        					 
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
	 export default{
		   mixins:[MescrollMixin],
		 data(){
			 return {
				 list:[],
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg'
			 }
		 },
		 onLoad(){
			 
		 },
		 methods:{
			  // 
			 async linquall(){
				 uni.showLoading({
				 	mask:true
				 })
				 let len = 0;
				 for (let s of this.list) {
					 if(len==this.list.length){
						 break;
					 };
				 	 let data = await this.$u.api.couponReceive({
				 	     id:s.id
				 	 });
					 if(data){
						 len++;
					 }
				 }
				 uni.showToast({
				 	icon:"success",
				 	title:"领取成功"
				 });
				 this.initList();
			 },
			 // 领取
			 async linqu(item){
				let data = await this.$u.api.couponReceive({
				    id:item.id
				});
				uni.showToast({
					icon:"success",
					title:"领取成功"
				});
				this.initList();
				console.log(data,"datatat");
				console.log(data,"datatata"); 
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
			    let data = await this.$u.api.couponIndex({
			        page:page.num,
			        pagesize:9999
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
	.content{
		min-height: 100vh;
		padding: 30rpx 20rpx 20rpx 20rpx;
		.btnall{
			width: 200rpx;
			height: 80rpx;
			line-height: 80rpx;
			font-weight: 500;
			font-size: 32rpx;
			color: #FFFFFF;
			text-align: center;
			background-color: #FACE51;
			border-radius: 90rpx;
			margin-bottom: 30rpx;
		}
		.w80{
		  width: 80%;
		}
		.fz-64{
			font-size: 64rpx;
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
	
</style>