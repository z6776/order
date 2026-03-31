<template>
	<view class="content b-t">
		<view class="list b-b m-b-30 radius-20" v-for="(item, index) in addressList" :key="index" @click="checkAddress(item)">
			<view class="wrapper borderbottom">
				<view class="u-box">
					<text class="name">{{item.name}}</text>
					<text class="mobile">{{item.mobile}}</text>
				</view>
				<view class="address-box">
					<text class="address">{{item.address+' '+item.door_number}}</text>
				</view>
			</view>
			<view class="d-flex f-start m-t-20">
				<radio :checked="item.isdefaults==1" color="#FACE51" style="transform: scale(.7);" @click.stop="setting(item)" />
				<text class="fz-28 fz-333333 fz-weight m-r-auto" @click.stop="setting(item)">设为默认地址</text>
				<image src="../../../../static/user/edit.png" class="icon-bianji m-r-10" mode="" @click.stop="addAddress('edit', item.id)"></image>
				<text class="fz-999999 fz-weight fz-28 m-r-30"  @click.stop="addAddress('edit', item.id)">编辑</text>
				<image   :src="$util.cdnurl('delicon.png')"  class="icon-bianji  m-r-10" mode="" @click.stop="deleteAddress(item.id,index)"></image>
				<text class="fz-999999 fz-weight fz-28"  @click.stop="deleteAddress(item.id,index)">删除</text>
			</view>
		</view>
		
		<u-empty mode="address" v-if="addressList.length == 0" textSize="30" iconSize="180" marginTop="180"></u-empty>
		<view class="boxFixed">
			<button class="add-btn" hover-class="op9" @click="addAddress('add')">新增收货地址</button>
		</view>
		
	</view>
</template>

<script>


	export default {
		data() {
			return {
				source: 0,
				addressList: []
			}
		},
		onLoad(option) {
			console.log(option.source);
			this.source = option.source;
		},
		onShow() {
			this.getList();
			
		},
		methods: {
			async setting(item) {
				uni.showLoading({
					mask:true,
					title:"设置中..."
				});
				let is_default = item.isdefaults==1 ? 2 : 1;
			 let data = await this.$u.api.addressEdit({...item,isdefaults:is_default});
			   this.getList()
			},
			//获取我的收货地址
			async getList() {
				let {data} = await this.$u.api.getAddressList({
				});
				if (data) {
					this.addressList = data;
				};
				uni.hideLoading();
			},
			//选择地址
			checkAddress(item) {
				if (this.source == 1) {
					//this.$api.prePage()获取上一页实例，在App.vue定义
					this.$util.prePage().addressData = item;
					
					uni.navigateBack()
				}
			},
			addAddress(type, id = 0) {
				uni.navigateTo({
					url: `/pages/components/pages/address/add?type=${type}&id=${id}`
				})
			},
			//添加或修改成功之后回调
			refreshList(data, type) {
				//添加或修改后事件，这里直接在最前面添加了一条数据，实际应用中直接刷新地址列表即可
				this.addressList.unshift(data);

				console.log(data, type);
			},
			async deleteAddress(id, index) {
				let [error, res] = await uni.showModal({
					title: '确定删除地址？',
					content: this.addressList[index].address
				})

				if (res.confirm) {
					let data = await this.$u.api.addressDelete({
						id
					});
					this.getList();
				}

			}
		}
	}
</script>

<style lang='scss'>
	page {
		padding-bottom: 220upx;
		padding-top: 1rpx;
		background-color: #F9F9F9;
	}

	.content {		
		position: relative;
		padding: 30rpx;
		padding-bottom: 220upx;
		min-height: 100vh;
	}

	.list {
		display: flex;
		flex-direction: column;
		/* align-items: center; */
		padding: 20upx 30upx;
		background: #fff;
		position: relative;
	}

	.wrapper {
		display: flex;
		flex-direction: column;
		flex: 1;
		padding-bottom: 40rpx;
	}

	.address-box {
		display: flex;
		align-items: center;
        margin-top: 20rpx;
		.tag {
			font-size: 24upx;
			margin-right: 10upx;
			background: #fffafb;
			border: 1px solid #ffb4c7;
			border-radius: 4upx;
			padding: 4upx 10upx;
			line-height: 1;
		}

		.address {
			font-size: 30upx;
		}
	}

	.u-box {
		font-size: 28upx;
		color: #666666;
		margin-top: 16upx;

		.name {
			margin-right: 30upx;
		}
	}

	.icon-bianji {
		width: 40upx;
		height: 40rpx;
	}

	.icon-lajitong {
		padding-left: 25rpx;
	}
	
	.add-btn {
		margin: 0  auto;
		display: flex;
		align-items: center;
		justify-content: center;
		width: 630rpx;
		height: 80rpx;
		background: #FACE51;
		border-radius: 40rpx 40rpx 40rpx 40rpx;
		font-size: 32upx;
		color: #fff;
	}
</style>