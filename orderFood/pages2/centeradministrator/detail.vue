<template>
	<view class="content">
		<view class="p20 bg-fff radius-20 p-relative">
			<view class="fz-32 fz-000000 fz-bold">服务信息</view>
			<view class="d-flex a-start m-t-30 f-start">
				<image src="../../static/images/newStatic/location.png" class="wh40 m-r-10" mode=""></image>
				<view class="d-c-flex fz-28 fz-494949 fz-500 a-start">
					<text>{{ toJson(info.address_json).address+toJson(info.address_json).door_number || "" }}</text>
					<view class="">
						{{ toJson(info.address_json).name || "" }}-{{ toJson(info.address_json).mobile || "" }}
					</view>
				</view>
			</view>
			<view class="d-flex f-start m-t-10">
				<image src="../../static/images/newStatic/clock.png" class="wh40 m-r-10" mode=""></image>
				<text class="fz-28 fz-000000 fz-bold">{{ info.expecttime_text || "" }}</text>
			</view>
			<view class="tagnum" :style="[tagStyle()]" v-if="params.pagetype=='orderyl'">
				{{ info.order_status_text || "" }}
			</view>
		</view>

		<view class="m-t-20 p20 bg-fff radius-20 p-b-40 bgLinear">
			<view class="fz-32 fz-000000 fz-bold m-b-30">服务项目</view>
			<view class="h130 d-flex f-start">
				<image :src="$util.getImgurl($util.isNull(info.product,'coverimage'))" class="wh130 radius-20" mode="aspectFill"></image>
				<view class="h100 d-c-flex a-start m-l-20">
					<view class="fz-500 fz-32 fz-000000">
						{{ $util.isNull(info.product,"name") }}
					</view>
					<view class="fz-32 fz-ff0000 fz-bold">
						¥{{ $util.isNull(info.product,"price") }}/{{ $util.isNull(info.product,"unit") }}
					</view>
				</view>
			</view>
			<view class="p-b-30 borderbottom">

			</view>
			<view class="d-flex m-t-30">
				<text class="fz-28 fz-500" style="color: rgba(0,0,0,0.5);">商品总额</text>
				<text class="fz-28 fz-500 fz-000000">{{ $util.isNull(info.product,"price") || "暂无"  }} </text>
			</view>
			
			<view class="form-item d-flex m-t-20" @click="goCoupon()" v-if="info.order_status_text=='待支付'">
				 <view class="label fz-707070 fz-28 fz-weight m-r-100 fs-0">优惠券</view>
					 <view class="d-flex f-start">
						 <text>{{ coupon.title || "请选择优惠券" }}</text>
						 <u-icon name="arrow-right" size="28" color="#000000" v-if="!coupon.title"></u-icon>
						 <view class="m-l-20" v-else @click.stop="delCoupon()">
							 <u-icon name="close" size="28" color="#000000" v-if="coupon.title" ></u-icon>
						 </view>
					 </view>
			</view>
			<view class="d-flex m-t-20" v-if="coupon.id">
				<text class="fz-28 fz-500" style="color: rgba(0,0,0,0.5);">优惠金额</text>
				<text class="fz-28 fz-500 fz-000000">{{ coupon.discount_price || "" }}</text>
			</view>
			<view class="d-flex m-t-20">
				<text class="fz-28 fz-500" style="color: rgba(0,0,0,0.5);">缴纳保证金金额</text>
				<text class="fz-28 fz-500 fz-000000">¥{{ info.deposit_price || "" }}</text>
			</view>
			<view class="d-flex m-t-20">
				<text class="fz-32 fz-bold fz-000000">合计支付</text>
				<text class="fz-32 fz-bold fz-ff0000">{{ coupon.totalprice || info.totalprice || "暂无" }}</text>
			</view>
		</view>

		<view class="m-t-20 p20 bg-fff radius-20 p-b-40 p-relative" v-if="params.pagetype!='service' && info.staff_user">
			<view class="fz-32 fz-000000 fz-bold m-b-30">服务人员</view>
			<view class="h140 d-flex f-start">
				<image :src="$util.getImgurl($util.isNull(info.staff_user,'avatar'))" class="wh140 b50" mode="aspectFill"></image>
				<view class="h100 d-c-flex a-start m-l-20">
					<view class="fz-500 fz-32 fz-000000">
						{{ $util.isNull(info.staff_user,'username')  }}
						<!-- ({{ $util.hideMiddleFourOfPhoneNumber($util.isNull(item.staff_user,'mobile')) }}) -->
					</view>
					<view class="fz-32 fz-ff0000 fz-bold">
						<text class="fz-32 fz-707070 fz-500">累计服务单数：</text>
						<text class="fz-32 fz-000000 fz-500">{{ info.staff_total || "" }}单</text>
					</view>
				</view>
			</view>
			<view class="statusbtn" v-if="info.status && info.status >= 4">
				已出发
			</view>
		</view>

		<view class="m-t-20 p20 bg-fff radius-20 p-b-40">
			<view class="fz-32 fz-000000 fz-bold m-b-30">订单信息</view>
			<view class="d-flex m-t-30">
				<text class="fz-28 fz-500 m-r-auto" style="color: rgba(0,0,0,0.5);">订单号：</text>
				<text class="fz-28 fz-500 fz-000000 borderRight">{{ info.out_trade_no }}</text>
				<text class="fz-28 fz-000000 fz-500 m-l-10" @click.stop="$util.makeCopy(info.out_trade_no)">复制</text>
			</view>
			<view class="d-flex m-t-20">
				<text class="fz-28 fz-500" style="color: rgba(0,0,0,0.5);">下单时间：</text>
				<text
					class="fz-28 fz-500 fz-000000">{{ $util.parseTime(info.createtime,"{y}-{m}-{d} {h}:{i}:{s}")  }}</text>
			</view>
			<view class="d-flex m-t-20">
				<text class="fz-28 fz-500" style="color: rgba(0,0,0,0.5);">缴纳保证金金额：</text>
				<text class="fz-28 fz-500 fz-000000">¥{{ info.deposit_price || "" }}</text>
			</view>
			<view class="d-flex m-t-20" v-if="info.gotime_text">
				<text class="fz-28 fz-500" style="color: rgba(0,0,0,0.5);">出发时间：</text>
				<text class="fz-28 fz-500 fz-000000">{{ info.gotime_text || "" }}</text>
			</view>
			<view class="d-flex m-t-20" v-if="info.finishtime_text">
				<text class="fz-28 fz-500" style="color: rgba(0,0,0,0.5);">服务完成时间：</text>
				<text class="fz-28 fz-500 fz-000000">{{ info.finishtime_text }}</text>
			</view>
		</view>
		
		<view class="m-t-20 p20 bg-fff radius-20 p-b-40 p-relative" v-if="evalute.id">
			<view class="fz-32 fz-000000 fz-bold m-b-30">评价信息</view>
			<view class="d-flex f-start">
				<text class="fz-28 fz-500 m-r-10" style="color: rgba(0,0,0,0.5);">评分</text>
				<view class="m-r-auto">
					<u-icon name="star-fill" class="m-r-10" color="#F2CB51" size="32" v-for="(item,i) in Number(evalute.score)"
						:key="i"></u-icon>
					<u-icon name="star-fill" class="m-r-10" color="#979797" size="32" v-for="(item,i) in 5-Number(evalute.score)"
						:key="i"></u-icon>
				</view>
			</view>
			<view class="fz-000000 fz-28 fz-bold m-t-10 m-b-10">
				{{ evalute.pjtxt || "" }}
			</view>
			<image :src="$util.getImgurl(item)" class="wh150 m-r-10 radius-20" mode="" v-for="(item,index) in $util.toarr(evalute.pjimages)" :key="index"  @click.stop="$util.lookimgarr(index,evalute.pjimages)"></image>
		</view>


		<view class="boxFixed bgt">
			<!-- params.pagetype=='service' ? 服务人员详情 :  params.pagetype=='orderyl'  ? "养老订单详情" : 中心管理员详情 -->

			<block v-if="params.pagetype=='service'">
				<block v-if="params.title=='待服务'">
					<mybtn msg="我已出发" @handclick="(e)=>cancelfn(1)" />
				</block>
				<block v-if="params.title=='已出发'">
					<view class="serviceing" @click.stop="sering">
						服务未进行
					</view>
					<view class="w20">

					</view>
					<view class="finish" @click.stop="show=true">
						完成服务
					</view>
				</block>
			</block>

			<block v-if="params.pagetype=='orderyl'">
				<block v-if="params.status=='已取消'">
					<mybtn msg="删除订单" @handclick="(e)=>cancelfn(2)" />
				</block>
				<block v-if="info.order_status_text=='待评价'">
					<mybtn msg="去评价" @handclick="pjfn" />
				</block>
				<block v-if="info.order_status_text=='待支付'">
					<mybtn msg="立即支付" @handclick="waitPay" />
				</block>
				
				<block v-if="info.status=='2' || info.status=='3' || info.status=='4'">
					<mybtn msg="取消订单" @handclick="(e)=>cancelfn(0,'istk')" />
				</block>
				
				<block v-if="params.status=='待预约'">
					<view class="cancelbtn" @click.stop="(e)=>cancelfn(0)">
						取消订单
					</view>
					<view class="w20">

					</view>
					<view class="finish" @click.stop="(e)=>contiuted(info)" v-if="$util.isShowcon(info)">
						继续支付
					</view>
				</block>
			</block>
			
			<block v-if="params.pagetype=='中心管理员' && info.order_status_text=='待指派'">
				<mybtn msg="立即指派" @handclick="open()" />
			</block>

		</view>
		
		<uni-popup ref="popup" type="center" background-color="#fff">
			<view class="p20 bg-fff radius-20 wh500">
				<view class="d-flex j-center fz-000000 fz-32 m-b-20">
					指派
				</view>
				<view style="width: 300rpx;" class="border w-100">
					<!-- :keyId="1" -->
					<qiaoSelect showField="username" :dataList="orgArray" phText="选择服务人员" phColor="#999999"
						searchKey="username" :showObj="showObj" :disabled="false" @change="selectChange"></qiaoSelect>
				</view>
		
		
				<mybtn msg="确认" @handclick="confirmzp" marginTop="100rpx" width="300rpx" height="60rpx" />
			</view>
		</uni-popup>
		

		<u-modal showCancelButton v-model="show" ref="umodal" title="完成服务" @cancel="show=false" :async-close="true" @confirm="finishservise"
			@close="show=false" :closeOnClickOverlay="true" confirmColor="#4cd964" cancelColor="#999999">
			<template>
				<view class="slot-content w100">
					<view class="d-flex j-center m-t-30 m-b-30">
						<input type="text" placeholder="请输入" v-model="unitnum" style="text-align: right;width: 150rpx;" />
						<text class="fz-28 fz-000000 m-l-30">次</text>
					</view>
				</view>
			</template>
		</u-modal>
		<orderpop :show.sync="cancelList[currentpop]['show']" :content="cancelList[currentpop]['msg']" @confirm="cffn" :isShowSlot="false"></orderpop>
	</view>
</template>
<script>
	import orderpop from "@/components/orderpop/index.vue";
	import qiaoSelect from "../../uni_modules/qiao-select/components/qiao-select/qiaoSelect.vue";
	import { mapState } from "vuex";
	export default {
		components: {
			qiaoSelect,
			orderpop
		},
		data() {
			return {
				coupon:{},
				orgArray:[],
				showObj:{},
				currentpop: 0,
				istk:"",
				cancelList: [{
					msg: "确认取消?",
					show: false
				}, {
					msg: "确认开始本次订单?",
					show: false
				}, {
					msg: "确认删除该订单",
					show: false
				}, {
					msg: "上传单号",
					show: false
				}],
				list: [{
					order_status_text: "待预约",
					color: "#FB7A35",
					backgroundColor: "#FEE8C7"
				}, {
					order_status_text: "待服务",
					color: "#FB7A35",
					backgroundColor: "#FEE8C7"
				}, {
					order_status_text: "待支付",
					color: "#FB7A35",
					backgroundColor: "#FEE8C7"
				}, {
					order_status_text: "待评价",
					color: "#FB7A35",
					backgroundColor: "#FEE8C7"
				}, {
					order_status_text: "已完成",
					color: "#494949",
					backgroundColor: "#4cd964"
				}, {
					order_status_text: "已取消",
					color: "#494949",
					backgroundColor: "#D9D9D9"
				}],
				show: false,
				src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				params: {},
				info: {},
				mechId:"",
				did:"",
				unitnum:"",
				evalute:{}  // 评价
			}
		},
		computed:{
			...mapState(["position"])
		},
		onLoad(query) {
			this.params = query;
			uni.setNavigationBarTitle({
				title: query.title
			});
		},
		onShow() {
				this.getdetail();
				this.sumtotal();
			uni.removeStorageSync("order");
		},
		methods: {
			contiuted(item){
				const { createtime,out_trade_no_d,total_price=item.deposit_price } = item;
				uni.setStorageSync("order", { createtime,out_trade_no_d,total_price});
				this.$util.navTo('/pages2/money/pay?type=yl&pagetype=contiute');
			},
			async sumtotal(type=1){
				if(this.coupon.id){
					let r = await this.$u.api.couponUsage({
						order_id: this.params?.id,//	string	是	id
						coupon_id:this.coupon.id,//	integer	是	优惠券id
						type
					});
					if(type==2){
							this.coupon = {};
					}else{
						this.coupon = {
							...this.coupon,
							...r
						}
					}
					console.log(r,"rrrrr");
				}
			},
			delCoupon(){
				this.coupon = {};
				this.getdetail();
			},
			// 获取优惠券
			goCoupon(){
				 this.$u.route({
					 url:"/pages/components/pages/balance/coupon",
					 params: {
					   type:'getcoupon',
					   status:4
					 }
				 })
			},
			// 发起评价
			pjfn(){
				uni.setStorageSync("evaluate", {...this.info?.product,number:this.info?.number });
				this.$util.navTo('/pages2/order/evaluateyl?id=' +  this.params?.id);
			},
			waitPay(){
				this.sumtotal(2);
			
					const { createtime,out_trade_no,total_price=this.coupon?.totalprice || this.info?.totalprice || "" } = this.info;
					uni.setStorageSync("order", { createtime,out_trade_no,total_price});
					
					this.$util.navTo('/pages2/money/pay?type=yl&pagetype=contiute&timeno=yes');
			},
			async finishservise(e){
							 if(!this.unitnum){
								 	this.$refs.umodal.clearLoading();
								 return this.$u.toast("请输入服务次数");
							 }
							 try{
							 	let r = await this.$u.api.ylpeoplecomplete({
							 		id:this.params?.id,//	string	是	订单id
							 		number:this.unitnum  //	string	是	数量
							 	});
							 	 this.$util.success("已完成","back");
							 }catch(e){
							 	//TODO handle the exception
									 this.$refs.umodal.clearLoading();
							 }
			},
			open(){
				this.getlistfw(this.info.category_id);
				this.did = this.info.id;
				this.$refs.popup.open();
			},
			async getlistfw(category_id){
				let data = await this.$u.api.ylcoregetAdminList({
					category_id
				});
				if (data && data.length) {
					this.orgArray = data.map(v => {
						return {
							id: v.id,
							username: v.username
						}
					});
				}
			},
			selectChange(e){ //返回选择的对象，如果输入框清空，返回null
				if (e) {
					this.mechId = e.id;
					// /api/delivery/assign
				} else {
					this.mechId = ''
				}
			},
			async confirmzp() {
				if(!this.mechId){
					return this.$u.toast("请选择人员!");
				}
				uni.showLoading({
			      mask:true
				})
				await this.$u.api.ylcorecomplete({
					id: this.did || "",
					staff_user_id: this.mechId || ""
				});
				this.$refs.popup.close();
				this.$util.success("指派成功","back");
				
			},
			
			async getdetail() {
				// 
				let { data } = await this.$u.api.yanglaomyEvaluate({
					order_id: this.params?.id
				});
				
				console.log(data,"$util.$util.$util.");
				if(data && data.length){
					this.evalute = data[0];
				}
				switch (this.params.pagetype) {
					case '中心管理员':
						let _d = await this.$u.api.ylcoredetail({
							id: this.params?.id
						});
						console.log(_d, "addressaddress");
						this.info = _d;
						break;
					case 'orderyl':
						let info = await this.$u.api.ylorderdetail({
							id: this.params?.id
						});
						console.log(info, "addressaddress");
						this.info = info;
						break;
					case 'service':
						let _u = await this.$u.api.ylpeopledetail({
							id: this.params?.id
						});
						console.log(_u, "addressaddress");
						this.info = _u;
						break;
					default:
						break;
				}

			},
			toJson(str) {
				if (!str || !(typeof str == 'string')) {
					return {}
				}
				return JSON.parse(str);
			},
			// 确认时间
			async cffn(e) {
				console.log("我的确认按钮");
				this.cancelList[this.currentpop].show = false;
				switch (this.currentpop) {
					case 0:
					let r = await this.$u.api.ylordercancelOrder({
						id: this.params?.id || "",
						type:this.istk  ? "2" : "1"
					});
					this.$util.success("取消成功", "back");
						break;
					case 1:
					let a = await this.$u.api.goto({
						id: this.params?.id || ""
					});
						this.$util.success("已出发", "back");
						break;
					case 2:
						let d = await this.$u.api.ylorderdestroyOrder({
							order_id: this.params?.id || ""
						});
						this.$util.success("删除成功", "back");
						break;
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
			// 取消订单
			cancelfn(e,type='') {
				if(!this.position.mobile && e==1){
						 this.$util.xhmodal("请完善手机号后重试").then(res=>{
							  this.$util.navTo("/pages/components/pages/mine/userinfo")
						 })
						 return
				};
				if(this.info.status >= 4){
					 this.cancelList[0]['msg'] = "是否确认取消该订单，服务人员已出发，取消订单会扣除您一定的保证金"
				}
				this.istk = type;
				this.currentpop = e;
				this.cancelList[e].show = true;
			},
			tagStyle() {
				let index = this.list.findIndex(v => v.order_status_text == this.info.order_status_text);
				return index > -1 ? {
					'color': this.list[index].color,
					'backgroundColor': this.list[index].backgroundColor
				} : {};
			},
			// 服务未进行
			sering() {
				this.$util.navTo('/pages2/service/noservice?id='+this.params?.id);
			},
			confirm() {

			}

		}
	}
</script>

<style scoped lang="scss">
	.w20 {
		width: 20rpx;
	}

	.tagnum {
		top: 0;
		right: 0;
		position: absolute;
		width: 120rpx;
		height: 60rpx;
		border-radius: 0rpx 20rpx 0rpx 20rpx;
		font-weight: 500;
		font-size: 32rpx;
		text-align: center;
		line-height: 60rpx;
		text-align: center;
		line-height: 60rpx;
	}

	.content {
		min-height: 100vh;
		background-color: #FAFAFA;
		padding: 32rpx 20rpx 20rpx 20rpx;
		padding-bottom: 220rpx;
	}

	.finish {
		width: 347rpx;
		height: 80rpx;
		background: #FACE51;
		border-radius: 100rpx 100rpx 100rpx 100rpx;
		border: 2rpx solid #FACE51;
		text-align: center;
		line-height: 80rpx;
		font-weight: 500;
		font-size: 32rpx;
		color: #000000;
	}

	.cancelbtn {
		width: 347rpx;
		height: 80rpx;
		background: #FFFFFF;
		border-radius: 100rpx 100rpx 100rpx 100rpx;
		border: 2rpx solid #979797;
		font-weight: 500;
		font-size: 32rpx;
		color: #000000;
		text-align: center;
		line-height: 80rpx;
	}

.wh500{
		width: 700rpx;
		height: 400rpx;
	}
	.serviceing {
		width: 347rpx;
		height: 80rpx;
		background: #FFFFFF;
		border-radius: 100rpx 100rpx 100rpx 100rpx;
		border: 2rpx solid #FACE51;
		text-align: center;
		line-height: 80rpx;
		font-weight: 500;
		font-size: 32rpx;
		color: #FACE51;
	}

	.wh150 {
		width: 150rpx;
		height: 150rpx;
	}

	.statusbtn {
		right: 0;
		top: 70rpx;
		position: absolute;
		width: 120rpx;
		height: 60rpx;
		border-radius: 90rpx 0 0 90rpx;
		font-weight: 800;
		font-size: 32rpx;
		color: #FB7A35;
		text-align: center;
		line-height: 60rpx;
		background-color: #FCE7D1;
	}

	.borderRight {
		padding-right: 20rpx;
		position: relative;
		margin-right: 10rpx;

		&::after {
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

	.bgLinear {
		background: linear-gradient(180deg, #FEE8C7 0%, #FFFFFF 40%);
	}

	.p-b-40 {
		padding-bottom: 40rpx !important;
	}

	.h140 {
		height: 140rpx;

		.wh140 {
			width: 140rpx;
			height: 140rpx;
		}
	}

	.h130 {
		height: 130rpx;

		.wh130 {
			width: 130rpx;
			height: 130rpx;
		}
	}
</style>