<template>
	<view class="pagebox">
		<view class="p20 m-b-30 cart-item-box bg-fff radius-20 p-b-30" >
			<view class="cart-item p-b-30 borderbottom">
				<view class="image-wrapper">
					<image :src="$util.getImgurl(shop.coverimage)" class="loaded" mode="aspectFill"></image>
				</view>
				<view class="item-right d-c-flex a-start h100">
					<text class="clamp title">{{ shop.name || "" }}</text>
					<view class="d-flex f-start">
						<text class="fz-28 fz-000000 m-r-10" style="color:rgba(0,0,0,0.5);">￥{{ shop.price || "" }} </text>
						<text class="fz-24 fz-000000" style="color:rgba(0,0,0,0.5);">{{ shop.number }}{{shop.unit}}</text>
					</view>
				</view>
			</view>
			<view class="d-flex m-t-20 m-b-20 f-start">
				 <text class="fz-28 fz-weight fz-333333 m-r-20">商品评价</text>
				 <view class="d-flex">
				 	 <!-- 自定义星星大小 -->
					 <u-rate :count="count" v-model="ratevalue" active-color="#FABD20" inactive-color="#999999" size="50" gutter="20"></u-rate>
					 <!-- <u-rate count="5" v-model="ratevalue"  active-color="#FABD20" inactive-color="#999999" size="60" gutter="20"></u-rate> -->
				 </view>
			</view>
			<!--  -->
			<view class="d-flex f-start a-start">
				<image src="../../static/images/newStatic/edit.png" class="wh32 fs-0 m-r-10" mode=""></image>
				<textarea v-model="keywords" class="bgareas" placeholder="符合评价规则，且评价超过10字即可获得福豆~" height="260rpx"></textarea>
			</view>
			
			<view class=" m-b-30 d-flex f-start">
					<u-upload :show-progress="true" :header="{'token':member.token}" ref="uploadref" :action="action" :file-list="item.fileList" >
					</u-upload>
			</view>
			<view class="">
				您的评价内容在商品评价页面将会被匿名展示~
			</view>
		</view>
		
		<u-toast ref="uToast" />
		
		<view class="boxFixed">
			 <mybtn msg="提交" @handclick="submit"></mybtn>
		</view>
	</view>
</template>

<script>
	// import {OrderComment} from '@/config/api.js';

import { baseUrl } from "@/common/const.js";
import { mapState  } from "vuex";
	export default {
		computed:{
			...mapState(["member"])
		},
		data() {
			return {
				keywords:"",
				count:5,
				action:baseUrl+"/api/common/upload",
				fileList1:[],
				value3:"",
				ratevalue:5,
				order_id: 0,
				product_id: 0,
				title: '',
				image: '',
				spec: '',
				rate: 5,
				radio: true,
				shop:{},
				arr:[],
				id:""
			}
		},
		onLoad(options) {
			this.id = options.id;
			let arr = uni.getStorageSync("evaluate");
			this.shop = arr;
			// for (let s of this.shopList) {
			// 	s.count = 5;
			// 	s.ratevalue = 5;
			// 	s.fileList = [];
			// 	s.comment = "";
			// }
		},
		onUnload() {
			uni.removeStorageSync("evaluate");
		},
	
		methods: {
			// 评价
			async submit(){
				if(!this.keywords){
					return this.$u.toast("请输入商品评价");
				}
				uni.showLoading({
					mask:true
				});
				let files = [];
				let lis = this.$refs['uploadref'].lists;
				for (let i = 0; i < lis.length; i++) {
					if(lis[i].progress==100){
						files.push(lis[i]?.response?.data?.url)
					}
				}
				let form = {
					picture:files.length ? files.join(",") : "",
					comment:this.keywords,//	string	是	评论
					order_id:this.id,//	integer	是	订单id
					product_id:this.shop?.id || "",//	integer	是	产品id
					rate:this.ratevalue//	integer	否	评价级别
				};
				let code = await this.$u.api.ylordercomment(form);
				this.$util.success("评价成功","back");
				console.log(code,"我的订单");
			},
			// 删除图片
			deletePic(){
				
			},
			afterRead(){
				
			},
			// 星星
			start(e) {
				this.rate = e.value;
				switch (this.rate) {
					case 3:
						this.radio = false;
						break;
					case 5:
						this.radio = true;
						break;
				}
			},
			// 单选
			clickRadio(e) {
				this.radio = !this.radio;
			},
			// 输入事件
			input(e) {
				this.textarea = e.detail.value;
			}
		}
	}
</script>
<style lang="scss">
	.bgareas{
		width: 100%;
	   padding: 0rpx;
		 height: 300rpx;
	   background-color: transparent !important;
	}
	.wh32{
		width: 32rpx;
		height: 32rpx;
	}
	.wh48{
		width: 48rpx;
		height: 48rpx;
	}
	.pagebox {
		min-height: 100vh;
		background: #F9F9F9;
		padding: 20rpx;
		padding-bottom: 220rpx;
	}
	::v-deep.u-textarea{
		border: none !important;
		background-color: #F9F9F9 !important;
	   border-radius: 20rpx !important;
	}
    .wh60{
		width: 60rpx;
		height: 60rpx;
	}
   .cart-item {
   	display: flex;
   	position: relative;
   	align-items: center;
    height: 160upx;
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
</style>