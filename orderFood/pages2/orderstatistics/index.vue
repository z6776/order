<template>
	<view class="pagebox">
	     <view class="d-flex f-warp">
			 <!-- "totalOrders": 9,
			     "todayOrders": 5,
				 
			     "totalSales": 140.03,
			     "todaySales": 14.03 -->
	     	 <view class="item wh48 d-c-flex bg-FACE51 j-center radius-20 m-b-20 p-relative">
	     	 	 <text>{{ info.totalOrders || "0" }}</text>
				 <text class="m-t-10">累计订单</text>
				 <image :src="$util.cdnurl('sumtabbg.png')" class="bgtab" mode=""></image>
	     	 </view>
			 <view class="item wh48 d-c-flex bg-FACE51 j-center radius-20 m-b-20 p-relative">
			 	 <text>{{ info.totalSales || "0" }}</text>
			 	 <text class="m-t-10">累计销售额</text>
				  <image  :src="$util.cdnurl('sumtabbg.png')" class="bgtab" mode=""></image>
			 </view>
			 <view class="item wh48 d-c-flex bg-FACE51 j-center radius-20 m-b-20 p-relative">
			 	 <text>{{ info.todayOrders || "0" }}</text>
			 	 <text class="m-t-10">今日订单</text>
				  <image  :src="$util.cdnurl('sumtabbg.png')"  class="bgtab" mode=""></image>
			 </view>
			 
			 <view class="item wh48 d-c-flex bg-FACE51 j-center radius-20 m-b-20 p-relative">
			 	 <text>{{ info.todaySales || "0" }}</text>
			 	 <text class="m-t-10">今日销售额</text>
				  <image  :src="$util.cdnurl('sumtabbg.png')"  class="bgtab" mode=""></image>
			 </view>
	     </view>
		 <!-- 时间范围选择 -->
		 <view class="d-flex m-t-10 ">
			 <selectDate  msg="请选择开始日期" :time.sync="startTime" @init="initList" />
			 <selectDate  msg="请选择结束日期" :time.sync="endTime" @init="initList"/>
		 </view>
		 
		 <!-- 搜索 -->
		 <view class="">
		 	<u-search :input-style="{'background':'#fff'}" type="text"  placeholder="请输入用户姓名/手机号" v-model="keyword" :show-action="false" @input="searchtit"></u-search>
		 </view>
		 
		 <view class="m-t-10">
		 	<u-search :input-style="{'background':'#fff'}" type="text"  placeholder="请输入商品名称" v-model="shopname" :show-action="false" @input="searchname"></u-search>
		 </view>
		 
		 <view class="m-t-10 m-b-10">
		 	<saddress :msg.sync="qcd" align="left"  @init="initList"  :timevalue.sync="selfpcikup_id" defaultmsg="请输入小区名称"/>
		 </view>
		<!-- getsq
		 getxq
		 getroder -->
		 <view class="d-flex tabs">
			 <view class="w347">
			 	<selectcom :msg.sync="isammsg" :list="isamlist" align="right"  @init="initList" :timevalue.sync="isam" defaultmsg="全天"/>
			 </view>
			  <view class="w347">
		 	     <selectcom :msg.sync="psmsg" :list="orderstatus" align="right"  @init="initList" :timevalue.sync="ordervalue" defaultmsg="订单状态"/>	
			  </view>
		 </view>
				 
		 <mescroll-body @init="mescrollInit" @down="downCallback" @up="upCallback">
		 <view class="p20 m-b-30 bg-fff radius-20 p-relative" v-for="(item,index) in list" @click="godetail(item)">
		 	 <view class="d-flex f-start m-b-20">	
		 	 	  <text class="fz-500 fz-28 fz-000000"> {{ $util.orderTypefn(item.subtype) }}-{{ $util.parseTime(item.getdate,"{m}-{d}") }}</text>
				  <text class="status-btn">{{item.order_status_text}}</text>
		 	 </view>
			 
			<view class="d-flex m-b-20">
				<scroll-view scroll-x class="scrollx flex-1">
					<image :src="$util.getImgurl(v.image)" class="loaded" mode="aspectFill"  v-for="(v,i) in item.products"></image>
				</scroll-view>
				<view class="d-flex fs-0 scrollright">
					 <view class="fz-28 fz-500 fz-454545">
					 	  共 {{ item.products && item.products.length ? item.products.length : 0 }} 件
					 </view>
					 <u-icon name="arrow-right" size="40" color="#000000"></u-icon>
				</view>
			</view>
			
			<view class="d-flex f-start m-b-20">
				 <text class="fz-707070 fz-28">姓名:</text>
				 <text class="fz-000000 fz-28 m-r-auto">{{ $util.isNull(item.user,"username")|| "" }}({{ $util.hideMiddleFourOfPhoneNumber($util.isNull(item.user,"mobile")) || "" }})</text>
				 <image :src="$util.cdnurl('phoneicon.png')" class="wh40" mode="" @click.stop="$util.makePhone($util.isNull(item.user,'mobile'))"></image>
			</view>
			
			<view class="d-flex f-start m-b-20" v-if="item.subtype==2">
				 <text class="fz-707070 fz-28">配送员:</text>
				<text class="fz-000000 fz-28">{{  $util.isNull(item.admin,"username")|| ""  }}({{ $util.hideMiddleFourOfPhoneNumber($util.isNull(item.admin,"mobile")) || "" }})</text>
				<!-- <u-icon name="phone-fill" size="32" color="#000000"></u-icon> -->
			</view>
	
	        <block v-if="item.subtype==2">
				<view class="d-flex f-start m-b-20">
					 <text class="fz-707070 fz-28">地址:</text>
					 <text class="fz-000000 fz-28">{{  $util.jsonToarr($util.isNull(item.extend,"address_json"))|| ""   }}</text>
				</view>
			</block>
			
			<block v-if="item.subtype==3">
				<view class="d-flex f-start m-b-20">
					 <text class="fz-707070 fz-28">地址:</text>
					 <text class="basecolor fz-28" v-if="item.selfpcikup && item.selfpcikup.villagein">{{ item.selfpcikup.villagein.name || "" }}</text>
					 <text class="basecolor fz-28" v-if="item.selfpcikup">-{{ item.selfpcikup.name || "" }}</text>
				</view>
			</block>
			
			 <view class="d-flex f-start m-b-20">
			 	 <text class="fz-707070 fz-28">下单时间:</text>
				 <text class="fz-000000 fz-28">{{ $util.parseTime(item.createtime,"{y}-{m}-{d} {h}:{i}") }}</text>
			 </view>
			 <view class="d-flex f-start">
			 	<text class="fz-707070 fz-28">实付:</text>
			 	<text class="fz-28 fz-ff0000 m-r-auto">￥{{ item.total_price || '0.00' }}</text>
			 </view>
			 <view class="p-b-30 borderbottom">
			 </view>
			 <view class="m-t-20 d-flex f-end">
				<mybtn msg='确认收货' width="200rpx" v-if="!item.have_received && item.order_status_text!='退款/售后'" height="60rpx" @handclick="(e)=>btnclick(e,item)" />
				<view class="m-r-20">
					
				</view>
				 <mybtn msg='申请售后' width="200rpx" height="60rpx" @handclick="(e)=>shfn(item,e)" v-if="item.order_status_text!='待付款' && item.order_status_text!='退款/售后'" />
				 <view class="m-r-20">
				 	
				 </view>
			 	<mybtn msg='查看详情' width="200rpx" height="60rpx" @handclick="(e)=>godetail(item)" />
			 </view>
		 </view>
		 
		 </mescroll-body>
		 
		 
	</view>
</template>

<script>
	
	import MescrollMixin from "@/utils/mescroll.js";
	import selectDate from "@/components/selectDate/index";
    import saddress from "@/components/saddress/index";
	import selectcom from "@/components/selectcom/index";
	 export default{
		 	mixins:[MescrollMixin],
		 components:{
			 saddress,
			 selectDate,
			 selectcom
		 },
		 data(){
			 return {
				 shopname:"",  // 商品名称
				 selfpcikup_id:"",
				 isam:"",
				 ordervalue:"",
				 qcd:"",
				 isammsg:"",
				 psmsg:"",
				 startTime:"",
				 endTime:"",
				 list:[{
					status_text:"待取餐" 
				 },{
					status_text:"已评价" 
				 },{
					status_text:"退款/售后" 
				 },{
					status_text:"待取餐" 
				 },{
					status_text:"已评价" 
				 },{
					status_text:"退款/售后" 
				 }],
				 datetimerange:"",//  时间范围选择
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				 info:{},
				 orderstatus:[
					{
						title:"订单状态",
						value:""
					},
					{
						title:"待取餐",
						value:2
					},{
						title:"待评价",
						value:3
					},{
						title:"已完成",
						value:4
					},{
						title:"退款/售后",
						value:6
					}],
					isamlist:[
					{
						title:"全天",
						value:""
					},
					{
						title:"上午",
						value:1
					},{
						title:"下午",
						value:2
					}]
					
			 }
		 },
		 onLoad(query){
			 // this.getlist()
		 },
		 methods:{ 
			 // 点击按钮
			 btnclick(e, item) {
			 	if (!item.user?.id) {
			 		return this.$u.toast("未找到用户信息");
			 	};
				this.$util.xhmodal("确认替该用户取餐").then(async res=>{
					 let { data } = await this.$u.api.receive({
					 	user_id: item.user?.id || "",
					 	id: item.order_id || ""
					 });
					 uni.showToast({
					 	icon: "success",
					 	title: "取餐成功"
					 });
					 this.initList();
				})
			 	// if (item.order_id) {
			 	// 	this.user_id = item.user?.id;
			 	// 	this.order_id = item.order_id;
			 	// }
			 	// this.currentpop = 1;
			 	// this.cancelList[1].show = true;
			 },
			 // 申请售后
			 shfn(item){
			 	let d = new Date();
				let aftertime = this.$store.state.aftertime;
				d.setHours(aftertime[0],aftertime[1] || "0",aftertime[2] || '0');
				
			 	// 大于晚上23点需要联系客服
			 	// if(new Date() > d){
			 	// 	return this.$u.toast("请前往首页联系客服");
			 	// };
			 	this.$util.navTo('/pages2/aftersales/index?id='+item.order_id+'&price='+item.total_price+"&pagetype=xs");
			 },
			 // 查看详情
			 godetail(item) {
			 	if (item.order_status_text == '退款/售后') {
			 		this.$util.navTo('/pages2/order/returndetail?id=' + item.order_id);
			 	} else {
					this.$util.navTo('/pages2/orderstatistics/orderstatisticsdetail?title='+item.order_status_text+'&id='+item.order_id)
			 		// this.$util.navTo('/pages2/order/orderdetail?id=' + item.order_id);
			 	}
			 },
			async getlist () {
				// /api/statistics/getSale
			let data = await this.$u.api.getSale();
			this.info = data
			},
			// 初始化列表
			 initList(){
			    this.list = [];
			    this.mescroll.resetUpScroll();
			},
			// 搜索列表
			searchtit(e){
			   this.keyword = e;
			   this.initList();
			},
			searchname(e){
				this.shopname = e;
				this.initList();
			},
			async upCallback(page){
				// /api/statistics/getSaleOrder
			   let {list,todayOrders,todaySales,totalOrders,totalSales} = await this.$u.api.getSaleOrder({
				   title:this.shopname, // 商品名称
				   naormo:this.keyword || "",
				   village_id:this.selfpcikup_id || "",//	integer	否	自提点id
				   startTime:this.startTime || "",//	string	否	开始时间
				   endTime: this.endTime ||  "",//	string	否	结束时间
				   isam: this.isam || "",//	integer	否	1=上午2=下午
				   type:this.ordervalue || "",//	string	否	类型:1.待付款 2.待取餐 3.待评价 4，已完成 5.已取消 6.退款 ,7.拼团中,
			       page:page.num,
			       pagesize:page.size
			   });
			   this.info = {
				   todayOrders,
				   todaySales,
				   totalOrders,
				   totalSales
			   };
			   console.log(list,"datatata");
			   if(page.num==1){
			       this.list = [];
			   }
			   this.list =  [...this.list,...list];
			   this.mescroll.endSuccess(list.length, page.size == list.length);
			},
			change(index) {
			   this.current = index;
			  this.initList();
			}
		 }
	 }
</script>

<style scoped lang="scss">
	.linethrough{
		text-decoration: line-through;
	}
	.w347{
		width: 347rpx;
	}
	.bgtime{
		padding: 0 40rpx;
		width: 347rpx;
		height: 60rpx;
		border-radius: 60rpx;
		background-color: #FFFFFF;
		font-weight: 500;
		font-size: 32rpx;
		color: #979797;
		.wh30{
			width: 35rpx;
			height: 35rpx;
		}
	}
	
	.bgtab{
		position: absolute;
		inset: 0;
		width: 100%;
		height: 100%;
	}
	.scrollx{
				   white-space: nowrap;
				   width: 520rpx;
				   .loaded{
					   width: 140rpx;
					   height: 140rpx;
					   margin-right: 20rpx;
					   border-radius: 20rpx;
				   }
	}
	
	.search{
		position: relative;
		height: 60rpx;
		border-radius: 90rpx;
		.ints{
			border-radius: 90rpx;
			padding-left: 20rpx;
			padding-right: 140rpx;
			height: 100%;
			background-color: #fff;
			width: 100%;
		}
		.rightslot{
			min-width: 140rpx;
			border-radius: 90rpx;
			height: 100%;
			bottom: 0;
			top: 0;
			padding-left: 10rpx;
			padding-right: 10rpx;
			background: linear-gradient(to left,#DD4D00,#FFD05B 90%);
			right: 0;
			position: absolute;
			font-weight: 500;
			font-size: 28rpx;
			display: flex;
			justify-content: center;
			align-items: center;
			color: #FFFFFF;
			line-height: 60rpx;
			.wh38{
				width: 38rpx;
				height: 38rpx;
			}
		}
	}
	::v-deep.u-content{
		background-color: #fff !important;
	}
	::v-deep.tabs{
		.dropmenu{
			width: 100% !important;
		}
		.bgtime{
			// overflow: hidden;
			// text-overflow: ellipsis;
			white-space: nowrap;
			width: 100% !important;
		}
	}
	.status-btn{
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
	.wh80{
		border-radius: 20rpx;
		width: 180rpx;
		height: 180rpx;
	}
	.wh40{
		width: 50rpx;
		height: 50rpx;
	}
	.content{
		min-height: 100vh;
		background-color: #FAFAFA;
		padding: 30rpx 20rpx 20rpx 20rpx;
	}
	.wh48{
		width: 48%;
		height: 140rpx;
	}
	
</style>