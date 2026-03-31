<template>
	<view class="container">
		<!-- 空白页 -->
		<view v-if="!isLogin || empty===true" class="empty">
			<image src="@/static/emptyCart.jpg" mode="aspectFit"></image>
			<view v-if="isLogin" class="empty-tips">
				空空如也
				<navigator  class="navigator" v-if="isLogin" url="/pages/index/newindex" open-type="switchTab">随便逛逛>
				</navigator>
			</view>
			<view v-else class="empty-tips">
				空空如也
				<view class="navigator" @click="navToLogin">去登陆></view>
			</view>
		</view>
		
		<block v-else>
		<view class="p20 d-flex fixed-top bg-f5f5f5" @click="delflag=!delflag">
			<text class="total">共{{ cart.length }}件商品</text>
			<text>编辑</text>
		</view>
		<scroll-view :show-scrollbar="false"  enhanced scroll-x  v-for="(item,index) in cart" style="white-space: nowrap;" :scroll-left="item.leftscroll" @scrolltolower="val=>{scrolltolower(val,item)}">
			<view style="display: flex;max-height: 750rpx;">
				<view class="d-flex f-start p20 bg-fff radius-20 fs-0 w100">
					<view class="dotbox d-flex j-center fs-0 m-l-20 m-r-20" :class="{'active':item.select}"  @click="selectItem(index)">
						<view class="dot" v-if="item.select">
							
						</view>
					</view>
					<view class="d-flex f-start  flex-1"  @click="godetail(item)">
						 <image :src="$util.getImgurl(item.image)" mode="aspectFill" class="wh80 fs-0 m-r-20"></image>
								 <view class="d-c-flex a-start flex-1">
								 	<view class="fz-32 fz-000000 line1 w360 d-flex f-start">
										 <view class="tagStyle m-r-10" v-if="item.isAc==1">福利抢购</view>
										 <view class="spacenormal">
										 	{{ item.title || ""  }}
										 </view>
								 	</view>
									<view class="fz-28 fz-999999 m-t-10 spacenormal" v-if="item.props_text">
										{{ item.props_text || ""}}
									</view>
									<view class="d-flex f-start  m-t-10">
										<view class="fz-28 fz-999999 line1 w360 spacenormal" v-if="item.desc">
												{{ item.desc || ""  }}
										 </view>
									</view>
									<view class="d-flex w-100 m-t-10">
										<text class="fz-FF2525 m-r-auto">￥ {{ item.sales_price || ""  }}</text>
										<view class="d-flex">
											 <image @click.stop="sumfn('-',index)" :src="$util.cdnurl('reduce.png')" class="btn" mode=""></image>
											 <text  class="m-l-20 m-r-20 fz-000000 fz-28">{{ item.number }}</text>
											 <image @click.stop="sumfn('+',index)" :src="$util.cdnurl('add.png')"  class="btn" mode=""></image>
										</view>
									</view>
								 </view>
					</view>
				</view>
				<view class="delbtn" @click.stop="delcart(index)">
					删除
				</view>
			</view>
	
		</scroll-view>
		
		<!-- 底部菜单栏 -->
		<view class="action-section">
			 <view class="d-flex f-start m-r-40" @click="selectItem(1,'all')">
			  	  <view class="dotbox d-flex j-center fs-0 m-r-10" :class="{'active':allchecked}">
			  	  	<view class="dot" v-if="allchecked">
			  	  		
			  	  	</view>
			  	  </view>
				  <text class="fz-28 fz-333333 fz-weight">全选</text>
			 </view>
			  
			<view class="total-box d-c-flex a-start m-r-auto">
				<view class="">
					<text class="fz-28 fz-979797">总计：</text>
					<text class="fz-28 fz-000000">¥{{total}}</text>
				</view>
				<view class="" v-if="delivery_price && false">
					<text class="fz-28 fz-979797">配送费预计：</text>
					<text class="fz-28 fz-979797">¥ {{ delivery_price }} </text>
				</view>
			</view>
			
			<button type="" class="no-border confirm-btn" @click="createOrder" v-if="delflag">去结算({{ totallen }})</button>
			<button type="" class="no-border confirm-btn" @click="delfn" v-if="!delflag">删除</button>
		</view>
			</block>
			
			<u-modal v-model="show" confirm-color="#FACE51" show-cancel-button :content="content" @confirm="delitem"></u-modal>
		
	</view>
</template>
<script>
	import { mapGetters,mapState } from "vuex";
	export default{
		computed:{
			// 总金额
			total(){
				let total = 0;
				for (let s of  this.cart) {
					if(!s.number){
						s.number = 1
					}
					if(s.select){
						total+=(Number(s.sales_price) * s.number)
					}
				}
			   return total.toFixed(2);
			},
			empty(){
				return !this.cart.length ? true : false;
			},
			...mapState(["delivery_price"]),
			...mapGetters(['isLogin'])
		},
		data(){
			return {
				screenLeft:0,
				content:"确认删除?",
				show:false,  // 删除
				allchecked:false,
				delflag:true,
				num:1,
				value:1,
				current:0,
				cart:[],
				totallen:0
			}
		},
		
		onShow(){
			
				this.refreshCart()
		},
		watch:{
			cart:{
				handler(newval){
					let len = 0;
					for (let s of newval) {
						if(s.select){
							len+=1
						}
					};
					this.totallen = len;
					if(len == newval.length){
						this.allchecked = true;
					}else{
						this.allchecked = false;
					}
				},
				immediate:true,
				deep:true
			}
		},
	   
		methods:{
		
			// 设置滚动条位置
			scrolltolower(e, item) {
				for (var i = 0; i < this.cart.length; i++) {
					let v = this.cart[i];
					if (item.id == v.id) {
						if (v.leftscroll) {
							this.$set(v, "leftscroll", 60);
						}
					} else {
						this.$nextTick(() => {
							this.$set(v, "leftscroll", '0');
						})
					}
				}
			},
			delcart(index){
				if(this.cart && this.cart.length){
					this.cart.splice(index,1);
					uni.setStorageSync("cart",this.cart);
					this.$set(this.cart[index], "leftscroll", '0');
					// this.refreshCart();
				};
			},
			delfn(){
				let arr = this.cart.filter(v=>v.select);
				if(arr.length){
					this.show = true;
				}else{
					return this.$u.toast("请选择商品");
				}
			},
			// 详情
			godetail(item){
				this.$util.navTo('/pages2/shopdetail/index?id='+item.id)
			},
			// 
			sumfn(s,i){
				if(s=='-'){
					if(this.cart[i].number>1){
						this.cart[i].number--;
					}
				}else{
					this.cart[i].number++; 
				}
			},
			// 
			delitem(){
				let list = this.cart.filter(v=>!v.select);
				uni.setStorageSync("cart",list);
				this.refreshCart();
			},
			navToLogin(){
			    this.$u.route('/pages/components/pages/login/newlogin')
			},
			refreshCart()
			{
				let cart = uni.getStorageSync('cart') || [];
				if(cart && cart.length){
					for (let i = 0; i < cart.length; i++) {
						let item = cart[i];
						if(!item.number){
							item.number = 1;
						}
					}
				}
			    this.cart = cart;
				this.screenLeft = 0;
				this.delflag = true;
			},
			createOrder(){
				let arr = this.cart.filter(v=>v.select);
				if(arr.length){
					uni.setStorageSync("shopcart",arr);
					this.$util.navTo('/pages2/orderconfirm/index?iscart=1');
				}else{
					return this.$u.toast("请选择商品");
				}
				
			},
			selectItem(i,type){
				// debugger;
				if(type){
					for (let s of this.cart) {
						if(this.allchecked){
							this.$set(s,"select",false);
						}else{
							this.$set(s,"select",true);
						}
					};
					this.allchecked = !this.allchecked;
					// this.$forceUpdate();
					return;
				}
				if(this.cart[i].select){
					this.$set(this.cart[i],"select",false);
				}else{
					this.$set(this.cart[i],"select",true);
				}
				
			},
			// 
			check(){
				
			},
			valChange(){
				
			}
		}
	}
</script>
<style lang="scss" scoped>
	.container{
		height: initial;
		min-height: 100vh;
		padding-top: 80rpx;
		background-color: #F5F5F5;
		padding-bottom: 150rpx;
	}
	.spacenormal{
		white-space: normal !important;
	}
	.delbtn{
		color: #fff;
		text-align: center;
		flex-shrink: 0;
		width: 130rpx;
		display: flex;
		justify-content: center;
		align-items: center;
		background-color: #FF0000;
	}
	.w360{
		width:240rpx;
	}
	/* 空白页 */
	.empty {
		position: fixed;
		left: 0;
		top: 0;
		width: 100%;
		height: 100vh;
		padding-bottom: 100upx;
		display: flex;
		justify-content: center;
		flex-direction: column;
		align-items: center;
		background: #fff;
	
		image {
			width: 240upx;
			height: 160upx;
			margin-bottom: 30upx;
		}
	
		.empty-tips {
			display: flex;
	
			.navigator {
				margin-left: 16upx;
			}
		}
	}
	.dotbox{
		width: 40rpx;
	    height: 40rpx;
		padding: 5rpx;
		background-color: aqua;
		border: 2rpx solid #909090;
		background-color: #fff;
		border-radius: 50%;
		.dot{
			flex-shrink: 0;
			width: 25rpx;
			height: 25rpx;
			border-radius: 50%;
			background-color: #FB7A35;
		}
	}
	.btn{
		width: 40rpx;
		height: 40rpx;
		border-radius: 50%;
	}
	.active{
	   border: 2rpx solid #FB7A35 !important;	
	}
	.linethrough{
		text-decoration: line-through;
	}
	.wh80{
		border-radius: 20rpx;
		width: 180rpx;
		height: 180rpx;
	}
	.maxwidth200{
	}
	.wh40{
		width: 50rpx;
		height: 50rpx;
	}
	
	/* 底部栏 */
	.action-section {
		position: fixed;
		z-index: 95;
		display: flex;
		align-items: center;
		justify-content: flex-start;
		width: 100%;
		height: 110upx;
		padding: 16rpx 20upx;
		background:#fff;
		bottom: 0;
		left: 0;
		right: 0;
		width: 100%;
		.checkbox {
			height: 52upx;
			position: relative;
	
			image {
				width: 52upx;
				height: 100%;
				position: relative;
				z-index: 5;
			}
		}
	
		.clear-btn {
			position: absolute;
			left: 26upx;
			top: 0;
			z-index: 4;
			width: 0;
			height: 52upx;
			line-height: 52upx;
			padding-left: 38upx;
			color: #fff;
			border-radius: 0 50px 50px 0;
			opacity: 0;
			transition: .2s;
	
			&.show {
				opacity: 1;
				width: 120upx;
			}
		}
	
		.total-box {
			display: flex;
			flex-direction: column;
			text-align: right;
			padding-right: 40upx;
			.price {
				font-weight: bold;
				font-size: 32rpx;
				color: #FF2727;
			}
	
		}
	
		.confirm-btn {
			margin: 0;
			width: 240rpx;
			height: 80rpx;
			background: #FACE51;
			border-radius: 40rpx 40rpx 40rpx 40rpx;
			font-weight: bold;
			font-size: 32rpx;
			color: #000000;			
		}
	}
	
	.w360{
		width: 380rpx;
	}
	.tagStyle{
		width: fit-content;
		height: 40rpx;
		background: #FFE2BE;
		border-radius: 10rpx 10rpx 10rpx 10rpx;
		font-weight: 500;
		font-size: 20rpx;
		color: #FB7A35;
		padding: 8rpx 10rpx;
	}
</style>