<template>
	<view class="content">
		
		<u-navbar :border-bottom="false" :leftIconColor="leftIconColor" :title="title" :is-back="isBack" :showLeft="showicon" :safeAreaInsetTop="safeAreaInsetTop" @leftclick="leftclick" :background="bgColor":titleStyle="{'fontSize':'36rpx','font-weight':'600','font-family': 'PingFang SC-Medium, PingFang SC','color':colors}" placeholder>
			<view class="u-nav-slot" slot="left">
				<slot />
			</view>
		</u-navbar>
	</view>
</template>

<script>
	export default {
		props: {
			isBack:{
				type:Boolean,
				default:false
			},
			leftIconColor:{
				type: String,
				default: ""
			},
			safeAreaInsetTop:{
				type: Boolean,
				default: true
			},
			showicon: {
				type: Boolean,
				default: false
			},
			title: {
				type: String,
				default: ""
			},
			bgColor: {
				type: String,
				default: "transparent"
			},
			colors: {
				type: String,
				default: "#ffffff"
			}
		},
		onPageScroll(e) {
			console.log(e,"1111111");
		},
		methods: {
			leftclick() {
				uni.navigateBack()
			}
		}
	}
</script>

<style scoped lang="scss">
	.content {
		background-color: transparent;
		height: 120rpx;
	}

	.u-nav-slot {
		margin-top: 5rpx;

	}
</style>