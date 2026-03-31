<template>
	<view class="pagebox">
		<view class="d-flex f-warp">
			<view class="item wh48 d-c-flex bg-FACE51 j-center radius-20 m-b-20 p-relative">
				<text>{{ info.totalOrder || "0" }}</text>
				<text class="m-t-10">累计订单</text>
				<image :src="$util.cdnurl('sumtabbg.png')" class="bgtab" mode=""></image>
			</view>
			<view class="item wh48 d-c-flex bg-FACE51 j-center radius-20 m-b-20 p-relative">
				<text>{{ info.totalMoney || "0" }}</text>
				<text class="m-t-10">累计销售额</text>
				<image :src="$util.cdnurl('sumtabbg.png')" class="bgtab" mode=""></image>
			</view>
			<view class="item wh48 d-c-flex bg-FACE51 j-center radius-20 m-b-20 p-relative">
				<text>{{ info.dayOrder || "0" }}</text>
				<text class="m-t-10">今日订单</text>
				<image :src="$util.cdnurl('sumtabbg.png')" class="bgtab" mode=""></image>
			</view>

			<view class="item wh48 d-c-flex bg-FACE51 j-center radius-20 m-b-20 p-relative">
				<text>{{ info.dayMoney || "0" }}</text>
				<text class="m-t-10">今日销售额</text>
				<image :src="$util.cdnurl('sumtabbg.png')" class="bgtab" mode=""></image>
			</view>
		</view>
		<!-- 时间范围选择 -->
		<!--  -->



		<view class="d-flex m-t-10 m-b-10">
			<view class="m-t-20 d-flex f-warp">
				<view class="w347">
					<selectDate msg="请选择开始日期" :time.sync="startTime" @init="initList" />
				</view>
				<view class="w347">
					<selectDate msg="请选择结束日期" :time.sync="endTime" @init="initList" />
				</view>
			</view>
		</view>
		<view class="">
			<view class="m-b-10">
				<xqaddress :msg.sync="qcd" align="left" @init="initList" :timevalue.sync="selfpcikup_id"
					defaultmsg="请选择社区" />
			</view>
			<view class="m-b-10">
				<qcaddress :msg.sync="xqd" align="left" @init="initList" :timevalue.sync="valiage_id"
					defaultmsg="请选择小区" />
			</view>
			<view class="m-t-10 m-b-10">
				<selectcom :msg.sync="psmsg" :list="orderstatus" align="right" @init="initList"
					:timevalue.sync="ordervalue" defaultmsg="订单状态" />
			</view>
		</view>

		<!-- <searchdropdown /> -->
		<!-- 列表项 -->
		<mescroll-body @init="mescrollInit" @down="downCallback" @up="upCallback">

			<view class="p20 m-b-30 bg-fff radius-20 p-relative" v-for="(item,index) in list" @click="goPage(item)" :key="item.id">
				<view class="d-flex f-start m-b-20">
					<text class="fz-500 fz-28 fz-000000">订单编号：</text>
					<text class="m-r-auto fz-500 fz-28 fz-000000">{{ item.out_trade_no || "" }}</text>
				</view>

				<view class="h130 d-flex f-start m-b-24">
					<image :src="$util.getImgurl($util.isNull(item.product,'coverimage'))" class="wh130 radius-20 fs-0" mode="aspectFill">
					</image>
					<view class="h100 d-c-flex a-start m-l-20 w-100">
						<view class="fz-500 fz-32 fz-000000">
							{{ $util.isNull(item.product,"name") }}
						</view>
						<view class="fz-28 fz-500 fz-707070">
							{{ item.expecttime_text || ""  }}
						</view>
						<view class="d-flex f-start w-100">
							<text class="fz-494949">¥{{ $util.isNull(item.product,"price") }}</text>
							<text class="fz-24 fz-999999 m-r-auto">/{{ $util.isNull(item.product,"unit") }}</text>
							<block v-if="item.number">
								<text class="fz-ff0000 fz-28 fz-32">{{Number(item.number) }}{{$util.isNull(item.product,"unit")}}</text>
								<text class="fz-ff0000 fz-28 fz-32">-</text>
								<text class="fz-ff0000 fz-28 fz-32">￥{{item.totalprice || ""}}</text>
							</block>
						</view>
					</view>
				</view>

				<view class="d-flex f-start m-b-10">
					<text class="fz-707070 fz-28">姓名:</text>
					<text class="m-r-auto fz-000000 fz-28">
						{{ $util.toJson(item.address_json).name }}({{ $util.hideMiddleFourOfPhoneNumber($util.toJson(item.address_json).mobile) }})
					</text>
					<image :src="$util.cdnurl('phoneicon.png')" @click.stop="$util.makePhone($util.toJson(item.address_json).mobile)" class="wh40" mode="">
					</image>
				</view>
				<view class="d-flex f-start m-b-10">
					<text class="fz-707070 fz-28 m-r-10">服务地址:</text>
					<text class="fz-000000 fz-28">{{ $util.toJson(item.address_json).address+ $util.toJson(item.address_json).door_number || ""  }}</text>
				</view>
				<view class="d-flex f-start m-b-10">
					<text class="fz-707070 fz-28 m-r-10">服务时间:</text>
					<text class="fz-000000 fz-28">{{ item.expecttime_text || "" }}</text>
				</view>

				<view class="d-flex f-start m-b-10">
					<text class="fz-707070 fz-28 m-r-10">下单时间:</text>
					<text class="fz-000000 fz-28"> {{ $util.parseTime(item.createtime,"{y}-{m}-{d} {h}:{i}:{s}") }}
					</text>
				</view>

				<view class="d-flex f-start m-b-10" v-if="item.order_status_text!='待指派' && item.order_status_text!='已取消'">
					<text class="fz-707070 fz-28 m-r-10">服务人员:</text>
					<text class="m-r-auto fz-000000 fz-28 m-r-auto">{{ $util.isNull(item.staff_user,'username')  }}({{ $util.hideMiddleFourOfPhoneNumber($util.isNull(item.staff_user,'mobile')) }})</text>
					<view class="statusbtn" v-if="item.status=='4'">
						已出发
					</view>
				</view>

				<view class="p-b-30 borderbottom" v-if="item.order_status_text=='待指派' || item.status==3">
				</view>
				<view class="m-t-10 d-flex f-end" v-if="item.order_status_text=='待指派' || item.status==3">
					<mybtn msg='指派' width="200rpx" height="60rpx" @handclick="(e)=>open(e,item)" />
				</view>

				<view class="tagnum" :style="[tagStyle(item.order_status_text)]">
					{{ item.order_status_text || "" }}
				</view>

			</view>
		</mescroll-body>

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



	</view>
</template>

<script>
	import searchdropdown from "@/components/searchdropdown/index";
	import selectDate from "@/components/selectDate/index";
	import MescrollMixin from "@/utils/mescroll.js";
	import selectcom from "@/components/selectcom";
	import qcaddress from "@/components/qcaddress";
	import xqaddress from "@/components/xqaddress"
	import qiaoSelect from "../../uni_modules/qiao-select/components/qiao-select/qiaoSelect.vue";
	export default {
		mixins: [MescrollMixin],
		components: {
			xqaddress,
			qiaoSelect,
			qcaddress,
			selectcom,
			selectDate
		},
		data() {
			return {
				orgArray: [],
				showObj: {},
				ordervalue: "",
				valiage_id: "",
				xqd: "",
				qcd: "",
				psmsg: "",
				startTime: "",

				endTime: "",
				// 类型:-1.已取消 2.待指派 34.待服务 5.待支付 6.待评价 7.已完成
				orderstatus: [{
						title: "已取消",
						value: '-1'
					}, {
						title: "待指派",
						value: 2
					},
					{
						title: "待服务",
						value: 3
					},
					{
						title: "待支付",
						value: 5
					},
					{
						title: "待评价",
						value: 6
					},
					{
						title: "已完成",
						value: 7
					}

				],
				list: [],
				clist: [{
					order_status_text: "待指派",
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
					backgroundColor: "#D9D9D9"
				}, {
					order_status_text: "已取消",
					color: "#494949",
					backgroundColor: "#D9D9D9"
				}],
				selfpcikup_id: "",
				datetimerange: "", //  时间范围选择
				src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				info: {},
				did: "",
				mechId: ""
			}
		},
		onLoad() {
		
		},
		methods: {
			open(e, item) {
				this.getlistfw(item.category_id);
				this.did = item.id;
				this.$refs.popup.open();
			},
			async getlistfw(category_id) {
				uni.showLoading({
					mask:true
				})
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
					uni.hideLoading();
				}
			},
			selectChange(e) { //返回选择的对象，如果输入框清空，返回null
				if (e) {
					this.mechId = e.id;

					// /api/delivery/assign
				} else {
					this.mechId = ''
				}
			},
			async confirmzp(item) {
				if(!this.mechId){
					return this.$u.toast("请选择人员!");
				}
				uni.showLoading({

				})
				await this.$u.api.ylcorecomplete({
					id: this.did || "",
					staff_user_id: this.mechId || ""
				});
				this.$refs.popup.close();
				uni.showToast({
					icon: "success",
					title: "指派成功"
				});
				this.initList()
			},
			// 订单详情community_id
			goPage(item) {
				this.$u.route({
					url: '/pages2/centeradministrator/detail',
					params: {
						id: item.id,
						title: item.order_status_text,
						pagetype: "中心管理员"
					}
				})
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
				// /api/statistics/getSaleOrder
				let {list,dayMoney,dayOrder,totalMoney,totalOrder} = await this.$u.api.ylcoregetOrders({
					community_id: this.selfpcikup_id || "", //	integer	否	社区id
					village_id: this.valiage_id || "", //	string	否	小区ID
					startTime: this.startTime || "", //	string	否	开始时间
					endTime: this.endTime || "", //	string	否	结束时间
					type: this.ordervalue || "", //	类型:-1.已取消 2.待指派 34.待服务 5.待支付 6.待评价 7.已完成
					page: page.num,
					pagesize: page.size
				});
				this.info = {
					dayMoney,
					dayOrder,
					totalMoney,
					totalOrder
				}
				if (page.num == 1) {
					this.list = [];
				}
				this.list = [...this.list, ...list];
				this.mescroll.endSuccess(list.length, page.size == list.length);
			},
			change(index) {
				this.current = index;
				this.initList();
			},
			// 
			tagStyle(status) {

				let index = this.clist.findIndex(v => v.order_status_text == status);
				return index > -1 ? {
					'color': this.clist[index].color,
					'backgroundColor': this.clist[index].backgroundColor
				} : {};
			}
		}
	}
</script>

<style scoped lang="scss">
	.linethrough {
		text-decoration: line-through;
	}

	.wh500 {
		width: 700rpx;
		height: 400rpx;
	}

	::v-deep .bgtime {
		padding: 0 40rpx;
		width: 100% !important;
		height: 60rpx;
		border-radius: 60rpx;
		background-color: #FFFFFF;
		font-weight: 500;
		font-size: 32rpx;
		color: #979797;

		.drop {
			width: 100% !important;
		}
	}

	.statusbtn {
		right: 0;
		bottom: 30rpx;
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

	.m-b-24 {
		margin-bottom: 24rpx;
	}

	.h130 {
		height: 130rpx;

		.wh130 {
			width: 130rpx;
			height: 130rpx;
		}
	}

	.bgtime {
		padding: 0 40rpx;
		width: 347rpx;
		height: 60rpx;
		border-radius: 60rpx;
		background-color: #FFFFFF;
		font-weight: 500;
		font-size: 32rpx;
		color: #979797;

		.wh30 {
			width: 35rpx;
			height: 35rpx;
		}
	}

	.bgtab {
		position: absolute;
		inset: 0;
		width: 100%;
		height: 100%;
	}

	.scrollx {
		white-space: nowrap;
		width: 520rpx;

		.loaded {
			width: 140rpx;
			height: 140rpx;
			margin-right: 20rpx;
			border-radius: 20rpx;
		}
	}

	.status-btn {
		position: absolute;
		right: 0;
		top: 0;
		width: fit-content;
		padding-left: 20rpx;
		padding-right: 20rpx;
		height: 60rpx;
		background: #FEE8C7;
		border-radius: 0rpx 20rpx 0rpx 20rpx;
		font-weight: 500;
		font-size: 28rpx;
		color: #FB7A35;
		text-align: center;
		line-height: 60rpx;
	}

	.wh80 {
		border-radius: 20rpx;
		width: 180rpx;
		height: 180rpx;
	}

	.wh40 {
		width: 50rpx;
		height: 50rpx;
	}

	.content {
		min-height: 100vh;
		background-color: #FAFAFA;
		padding: 30rpx 20rpx 20rpx 20rpx;
	}

	.wh48 {
		width: 48%;
		height: 140rpx;
	}

	.w347 {
		width: 347rpx;
	}
</style>