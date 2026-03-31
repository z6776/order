<template>
	<view class="pagebox">
		<view class="p20 m-b-30 cart-item-box bg-fff radius-20 p-b-30" v-for="(item,index) in shopList" :key="item.id">
			<view class="cart-item p-b-30 borderbottom">
				<view class="image-wrapper m-l-20">
					<image :src="$util.getImgurl(item.image)" class="loaded" mode="aspectFill"></image>
				</view>
				<view class="item-right">
					<text class="clamp title">{{ item.title || "" }}</text>
					<view class="d-flex m-t-20 m-b-20">
						<text class="attr m-r-10">￥ {{item.price || ""}} </text>
						<text class="attr m-r-10">x {{ item.number || "" }}</text>
					</view>
				</view>
			</view>
			<view class="d-flex m-t-20 m-b-20 f-start">
				 <text class="fz-28 fz-weight fz-333333 m-r-20">商品评价</text>
				 <view class="d-flex">
				 	 <!-- 自定义星星大小 -->
					 <u-rate :count="item.count" v-model="item.ratevalue" active-color="#FABD20" inactive-color="#999999" size="50" gutter="20"></u-rate>
					 <!-- <u-rate count="5" v-model="ratevalue"  active-color="#FABD20" inactive-color="#999999" size="60" gutter="20"></u-rate> -->
				 </view>
			</view>
			<view class="">
				<textarea v-model="item.comment" class="bgareas" placeholder="展开说说对商品的想法吧~" height="260rpx"></textarea>
			</view>
			<view class="m-t-30 m-b-30 d-flex f-start">
					<u-upload @beforeRead="beforeRead" @afterRead="afterRead" :show-progress="false" :header="{'token':member.token}" :ref="'upload'+index" :action="action" :file-list="item.fileList" ></u-upload>
			</view>
			<view class="">
				 你的评价内容在商品评价页面将会匿名展示
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
				shopList:[],
				arr:[],
				id:""
			}
		},
		onLoad(options) {
			this.id = options.id;
			let arr = uni.getStorageSync("evaluate");
			this.shopList = arr;
			for (let s of this.shopList) {
				s.count = 5;
				s.ratevalue = 5;
				s.fileList = [];
				s.comment = "";
			}
		},
		onUnload() {
			uni.removeStorageSync("evaluate");
		},
		methods: {
			// 
			beforeRead(e){
				uni.showLoading({
					mask:true
				})
			},
			afterRead(){
				uni.hideLoading()
			},
			// 评价
			async submit(){
				
				let flag = this.shopList.every(v=>!v.comment);
				if(flag){
					return this.$u.toast("请输入商品评价");
				}
				
				let files = [];
				for (let i = 0; i < this.shopList.length; i++) {
					let item = this.shopList[i];
					let lis = this.$refs[`upload${i}`]['0'].lists;
					
					console.log(this.$refs[`upload${i}`]['0'].lists);
					if(lis && lis.length){
						item.url = [];
						for (let s of lis) {
							if(s && s.response && s.response.data){
								item.url.push(s.response.data.url)
							}
						}	
					}
				}
				for (let i = 0; i < this.shopList.length; i++) {
					 let item = this.shopList[i];
					 if(item.url && item.url.length){
						 item.url = item.url.join(",");
					 }
				}
				try{
					uni.showLoading({
						
					});
					for (let i = 0; i < this.shopList.length; i++) {
						let item = this.shopList[i];
						let form = {
							picture:item.url || "",
							comment:item.comment,//	string	是	评论
							order_id:this.id,//	integer	是	订单id
							product_id:item.product_id || "",//	integer	是	产品id
							rate:item.ratevalue,//	integer	否	评价级别
							anonymous:"1"//	integer	否	是否匿名:0=否,1=是
						};
						let code = await this.$u.api.comment(form);
					};
					this.$util.success("评价成功","back");
				}catch(e){
					//TODO handle the exception
					console.log(e,"出错了");
				}
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
		
	   padding: 20rpx;
	   
	   background-color: #f6f6f6;
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
</style>