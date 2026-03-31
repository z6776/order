<template>
	<view class="content">
		 <!---->
		<image class="loginbg"  :src="bgimg ? $util.getImgurl(bgimg) :  $util.cdnurl('loginbg.png') "  mode=""></image>
	     	<u-navbar title="首页" :is-back="false"  :background="bgColorOpa" :border-bottom="false">
				<view class="p-l-20" @click="$util.back()">
					<u-icon name="arrow-left" size="32" color="#000000" bold></u-icon>
				</view>
	     	</u-navbar>
			
			<view class="avatar"  :style="{'marginTop':safeTop+'px'}">
				<block v-if="!member.avatar">
					<image :src="$util.cdnurl('missing-face.png')"  class="wh140" mode=""></image>
					<image :src="$util.cdnurl('carmas1.png')"  class="wh40" mode=""></image>
				</block>
				<block v-else>
					<image :src="$util.getImgurl(member.avatar)" class="wh140" mode=""></image>
				</block>
				  <button size='mini' open-type="chooseAvatar" @chooseavatar="chooseavatar" type="success" style="position: absolute;inset:0;" class="btns"></button>
			</view>
			<list-cell :hover="false">
				<view class="form-input w-100 d-flex align-items-center">
					<view class="label">昵称</view>
					<view class="input flex-fill">
						<input type="nickname" @change="change" class="fz-right" placeholder="请填写昵称" placeholder-class="text-color-assist font-size-base"  v-model="member.username">
					</view>
				</view>
			</list-cell>
			
			<view class="lgs m-t-30">
				<!-- loginWechat open-type="getPhoneNumber" @getphonenumber -->
				<button  v-if="ischeck" @click="getphonenumber">一键授权登录</button>
				<button  v-else @click="getCheck()">一键授权登录</button>
				
			     <view class="d-flex f-start m-t-60 msg" @click="ischeck=!ischeck">
			     	  	<radio :checked="ischeck" style="transform: scale(.8)" color="#FACE51" />
						<text class="fz-28 fz-585858">我已阅读并同意</text>
						<text class="fz-28 fz-5DA5FF" @click.stop="$util.navTo('/pages/components/pages/userinformation/index?title=用户协议&key=useragreement',false)">《用户协议》</text>
						<text class="fz-28 fz-585858">和</text>
						<text class="fz-28 fz-5DA5FF" @click.stop="$util.navTo('/pages/components/pages/userinformation/index?title=隐私政策&key=useragreement',false)">《隐私政策》</text>
			     </view>
			</view>
			<u-toast ref="uToast"></u-toast>
	</view>
</template>

<script>
	import { mapState,mapMutations } from "vuex";
	const app = getApp();
	 export default{
		 data(){
			 return {
				 bgimg:"",
				 member:{},
				 ischeck:false,
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg'
			 }
		 },
		 computed:{
			 ...mapState(['openid', 'lang','position']),
			 safeTop(){
				 let res = uni.getMenuButtonBoundingClientRect();
				 if(app.globalData.is375){
					 // 有刘海没有刘海 没有刘海偏上要多顶20个px
					 return app.globalData.isIPhoneX ? res.bottom+100 : res.bottom+120;
				 }else{
					 // 大于375的背景图不够
					return app.globalData.isIPhoneX ? res.bottom+120 : res.bottom+140; 
				 }
				
			 }
		 },
		 onLoad(){
			 // this.getBg();
			 this.member = JSON.parse(JSON.stringify(this.$store.state.membercopy));
		 },
		 methods:{  
				...mapMutations(['SET_MEMBER']),
				async getBg(){
					let data = await this.$u.api.attentionOrder({
						key:"login_image"
					});
				   if(data){
					   this.bgimg = data;
				   }
					console.log(data,":1111111");
				},
				chooseavatar(e){
					uni.showLoading({
						
					});
					console.log(e,"123123");
					const that = this;
					uni.uploadFile({
						url: this.$u.http.config.baseUrl + '/api/common/upload', 
						filePath: e.detail.avatarUrl,
						name: 'file',
						header: {
							token: '',
							lang: this.lang,
							'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
						},
						success(uploadFileResult){
							console.log(uploadFileResult,"uploadFileResultuploadFileResult");
							if (uploadFileResult) {
								const upload = JSON.parse(uploadFileResult.data);
								that.$set(that.member,'avatar',upload.data.fullurl)
								console.log(that.member.avatar,"uploadFileResultuploadFileResult");
							}
							uni.hideLoading();
						}, 
						fail(e){
							console.log('网络链接错误');
							console.log(e);
							uni.hideLoading();
						}
					});
				},
				change(e){
					this.member.username = e.detail.value;
					console.log(e);
				},
				getCheck(){
					if(!this.ischeck){
						return this.$u.toast("请阅读协议并勾选");
					}
				},
			 // #ifdef MP-WEIXIN
			 async getphonenumber(e) {
				 console.log(e,"eeeeee");
				 uni.showLoading({
					 title:"登录中...",
					 mask:true
				 })
			 	// if (e.detail.encryptedData && e.detail.iv) {
			 		let data = await this.$u.api.loginWechat({
			 			// encryptedData: e.detail.encryptedData,
			 			// iv: e.detail.iv,
			 			openid: this.openid,
						avatar:this.member?.avatar || "",
						username:this.member?.username || ""
			 		});
			 		if (data) {
			 			this.SET_MEMBER(data);
						uni.hideLoading()
						// this.getUserInfo();
			 			this.$refs.uToast.show({
			 				title: '登录成功',
			 				type: 'success'
			 			});
			 			setTimeout(function() {
			 				uni.navigateBack();
			 			}, 2000);
			 		}
			 	// }
			 },
			 // #endif
		 }
	 }
</script>

<style scoped lang="scss">
	.avatar{
			width: 140rpx;
			height: 140rpx;
			position: relative;
			margin: 0 auto;
			margin-bottom: 40rpx;
			.wh140{
				width: 140rpx;
				height: 140rpx;
				// background-color: #999999;
			  border-radius: 50%;
			}
			.wh40{
				width: 40rpx;
				height: 40rpx;
				position: absolute;
				bottom: 0;
				right: 0;
			}
			
		}
		.form-input {
			.label {
				width: 160rpx;
				font-size: $font-size-base;
				color: $text-color-base;
			}
			
			.input {
			}
			
			.radio-group {
				display: flex;
				justify-content: flex-start;
				
				.radio {
					padding: 10rpx 30rpx;
					border-radius: 6rpx;
					border: 2rpx solid $text-color-assist;
					color: $text-color-assist;
					font-size: $font-size-base;
					
					&.checked {
						background-color: $color-primary;
						color: $text-color-white;
						border: 2rpx solid $color-primary;
					}
				}
			}
		}
		
		.btns{
			height: 100%;
			background-color: transparent !important;
		}
	.content{
		min-height: 100vh;
		padding: 30rpx 20rpx 20rpx 20rpx;
	}
	.lgs{
		button{
			width: 630rpx;
			height: 80rpx;
			background: #FACE51;
			border-radius: 100rpx 100rpx 100rpx 100rpx;
			font-weight: 500;
			font-size: 32rpx;
			color: #000000;
			margin: 0 auto;
		}
		.msg{
			margin-left: 20rpx;
		}
	}
	.loginbg{
		width:100%;
		height: 100%;
		position: fixed;
		inset: 0;
		z-index: -1;
	}
	
</style>