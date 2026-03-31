<template>
	<view class="container">
		<view class="flex-fill form">
			<view class="avatar">
				<block v-if="!member.avatar">
					<image  :src="$util.cdnurl('ava.png')"  class="wh140" mode=""></image>
					<image :src="$util.cdnurl('carmas1.png')"  class="wh40" mode=""></image>
				</block>
				<block v-else>
					<image :src="$util.getImgurl(member.avatar)" class="wh140" mode=""></image>
				</block>
				<button size='mini' open-type="chooseAvatar" @chooseavatar="chooseavatar" type="success" style="position: absolute;inset:0;height: 100%;" class="btns"></button>
			</view>
			<!-- 昵称 -->
			<list-cell :hover="false">
				<view class="form-input w-100 d-flex align-items-center">
					<view class="label">昵称</view>
					<view class="input flex-fill">
						<input type="nickname" @change="change" class="fz-right" placeholder="请填写昵称" placeholder-class="text-color-assist font-size-base"  v-model="member.welcome">
					</view>
				</view>
			</list-cell>
			
			<list-cell :hover="false">
				<button open-type="getPhoneNumber" @getphonenumber="getPhoneNumber" class="u-reset w100">
				<view class="form-input w-100 d-flex align-items-center">
					<view class="label t-left">手机号</view>
					<view class="input flex-fill">
						<input disabled class="fz-right" placeholder="请填写手机号" placeholder-class="text-color-assist font-size-base"  v-model="member.mobile">
					</view>
				</view>
				</button>
			</list-cell>
			
			<list-cell :hover="false" :arrow="!member.birthday">
				<view class="form-input w-100 d-flex align-items-center">
					<view class="label">出生年月</view>
					<view class="input flex-fill fz-right">
						<picker :disabled="member.birthday" mode="date" :value="member.birthday" class="fz-right" :start="startDate" :end="endDate" @change="handleDateChange">
							{{member.birthday ? $util.parseTime(member.birthday,"{y}-{m}-{d}")  : '无'}}
						</picker>
					</view>
				</view>
			</list-cell>
			
			<list-cell :hover="false" last v-if="position.rule && position.rule.length">
				<view class="form-input w-100 d-flex align-items-center">
					<view class="label">当前角色</view>
					<view class="input flex-fill fz-right">
						<text v-for="(item,i) in position.rule">{{ i==position.rule.length-1 ? item.name  : item.name + ","  }}</text>
					</view>
				</view>
			</list-cell>
		</view>
		<view class="tip">
			提示：可修改头像、昵称、出生年月，出生年月提交后无法修改
		</view>
		
		<view class="boxFixed bgt d-c-flex">
			   <view class="subupdate" @tap="save" hover-class="op9">
			   	  提交修改
			   </view>
					   <view class="logout"  @tap="logoutfn" hover-class="op9">
					   	  退出登录
					   </view>
		</view>
		
		<u-toast ref="uToast"></u-toast>
	</view>
</template>

<script>
	
	import listCell from '@/components/list-cell/list-cell'
	import { mapState,mapMutations} from 'vuex';
	export default {
		components: {
			listCell
		},
		data() {
			const currentDate = this.getDate({format: true})
			return {
				member: {},
				date: currentDate
			}
		},
		computed: {
			...mapState(['openid', 'lang','position']),
			startDate() {
				return this.getDate('start');
			},
			endDate() {
				return this.getDate('end');
			}
		},
		onLoad() {
			this.member = JSON.parse(JSON.stringify(this.$store.state.position));
			// console.log(this.member);
		},
		methods: {
			...mapMutations(["SET_MEMBER","SET_POSITION"]),
			changemobile(e){
				this.member.mobile = e.detail.value;
				console.log(e,"eeeeeeee");
			},
			change(e){
				this.member.welcome = e.detail.value;
				console.log(e);
			},
			logout() {
				this.SET_MEMBER({});
				this.$refs.uToast.show({
					title: '已退出',
					type: 'success'
				});
				setTimeout(function() {
					uni.navigateBack();
				}, 2000);
			},
			logoutfn(){
				//退出登录
					uni.showModal({
						content: '确定要退出登录么',
						success: (e) => {
							if (e.confirm) {
								this.logout();
							}
						}
					});
			},
			chooseavatar(e) {
				const that = this;
				uni.uploadFile({
					url: this.$u.http.config.baseUrl + '/api/common/upload', 
					filePath: e.detail.avatarUrl,
					name: 'file',
					header: {
						token: this.member.token,
						lang: this.lang,
						'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
					},
					success(uploadFileResult){
						if (uploadFileResult) {
							const upload = JSON.parse(uploadFileResult.data);
							that.member.avatar = upload.data.fullurl;
						}
					}, 
					fail(e){
						console.log('网络链接错误');
						console.log(e)
					}
				});
			},
			// #ifdef MP-WEIXIN
			async getPhoneNumber(e) {
				console.log(e,"eeeeeeeee");
				 if(!e.detail.iv){
					 return this.$u.toast("授权失败");
				 }
						 uni.showLoading({
							 mask:true
						 })
				// if (e.detail.encryptedData && e.detail.iv) {
					let data = await this.$u.api.userLoginForWechatMini({
						encryptedData: e.detail.encryptedData,
						iv: e.detail.iv,
						openid: this.openid,
						avatar:"",
						username:""
					});
					if (data) {
						this.member.mobile = data.mobile || "";
					}
				// }
			},
			// #endif
			
			// async getPhoneNumber(e) {
			// 	if (e.hasOwnProperty('detail')) {
			// 		let data = await this.$u.api.userDecryptData({
			// 			encryptedData: e.detail.encryptedData,
			// 			iv: e.detail.iv,
			// 			openid: this.openid
			// 		});
			// 		if (data) {
			// 			this.member.mobile = data.phoneNumber;
			// 		}
			// 	}
			// },
			getDate(type) {
				const date = new Date();
				let year = date.getFullYear();
				let month = date.getMonth() + 1;
				let day = date.getDate();
	
				if (type === 'start') {
					year = year - 60;
				} else if (type === 'end') {
					year = year + 2;
				}
				month = month > 9 ? month : '0' + month;;
				day = day > 9 ? day : '0' + day;
				return `${year}-${month}-${day}`;
			},
			handleDateChange(e) {
				this.member.birthday = e.target.value;
				this.$forceUpdate();
			},
			async save() {
				let data = await this.$u.api.profile({
					username: this.member.welcome,
					mobile: this.member.mobile,
					gender: '',
					birthday: this.member.birthday || "",
					avatar: this.member.avatar
				});
				this.getUserInfo();
				const member = Object.assign(this.$store.state.member, this.member)
				this.$store.commit('SET_MEMBER', member);
				uni.showToast({
					icon:"success",
					title:"修改成功"
				});
				setTimeout(()=>{
					uni.navigateBack()
				},1500)
			},
			async getUserInfo() {
					let data = await this.$u.api.userindex();
					
					if (data) {
						this.SET_POSITION(data);
					}
			}
		}
	}
</script>

<style lang="scss" scoped>
page {
	height: 100%;
	background-color: #F5F5F5;
}
.tip{
		font-weight: 500;
		font-size: 24rpx;
		color: rgba(255,0,0,0.5);
		margin-top: 24rpx;
	}
	.boxFixed{
		bottom: 100rpx !important;
	}
	.subupdate{
		width: 630rpx;
		height: 80rpx;
		background: #FACE51;
		border-radius: 100rpx 100rpx 100rpx 100rpx;
		font-weight: 500;
		font-size: 32rpx;
		color: #000000;
		line-height: 80rpx;
		text-align: center;
	}
	.logout{
		font-family: PingFang SC, PingFang SC;
		font-weight: 500;
		font-size: 32rpx;
		color: #000000;
		width: 630rpx;
		height: 80rpx;
		background: #FFFFFF;
		line-height: 80rpx;
		text-align: center;
		border-radius: 100rpx 100rpx 100rpx 100rpx;
		margin-top: 40rpx;
	}
	.btns{
		background-color: transparent !important;
	}
.avatar{
		width: 140rpx;
		height: 140rpx;
		position: relative;
		margin: 0 auto;
		margin-bottom: 40rpx;
		.wh140{
			width: 140rpx;
			height: 140rpx;
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

.container {
	background-color: #F5F5F5;
	padding: 30rpx 30rpx;
}

.form {
	border-radius: 8rpx;
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

.btn-box {
	height: calc((100vh - 40rpx) / 2);
}

.save-btn {
	width: 90%;
	border-radius: 50rem !important;
	font-size: $font-size-lg;
}
</style>
