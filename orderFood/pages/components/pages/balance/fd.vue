<template>
	<view class="content">
		<view class="zichan p-relative">
				<image :src="$util.cdnurl('fdbg.png')" class="bgye" mode=""></image>
				<view class="d-flex f-start rules" @click.stop="$util.navTo('/pages/components/pages/userinformation/index?title=福豆规则&key=fudourule')">
					<image  :src="$util.cdnurl('question.png')" class="question" mode=""></image>
					<text class="fz-28 basecolor">福豆规则</text>
				</view>
				
				<view class="d-c-flex">
					<text class="fz-B85724">当前福豆</text>
					<text class="fz-56 fz-weight fz-B85724"> {{ info.current || "0"}} </text>
				</view>
		
			
			<view class="d-flex m-t-56">
				<view class="d-c-flex w33">
					<text class="fz-B85724">累计福豆</text>
					<text class="fz-56 fz-weight fz-B85724">{{   info.total > 9999 ?  "9999+" : $util.isNull(info,'total') || "0" }}</text>
				</view>
				
				<view class="d-c-flex w33">
					<text class="fz-B85724">累计消耗</text>
					<text class="fz-56 fz-weight fz-B85724">{{   info.consumption > 9999 ?  "9999+" : $util.isNull(info,'consumption') || "0" }}</text>
				</view>

				<view class="d-c-flex w33">
				   	    <text  class="fz-B85724 ">冻结福豆</text>
				   	    <text  class="fz-56 fz-weight fz-B85724">{{   info.frozen > 9999 ?  "9999+" : $util.isNull(info,'frozen') || "0" }}</text>
				   </view>
			</view>

		</view>

		<view class="title">
			明细记录
		</view>
		
		<view class="m-t-20 d-flex f-warp p-l-20 p-r-20">
			
		</view>
		

		<view class="d-flex">
			<view class="wh347">
				<selectDate  msg="请选择开始日期" :time.sync="startTime" @init="initList" />
			</view>
			<view class="wh347">
				<selectDate  msg="请选择结束日期" :time.sync="endTime" @init="initList"/>
			</view>
		</view>

		<view class="bg-fff radius-20">
			<mescroll-body @init="mescrollInit" @down="downCallback" @up="upCallback">
				<view class="p20 p-t-0">
					<view class="d-flex p-b-20 p-t-20 borderbottom" v-for="item in list"  @click.stop="godetail(item)" :key="item.id">
						<view class="d-c-flex a-start">
							<text class="fz-454545 fz-28 fz-weight">{{item.memo || ""}}</text>
							<text class="fz-979797 fz-28 m-t-10">{{ $util.parseTime(item.createtime,"{y}-{m}-{d} {h}:{i}:{s}")  || ""}}</text>
						</view>
						<view class="d-flex f-start">
							<text class="fz-F8B300 fz-500">
								<block v-if="Number(item.before) < Number(item.after)">
									+
								</block>
								<block v-if="Number(item.before) > Number(item.after)">
									-
								</block>
							   {{item.score}}
							</text>
							<u-icon name="arrow-right" v-if="item.type && item.order_id"></u-icon>
						</view>
					</view>
				</view>
			</mescroll-body>
		</view>
		
		<uni-calendar
			   range
				ref="calendar"
				:insert="false"
				@confirm="confirm"
				 />

	</view>
</template>

<script>
	import MescrollMixin from "@/utils/mescroll.js";
	import selectDate from "@/components/selectDate";
	export default {
		components:{
			selectDate
		},
		mixins:[MescrollMixin],
		data() {
			return {
				balancelist: [{
					title: "幸福食堂下单",
					time: "2024.03.02 10:30:20",
					money: "+1颗"
				}, {
					title: "充值",
					time: "2024.03.02 10:30:20",
					money: "+1颗"
				}, {
					title: "幸福食堂下单",
					time: "2024.03.02 10:30:20",
					money: "+31颗"
				}],
				list:[],
				current: 0,
				src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				info: {},
				ttime:"",
				startTime:"",
				endTime:""
			}
		},
		onLoad() {
			this.getinfo();
		},
		methods: {
			//
			async godetail(item){
				 // 食堂
				 if(item.type=='shop' && item.order_id){
					 const res = await this.$u.api.haOrder({
					 	 id:item.order_id
					 });
					 this.$util.navTo("/pages2/order/orderdetail?id="+res);
					 return;
				 }
				 // 养老
				 if(item.type=='yanglao' && item.order_id){
					 // const res = await this.$u.api.haOrder({
						//  id:item.order_id
					 // });
					 this.$util.navTo("/pages2/centeradministrator/detail?id="+item.order_id+"&title=订单详情&pagetype=orderyl");
					 return;
				 }
				 
				 
			 },
			open(type){
				this.ttime = type;
				this.$refs.calendar.open();
			},
			// 确认时间
			confirm(e){
				if(this.ttime=='start'){
					this.startTime = e.fulldate;
				}else{
					 this.endTime = e.fulldate;
				}
				this.initList()
				console.log(e,"eeeeeeee")
			},
			async getinfo() {
				let data = await this.$u.api.scoreStatistics();
				this.info = data
			},
			
			// 初始化列表
			 initList(){
			    this.list = [];
			    this.mescroll.resetUpScroll();
			},
			
			async upCallback(page){
			   let data = await this.$u.api.scorelog({
				   startTime:this.startTime || "",  //	string	否	开始时间
				   endTime:this.endTime || "", //	string	否	结束时间
			       page:page.num,
			       pagesize:page.size
			   });
			   console.log(data,"datatata");
			   if(page.num==1){
			       this.list = [];
			   }
			   this.list =  [...this.list,...data];
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
	.content {
		min-height: 100vh;
		padding: 30rpx 20rpx 20rpx 20rpx;
		.w33{
			width: 33.3%;
		}
        ::v-deep.mescroll-body{
			min-height: initial !important;
		}
		.fz-B85724 {
			color: #B85724;
		}

		.rules {
			position: absolute;
			top: 20rpx;
			right: 30rpx;

			.question {
				width: 32rpx;
				height: 32rpx;
				margin-right: 10rpx;
			}
		}

		.fz-56 {
			font-size: 56rpx;
		}

		.m-t-56 {
			margin-top: 56rpx;
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

		.title {
			font-weight: 800;
			font-size: 32rpx;
			color: #000000;
			margin-top: 20rpx;
			margin-bottom: 20rpx;
		}

		.zichan {
			width: 714rpx;
			height: 400rpx;
			position: relative;
			padding: 38rpx 20rpx;
			border-radius: 20rpx;
			margin-bottom: 30rpx;

			.bgye {
				border-radius: 20rpx;
				width: 100%;
				height: 100%;
				z-index: -1;
				inset: 0;
				position: absolute;
			}
		}
		
		.wh347{
			width: 347rpx;
		}
	}
</style>