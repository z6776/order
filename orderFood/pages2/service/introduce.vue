<template>
	<view>
		<view class="d-c-flex p-relative m-b-40">
			<block v-if="!member.avatar">
				<image  :src="$util.cdnurl('ava.png')"  class="portrait fs-0" mode=""></image>
				<image :src="$util.cdnurl('carmas1.png')"  class="wh40" mode=""></image>
			</block>
			<block v-else>
				<image :src="$util.getImgurl(member.avatar)" class="portrait fs-0" mode=""></image>
			</block>
			<button class="button" open-type="chooseAvatar" @chooseavatar="chooseavatar"></button>
		</view>
			<view class="radius-20">
				<view class="list-cell b-b m-t" hover-class="cell-hover" :hover-stay-time="50">
					<text class="cell-tit m-r-auto">姓名</text>
					<input class="input" type="nickname" v-model="member.welcome" placeholder="请输入姓名" @change="change" style="text-align: right;" />
				</view>
				<view class="list-cell b-b m-t"  hover-class="cell-hover" :hover-stay-time="50">
					<text class="cell-tit m-r-auto">手机号</text>
					<input class="input" v-model="member.mobile" placeholder="请输入手机号"  style="text-align: right;" />
				</view>
				<view class="list-cell b-b m-t"  hover-class="cell-hover" :hover-stay-time="50">
					<text class="cell-tit m-r-auto">身份证号</text>
					<input class="input"  v-model="member.sfz_num"  placeholder="请输入身份证号" style="text-align: right;" />
				</view>
			</view>
			
			<view class="boxFixed">
				<mybtn msg="保存" @handclick="save" />
			</view>
	</view>
</template>

<script>
	import { mapState,mapMutations} from 'vuex';
	export default {
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
			console.log(this.member);
		},
		methods: {
			...mapMutations(["SET_MEMBER"]),
			change(e){
				this.member.username = e.detail.value;
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
			async getPhoneNumber(e) {
				if (e.hasOwnProperty('detail')) {
					let data = await this.$u.api.userDecryptData({
						encryptedData: e.detail.encryptedData,
						iv: e.detail.iv,
						openid: this.openid
					});
					if (data) {
						this.member.mobile = data.phoneNumber;
					}
				}
			},
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
				this.member.birthday = e.target.value
			},
			async save() {
				if(!this.member.sfz_num){
					return this.$u.toast("请输入身份证号");
				}
				let data = await this.$u.api.profile({
					username: this.member.welcome,
					mobile: this.member.mobile,
					gender: '',
					birthday: this.member.birthday,
					avatar: this.member.avatar,
					sfz_num:this.member.sfz_num
				});
				const member = Object.assign(this.$store.state.member, this.member)
				this.$store.commit('SET_MEMBER', member)
				uni.showToast({
					icon:"success",
					title:"修改成功"
				});
				setTimeout(()=>{
					uni.navigateBack()
				},1500)
				
			}
		}
	}
</script>

<style lang="scss">
	page{
		padding: 20rpx;
		box-sizing: border-box;
	}
	.wh40{
		width: 40rpx;
		height: 40rpx;
	}
	.log-out-btn{
		width: 630rpx;
		height: 80rpx;
		text-align: center;
		line-height: 80rpx;
		border: 2rpx solid #999999;
		border-radius: 50rpx;
		margin: 0 auto;
		margin-top: 180upx;
		display: flex;
		justify-content: center;
		align-items: center;
		.cell-tit{
			font-weight: 500;
			font-size: 32rpx;
			color: #999999;
		}
	}
	.portrait {
		width: 180upx;
		height: 180upx;
		border-radius: 50%;
		vertical-align: middle;
	}
	.list-cell{
		display:flex;
		align-items:center;
		padding: 30upx 20rpx;
		line-height:60upx;
		position:relative;
		background: #fff;
		justify-content: center;
		
		&.cell-hover{
			background:#fafafa;
		}
		&.b-b:after{
			left: 30upx;
			border-bottom: 2rpx solid #F9F9F9;
		}
		/* &.m-t{
			margin-top: 16upx; 
		} */
		.cell-more{
			// align-self: baseline;
			margin-left:10upx;
		}
		.cell-tit{
			flex: 1;
			
			font-size: 28rpx;
			color: #333333;
			margin-right:10upx;
		}
		.cell-tip{
		}
		switch{
			transform: translateX(16upx) scale(.84);
		}
	}
	.button {
		position: absolute;
		width: 100%;
		height: 100%;
		top: 0;
		opacity: 0;
	}
	.user-section {
		display: flex;
		align-items: center;
		justify-content: center;
		position: relative;
		.bg {
			position: absolute;
			left: 0;
			top: 0;
			width: 100%;
			height: 100%;
			filter: blur(1px);
			opacity: .7;
		}

		.portrait-box {
			width: 90upx;
			height: 90upx;
			// border: 6upx solid #fff;
			border-radius: 50%;
			// position: relative;
			z-index: 2;
			
		}

		.portrait {
			position: relative;
			width: 100%;
			height: 100%;
			border-radius: 50%;
		}

		// .yticon {
		// 	position: absolute;
		// 	line-height: 1;
		// 	z-index: 5;
		// 	font-size: 48upx;
		// 	color: #fff;
		// 	padding: 4upx 6upx;
		// 	border-radius: 6upx;
		// 	background: rgba(0, 0, 0, .4);
		// }

		.pt-upload-btn {
			right: 0;
			bottom: 10upx;
		}

		.bg-upload-btn {
			right: 20upx;
			bottom: 16upx;
		}
	}


	.yt-list-cell {
		margin-top: 16rpx;
		background: #fff;
		display: flex;
		align-items: center;
		padding: 10rpx 30rpx;
		line-height: 70rpx;
		position: relative;

		.cell-tit {
			flex: 1;
			font-size: 26rpx;
			color: #000000;
			margin-right: 10rpx;

			.input {
				display: inline-block;
				vertical-align: middle;
				margin-left: 20rpx;
				width: 550rpx;
				float: right;
				line-height: 70rpx !important;
				height: 70rpx !important;
			}

			.username {
				width: 300rpx;
				position: absolute;
				right: 30rpx;
				z-index: 100;
			}
		}
	}
</style>
