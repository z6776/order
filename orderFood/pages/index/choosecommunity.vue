<template>
	<view class="container">
		<!-- 搜索 -->
		<view class="p20 m-b-20 bg-fff">
			<u-search @change="searchtit" placeholder="请输入小区名称" v-model="keyword" :show-action="false"></u-search>
		</view>
		<mescroll-body @init="mescrollInit" @down="downCallback" @up="upCallback">
		<view class="radius-20">
			<view class="list-cell b-b m-t" hover-class="cell-hover" :hover-stay-time="50"
				v-for="(item,index) in list" @click="selItem(item),current=index" :key="item.id">
				<text class="cell-tit">{{item.name}}</text>
				<image   :src="$util.cdnurl('check.png')"   mode="aspectFill" class="wh48" v-if="current==index">
				</image>
			</view>
		</view>
		</mescroll-body>
	</view>
</template>

<script>
	import {
		mapMutations
	} from 'vuex';
	import MescrollMixin from "@/utils/mescroll.js";
	export default {
mixins:[MescrollMixin],
		data() {
			return {
				keyword: "",
				list:[],
				// cityList: [{
				// 	title: "阳光创谷"
				// }, {
				// 	title: "保利花园"
				// }, {
				// 	title: "阳光创谷"
				// }, {
				// 	title: "保利花园"
				// }, {
				// 	title: "阳光创谷"
				// }, {
				// 	title: "保利花园"
				// }, {
				// 	title: "阳光创谷"
				// }, {
				// 	title: "保利花园"
				// }, {
				// 	title: "阳光创谷"
				// }, {
				// 	title: "保利花园"
				// }],
				current: 0,
				value1: false,
				type:"",
				id:""
			};
		},
		onLoad(query) {
			this.type = query.type;
			this.id = query.id;
		},
		methods: {
			...mapMutations(['logout','valiageaddress',"seladdress",'SET_LATLNG']),
			// 确认
			async selItem(item){
				if(this.type=='address'){
					this.$util.prePage().form.address = item.name;
					this.$util.prePage().form.lat = item.latitude;
					this.$util.prePage().form.lng = item.longitude;
					this.$util.prePage().address_id = item.id;
					uni.navigateBack();
					return 
				}
				if(this.type=='index'){
					this.$util.prePage().valiage = item;
					this.valiageaddress(item);
					uni.navigateBack();
					return 
				}
				
				
			},
			// 初始化列表
			initList() {
				this.list = [];
				this.mescroll.resetUpScroll();
			},
			// 搜索列表
			searchtit(e) {
				this.keyword = e;
				this.initList();
			},
			async upCallback(page) {
				let {
					data
				} = await this.$u.api.getVillageList({
					name: this.keyword || "",
					page: page.num,
					pagesize: 20
				});
				console.log(data, "datatata");
				if (page.num == 1) {
					this.list = [];
				}
				
				this.list = [...this.list, ...data];
				if(this.id &&this.current==0){
					let index = this.list.findIndex(v=>v.id==this.id);
					this.current = index;
				}
				this.mescroll.endSuccess(data.length, 20 == data.length);
			},



			navTo(url) {
				uni.navigateTo({
					url: url
				});
			},
			//退出登录
			toLogout() {
				uni.showModal({
					content: '确定要退出登录么',
					success: (e) => {
						if (e.confirm) {
							this.logout();
							setTimeout(() => {
								uni.navigateBack();
							}, 200)
						}
					}
				});
			},
			//switch
			switchChange(e) {
				let statusTip = e.detail.value ? '打开' : '关闭';
				this.$api.msg(`${statusTip}消息推送`);
			},

		}
	}
</script>

<style lang='scss'>
	page {
		background: #fafafa;
		padding: 20rpx;
		box-sizing: border-box;
	}

	.wh48 {
		width: 48rpx;
		height: 48rpx;
	}

	.title {
		font-size: 30rpx;
		color: #303133;
	}

	.list-cell {
		display: flex;
		align-items: center;
		padding: 20upx;
		line-height: 60upx;
		position: relative;
		background: #fff;
		justify-content: center;

		&.log-out-btn {
			margin-top: 40upx;

			.cell-tit {
				color: #4DD88D;
				text-align: center;
				margin-right: 0;
			}
		}

		&.cell-hover {
			background: #fafafa;
		}

		&.b-b:after {
			left: 30upx;
		}

		/* &.m-t{
			margin-top: 16upx; 
		} */
		.cell-more {
			align-self: center;
			font-size: 32rpx;
			margin-left: 10upx;
		}

		.cell-tit {
			flex: 1;
			font-size: 28rpx;
			margin-right: 10upx;
		}

		switch {
			transform: translateX(16upx) scale(.84);
		}
	}
</style>