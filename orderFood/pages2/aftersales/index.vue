<template>
	<view class="container">
		<view class="radius-20 bg-fff m-b-20">
			<view class="list-cell b-b m-t radius-20" @click="show = true" hover-class="cell-hover"
				:hover-stay-time="50">
				<text class="cell-tit m-r-auto">
					<text>货物状态</text>
					<text class="fz-FF2727">*</text>
				</text>
				<text v-if="status.label" class="fz-28 basecolor">{{ status.label }}</text>
				<u-icon name="arrow-right" color="#666666" size="28"></u-icon>
			</view>

			<view class="list-cell b-b m-t" hover-class="cell-hover" :hover-stay-time="50" @click="rshow=true">
				<text class="cell-tit m-r-auto">
					<text><text>退款原因</text></text>
					<text class="fz-FF2727">*</text>
				</text>
				<text v-if="reason.label" class="fz-28 basecolor">{{ reason.label }}</text>
				<u-icon name="arrow-right" color="#666666" size="28"></u-icon>
			</view>
			<view class="d-c-flex m-t a-start p20 p-t-0" hover-class="cell-hover" :hover-stay-time="50" >
				<view class="cell-tit">
					<text>退款金额</text>
					<text>*</text>
				</view>
				<view class="fz-32 fz-FF2525 m-t-10 m-b-10">
					￥ {{ total }}
				</view>
				<view class="fz-24 fz-666666">
					不可修改
				</view>
			</view>
		</view>

		<view class="radius-20 bg-fff p20">
			<view class="">
				补充描述和凭证
			</view>
			<textarea v-model="content" class="bgareas radius-20 m-t-20" placeholder="补充描述有助于商家处理售后问题~"
				height="260rpx"></textarea>
			<view class="m-t-30 m-b-30 d-flex f-start">
				<u-upload :show-progress="false" ref="uUpload" :action="action" :file-list="fileList"></u-upload>
			</view>
		</view>

		<view class="list-cell log-out-btn" @click="toLogout" v-if="false">
			<text class="cell-tit">退出登录</text>
		</view>

		<view class="boxFixed">
			<mybtn msg="提交" @handclick="submit" />
		</view>

		<u-select v-model="show" :list="list" @confirm="confirm"></u-select>


		<u-select v-model="rshow" :list="rlist" @confirm="rconfirm"></u-select>

<u-toast ref="uToast" />
		
	</view>
</template>

<script>
	import {
		mapMutations
	} from 'vuex';
	import {
		baseUrl
	} from "@/common/const.js";
	export default {
		data() {
			return {
				content:"",
				rshow: false,
				reason: {},
				status: {},
				action: baseUrl + "/api/common/upload",
				show: false,
				rlist: [{
						value: '1',
						label: '不想要了'
					},
					{
						value: '2',
						label: '商品与实物不符'
					},
					{
						value: '3',
						label: '其他原因'
					}
				],
				list: [{
						value: '1',
						label: '未收到货'
					},
					{
						value: '2',
						label: '已收到货'
					}
				],
				price: "",
				value3: "",
				fileList: [],
				action: baseUrl + "/api/common/upload",
				id: "",
				product_id:"",
				pagetype:"",
				total:""
			};
		},
		onLoad(query) {
			this.id = query.id;
			this.price = query.price;
			this.product_id = query.product_id;
			this.pagetype = query.pagetype;
			this.sumtotal();
		},
		methods: {
			...mapMutations(['logout']),
			async sumtotal(){
				let data = await this.$u.api.shcalculation({
					order_id:this.id || "", //	string	否	订单id
					product_id:this.product_id || "" //	integer	否	商品id
				});
				this.total = data;
			},
			rconfirm(e) {
				this.reason = e[0];
				console.log(e, "eeeeee");
			},
			// 
			confirm(e) {
				this.status = e[0];
				console.log(e, "eeeeee");
			},
			async submit() {
				uni.showLoading({
					mask:true
				});
				let form = {
					dispatch_status: this.status?.value || "", //	integer	否	发货状态;1=未收到货2=已收到货
					reason: this.reason?.label || "", //	string	否	退款原因
					contentfiles: "", //	string	否	凭证
					content: this.content || "", //	string	否	相关描述
					order_id: this.id || "", //	integer	否	订单id
					product_id:this.product_id || "" //	integer	否	商品id
				}
				let files = [];
				if(!this.status?.value){
					return this.$u.toast("请选择货物状态");
				}
				if(!this.reason?.label){
					return this.$u.toast("请选择退款原因");
				}
				// 通过filter，筛选出上传进度为100的文件(因为某些上传失败的文件，进度值不为100，这个是可选的操作)
				for (let i = 0; i < this.$refs.uUpload.lists.length; i++) {
					  let item = this.$refs.uUpload.lists[i];
					  if(item.progress == 100){
						  files.push(item.response?.data?.url)
					  }
				};
				if(files.length){
					form.contentfiles = files.join(",");
				};
				if(this.pagetype=='xs'){
					let res = await this.$u.api.aftersaleAll(form);
				}else{
				    let res = await this.$u.api.addAftersale(form);	
				}
				// this.$refs.uToast.show({
				// 	title: '申请成功'
				// });
				this.$util.success("申请成功",'back');
				return;
				uni.navigateTo({
					url: "/pages2/submitSuccess/index"
				})
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
		padding: 20rpx;
		box-sizing: border-box;
	}

	.container {
		padding-bottom: 220rpx;
	}

	.bgareas {
		width: 100%;

		padding: 20rpx;

		background-color: #f6f6f6;
	}

	.list-cell {
		display: flex;
		align-items: baseline;
		padding: 20upx 20rpx;
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
			align-self: baseline;
			margin-left: 10upx;
		}

		.cell-tit {
			flex: 1;
			margin-right: 10upx;
		}

		.cell-tip {}

		switch {
			transform: translateX(16upx) scale(.84);
		}
	}
</style>