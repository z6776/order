<template>
	<view class="container">
		<view class="form-box">
			<view class="form">
				<list-cell :hover="false">
					<view class="form-input">
						<view class="label">姓名</view>
						<input class="input" placeholder="请输入收货人" v-model="form.name" placeholder-class="text-color-assist" />
					</view>
				</list-cell>
				<!-- <list-cell :hover="false">
					<view class="form-input">
						<view class="label">性别</view>
						<view class="radio-group">
							<view class="radio" :class="{'checked': !form.sex}" style="margin-right: 10rpx;" @tap="form.sex=0">先生</view>
							<view class="radio" :class="{'checked': form.sex}" @tap="form.sex=1">女士</view>
						</view>
					</view>
				</list-cell> -->
				<list-cell :hover="false">
					<view class="form-input">
						<view class="label">联系电话</view>
						<input class="input" placeholder="请输入收货人联系方式" v-model="form.mobile" placeholder-class="text-color-assist" />
					</view>
				</list-cell>
				<list-cell :hover="false">
					<view class="form-input">
						<view class="label">所在小区</view>
						<view class="input" @click="chooseLocation">{{form.address ? form.address : '请选择所在小区'}}</view>
						<u-icon name="arrow-right" size="32" color="#000000"></u-icon>
					</view>
				</list-cell>
				<list-cell :hover="false">
					<view class="form-input">
						<view class="label">详细地址</view>
						<input class="input" placeholder="请输入楼号,门牌号" v-model="form.door_number" placeholder-class="text-color-assist" />
					</view>
				</list-cell>
			</view>
			<view class="default-row d-flex f-start m-t-30" @click="switchChange">
					<radio :checked="form.isdefaults==1" color="#FACE51" style="transform: scale(.7);"/>
			     	<text class="tit fz-333333 fz-weight fz-28 m-l-10">设为默认地址</text>
			</view>
			
			<view class="btn-section">
				<button type="primary" size="default" @tap="save">保存</button>
			</view>
			
		</view>
	</view>
</template>

<script>
	import listCell from '@/components/list-cell/list-cell'
    import { mapState } from "vuex";
	export default {
		components: {
			listCell
		},
		data() {
			return {
				address_id:"",
				form: {
					isdefaults:"2",
					name: '',
					sex: 0,
					mobile: '',
					address: '',
					door_number: '',
					lat: '',
					lng: ''
				}
			}
		},
		async onLoad({
			id,type
		}) {
			uni.setNavigationBarTitle({
				title:type=='add' ? '添加收货地址' : "编辑收货地址"
			});
			if(type=='edit'){
				this.getDetail(id);
			}
		},
		methods: {
			// 获取小区地址
			async getDetail(id){
				let data = await this.$u.api.getAddressInfo({id});
				this.form = data;
				this.address_id = data.village_id;
			},
			//默认地址
			switchChange() {
				if(this.form.isdefaults==1){
					this.form.isdefaults=2
				}else{
					this.form.isdefaults=1
				}
				this.$forceUpdate()
			},
			// 
			async save(){
				let data = {};
				if(!this.form.lat){
					return this.$u.toast("请选择所在小区");
				}
				uni.showLoading({
					
				});
				this.form.village_id = this.address_id;
				
				if (this.form.hasOwnProperty('id')) {
					
					data = await this.$u.api.addressEdit(this.form);
				} else {
					data = await this.$u.api.addressAdd(this.form);
				}
				if (data) {
					setTimeout(function(){
						uni.navigateBack()
					}, 2000);
				}
			},
			async chooseLocation() {
				let id = this.address_id ? this.address_id :"";
				this.$util.navTo('/pages/index/choosecommunity?type=address&id='+id);
				return;
				let [error, res] = await uni.chooseLocation();
				if (res) {
					this.form.address = res.address + ' ' + res.name;
					this.form.lat = res.latitude;
					this.form.lng = res.longitude;
					// console.log('位置名称：' + res.name);
					// console.log('详细地址：' + res.address);
					// console.log('纬度：' + res.latitude);
					// console.log('经度：' + res.longitude);
				}
			}
		}
	}
</script>

<style lang="scss" scoped>
	.form-box {
		width: 100%;
		height: 100%;
		padding: 30rpx;
		display: flex;
		flex-direction: column;
		color: $text-color-base;

		.form-input {
			display: flex;
			align-items: center;
			width: 100%;
		}

		.label {
			width: 200rpx;
			font-size: $font-size-lg;
			color: $text-color-base;
			font-weight: 500;
		}

		.input {
			flex: 1;
			display: flex;
			align-items: center;
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

		.btn-section {
			flex: 1;
			display: flex;
			align-items: center;
			justify-content: center;
			button {
				background-color: #FACE51;
				font-size: $font-size-base;
				height: 90rpx;
				border-radius: 50rem !important;
				width: 85%;
				display: flex;
				align-items: center;
				justify-content: center;
			}
		}
	}
</style>
