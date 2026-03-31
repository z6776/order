<template>
	<view class="content p-t-1">
		<u-navbar immersive  :is-back="false" :title="title" :background="bgColorOpa" :border-bottom="false">
				<view class="slot-wrap" @click="$util.back()">
					<view class="wh33" >
						<u-icon name="arrow-left" color="#fff" size="32" bold></u-icon>
					</view>
					<view class="wh33 d-flex j-center">
						<text class="fz-32 fltxt" v-if="type=='seckill'">{{ seckill || '秒杀' }}</text>
						<image class="wh144" v-else :src="$util.cdnurl('pttit.png')" mode=""></image>
					</view>
					
					<view class="wh33"></view>
				</view>
		</u-navbar>
		
		
		<view :style="{'marginTop':safeTop+'px'}" >
			
		</view>
		
		<block v-if="type=='groupon'">
			<view class="d-c-flex m-b-40">
				 <view class="title m-b-20 fz-italic">
				 	{{ $util.parseTime($util.isNull(listfn.activityin,'endtime'),"{m}-{d} {h}:{i}")    }}结束
				 </view>
				 <view class="subtitle m-b-20">
				 	拼团商品均为次日下午发货哦~
				 </view>
				 
				 <view class="suc d-flex j-center">
				 	<view class="d-flex avatargroup">
						<image :src="$util.isNull(item.user1,'avatar')" :style="{'zindex':index,'transform':'translateX('+-(10*index)+'rpx)'}" class="avatar" v-for="(item,index) in userList" :key="index" mode=""></image>
				 	</view>
				 	 <text class="m-l-20">{{ totaluser }}人拼团成功</text>
				 </view>
			</view>
			
		</block>
		
		<block v-else>
			<view class="d-c-flex m-b-40">
			<view class="title m-b-20 fz-weight fz-italic">
				每日 {{ titleqg }} 进行抢购
			</view>
			<view class="subtitle m-b-20">
				福利抢购商品均为次日下午发货哦~
			</view>
			</view>
		</block>
		
		 <view class="p20 h240 bg-fff d-flex f-start radius-20 m-b-30" v-for="(item,index) in list" @click="godetail(item)"> 
		 	 <image :src="$util.getImgurl(item.productin.image)" mode="aspectFill" class="wh80 fs-0 m-r-20"></image>
			 <view class="d-c-flex a-start flex-1 h-100">
			 	<view class="fz-32 fz-000000 fz-bold">
			 		{{ item.productin.title || "" }}
			 	</view>
				<view class="m-t-10 m-b-10 line2" v-if="item.productin.desc">
					{{ item.productin.desc || "" }}
				</view>
				<view class="menuitem" v-if="type=='groupon'">
					已拼 {{ item.oknum || "0" }} 份
				</view>
				<block  v-if="type=='seckill'">
					<view class="d-flex f-start w-100 a-end">
						<text class="fz-24 fz-ff0000">￥</text>
						<text class="fz-FF2525 fz-32 m-r-20">{{ item.price || ""  }}</text>
						<text class="linethrough m-r-auto fz-24 basecolor">￥{{ item.productin.sales_price || ""  }}</text>
						
						<image :src="$util.cdnurl('shopcar.png')"  mode="aspectFill" class="wh48" @click.stop="addCart(item,item.productin)"></image>
					</view>
				</block>
				<block v-else>
					<view class="d-flex f-start w-100 a-end">
						<text class="pttxt">拼团价</text>
						<text class="fz-24 fz-ff0000">￥</text>
						<text class="fz-FF2525 fz-weight fz-32 m-r-20">{{ item.min_price || ""  }}</text>
						<text class="linethrough m-r-auto fz-24 basecolor">￥{{ item.productin.sales_price || ""  }}</text>
						
					</view>
				</block>
				
			 </view>
		 </view>
		 
	</view>
</template>

<script>
	const app = getApp();
	 export default{
		 data(){
			 return {
				 userList:[],// 拼团的userlist
				 list:[],  // 秒杀
				 isIPhoneX:app.globalData.isIPhoneX,
				 title:"",
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				 isMany:true,
				 type:"",
				 totaluser:0,
				 page:1,
				 seckill:"",
				 params:{}
			 }
		 },
		 computed:{
			 titleqg(){
			 	let arr = this.list;
			 	if(arr && arr.length && arr[0].activityin){
			 		return arr[0].activityin?.starthour  + "-"+ arr[0].activityin?.endhour
			 	};
			 	return "";
			 },
			 listfn(){
				 if(this.list && this.list.length){
					 return this.list[0]
				 }
				 return {}
			 },
		 			 safeTop(){
		 				 let res = uni.getMenuButtonBoundingClientRect();
						  return this.isIPhoneX ? res.bottom+29 : res.bottom+49;
		 				 if(app.globalData.is375){
		 					 // 有刘海没有刘海 没有刘海偏上要多顶20个px
		 					 return this.isIPhoneX ? res.bottom+29 : res.bottom+49;
		 				 }else{
		 					 // 大于375的背景图不够
		 					return this.isIPhoneX ? res.bottom+69 : res.bottom+89; 
		 				 }
		 				
		 			 }
		 },
		 onLoad(query){
			 this.params = query;
			 this.type = query.type;
			 this.getlist(); 
			 this.getPs();
		 },
		 onReachBottom() {
		 	if(this.isMany){
				this.page++;
			}
		 },
		 async onShareAppMessage(e){
		 	try{
		 		return {
		 			path:`/pages2/flashsale/index?${this.$util.objectToQueryString(this.params)}`
		 		};
		 	}catch(err){
		 		
		 	}
		 },
		 methods:{
			 // 获取配送费存储
			 async getPs(){
			 
				let seckill = await this.$u.api.attentionOrder({
					key:"seckill"
				});
				this.seckill = seckill;
			
			 },
			 godetail(item){
				 this.$util.navTo(`/pages2/shopdetail/index?type=${this.type}&id=`+item.productin.id+"&activity_id="+item.activity_id)
			 },
			 //添加购物车
			 async addCart(product,item) {
			    let cart = uni.getStorageSync("cart") || [];
			    let _item = JSON.parse(JSON.stringify(item));
			    if(cart.some(v=>v.id==_item.id)){
			 	   return this.$u.toast("该商品已在购物车");
			    }
				// 秒杀商品价格不同显示最低价
				_item.sales_price = product.price;
				// 活动商品isAc设为1
				_item.isAc = 1;
				_item.activity_id = product.activity_id || "";
			    cart = [...cart,_item];
			    uni.setStorageSync("cart",cart);
			     return this.$u.toast("加入成功");
			 },
			 async getlist () {
				 let _d = {
					 page:this.page,
					 pagesize:10,
				 	atype:this.type //	string	是	活动类型;seckill=秒杀groupon=拼团
				 }
				 const res = await this.$u.api.getMarketingList(_d);
				 if(this.type=='groupon'){
					  this.list = [...this.list,...res.list?.data];
					  this.totaluser = res.total;
					  this.userlist = res.userList;
					  if(res.list?.data.length<10){
					  	this.isMany = false;
					  }
				 }else{
					  this.list = [...this.list,...res.data];
					  if(res.data.length<10){
					  	this.isMany = false;
					  }
				 }
			   
				
			 },
		 }
	 }
</script>

<style scoped lang="scss">
	.content{
		min-height: 100vh;
		background-image: url($cdnurl+'bgnew.png');
		position: relative;
		z-index: 2;
		padding: 30rpx 20rpx 20rpx 20rpx;
		background-size: 100% 100%;
	}
	.fltxt{
		font-weight: 800;
		color: #fff;
	}
	.pttxt{
		font-weight: 800;
		font-size: 32rpx;
		color: #FF0000;
	}
	.h240{
		height: 240rpx;
	}
	.p-t-1{
		padding-top: 1rpx;
	}
	.menuitem{
		font-weight: 500;
		font-size: 24rpx;
		color: #FACE51;
		text-align: center;
		min-width: 160rpx;
		height: 40rpx;
		border-radius: 100rpx 100rpx 100rpx 100rpx;
		border: 2rpx solid #FACE51;
		margin-bottom: 10rpx;
	}
	.suc{
		font-weight: 500;
		font-size: 24rpx;
		color: rgba(255,255,255,0.8);
		.avatargroup{
			max-width: 200rpx;
			position: relative;
			.avatar{
				width: 40rpx;
				height: 40rpx;
				border-radius: 50%;
				position: relative;
			}
		}
	}
	
	.basecolor{
		color: rgba(0,0,0,0.5);
	}
	.title{
		font-family: YouSheBiaoTiHei, YouSheBiaoTiHei;
		font-weight: 400;
		font-size: 48rpx;
		color: #FFFFFF;
	}
	.subtitle{
		font-weight: 500;
		font-size: 28rpx;
		color: #FFFFFF;
	}
	.whbg{
		position: fixed;
		width:100%;
		height: 100%;
		inset: 0;
		z-index: -1;
	}
	.wh144{
		width: 144rpx;
		height: 32rpx;
	}
	.linethrough{
		text-decoration: line-through;
	}
	.wh80{
		border-radius: 20rpx;
		width: 200rpx;
		height: 200rpx;
	}
	.wh48{
		width: 48rpx;
		height: 48rpx;
	}
	::v-deep.u-navbar-inner{
		margin-right: 0 !important;
	}
	.slot-wrap{
		width: 100%;
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 0 20rpx;
		.wh33{
			width: 33.3%;
		}
	}
	
</style>