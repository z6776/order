<template>
	<view class="content">
		<view class="supermarket bg-fff radius-20">
			<view class="m-b-20 d-flex">
				<text class="fz-32 fz-333333 fz-weight m-r-10">商品信息</text>
				<text class="fz-28 fz-000000 m-r-10" v-if="info.subtype==2">配送到家</text>
				<text class="fz-28 fz-000000 m-r-10" v-if="info.subtype==1">堂食</text>
				<text class="fz-28 fz-000000 m-r-10" v-if="info.subtype==3">配送点自提</text>
			</view>
			<view class="m-b-30" v-for="(v,i) in info.products" :key="v.id">
				<view class="cart-item" :class="{'endclass':i==1}">
					<view class="image-wrapper m-l-20">
						<image :src="$util.getImgurl(v.image)" class="loaded" mode="aspectFill"></image>
					</view>
					<view class="item-right p-t-10 p-b-10">
						<text class="clamp fz-bold fz-28 fz-000000">{{ v.title || "" }}</text>
						<view class="d-flex f-start m-t-10 m-b-10">
							<text class="fz-28 basecolor">￥{{ orderpriceone(v) }}x{{ v.number || "1" }} </text>
							<text class="fz-24 basecolor">(另需打包费:￥{{ v.package_price || v.packing_price || "0" }}元)</text>
						</view>
						
						<view class="fz-28 basecolor m-b-10" v-if="v.spec || v.desc">
							{{ v.spec || "" }}{{v.desc || ""}}
						</view>
						
						
						
						<view class="d-flex">
							<text class="price fz-24 fz-000000 m-r-auto">商品金额￥{{orderpriceone(v)}}元 </text>
							<text class="fz-979797 fz-28 fz-weight">实付：</text>
							<text class="basecolor fz-28 fz-weight">￥{{  orderpricefn(v)}}</text>
						</view>
					</view>
				</view>
			</view>
			
			<view class="form bg-fff radius-20 p-30-20 d-c-start-flex m-t-30">
				<view class="formitem d-flex">
					<text class="fz-28 fz-weight basecolor">商品总额</text>
					<text class="fz-28  fz-000000">￥{{ info.total_price || "" }}元</text>
				</view>
				<view class="formitem d-flex">
					<text class="fz-28 fz-weight basecolor">优惠金额</text>
					<text class="fz-28  fz-000000">￥{{ info.discount_price || "" }}元</text>
				</view>
				<view class="formitem d-flex">
					<text class="fz-28 fz-weight basecolor">福豆抵扣金额</text>
					<text class="fz-28  fz-000000">￥{{ info.score_discount_price || "" }}元</text>
				</view>
				<view class="formitem d-flex">
					<text class="fz-28 fz-weight basecolor">配送费</text>
					<text class="fz-28  fz-000000">￥{{ info.delivery_price || "" }}元</text>
				</view>
				<view class="formitem d-flex">
					<text class="fz-28 fz-weight basecolor">打包费</text>
					<text class="fz-28  fz-000000">￥{{ info.packing_price || "" }}元</text>
				</view>
				<view class="formitem d-flex">
					<text class="fz-32 fz-weight fz-333333">合计支付</text>
					<text class="fz-32  fz-333333">￥{{ info.total_price|| "" }}元</text>
				</view>
			</view>
		</view>
		
		
		
		
				
		<view class="form bg-fff radius-20 p-30-20 d-c-start-flex m-t-30">
			<view class="formitem d-flex">
				<text class="fz-32 fz-weight fz-333333">配送信息</text>
			</view>
			<view class="formitem d-flex f-start">
				<image :src="$util.cdnurl('ztaddress.png')"  class="wh40 m-r-10" mode=""></image>
				<text class="fz-000000 fz-28 m-r-auto">自提点</text>
				<!-- 金东方海棠花园 - -->
				<text class="basecolor fz-28" v-if="info.village">{{ info.village.name || "" }}</text>
				<text class="basecolor fz-28" v-if="info.selfpcikup">{{ info.selfpcikup.name || "" }}</text>
			</view>
			
			<view class="formitem d-flex f-start" @click.stop="$util.makePhone(info.address.mobile)">
				<image  :src="$util.cdnurl('phone.png')"  class="wh40 m-r-10" mode=""></image>
				<text class="fz-000000 fz-28 m-r-auto">联系人</text>
				<text class="fz-28 basecolor m-r-20">{{ info.address.name || "" }}</text>
				<text class="fz-28 basecolor" v-if="info.address && info.address.mobile">{{ $util.hideMiddleFourOfPhoneNumber(info.address.mobile)  || "" }}</text>
			</view>
			
			<view class="d-flex f-start">
				<image :src="$util.cdnurl('ztclock.png')"   mode="" class="wh40 m-r-10"></image>
				<text class="m-r-auto fz-000000 fz-28">配送时间:</text>
				<text class="fz-28 basecolor">{{ $util.parseTime(info.getdate,"{y}-{m}-{d}") }}</text>
				<text class="fz-28 basecolor">{{ $util.isam(info.isam) }}</text>
			</view>
			
			<view class="d-flex f-start">
				<image  :src="$util.cdnurl('psicon.png')"   mode="" class="wh40 m-r-10"></image>
				<text class="m-r-auto fz-000000 fz-28">配送员:</text>
				<text class="fz-28 basecolor">{{ info.admin.username || "" }}</text>
				<text class="fz-28 basecolor" v-if="info.admin.mobile">（{{ info.admin.mobile  }}）</text>
			</view>
			
			<view class="basecolor breakword">
				<text>备注:</text>
				<text>{{  info.remark || "" }}</text>
			</view>
		</view>
		
		<view class="form bg-fff radius-20 p-30-20 d-c-start-flex m-t-30">
			<view class="formitem d-flex">
				<text class="fz-weight fz-32 fz-333333">订单信息</text>
			</view>
			<view class="formitem d-flex f-start" @click="$util.makeCopy(info.out_trade_no)">
				<text class="fz-494949 fz-28 m-r-auto">订单号:</text>
				<text class="fz-494949 fz-28 borderRight">{{ info.out_trade_no || "" }}</text>
				<view class="copy" >复制</view>
			</view>
			
			<view class="formitem d-flex f-start">
				<text class="m-r-auto  fz-333333">下单时间:</text>
				<text class="fzs">{{ info.createtime || "" }}</text>
			</view>
			
			<view class="formitem d-flex f-start">
				<text class="m-r-auto  fz-333333">支付时间:</text>
				<text class="fzs">{{ info.paidtime || "" }}</text>
			</view>
			<view class="formitem d-flex f-start">
				<text class="m-r-auto  fz-333333">取餐时间:</text>
				<text class="fzs">{{ $util.parseTime(info.getdate,"{y}-{m}-{d}") }}{{ $util.isam(info.isam) }}</text>
			</view>
		</view>
		
		<view class="form bg-fff radius-20 p-30-20 d-c-start-flex m-t-30">
			<view class="formitem d-flex">
				<text class="  fz-333333">转单信息</text>
			</view>
			<view class="formitem d-flex f-start">
				<text class="  fz-333333">申请时间:</text>
				<text class="">{{ $util.parseTime(dinfo.createtime,"{y}-{m}-{d} {h}:{i}") }}</text>
			</view>
			
			<view class="formitem d-flex f-start">
				<text class="fz-333333">申请原因:{{ dinfo.reason || "" }}</text>
			</view>
			
			<view class="formitem d-flex f-start">
				<text class="fz-333333">申请人:{{ dinfo.adminin.username || "" }}</text>
			</view>
			
			<view class="formitem d-flex f-start" v-if="dinfo.newAdminin">
				<text class="  fz-333333">申请转单给:</text>
				<text class="">{{ dinfo.newAdminin.username || "" }}({{ $util.hideMiddleFourOfPhoneNumber(dinfo.newAdminin.mobile) }})</text>
			</view>
			
		<!-- 	
			<view class="d-flex f-start" v-if="dinfo.new_admin_id">
				 <text class="fz-707070 fz-28 m-r-10">申请转单给:</text>
				 <text class="fz-000000">{{ $util.isNull(dinfo.new_admin_id,"username")  || "" }}</text>
			</view> -->
			
			<view class="formitem d-flex f-start">
				<text class="  fz-333333">审核时间:</text>
				<text class="">{{ $util.parseTime(dinfo.updatetime,"{y}-{m}-{d} {h}:{i}") }}</text>
			</view>
			<view class="formitem d-flex f-start">
				<text class="  fz-333333">审核结果:</text>
				<text class="">{{ $util.approveresult(dinfo.approveresult) }}</text>
			</view>
			
		</view>
		
		<block v-if="title=='未审核'">
			<view class="bfixed">
				<mybtn width="300rpx" height='60rpx' msg="驳回" @handclick="(e)=>refn(e,info)" />
				<mybtn width="300rpx" height='60rpx' msg="同意" @handclick="(e)=>open(e,info)" />
			</view>
		</block>
		
		<uni-popup ref="popup" type="center" background-color="#fff">
			<view class="p20 bg-fff radius-20 wh500">
				<view class="d-flex j-center fz-000000 fz-32 m-b-20">
					 指派
				</view>
				<view style="width: 300rpx;" class="border w-100">
					<!-- :keyId="1" -->
					<qiaoSelect showField="username"  :dataList="orgArray" phText="选择配送人员" phColor="#999999"  searchKey="username"
						:showObj="showObj"  :disabled="false" @change="selectChange"></qiaoSelect>
				</view>
				
				<mybtn msg="确认" @handclick="confirmzp" marginTop="100rpx" width="300rpx" height="60rpx"  />
			</view>
		</uni-popup>
		
		<uni-popup ref="popupreason" type="center" background-color="#fff">
				<view class="p20 bg-fff radius-20 w700">
					<view class="d-flex j-center fz-000000 fz-32 m-b-20">
						 驳回原因
					</view>
					<view class="d-flex f-start">
						<textarea placeholder="请输入驳回原因" v-model="reason" name="" id="" cols="30" rows="10"></textarea>
					</view>
					
					<mybtn msg="确认" @handclick="confirmreason" width="300rpx" height="60rpx" marginTop="30rpx" />
				</view>
			</uni-popup>
			
			


	</view>
</template>

<script>
	import qiaoSelect from "../../uni_modules/qiao-select/components/qiao-select/qiaoSelect.vue";
	import orderpop from "@/components/orderpop/index.vue";
	export default {
		components: {
			qiaoSelect,
			orderpop
		},
		data() {
			return {
				title:"",
				timestamp:86400,
				form: {},
				showApply: false,
				currentpop: 0,
				reason:"",
				showObj:{},
				orgArray:[],
				list:[],
				current: 0,
				did:"",
				mechId:"",
				status: "",
				src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				info:{},
				dinfo:{},
				zdid:{}
			}
		},
		onLoad(query) {
			this.title = query.title;
			uni.setNavigationBarTitle({
				title:query.title ||""
			});
			this.id = query.id;
			this.zdid = query.zdid;
			this.getdetail();
			// 转单信息详情
			this.getzddetail();
			this.getlist();
		},
		methods: {
			orderpriceone(v){
				if(this.info.activity_type=='seckill' || this.info.activity_type=='groupon'){
					 return v.activityProduct?.price;
				}
				return v?.price;
			},
			orderpricefn(v){
				let number = v.number ?  Number(v.number) :  1;
				if(this.info.activity_type=='seckill' || this.info.activity_type=='groupon'){
					 return (Number(v.activityProduct?.price) * number).toFixed(2);
				}
				return (Number(v?.price) * number).toFixed(2);
			},
			// 获取转单信息
			async getzddetail(){
				let data = await this.$u.api.getDeliveryInfo({
					id:this.zdid || "",// 	string	否	配送ID
				});
				this.dinfo = data;
				console.log(data,"datadatat");
			},
			// 驳回原因
			refn(e,item){
				this.$refs.popupreason.open();
				// deliveryorder_id:
			},
			// 驳回
			async confirmreason(){
				if(!this.reason){
					return this.$u.toast("请输入驳回原因");
				}
				let data = await this.$u.api.assignTool({
					new_admin_id:"",//	string	否	新配送员ID
					id:this.dinfo.id || "",//	string	否	转单申请id
					approveresult:"3",//	string	否	审核结果;1=审核中2=同意3=拒绝
					reject:this.reason || "" //	string	否	拒绝原因
				});
				this.$util.success("审核成功","back");
				console.log(data,"datadatat");
			},
			open(e,item){
				let index = this.orgArray.findIndex(v=>v.id==this.dinfo?.new_admin_id);
				if(index>-1){
					this.showObj = this.orgArray[index];
					this.mechId = this.orgArray[index].id;
				}
				this.did = item.id;
				this.$refs.popup.open();
			},
			async getlist(){
					// /api/delivery/getAdminList
				let data = await this.$u.api.getAdminList();
				if(data && data.length){
					this.orgArray = data.map(v=>{
						return {
							id:v.id,
							username:v.user?.username
						}
					});
				}
			},
			selectChange(e) {//返回选择的对象，如果输入框清空，返回null
				if (e) {
					this.mechId = e.id;
					// /api/delivery/assign
				} else {
					this.mechId = ''
				}
			},
			async confirmzp(item){
				uni.showLoading({
					mask:true
				})
				if(!this.mechId){
					return this.$u.toast("请选择配送员");
				}
				// new_admin_id	string	否	新配送员ID
				// id	string	否	转单申请id
				// approveresult	string	否	审核结果;1=审核中2=同意3=拒绝
				// reject	string	否	拒绝原因
				await this.$u.api.assignTool({
					new_admin_id:this.mechId,
					id:this.dinfo.id || "",
					approveresult:"2"
				});
				
				this.$refs.popup.close();
				this.$util.success("审核成功","back");
			},
			// 订单详情
			async getdetail(){
				let data = await this.$u.api.orderDetail({
					id:this.id
				});
				if(data.order_status_text=='配送中'){
					data.order_status_text='待取餐';
				}
				this.info = data;
			},
			// 点击按钮
			btnclick(e) {
				if (e == 3) {
					this.currentpop = e;
					this.showApply = true;
					return;
				}
				this.currentpop = e;
				this.cancelList[e].show = true;
			},
			// 确认时间
			confirm(e) {
				console.log("我的确认按钮");
				this.cancelList[this.currentpop].show = false;
				switch (this.currentpop) {
					case 2:
						uni.showToast({
							icon: "success",
							title: "申请成功"
						})
						break;
					case 3:
						this.showApply = false;
						break;
					default:
						break;
				}
			},
		}
	}
</script>

<style scoped lang="scss">
	.intform {
		width: 100%;
		border: 2rpx solid #999999;
		padding-left: 20rpx;
		border-radius: 20rpx;
		height: 80rpx;
		line-height: 80rpx;
		margin-top: 30rpx;
	}
	
	.w700{
		width: 700rpx;
		height: 500rpx;
	}
	
	.line32{
		line-height: 32rpx;
	}
	
	
	.borderRight{
			padding-right: 20rpx;
			position: relative;
			margin-right: 30rpx;
			&::after{
				content: "";
				position: absolute;
				width: 2rpx;
				height: 60%;
				top: 50%;
				transform: translateY(-50%);
				background-color: #979797;
				right: 0;
				bottom: 0;
			}
		}
	
	.wh150{
		width: 150rpx;
		height: 150rpx;
		margin-right: 30rpx;
	}
	
	.copy{
		flex-shrink: 0;
		width: fit-content;
		padding: 0 10rpx;
		height: 40rpx;
		text-align: center;
		// padding: 5rpx 20rpx;
		border-radius: 50rpx;
		// font-size: 28rpx;
		line-height: 40rpx;
		border: 1rpx solid #666666;
	}

	.getOther {
		width: fit-content;
		padding: 0 30rpx;
		color: #000000;
		text-align: center;
		margin-left: auto;
		border: 2rpx solid #666666;
		border-radius: 10rpx;
	}

	::v-deep.placeholderClass {
		color: #999999;
		font-size: 28rpx;
	}
	
	.wh500{
		width: 700rpx;
		height: 400rpx;
	}
	
	
	.bfixed{
			position: fixed;
			left: 0;
			right: 0;
			bottom: 0;
			min-height: 200rpx;
			background-color: #FFFFFF;
			display: flex;
			justify-content: space-around;
			align-items: center;
			z-index: 10;
	}

	.content {
		min-height: 100vh;
		padding: 30rpx 20rpx;
		// background: linear-gradient(to bottom, #4DD88D, #F9F9F9 300rpx);
		padding-bottom: calc(240rpx + env(safe-area-inset-bottom));
        padding-top: 20rpx;
		.form {
			line-height: 60rpx;
			padding-top: 15rpx;
			padding-bottom: 15rpx;
		}

		.wh46 {
			width: 46rpx;
			height: 46rpx;
		}

		.person {
			padding: 20rpx 30rpx 40rpx 20rpx;
		}

		.supermarket {
			padding: 30rpx 20rpx 30rpx 20rpx;

			.endclass {
				// border-bottom: 2rpx solid #F9F9F9;
				// padding-bottom: 30rpx;
			}

			.cart-item {
				display: flex;
				position: relative;
				align-items: center;

				.image-wrapper {
					width: 160upx;
					height: 160upx;
					flex-shrink: 0;
					position: relative;

					image {
						border-radius: 8upx;
					}
				}

				.checkbox {
					position: absolute;
					left: -16upx;
					top: -16upx;
					z-index: 8;
					font-size: 44upx;
					line-height: 1;
					padding: 4upx;
					background: #fff;
					border-radius: 50px;
				}

				.item-right {
					display: flex;
					flex-direction: column;
					flex: 1;
					overflow: hidden;
					position: relative;
					padding-left: 20upx;

					.title,
					.price {
						height: 40upx;
						line-height: 40upx;
					}

					.attr {
						font-weight: bold;
						font-size: 24rpx;
						color: #999999;
						height: 50upx;
						line-height: 50upx;
					}

					.price {
						height: 50upx;
						line-height: 50upx;
					}
				}

				.del-btn {
					padding: 4upx 10upx;
					font-size: 34upx;
					height: 50upx;
				}

				.invalid {
					position: absolute;
					right: 0;
					bottom: 0;
					background: #999999;
					color: #ffffff;
					padding: 6upx 12upx;
					border-radius: 10upx;
					font-size: 26upx;
					margin-right: 50upx;
					margin-bottom: 32upx;
				}
			}
		}
	}

	.btn {
		font-weight: 800;
		font-size: 28rpx;
		color: #FFFFFF;
		text-align: center;
		line-height: 80rpx;
		width: 300rpx;
		height: 80rpx;
		background: #4DD88D;
		border-radius: 40rpx 40rpx 40rpx 40rpx;
		margin-left: auto;
		margin-top: 40rpx;
		margin-right: 20rpx;
	}

	.button {
		height: 100rpx;
	}
</style>