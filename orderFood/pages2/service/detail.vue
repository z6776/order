<template>
	<view class="content">
		<!-- 服务信息 -->
	     <view class="form bg-fff radius-20 p-30-20 d-c-start-flex">
	     	<view class="formitem d-flex">
	     		<text class="fz-32 fz-weight fz-333333">服务信息</text>
	     	</view>
	     	<view class="formitem d-flex f-start a-start">
	     		<image src="../../static/user/address.png" class="wh30 v-m" mode=""></image>
	     		<view class="d-c-flex a-start">
	     			<text class="line32">湖北省武汉市江夏区阳光创谷</text>
	     			<view>
	     				<text>王先生-</text>
	     				<text>130****2233</text>
	     			</view>
	     		</view>
	     	</view>
	     	
	     	<view class="d-flex f-start">
	     		<image  :src="$util.cdnurl('clock.png')"  mode="" class="wh30 m-r-10"></image>
	     		<text>2024-08-26</text>
	     		<text>10:00</text>
	     	</view>
	     </view>
		 
		 
		 <view class="supermarket bg-fff radius-20 m-b-20">
		 	<view class="m-b-20 d-flex">
		 		<text class="fz-32 fz-333333 fz-weight m-r-10">服务项目</text>
		 	</view>
		 	<view class="m-b-30">
		 		<view class="cart-item" :class="{'endclass':i==1}">
		 			<view class="image-wrapper m-l-20">
		 				<image :src="$util.cdnurl('menu.png')" class="loaded" mode="aspectFill"></image>
		 			</view>
		 			<view class="item-right p-t-10 p-b-10">
		 				<text class="clamp title">上门助浴上门助浴上门助浴</text>
		 				<view class="d-flex m-t-20 m-b-20">
		 					￥19.90/次
		 				</view>
		 			</view>
		 		</view>
		 	</view>
		 	
		 	<view class="form bg-fff radius-20 p-30-20 d-c-start-flex m-t-30">
		 		<view class="formitem d-flex">
		 			<text class="fz-28 fz-weight fz-333333">商品总额</text>
		 			<text class="fz-28  fz-333333">￥142.5元</text>
		 		</view>
		 		<view class="formitem d-flex">
		 			<text class="fz-28 fz-weight fz-333333">优惠金额</text>
		 			<text class="fz-28  fz-333333">￥15元</text>
		 		</view>
		 		<view class="formitem d-flex">
		 			<text class="fz-28 fz-weight fz-333333">缴纳保证金金额</text>
		 			<text class="fz-28  fz-333333">￥100元</text>
		 		</view>
		 		<view class="formitem d-flex">
		 			<text class="fz-32 fz-weight fz-333333">商品合计支付</text>
		 			<text class="fz-32  fz-333333">暂无</text>
		 		</view>
		 	</view>
		 </view>
		 
		
		 
		 <view class="form bg-fff radius-20 p-30-20 d-c-start-flex m-t-30">
		 	<view class="formitem d-flex">
		 		<text class="  fz-333333">订单信息</text>
		 	</view>
		 	<view class="formitem d-flex f-start">
		 		<text class="  fz-333333">订单号:</text>
		 		<text class="m-r-auto">20240817001</text>
		 		<view class="copy">复制</view>
		 	</view>
		 	
		 	<view class="formitem d-flex f-start">
		 		<text class="  fz-333333">下单时间:</text>
		 		<text class="m-r-auto">2024-08-17 11:00:01</text>
		 	</view>
			
		 	<view class="formitem d-flex f-start">
		 		<text class="  fz-333333">缴纳保证金时间:</text>
		 		<text class="m-r-auto">2024-08-17 11:00:01</text>
		 	</view>
		 	<view class="formitem d-flex f-start">
		 		<text class="  fz-333333">出发时间:</text>
		 		<text class="m-r-auto">2024-08-17 11:00:01</text>
		 	</view>
			<view class="formitem d-flex f-start">
				<text class="  fz-333333">完成时间:</text>
				<text class="m-r-auto">2024-08-17 11:00:01</text>
			</view>
			<view class="formitem d-flex f-start">
				<text class="  fz-333333">取消时间:</text>
				<text class="m-r-auto">2024-08-17 11:00:01</text>
			</view>
		 </view>
		 
		 <!--  -->
		 <view class="boxFixed footer" v-if="showFooter">
			 <block v-if="title=='待服务'">
				  <mybtn msg="立即指派" />
			 </block>
			 
			 <block v-if="title=='已出发'">
			       <mybtn msg="服务未进行" width="347rpx" height="80rpx" />
				   <view class="m-r-20">
				   	
				   </view>
				   <mybtn msg="完成服务" width="347rpx" height="80rpx" />
			 </block>
			 
		 </view>
		 
		 
		 
	</view>
</template>

<script>
	 export default{
		 computed:{
			showFooter(){
				let title = this.title;
				return title!='已取消' && title!='已完成';
			} 
		 },
		 data(){
			 return {
				 count:5,
				 ratevalue:3,
				 title:"",  // 页面标题
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg'
			 }
		 },
		 onLoad(options){
			 this.title = options.title;
			 uni.setNavigationBarTitle({
			 	title:options.title
			 })
		 },
		 methods:{
			 
		 }
	 }
</script>

<style scoped lang="scss">
	.content{
		min-height: 100vh;
		background-color: #FAFAFA;
		padding: 30rpx 20rpx 20rpx 20rpx;
	}
	
	.wh300{
		width: 150rpx;
		height: 150rpx;
		border-radius: 20rpx;
		margin-right: 20rpx;
	}
	
	
	.intform {
		width: 100%;
		border: 2rpx solid #999999;
		padding-left: 20rpx;
		border-radius: 20rpx;
		height: 80rpx;
		line-height: 80rpx;
		margin-top: 30rpx;
	}
	
	.line32{
		line-height: 32rpx;
	}
	
	.wh150{
		width: 150rpx;
		height: 150rpx;
		margin-right: 30rpx;
	}
	
	.copy{
		flex-shrink: 0;
		width: fit-content;
		padding: 0 10rpx;
		height: 40rpx;
		text-align: center;
		// padding: 5rpx 20rpx;
		border-radius: 50rpx;
		// font-size: 28rpx;
		line-height: 40rpx;
		border: 1rpx solid #666666;
	}
	
	.getOther {
		width: fit-content;
		padding: 0 30rpx;
		color: #000000;
		text-align: center;
		margin-left: auto;
		border: 2rpx solid #666666;
		border-radius: 10rpx;
	}
	
	::v-deep.placeholderClass {
		color: #999999;
		font-size: 28rpx;
	}
	.b50{
		border-radius: 50% !important;
	}
	
	.content {
		min-height: 100vh;
		padding: 30rpx 20rpx;
		// background: linear-gradient(to bottom, #4DD88D, #F9F9F9 300rpx);
		padding-bottom: calc(240rpx + env(safe-area-inset-bottom));
	    padding-top: 20rpx;
		.form {
			line-height: 60rpx;
			padding-top: 15rpx;
			padding-bottom: 15rpx;
		}
	
		.wh46 {
			width: 46rpx;
			height: 46rpx;
		}
	
		.person {
			padding: 20rpx 30rpx 40rpx 20rpx;
		}
	
		.supermarket {
			padding: 30rpx 20rpx 30rpx 20rpx;
	
			.endclass {
				// border-bottom: 2rpx solid #F9F9F9;
				// padding-bottom: 30rpx;
			}
	
			.cart-item {
				display: flex;
				position: relative;
				align-items: center;
	
				.image-wrapper {
					width: 160upx;
					height: 160upx;
					flex-shrink: 0;
					position: relative;
	                
					image {
						border-radius: 8upx;
					}
				}
	
				.checkbox {
					position: absolute;
					left: -16upx;
					top: -16upx;
					z-index: 8;
					font-size: 44upx;
					line-height: 1;
					padding: 4upx;
					background: #fff;
					border-radius: 50px;
				}
	
				.item-right {
					display: flex;
					flex-direction: column;
					flex: 1;
					overflow: hidden;
					position: relative;
					padding-left: 20upx;
	
					.title,
					.price {
						height: 40upx;
						line-height: 40upx;
					}
	
					.attr {
						font-weight: bold;
						font-size: 24rpx;
						color: #999999;
						height: 50upx;
						line-height: 50upx;
					}
	
					.price {
						height: 50upx;
						line-height: 50upx;
					}
				}
	
				.del-btn {
					padding: 4upx 10upx;
					font-size: 34upx;
					height: 50upx;
				}
	
				.invalid {
					position: absolute;
					right: 0;
					bottom: 0;
					background: #999999;
					color: #ffffff;
					padding: 6upx 12upx;
					border-radius: 10upx;
					font-size: 26upx;
					margin-right: 50upx;
					margin-bottom: 32upx;
				}
			}
		}
	}
	
	.btn {
		font-weight: 800;
		font-size: 28rpx;
		color: #FFFFFF;
		text-align: center;
		line-height: 80rpx;
		width: 300rpx;
		height: 80rpx;
		background: #4DD88D;
		border-radius: 40rpx 40rpx 40rpx 40rpx;
		margin-left: auto;
		margin-top: 40rpx;
		margin-right: 20rpx;
	}
	
	.button {
		height: 100rpx;
	}
	
</style>