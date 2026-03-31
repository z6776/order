<template>
	<view class="content">
		<image :src="$util.cdnurl('memberbg.png')"  class="memberimg" mode=""></image>
	   <u-navbar title="会员中心" :is-back="false" :border-bottom="false">
		<view class="p-l-20" @click="$util.back()">
			<u-icon name="arrow-left" size="32" color="#000000" bold></u-icon>
		</view>
	   </u-navbar>
	   
	  <view class="uni-margin-wrap">
		<swiper display-multiple-items='1' previous-margin="23px" next-margin="10px" :current="current" @change="handlechange" circular :indicator-dots="false" :autoplay="false" interval="3000" duration="600">
			<swiper-item v-for="(item,i) in info.list">
				<view class="swiper-itembox">
					<image  :src="$util.getImgurl(item.bannerimage)"   class="exportbg" mode=""></image>
					 <view class="row d-flex m-b-140">
					 	  <text class="vip">{{ item.name || "" }}</text>
						  <text class="vipmsg" >福豆: {{ position.score || "0" }} 颗</text>
					 </view>
					 <view class="d-c-flex a-start">
						 <view class="d-flex f-start">
							 <view class="w360">
							 	 <view class="linedot" :id="'D'+item.id" :style="{'width':item.width}">
									<view class="perage">
										<text class="fz-000000 fz-28">{{ isItem(item) ? stotal.scoretotal : Number(item.maxsales) }}</text>
										<text class="fz-979797 fz-28">/{{Number(item.maxsales) }}</text>
									 </view>
							 	 </view>
							 </view>
							 <text class="lv m-l-20" v-if="filtername(item.name)">Lv{{  filtername(item.name) }} </text>
						 </view>
					 </view>
					 
					 <view class="leiji m-t-10">
					 	 {{item.rulescontent || ""}}
					 </view>
				</view>
			</swiper-item>
		</swiper>
	  </view>
	  
	  <image   :src="$util.cdnurl('expertlogo.png')"  class="wh200" mode=""></image>
	  
	  <view class="p20">
			  <view class="d-flex">
				  
				  <view class="left-box bg-FDE4E3 d-c-flex j-center radius-20">
					  <view class="m-b-30">
						<image :src="$util.cdnurl('birth.png')"  class="wh40" mode=""></image>
						<text class="fz-500 fz-32 fz-000000">生日折扣</text>
					  </view>
					  <view class="zkcontent fz-28 fz-fff basecolor msg">
						  生日当天小碗菜系列堂食（送长寿面一份）
					  </view>
				  </view>
				  
				  <view class="right-box d-c-flex ">
					  <view class="right-box-item d-c-flex bg-FDE4E3 j-center radius-20">
						 <view class="d-flex f-start m-b-10">
							<image :src="$util.cdnurl('online.png')"  class="wh40" mode=""></image>
							<text class="fz-500 fz-32 fz-000000">线上打折</text>
						 </view>
						 <view class="zkcontent fz-28 fz-fff basecolor msgright">
							  （5-8折）
						 </view>
					  </view>
					  <view class="right-box-item d-c-flex bg-FDE4E3 j-center radius-20">
						<view class="d-flex f-start m-b-10">
							<image  :src="$util.cdnurl('zekou.png')"  class="wh40" mode=""></image>
							<text class="fz-500 fz-32 fz-000000">抵扣券</text>
						</view>
						<view class="fz-28 fz-fff basecolor msgright">
							 满199元减50元（满减、指定商品）
						</view>
					  </view>
				  </view>
				  
			  </view>
			  
			  
			  <view class="rules m-t-20 radius-20">
			  	   <view class="fz-000000 fz-weight fz-32">
			  	   	    会员规则
			  	   </view>
				   <view class="basecolor fz-28 m-t-30">
						{{ info.my.rulescontent || "" }}
				   </view>
			  </view>
	  	  </view>

	</view>
</template>

<script>
	import { mapState } from "vuex";
	 export default{
		 computed:{
			 ...mapState(["position"])
		 },
		 data(){
			 return {
				 loading:false,
				 list:[{
					 name:"一",
					 status:1
				 },{
					 name:"二",
					 status:2
				 },{
					 name:"三",
					 status:3
				 },{
					 name:"四",
					 status:4
				 },{
					 name:"五",
					 status:5
				 },{
					 name:"六",
					 status:6
				 },{
					 name:"七",
					 status:7
				 },{
					 name:"八",
					 status:8
				 }],
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				 current:0,
				 info:{}  ,// 会员等级列表
				 stotal:{}
			 }
		 },
		 onLoad(){
			 this.scoretotalfn();
		 },
		 methods:{
			 isItem(item){
				   return item.weigh>=this.info?.my?.weigh;
			 },
			 async scoretotalfn(){
				 let res = await this.$u.api.scoretotal();
				 this.stotal = res;
				  this.getinfo();
			 },
			 filtername(e){
				 let item = this.list.find(v=>e.includes(v.name));
				 if(Object.keys(item).length>0){
					  return item.status+1
				 }else{
					 return "";
				 }
			 				
			 },
			 async getinfo () {
				 uni.showLoading({
				 	title:"加载中..."
				 })
				 let res = await this.$u.api.getUserlevel();
				 this.info = res;
				 
				 this.$nextTick(()=>{
					 // 获取dom
					 const query = uni.createSelectorQuery().in(this);
					 
					 for (let i = 0; i < res.list.length; i++) {
						 let item = res.list[i];
						query.select(`#D${item.id}`).boundingClientRect(B=>{
							 console.log(B,"bbbbbbbbbbbb");
							 if(item.weigh<this.info?.my?.weigh){
								 this.$set(item,"width","100%")
							 }else{
								  // (Number(this.stotal.scoretotal)/Number(item.maxsales));
								  if(180 * (Number(this.stotal.scoretotal)/Number(item.maxsales)) < 32){
									  item.width = '32.22104px'
								  }else{
									   item.width =  180 * (Number(this.stotal.scoretotal)/Number(item.maxsales))+"px";
								  }
							 }
							
						}).exec()
					 };
					 this.loading = true;
					 uni.hideLoading();
				 })
			 },
			 handlechange(e){
			 				this.current=e.detail.current
			 			}
			 
		 }
	 }
</script>

<style scoped lang="scss">
	.content{
		min-height: 100vh;
		padding: 30rpx 20rpx 20rpx 20rpx;
	}
	.swiper{
		height: 340rpx;
	}
	.m-b-140{
		margin-bottom: 100rpx;
	}
	.rules{
		padding: 32rpx 28rpx;
		background: linear-gradient(to bottom,#FDE4E3,#FFFFFF 30%);
	}
	.bg-FDE4E3{
		background-color: #FDE4E3;
	}
	.left-box{
		width: 49%;
		padding: 36rpx 20rpx;
	}
	.right-box{
		width: 49%;
		&-item{
			padding: 24rpx 20rpx;
			width: 100%;
			height: 170rpx;
		}
	}
	.msg{
		width: fit-content;
		background: rgba(255,255,255,0.6);
		border-radius: 10rpx 10rpx 10rpx 10rpx;
		padding: 20rpx 12rpx;
	}
	.msgright{
		border-radius: 10rpx 10rpx 10rpx 10rpx;
		width: fit-content;
		padding: 10rpx 12rpx;
		background: rgba(255,255,255,0.6);
	}
	.left-box,.right-box{
		// width: 347rpx;
		height: 360rpx;
		border-radius: 20rpx;
	}
	.wh200{
		display: block;
		width: 200rpx;
		height: 45rpx;
		margin: 0 auto;
		margin-top: 32rpx;
		margin-bottom: 32rpx;
	}
	.w360{
		width: 360rpx;
		height: 8rpx;
		background: rgba(255,255,255,0.5);
		border-radius: 20rpx 20rpx 20rpx 20rpx;
		.linedot{
			width: 144rpx;
			height: 8rpx;
			background: #FF472F;
			border-radius: 20rpx 20rpx 20rpx 20rpx;
			position: relative;
			.perage{
				width: fit-content;
				min-width: 160rpx;
				height: 40rpx;
				background: rgba(255,255,255,0.8);
				border-radius: 8rpx 8rpx 8rpx 8rpx;
				position: absolute;
				top: -50rpx;
				right: -100rpx;
				padding-left: 10rpx;
				padding-right: 10rpx;
				
			}
		}
	}
	.lv{
		font-weight: 400;
		font-size: 24rpx;
		color: #B82424;
	}
	.leiji{
		font-weight: 500;
		font-size: 24rpx;
		color: rgba(0,0,0,0.5);
	}
	.uni-margin-wrap{
		width: 100%;
		swiper{
			width: 100%;
			height: 340rpx;
		}
	}
	.swiper-itembox{
		width: 96%;
		height: 340rpx;
	   padding: 36rpx 32rpx 44rpx 32rpx;
	   position: relative;
	   .exportbg{
		   width: 100%;
		   height: 100%;
		   position: absolute;
		   inset: 0;
		   z-index: -1;
	   }
		 .row{
			 .vip{
				font-weight: 500;
				font-size: 36rpx;
				color: #000000;  
			 }
			 .vipmsg{
				  font-weight: 500;
				  font-size: 28rpx;
				  color: #935200;
			 }
		 }
	}
	
	
	.memberimg{
		position: fixed;
		inset: 0;
		width: 100%;
		height: 100%;
		z-index: -1;
	}
	
</style>