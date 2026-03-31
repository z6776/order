<template>
	<view class="">
		<scroll-view  scroll-x class="scroll-X" :scroll-into-view="intoviewbyid" @scroll="scroll" scroll-with-animation   :show-scrollbar="false"  enhanced>
			<view class="scroll-view-item itembox line1"
			  :id="'msg'+index"
			  v-for="(item,index) in list"
			  :key="item.id" @click="change(index)"
			  :class="{'active':index==current}"
			  >
				<text> {{item.name}}</text>
				<image v-if="index==current" :src="$util.cdnurl('hotbg.png')" class="wh154"></image>
			</view>
		
		</scroll-view>
	</view>
</template>

<script>
	export default {
        props:{
			list:{
			  type:Array,
			  default:[]
			}
		},
		data() {
			return {
				left:0,
				intoviewbyid: "msg0",
				// list: [{
				// 	id: 1,
				// 	title: "低糖专区"
				// }, {
				// 	id: 2,
				// 	title: "特惠老年餐"
				// }, {
				// 	id: 3,
				// 	title: "青年口味餐"
				// }, {
				// 	id: 4,
				// 	title: "成品菜"
				// }, {
				// 	id: 5,
				// 	title: "小碗菜"
				// }, {
				// 	id: 6,
				// 	title: "小碗菜"
				// }],
				current: 0,
				src: 'https://cdn.uviewui.com/uview/album/1.jpg'
			}
		},
		onLoad() {

		},
		methods: {
			// 滚动
			scroll(e) {
				this.left = e.detail.scrollLeft;
			},
			change(e) {
				this.intoviewbyid = 'msg' +e;
				this.current = e;
				this.$emit("change",this.list[e].id);
				// let query = uni.createSelectorQuery().in(this);
				// query.select('.')
				// console.log(e, "ee")
			}
		}
	}
</script>

<style lang="scss" scoped>
	.content {
		// min-height: 100vh;
		background-color: #FAFAFA;
		padding: 30rpx 20rpx 20rpx 20rpx;
	}

	.scroll-X {
		white-space: nowrap;
			
		// display: flex;
	}
	
	.active{
		
		font-weight: 800;
		font-size: 32rpx !important;
		color: #FFFFFF !important;
	}

	// .scroll-view-item{

	.itembox {
		flex-shrink: 0;
		// padding: 30rpx 22rpx;
		font-weight: 500;
		font-size: 28rpx;
		color: #979797;
		width: 154rpx;
		height: 100rpx;
		border-radius: 0 20rpx 0 0;
		display: inline-block;
		text-align: center;
		line-height: 100rpx;
		position: relative;
		.wh154 {
			position: absolute;
			inset: 0;
			z-index: -1;
			width: 154rpx;
			height: 100rpx;
			border-radius: 0 20rpx 0 0;
			transition: left .3s linear;
		}
	}

	// }
</style>