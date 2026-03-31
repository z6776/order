<template>
	<view class="groupbuying p20">
		<!-- groupbuying -->
	     <view class="d-flex m-b-20" @click="$emit('lookmany')">
			 <view class="">
			 	 <slot></slot>
			 </view>
			 <view class="d-flex f-start">
			 	 <text class="fz-979797 fz-28">查看更多</text>
				 <u-icon name="arrow-right" color="#979797" size="24"></u-icon>
			 </view>
	     </view>
		  <!--  -->
		 <swiper  :style="{'height':sumList[0].length<=4 ? '300rpx':'610rpx'}" :autoplay="false" circular :indicator-dots="false" :vertical="false" :interval="3000" :duration="600">
			   <swiper-item v-for="(item,index) in sumList" :key="index">
				   <view class="d-flex f-warp a-start" style="height: 100%;">
						<view class="d-c-flex boxitem" v-for="(v,i) in item"  :key="i" @click="godetail(v)"> 
						<u-image :src="$util.getImgurl($util.isNull(v.productin,'image'))" width="150rpx"  border-radius="20rpx"  height="150rpx"  mode="aspectFill" ></u-image>
							  <!-- <image :src="$util.getImgurl($util.isNull(v.productin,'image'))" mode="aspectFill" class="wh150"></image> -->
							  <view class="title fz-28 m-t-10 m-b-10 line1 w100 fz-center">
								  {{$util.isNull(v.productin,'title')}}
							  </view>
							  <view class="fz-ff0000 fz-32 fz-weight m-b-10">
								  
								  <block v-if="type=='groupon'">
									  ¥{{v.min_price  || "0.00"}}
								  </block>
								  <block v-else>
									  ¥{{v.price || "0.00"}}
								  </block>
								   
							  </view>
							  <view class="fz-999999 fz-28 linethough" v-if="v.productin && v.productin.sales_price && openprice==1">
								   ￥{{$util.isNull(v.productin,'sales_price')  || "0.00"}}
							  </view>
						</view>
						<view class="w25" v-for="(p,j) in 8-item.length" :key="j">
							
						</view>
				   </view>
			   </swiper-item>
		</swiper>
		
		
	</view>
</template>

<script>
	 export default{
		 props:{
			 openprice:{
				type:String,
				 default:""
			 },
			type:{
				type:String,
				default:""
			}, 
			list:{
				type:Array,
				default:[]
			}
		 },
		 data(){
			 return {
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg'
			 }
		 },
		 computed:{
			sumList(){
				console.log(this.list);
				return this.chunkArray(this.list,8)
			} 
		 },
		 onLoad(){
			 
		 },
		 methods:{
			chunkArray(arr, chunkSize) {  
			   return arr.reduce((acc, cur, index) => {  
			     const chunkIndex = Math.floor(index / chunkSize);  
			     if (!acc[chunkIndex]) {  
			       acc[chunkIndex] = [];  
			     }  
			     acc[chunkIndex].push(cur);  
			     return acc;  
			   }, []);  
			 },
			 // 去商品详情
			godetail(item){
				this.$util.navTo(`/pages2/shopdetail/index?type=${this.type}&id=`+item.productin.id+"&activity_id="+item.activity_id,false)
			}
			 
		 }
	 }
</script>

<style scoped lang="scss">
	::v-deep.u-drawer__scroll-view{
		height: 800rpx !important;
	}
	.groupbuying{
		min-height: 300rpx;
		border-radius: 20rpx;
		background-color: #fff;
		margin-top: 30rpx;
		margin-bottom: 30rpx;
	}
	.title{
		font-weight: 500;
		font-size: 28rpx;
		color: rgba(0,0,0,0.6);
	}
	.w25{
		width: 25%;
	}
	.boxitem{
		width: 25%;
		// height: 300rpx;
	}
	.wh150{
		border-radius: 20rpx;
		width: 150rpx;
		height: 150rpx;
	}
</style>