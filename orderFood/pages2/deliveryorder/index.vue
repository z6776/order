<template>
	<view class="content">
		<view class="bgf7bf35">
			<u-navbar title="配送订单" :is-back="false" :background="bgColorOpa" :border-bottom="false">
				<view class="p-l-20" @click="$util.back()">
					<u-icon name="arrow-left" size="32" color="#000000" bold></u-icon>
				</view>
			</u-navbar>
			<!-- 搜索 -->
			<view class="d-flex search">
				<input class="ints" type="text" v-model="keyword" placeholder="请输入配送员姓名/手机号" @input="searchtit" />
				<view class="rightslot" @click.stop="initList">
					<image :src="$util.cdnurl('search.png')" mode="" class="wh38"></image>
					<text class="fz-32">搜索</text>
				</view>
			</view>
			<view class="d-flex search m-t-10">
				<input class="ints" type="text" v-model="keywordxd" placeholder="请输入下单人姓名/手机号" @input="searchxd" />
				<view class="rightslot" @click.stop="initList">
					<image :src="$util.cdnurl('search.png')" mode="" class="wh38"></image>
					<text class="fz-32">搜索</text>
				</view>

			</view>



		</view>
		<!--  -->
		<view class="m-t-20 d-flex f-warp p-l-20 p-r-20">
			<view class="wh347">
				<selectDate msg="请选择开始日期" :time.sync="startTime" @init="initList" />
			</view>
			<view class="wh347">
				<selectDate msg="请选择结束日期" :time.sync="endTime" @init="initList" />
			</view>
		</view>
		<!--  -->
		<view class="p-l-20 p-r-20">
			<view class="m-b-10">
				<qcaddress :msg.sync="qcd" align="left" @init="initList" :timevalue.sync="selfpcikup_id"
					defaultmsg="销售区域" />
			</view>
			<view class="m-t-10 m-b-10">
				<selectcom :msg.sync="psmsg" :list="orderstatus" align="right" @init="initList"
					:timevalue.sync="ordervalue" defaultmsg="订单状态" />
			</view>
		</view>

		<mescroll-body @init="mescrollInit" @down="downCallback" @up="upCallback">
			<view class="p20">
				<view class="p20 m-b-30 bg-fff radius-20 itemorder" v-for="(item,index) in list" :key="item.order_id"
					@click="godetail(item)">
					<view class="d-flex f-start m-b-30">
						<text
							class="fz-28 fz-000000 fz-500">{{ $util.orderTypefn(item.subtype) }}-{{ $util.parseTime(item.getdate,"{m}-{d}") }}</text>
						<text class="m-r-auto">{{ $util.isam(item.isam) }}</text>
						<text class="status-btn" v-if="!(item.subtype==1) && item.status==1 && item.have_paid">{{ !item.is_received ? '配送中' : '已送达' }}</text>
					</view>

					<view class="d-flex m-b-20">
						<scroll-view scroll-x class="scrollx flex-1">
							<image :src="$util.getImgurl(v.image)" class="loaded" mode="aspectFill"
								v-for="(v,i) in item.products" :key="v.id"></image>
						</scroll-view>
						<view class="d-flex fs-0 scrollright">
							<view class="fz-500 fz-454545 fz-weight">
								共{{ item.products.length }}件
							</view>
							<u-icon name="arrow-right" size="28" color="#000000"></u-icon>
						</view>
					</view>

					<view class="d-flex f-start m-b-20 m-t-20">
						<text class="fz-707070 fz-28">姓名:</text>
						<text
							class="fz-000000 fz-28 m-r-auto">{{ $util.isNull(item.user,"username")|| "" }}({{ $util.hideMiddleFourOfPhoneNumber($util.isNull(item.user,"mobile")) || "" }})</text>
						<image :src="$util.cdnurl('phoneicon.png')" class="wh40" mode=""
							@click.stop="$util.makePhone($util.isNull(item.user,'mobile'))"></image>
					</view>
					<view class="d-flex f-start m-b-20">
						<text class="fz-707070 fz-28">配送员:</text>
						<text class="fz-000000 fz-28"
							v-if="item.admin">{{ $util.isNull(item.admin,"username")|| "" }}({{ $util.hideMiddleFourOfPhoneNumber($util.isNull(item.admin,"mobile")) || "" }})</text>
						<!-- <u-icon name="phone-fill" size="32" color="#000000"></u-icon> -->
					</view>
					<!-- 配送到家选地址 -->
					<view class="d-flex f-start m-b-20" v-if="item.subtype==2">
						<text class="fz-707070 fz-28">地址:</text>
						<text class="fz-000000 fz-28"> {{$util.jsonToarr(item.address_json) }} </text>
					</view>
					<!-- 配送到自提点 -->
					<view class="d-flex f-start m-b-20" v-if="item.subtype==3 && false">
						<text class="fz-707070 fz-28">地址:</text>
						<text class="fz-000000 fz-28"> {{$util.jsonToarr(item.address_json) }} </text>
					</view>

					<view class="d-flex f-start m-b-20">
						<text class="fz-707070 fz-28">自提点:</text>
						<text class="fz-000000 fz-28">{{ item.selfpcikup.name || "" }}</text>
					</view>

					<view class="d-flex f-start m-b-20">
						<text class="fz-707070 fz-28">下单时间:</text>
						<text class="fz-000000 fz-28">
							{{ $util.parseTime(item.createtime,"{y}-{m}-{d} {h}:{i}") }}</text>
					</view>

					<view class="d-flex f-start m-b-20" v-if="item.status==1 && item.have_paid">
						<text class="fz-707070 fz-28">实付:</text>
						<text class="fz-000000 fz-28"> {{ item.total_price || "" }}</text>
					</view>
					
					<view class="p-b-30 borderbottom"  v-if="item.status==1 && item.have_paid">

					</view>
					<view class="m-t-20 d-flex f-end" v-if="item.status==1 && item.have_paid">
						<view class="d-flex " @click.stop>
							<mybtn msg='确认收货' width="200rpx" v-if="!item.have_received" height="60rpx" @handclick="(e)=>btnclick(e,item)" />
								<view class="m-r-10">
									
								</view>
							<mybtn msg='申请售后' width="200rpx" height="60rpx" @handclick="(e)=>shfn(item,e)" v-if="item.status!='-1'" />
								<view class="m-r-10">
									
								</view>
							<mybtn msg='指派' width="200rpx" height="60rpx" @handclick="(e)=>open(item,e)"
								v-if="!item.is_received" />
						</view>
					</view>
				</view>
			</view>




		</mescroll-body>


		<uni-popup ref="popup" type="center" background-color="#fff">
			<view class="p20 bg-fff radius-20 wh500">
				<view class="d-flex j-center fz-000000 fz-32 m-b-20">
					指派
				</view>
				<view style="width: 300rpx;" class="border w-100">
					<qiaoSelect ref="qiaoSelect" showField="username" :dataList="orgArray" phText="选择配送人员"
						phColor="#999999" searchKey="username" :showObj="showObj" :disabled="false"
						@change="selectChange"></qiaoSelect>
				</view>


				<mybtn msg="确认" @handclick="confirmzp" marginTop="100rpx" width="300rpx" height="60rpx" />
			</view>
		</uni-popup>

		<orderpop :show.sync="cancelList[currentpop]['show']" :content="cancelList[currentpop]['msg']" @confirm="confirm" :isShowSlot="false">
		</orderpop>

	</view>
</template>

<script>
	import orderpop from "@/components/orderpop/index.vue";
	import searchdropdown from "@/components/searchdropdown/index";
	import selectDate from "@/components/selectDate/index";
	import MescrollMixin from "@/utils/mescroll.js";
	import selectcom from "@/components/selectcom";
	import qcaddress from "@/components/qcaddress";
	import qiaoSelect from "../../uni_modules/qiao-select/components/qiao-select/qiaoSelect.vue";
	export default {
		mixins: [MescrollMixin],
		components: {
			qiaoSelect,
			qcaddress,
			selectcom,
			selectDate,
			orderpop
		},
		data() {
			return {
				currentpop: 0,
				cancelList: [{
					msg: "确认取消?",
					show: false
				}, {
					msg: "确认取餐?",
					show: false
				}, {
					msg: "申请换货?",
					show: false
				}, {
					msg: "上传单号",
					show: false
				}],
				order_id: "",
				keywordxd: "",
				showObj: {},
				orgArray: [],
				qcd: "",
				selfpcikup_id: "", // 自提点id
				xsmsg: "", // 
				psmsg: "",
				xsvalue: "", // 销售区域的值
				ordervalue: "", // 订单状态的值
				orderstatus: [{
					title: "配送中",
					value: 2
				}, {
					title: "已送达",
					value: 1
				}],
				startTime: "",
				endTime: "",
				keyword: "",
				list: [],
				tablist: [{
					status_text: "配送中"
				}, {
					status_text: "已送达"
				}],
				datetimerange: "", //  时间范围选择
				src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				mechId: "",
				did: "",
				user: {}
			}
		},
		onLoad() {
			this.getlist();
		},

		methods: {
			// 点击按钮
			btnclick(e, item) {
				if (!item.user?.id) {
					return this.$u.toast("未找到用户信息");
				}
				if (item.order_id) {
					this.user_id = item.user?.id;
					this.order_id = item.order_id;
				}
				this.currentpop = 1;
				this.cancelList[1].show = true;
			},
			async confirm() {
				uni.showLoading({
					mask: true
				});
				let { data } = await this.$u.api.receive({
					user_id: this.user_id || "",
					id: this.order_id || ""
				});
				uni.showToast({
					icon: "success",
					title: "取餐成功"
				});
					this.cancelList[1]['show']  = false;
				this.initList();
			
			},
			// 申请售后
			async shfn(item) {
				let d = new Date();
				let aftertime = this.$store.state.aftertime;
				d.setHours(aftertime[0], aftertime[1] || "0", aftertime[2] || '0');

				// 大于晚上23点需要联系客服
				// if(new Date() > d){
				// 	return this.$u.toast("请前往首页联系客服");
				// };
				// let orderid = await this.$u.api.haOrder({id:item.order_id});
				this.$util.navTo('/pages2/aftersales/index?id=' + item.order_id + '&price=' + item.total_price +
					'&pagetype=xs');
			},
			open(item) {
				this.$refs.qiaoSelect.clickClear();
				this.did = item.order_id;
				this.$refs.popup.open();
			},
			async getlist() {
				// /api/delivery/getAdminList
				let data = await this.$u.api.getAdminList();
				if (data && data.length) {
					this.orgArray = data.map(v => {
						return {
							id: v.id,
							username: v.user?.username
						}
					});
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
				if (!this.mechId) {
					return this.$u.toast("请选择人员!")
				}
				uni.showLoading({
					mask: true
				});
				await this.$u.api.assign({
					admin_id: this.mechId,
					id: this.did || ""
				});
				this.$refs.popup.close();
				uni.showToast({
					icon: "success",
					title: "指派成功"
				});
				this.initList();
			},
			async godetail(item) {
				let status_text = !item.is_received ? '配送中' : '已送达';
				let orderid = await this.$u.api.haOrder({
					id: item.order_id
				})
				this.$util.navTo('/pages2/deliveryorder/detail?title=' + status_text + '&id=' + item.order_id + "&status=" + item.status+"&have_paid="+item.have_paid);
			},
			// 指派
			zpfn(e) {
				console.log(e, "eeeeeeeee");
			},
			// 初始化列表
			initList() {
				this.list = [];
				this.mescroll.resetUpScroll();
			},
			// 搜索列表
			searchtit(e) {
				this.keyword = e.detail.value;
				this.initList();
			},
			searchxd(e) {
				this.keywordxd = e.detail.value;
				this.initList();
			},
			async upCallback(page) {
				let data = await this.$u.api.deliverygetOrders({
					tituse: this.keywordxd || "",
					all: "1",
					selfpcikup_id: this.selfpcikup_id || "", //	integer	否	自提点id
					startTime: this.startTime || "", //	string	否	开始时间
					endTime: this.endTime || "", //	string	否	结束时间
					subtype: "" || "", //	integer	否	购买类型:1=自取,2=配送到家,3=配送到自提点
					is_received: this.ordervalue || "", //	string	否	是否送达：1是2否
					tit: this.keyword || "", //	string	否	名称或手机号
					page: page.num,
					pagesize: page.size
				});
				console.log(data, "datatata");
				if (page.num == 1) {
					this.list = [];
				}
				this.list = [...this.list, ...data];
				this.mescroll.endSuccess(data.length, page.size == data.length);
			},
			change(index) {
				this.current = index;
				this.initList();
			}

		}
	}
</script>

<style scoped lang="scss">
	.linethrough {
		text-decoration: line-through;
	}

	.trans {
		color: #F7BF35 !important;
		border: 2rpx solid #F7BF35;
		background-color: transparent !important;
	}

	.bgf7bf35 {
		box-sizing: border-box;
		background: linear-gradient(to bottom, #F9DA77, #F7BF35 30%);
		padding: 20rpx;
	}

	::v-deep.bgtime {
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

		.wh30 {
			width: 35rpx;
			height: 35rpx;
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

	.scrollx {
		white-space: nowrap;
		width: 520rpx;

		.loaded {
			width: 200rpx;
			height: 200rpx;
			margin-right: 30rpx;
			border-radius: 20rpx;
		}
	}

	.search {
		position: relative;
		height: 60rpx;
		border-radius: 90rpx;

		.ints {
			border-radius: 90rpx;
			padding-left: 20rpx;
			padding-right: 140rpx;
			height: 100%;
			background-color: rgba(255, 255, 255, 0.25);
			width: 100%;
		}

		.rightslot {
			min-width: 140rpx;
			border-radius: 90rpx;
			height: 100%;
			bottom: 0;
			top: 0;
			padding-left: 10rpx;
			padding-right: 10rpx;
			background: linear-gradient(to left, #DD4D00, #FFD05B 90%);
			right: 0;
			position: absolute;
			font-weight: 500;
			font-size: 28rpx;
			display: flex;
			justify-content: center;
			align-items: center;
			color: #FFFFFF;
			line-height: 60rpx;

			.wh38 {
				width: 38rpx;
				height: 38rpx;
			}
		}
	}

	.itemorder {
		position: relative;

		.status {
			padding: 8rpx 20rpx;
			width: fit-content;
			height: 60rpx;
			background: #FEE8C7;
			border-radius: 0rpx 0rpx 20rpx 0rpx;
			color: #FB7A35;
			border-radius: 0 0 10rpx;
			top: 0;
			right: 0;
			position: absolute;
		}
	}

	//
	.cditem {
		width: 48%;
		height: 60rpx;
		line-height: 60rpx;
		padding-left: 10rpx;
		padding-right: 10rpx;
		border-radius: 10rpx;
	}

	.searchbox {
		padding: 20rpx 40rpx;
	}

	.wh500 {
		width: 700rpx;
		height: 400rpx;
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
		// padding: 30rpx 20rpx 20rpx 20rpx;
	}

	.wh48 {
		width: 48%;
		height: 200rpx;
	}

	.wh347 {
		width: 347rpx;
	}
</style>