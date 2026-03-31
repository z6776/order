<template>
	<view class="content">
		<movable-area class="movableArea">
			<movable-view class="movableView"
				:position="position"
				:x="x"
				:y="y"
				:direction="direction"
				:damping="damping"
				@change="onChange"
				@tap="onTap"
				@touchend="onTouchend"
				>
				<image src="../../static/phone.png" mode="" class="iconImage"></image>
			</movable-view>
		</movable-area>
	</view>
</template>

<script>
	const app = getApp();
	import { mapState } from "vuex";
	export default {
		data() {
			return {
				phone:"",
				animation:false,
				x: app.globalData.x,
				y: app.globalData.y,
				x1: 0,
				x2: 0,
				y1: 0,
				y2: 0,
				move: {
					x: app.globalData.x,
					y: app.globalData.y
				}
			};
		},
		computed:{
			...mapState(["latlng"])
		},
		props: {
			damping: {
				type: Number,
				default: 10
			},
			direction: {
				type: String,
				default: "all"
			},
			position: {
				type: Number,
				default: 4
			}
		},
		mounted() {
			uni.getSystemInfo({
				success: (res) => {
					this.x2 = parseInt(res.windowWidth) - 50;
					this.y2 = parseInt(res.windowHeight) - 20;
				}
			});
			//获取管理员手机号
			// this.getdetail();
		},
		methods: {
			// 关于我们
			// async getdetail(type){
			// 	let data = await this.$u.api.attentionOrder({
			// 		key:"phone"
			// 	});
			// 	this.phone = data;
			// },
			onChange(e) {
				if (e.detail.source === "touch") {
					this.move.x = e.detail.x;
					this.move.y = e.detail.y;
				}
			},
			onTap(e) {
				// console.log("Tap event");
				if(!this.latlng.valiagephone){
					return this.$u.toast("所在小区暂未设置电话");
				}
				this.$util.makePhone(this.latlng.valiagephone);
				// 在这里处理单击事件的逻辑
				// 例如打开链接、执行动作等
			},
			onTouchend() {
				this.x = this.move.x;
				this.y = this.move.y;
				setTimeout(() => {
					if (this.move.x < this.x2 / 2) this.x = this.x1;
					else this.x = this.x2;
					// console.log("yuan" + this.x, this.y)
				}, 100)
			},
			onLoad: function(e) {
			
			}
		},
	};
</script>

<style scoped>
	.content {
		position: relative;
		/* height: 100vh; */
	}

	.movableArea {
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		pointer-events: none;
		z-index: 999;
	}

	.movableView {
		pointer-events: auto;
		width: 150rpx;
		height: 150rpx;
		
		/* padding: 10rpx; */
		/* border-radius: 100%; */
		/* border: 2px solid #33A3DC; */
		/* background-color: #DAEE78; */
	}

	.iconImage {
		display: block;
		width: 150rpx;
		height: 150rpx;
	}

	.contact {
		width: 50px;
		height: 50px;
		overflow: hidden;
		position: absolute;
		left: 0px;
		top: 0px;
		border-radius: 100%;
		opacity: 0;
	}
</style>
