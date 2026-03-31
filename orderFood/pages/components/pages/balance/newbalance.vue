<template>
	<view class="content">
		<image :src="$util.cdnurl('yuebg.png')" class="yuebg" mode=""></image>
		<view class="bgbox d-c-flex m-b-30">
			<view class="title">
				我的余额
			</view>
			<view class="total">
				{{ position.money || "0.00" }}
			</view>
			<view class="w100 m-b-10" v-if="vipProgress">
				<u-line-progress height="16" :show-percent="false" active-color="#FACE51" :percent="vipProgresscom()"></u-line-progress>
			</view>
			<view class="msg" v-if="vipProgress">
				 {{ vipProgress.accumulate || '0'  }}/{{ vipProgress.minsales || '0'  }}充值达到{{ vipProgress.minsales || '0'  }}元时可享受一年会员
			</view>
		</view>
		  <view class="paycount bg-fff radius-20 m-b-20">
		  	   <text class="fz-32 fz-333333 fz-weight">请选择充值金额</text>
			   <view class="d-flex f-warp m-t-30 m-b-30">
			   	  <view class="item d-c-flex j-center" v-for="(item,index) in list" :class="{active:current==index}" @click="current=index">
			   	  	   <view>{{item.sell_price}}元</view>
					   <view class="fz-24 basecolor m-t-10">赠送: {{  sumfn(item) }}元</view>
					    <!-- -->
			   	  </view>
			   </view>
			   <block v-if="cz_show==1">
				   <text class="fz-32 fz-333333 fz-weight">其他金额</text>
				   <view class="intxbox d-flex f-start m-t-30 m-b-20">
				   	  <text class="fz-48 fz-333333 fz-weight m-r-20">￥</text>
				   	  <input type="digit" placeholder="请输入其他金额" placeholder-class="placeholderclass" class="fz-48 fz-000000 fz-weight" v-model="money" />
				   </view>
				   <view class="fz-28 fz-weight fz-ff000050" v-if="price">
				   	充值金额最少为 {{ price }} 元
				   </view>
			   </block>
		  </view>
		  
		  <view class="paycount bg-fff radius-20 m-b-20">
		  	  <text class="fz-weight fz-32 fz-333333 m-b-10">充值说明</text>
			  <rich-text :nodes="content | filterdetail"></rich-text>
		  </view>
		  
		  <view class="boxFixed">
		  	  <mybtn  msg="充值" @handclick="payfn"></mybtn>
		  </view>
		  
		  <!--轻提示-->
		  <u-toast ref="uToast"></u-toast>
		  
	</view>
</template>

<script>
	import { mapState } from "vuex";
	 export default{
		 computed:{
		 	...mapState(["position",'member'])
		 },
		 data(){
			 return {
				 cz_show:"", // 是否显示充值板块
				 money:"",
				 current:0,
				 list:[],
				 content:"",
				 price:"",
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				 vipProgress:""
			 }
		 },
		 onLoad(){
			this.getlist();
			this.getdetail();
			this.vipProgressfn();
			//
		 },
		 methods:{
			 vipProgresscom(){
				 let str = this.vipProgress.percentage;
				 console.log( str.substring(0,str.indexOf('%')));
				 return str.substring(0,str.indexOf('%'));
			 },
			 // 获取充值进度条
			 async vipProgressfn(){
				 let data = await this.$u.api.vipProgress();
				 this.vipProgress = data;
			 },
			 // 
			 async getUserInfo() {
			 		let data = await this.$u.api.userindex();
			 		if (data) {
			 			this.$store.commit('SET_POSITION',data);
			 		}
			 },
			 async getdetail(type){
			 	let data = await this.$u.api.attentionOrder({
			 		key:'min_money'
			 	});
			 	this.price = data;
			 },
			 sumfn(item){
				 return (item.value - item.sell_price).toFixed(2);
			 },
			 async payfn() {
				 if(!this.position.mobile){
					 this.$util.xhmodal("请完善手机号后重试").then(res=>{
						  this.$util.navTo("/pages/components/pages/mine/userinfo")
					 })
					 return
				 }
				 if(this.money && Number(this.money) < 1){
					 return this.$u.toast("充值金额最少为1元")
				 };
			 	let data = await this.$u.api.balanceRecharge({
			 		recharge_id: this.list[this.current].id,
					custom:this.money
			 	});
			 	if (!data) {
			 		return;
			 	}
				uni.showLoading({
					mask: false
				});
			 	let pay = await this.$u.api.payUnify({out_trade_no: data.out_trade_no});
			 	if (pay) {
			 		let that = this;
			 		uni.requestPayment({
			 			provider: 'wxpay',
			 			timeStamp: pay.timeStamp,
			 			nonceStr: pay.nonce_str,
			 			package: 'prepay_id=' + pay.prepay_id,
			 			signType: 'MD5',
			 			paySign: pay.paySign,
			 			success: async function(res) {
			 				that.$refs.uToast.show({
			 					title: '充值成功',
			 					type: 'success'
			 				});
			 				// that.member.money = (parseFloat(that.member.money) + parseFloat(recharge.value)).toFixed(2);
							that.getUserInfo();
							that.vipProgressfn();
			 			},
			 			fail: function(err) {
			 				that.$refs.uToast.show({
			 					title: '支付失败',
			 					type: 'error'
			 				});
			 			}
			 		});
			 	}
			 },
			async getlist(){
				const info =  await this.$u.api.attentionOrder({
					key:"rechargeagreement"
				});
				const cz_show =  await this.$u.api.attentionOrder({
					key:"cz_show"
				});
				this.content = info;
				this.cz_show = cz_show;
				 const res = await this.$u.api.getMoneyList();
				
				 this.list = res;
			}
			 
		 }
	 }
</script>

<style scoped lang="scss">
	.content{
		min-height: 100vh;
		padding: 30rpx 20rpx 20rpx 20rpx;
		padding-bottom: 200rpx;
		
	}
	.title{
		font-weight: 500;
		font-size: 32rpx;
		color: rgba(184,87,36,0.8);
	}
	.total{
		font-weight: 800;
		font-size: 56rpx;
		color: #B85724;
		margin-top: 16rpx;
		margin-bottom: 56rpx;
	}
	.msg{
		 font-weight: 500;
		 font-size: 24rpx;
		 color: #979797;
	}
	.yuebg{
		height: 400rpx;
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		width: 100%;
		z-index: -1;
	}
	.paycount{
		padding: 30rpx 20rpx;
	}
	.intxbox{
		height: 110rpx;
		 padding-bottom: 10rpx;
		 border-bottom: 2rpx solid #F9F9F9;
		 input{
			 height: 100%;
			 line-height: 100%;
		 }
	}
	::v-deep.placeholderclass{
		font-weight: 500;
		font-size: 32rpx;
		color: #999999;
	}
	.item{
		font-weight: 800;
		font-size: 28rpx;
		color: #000000;
		 width: 218rpx;
		 height: 130rpx;
		 background: #EBEBEB;
		 border-radius: 16rpx 16rpx 16rpx 16rpx;
		 border: 2rpx solid transparent;
		 margin-bottom: 24rpx;
		 text-align: center;
	}
	.active{
		border: 2rpx solid #FACE51 !important;
		background-color: #FACE51 !important;
	}
	.h220{
		width: 100%;
		border-radius: 20rpx;
		height: 220rpx;
		margin-bottom: 20rpx;
	}
	
</style>