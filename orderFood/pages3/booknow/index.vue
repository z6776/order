<template>
	<view class="container">
		   <view class="item item-1 bg-fff m-t-24 m-b-24">
			   <navigator url="/pages/components/pages/address/address?source=1" class="address-section radius-20">
				<view class="order-content">
					<view class="order-content " v-if="addressData && addressData.name">
						<view class="d-flex f-start">
							<text class="dottag m-r-10">默认</text>
							<text class="fz-000000 fz-bold fz-28">{{ addressData.address|| ""  }}</text>
						</view>
						
						<view class="m-t-20">
							<view class="d-flex">
								<text class="fz-28 fz-000000 fz-bold">{{ addressData.door_number|| ""  }}</text>
								<u-icon name="arrow-right" color="#979797" size="32"></u-icon>
							</view>
							<view class="top m-t-10">
								<text class="fz-494949 fz-28 m-r-20">{{ addressData.name|| ""  }}</text>
								<text class="fz-494949 fz-28">{{ addressData.mobile || ""  }}</text>
							</view>							
						</view>
					</view>
					<block v-else>
						<view class="d-flex f-start m-b-20">
							<image  :src="$util.cdnurl('addressicon.png')"  mode="aspectFill" class="wh36"></image>
							<view class="cen m-l-20 m-r-auto">请选择服务地址</view>
							<u-icon name="arrow-right" color="#979797" size="32"></u-icon>
						</view>
					</block>
				</view>
			   </navigator> 
			   <view class="form-item d-flex f-start  p-t-20 p-b-20" @click="showtime">
					 <view class="label fz-707070 fz-28 fz-weight m-r-10 fs-0 m-r-auto">期望服务时间</view>
					 <view class="d-flex">
						 <uni-datetime-picker :hideSecond="true" type="datetime" :start="starttime" v-model="date" @change="confirm">
							 {{ date || "请选择期望服务时间" }}
							 <u-icon name="arrow-right" color="#979797" size="32"></u-icon>
						 </uni-datetime-picker>
						 <!-- <selectDate  msg="请选择期望服务时间" :time.sync="date" @init="confirm" /> -->
						<!-- <u-picker :start-year="startyear" mode="time" :default-time="dtime" v-model="show" :params="timep" @confirm="confirm"></u-picker> -->
						
					 </view>
			   </view>
				 <view class="form-item d-flex f-start  p-t-20 p-b-20 a-start">
					 <view class="label fz-707070 fz-28 fz-weight m-r-10 fs-0">订单备注</view>
					<textarea class="p20 bgareas" v-model="remark" id="" cols="30" rows="10" placeholder="请输入订单备注或者建议内容"></textarea>
				 </view>
		   </view>
		   
		   <view class="item bg-fff m-b-24 item-2">
			   <view class="m-b-30 fz-32 fz-000000 fz-bold">
			   	    服务项目
			   </view>
			   <view class="h130 d-flex f-start">
			   	   <image :src="$util.getImgurl(options.coverimage)" class="wh130 radius-20" mode="aspectFill"></image>
				   <view class="h100 d-c-flex a-start m-l-20">
				   	  <view class="fz-500 fz-32 fz-000000">
				   	      	{{ options.name || "" }}
				   	  </view>
					  <view class="fz-32 fz-ff0000 fz-bold">
					  	  ¥ {{ options.price || "" }}
					  </view>
				   </view>
			   </view>
			  <view class="fz-500 fz-24 m-t-20" style="color: rgba(255, 0, 0, .5)">
			   	    {{ bond || "" }}
			   </view>
		   </view>
		   
		   
		   <view class="item bg-fff item-3 m-b-24">
		   	    <view class="m-b-20 d-flex">
		   	    	<text class="fz-28 fz-500 fz-494949">订单金额</text>
					<text class="fz-28 fz-bold fz-000000">{{ options.price || "" }}</text>
		   	    </view>
				<view class="d-flex">
					<text class="fz-28 fz-500 fz-494949">保证金</text>
					<text class="fz-28 fz-bold fz-000000">￥{{ bondtxt }}</text>
				</view>
		   </view>
		   
		   <view class="item item-4  m-b-24 bg-fff">
		   	   <view class="fz-32 fz-bold fz-000000 m-b-20">
		   	   	    注意事项
		   	   </view>
			   <view class="">
				   <rich-text :nodes="richttext | filterdetail"></rich-text>
			   </view>
		   </view>
		   
		   <view class="fixbottom bg-fff d-flex">
		   	    <view class="d-flex f-start">
		   	    	 <text class="fz-500 fz-28 fz-707070">合计:</text>
					 <text class="fz-500 fz-28 fz-ff0000">￥{{ bondtxt || "" }}</text>
		   	    </view>
				
				<view class="paybtn" hover-class="op9" @click="payfn">
					 立即支付
				</view>
		   </view>
		   
	</view>
</template>
<script>
	import selectDate from "@/components/selectDate";
	import { mapState } from "vuex";
	 export default{
		 components:{
			 selectDate
		 },
		 data(){
			 return {
				 timep:{
					 	year: true,
					 	month: true,
					 	day: true,
					 	hour: true,
					 	minute: true,
					 	second: false,
					 	// 选择时间的时间戳
					 	timestamp: true,
				 },
				 options:{},
				 show:false,
				 startDate:"",
				 endDate:"",
				 date:"",
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				 addressData:{},
				 dtime:"",
				 richttext:"",
				 bondtxt:"",
				 bond:"",
				 remark:""
			 }
		 },
		 computed:{
			  ...mapState(['member','position']),
			 starttime(){
			    return new Date().getTime()	 
			 }
		 },
		 onLoad(options){
			 this.options = options;
			  this.getDefault();
			 this.getrich();
		 },
		 onShow(){
			 uni.removeStorageSync("order");
		 },
		 methods:{
			 async payfn(){
				 uni.showLoading({
				 	mask:true
				 });
				 if(!this.position.mobile){
						 uni.hideLoading();
						 this.$util.xhmodal("请完善手机号后重试").then(res=>{
							  this.$util.navTo("/pages/components/pages/mine/userinfo")
						 })
						 return
				 }
				 // 
				if(!this.addressData.id){
					return this.$u.toast("请选择地址");
				}
				if(!this.date){
					return this.$u.toast("请选择服务时间");
				}
				let data = await this.$u.api.ylorderSubmit({
					product_id:this.options.id,//	string	是	服务ID
					community_id:"",//	integer	是	社区ID
					village_id:this.addressData.village_id,//	integer	是	小区ID
					address_id:this.addressData.id,//	integer	是	地址ID
					expecttime:this.date,//	string	是	期望服务时间
					memo:this.remark  //	string	是	订单备注
				});
				uni.setStorageSync("order",data);
				
				this.$util.navTo('/pages2/money/pay?type=yl');
			 },
			 showtime(){
				 if(this.date){
					 this.dtime = this.$util.parseTime(this.date,"{y}-{m}-{d} {h}:{i}");
				 }
				this.show=true;
			 },
			 // 选择生日
			 confirm(e){
				 this.date = e;
				 console.log(e,"eeeee");
			 },
			 async getrich(){
				 let data = await this.$u.api.attentionOrder({
					key:"bond_order"
				 });
				 // 保证金
				 let bond = await this.$u.api.attentionOrder({
				 	 key:"bond"
				 });
				 // 保证金介绍
				 let bondtxt = await this.$u.api.attentionOrder({
				 	key:"deposit_price"
				 });
				this.bondtxt = bondtxt;
				this.bond = bond;
			 this.richttext = data
			 console.log(data,'res')
			 },
			 async getDefault(){
				let res = await this.$u.api.getDefaultsAddress();
				this.addressData  = res;
				console.log(res,"ressssssssss");
			 }
		 }
	 }
</script>

<style scoped lang="scss">
	@import '~@/pages3/booknow/index.scss';
</style>