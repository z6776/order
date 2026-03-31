<template>
	<view class="pagebox">
		
		<!-- 个人信息 -->
		<view class="user-section" @click="$util.navTo('/pages2/service/introduce')">
			<view class="user-info-box d-flex">
				
				<view class="d-flex f-start m-r-auto">
					<image class="wh170 b50 fs-0" :src="$util.getImgurl(position.avatar)"></image>
					<view class="d-c-flex a-start">
						<text class="fz-32 fz-500 fz-000000 m-r-10">{{ member.username || "" }}</text>
						<view class="m-t-20">
							<text class="fz-500 basecolor fz-28">累计服务单数:</text>
							<text class="fz-500 fz-black fz-28">{{ user.total || "0" }}</text>
						</view>
					</view>
				</view>
				<view class="info-box">
					<image src="../../static/user/edit.png" class="wh40" mode="aspectFill"></image>
				</view>
			</view>
		</view>
		
		<view class="m-t-20 m-b-20">
			<v-tabs paddingItem="0" :scroll="false" color="#979797" lineColor="#FACE51" lineHeight="6rpx" bold activeColor="#FACE51"
				v-model="current" field="name" :lineScale="0.3" bgColor="transparent" :tabs="tablist"
				@change="change"></v-tabs>
				
			<!-- <u-tabs bgColor="transparent" :list="tablist" active-color="#FACE51" inactive-color="#979797" :is-scroll="false" :current="current" @change="change"></u-tabs> -->
		</view>
		<mescroll-body @init="mescrollInit" @down="downCallback" @up="upCallback">
		
		<!-- 列表项 -->
		<view class="p20 p-t-0">
		<view class="p20 m-b-30 bg-fff radius-20 p-relative" v-for="(item,index) in list" @click="goPage(item)">
			 <view class="d-flex f-start m-b-20">	
			 	  <text class="fz-500 fz-28 fz-494949">订单编号：</text>
						  <text class="m-r-auto fz-500 fz-24 fz-494949">{{ item.out_trade_no || "" }}</text>
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
			 			<block v-if="item.order_status_text=='待支付'">
			 				<text class="fz-ff0000 fz-28 fz-32">{{item.number}}{{$util.isNull(item.product,"unit")}}</text>
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
			 	<text class="fz-000000 fz-28">{{ $util.toJson(item.address_json).address }}</text>
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
					 <view class="p-b-30 borderbottom">
					 </view>
					 <view class="m-t-10 d-flex f-end">
						 <block v-if="current==0">
							 <mybtn msg='我已出发' width="200rpx" height="60rpx" @handclick="(e)=>cffn(e,0,item)" />
						 </block>
						 <block v-if="current==1">
							  <mybtn msg='服务未进行' @handclick="(e)=>sering(item)" width="200rpx" height="60rpx" />
							  <view class="m-r-10">
							  	
							  </view>
							  <mybtn msg='完成服务' width="200rpx" height="60rpx" @handclick="(e)=>showfn(item)" />
						 </block>
						 <block v-if="current==2">
							  <mybtn msg='查看详情' width="200rpx" height="60rpx" @handclick="(e)=>goPage(item)" />
						 </block>
						 <block v-if="current==3">
						 	  <mybtn msg='查看详情' width="200rpx" height="60rpx" @handclick="(e)=>goPage(item)"/>
						 </block>
					 </view>
					 
					 <view class="tagnum" :style="[tagStyle(item.order_status_text)]">
					 	 {{ item.order_status_text || "" }}
					 </view>	 
		</view>
		</view>
		</mescroll-body>
		<!--  -->
		<u-modal ref="umodal" showCancelButton v-model="show" title="完成服务" @cancel="show=false" :async-close="true" @confirm="finishservise" @close="show=false" :closeOnClickOverlay="true" confirmColor="#4cd964" cancelColor="#999999">
		     <template>
		     	<view class="slot-content w100">
					<view class="d-flex j-center m-t-30 m-b-30 h120">
						 <input type="text" placeholder="请输入" v-model="unitnum" style="text-align: right;width: 150rpx;height: 120rpx;"/>
						 <text class="fz-28 fz-000000 m-l-30">{{ unit }}</text>
					</view>
		     	</view>
		     </template>
		</u-modal>
		<!--    -->
		<orderpop :show.sync="cancelList[currentpop]['show']" :content="cancelList[currentpop]['msg']" @confirm="confirm" :isShowSlot="false">
			</orderpop>
		 
		 
	</view>
</template>

<script>
	import MescrollMixin from "@/utils/mescroll.js";
	import orderpop from "@/components/orderpop/index.vue";
	import searchdropdown from "@/components/searchdropdown/index";
	import { mapState ,mapGetters,mapMutations }  from "vuex";
	 export default{
		 mixins:[MescrollMixin],
		 components:{
			 orderpop,
			 searchdropdown
		 },
		 data(){
			 return {
				 unitnum:"",
				 currentpop:0,
				 user:{},
				 // :-1.已取消 3.待出发 4.已出发 5.已完成
				 show:false,  // 显示
				 current:0,
				 cancelList: [{
				 	msg: "确认开始本次服务?",
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
				 tablist:[{
					name:"待出发" ,
					value:3
				 },{
					name:"已出发" ,
					value:4
				 },{
					name:"已完成" ,
					value:5
				 },{
					name:"已取消" ,
					value:-1
				 }],
				 list:[],
				 clist:[{
					order_status_text:"已出发",
					color:"#FB7A35",
					backgroundColor:"#FEE8C7"	
				 },{
					order_status_text:"待服务",
					color:"#FB7A35",
					backgroundColor:"#FEE8C7"	
			     }],
				 datetimerange:"",//  时间范围选择
				 order_id:"",
				 unit:"",
				 unitid:"",
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg'
			 }
		 },
		 onLoad(){
		 },
		 computed:{
			 ...mapState(["position","member"]),
			 ...mapGetters(['isLogin']),
		 },
		 onShow() {
		 	this.getUserInfo()
		 },
		 methods:{
			 ...mapMutations(["SET_POSITION"]),
			 goPage(item){
				this.$util.navTo('/pages2/centeradministrator/detail?title='+item.order_status_text+'&pagetype=service'+"&id="+item.id);
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
			 async upCallback(page){
			    let {user,list } = await this.$u.api.ylpeoplegetOrders({
			        type:this.tablist[this.current].value,
			        page:page.num,
			        pagesize:page.size
			    });
			    if(page.num==1){
			        this.list = [];
			    }
				if(user){
					this.user = user;
				}
				if(list){
					   this.list =  [...this.list,...list];
				}
			    this.mescroll.endSuccess(list.length, page.size == list.length);
			 },
			 change(index) {
			    this.current = index;
			   this.initList();
			 },
			 // 获取个人信息
			 async getUserInfo() {
			 	if (this.isLogin) {
			 		let data = await this.$u.api.userindex();
			 		if (data) {
			 			this.SET_POSITION(data);
			 		}
			 	}
			 },
			 cffn(e,cur,item){
				 if(!this.position.mobile){
							 this.$util.xhmodal("请完善手机号后重试").then(res=>{
								  this.$util.navTo("/pages/components/pages/mine/userinfo")
							 })
							 return
				 }
					 this.order_id = item.id;
						this.cancelList[cur].show = true;
			 },
			 async finishservise(e){
				 if(!this.unitnum){
					 	this.$refs.umodal.clearLoading();
					 return this.$u.toast("请输入服务次数");
				 }
				 try{
				 	let r = await this.$u.api.ylpeoplecomplete({
				 		id:this.unitid,//	string	是	订单id
				 		number:this.unitnum  //	string	是	数量
				 	});
				 				
				 	this.show = false;
				 	 this.initList();
				 	 this.$util.success("已完成");
				 }catch(e){
				 	//TODO handle the exception
						 this.$refs.umodal.clearLoading();
				 }
			 },
			 // 确认时间
			 async confirm(e) {
			 	console.log("我的确认按钮");
			 	this.cancelList[this.currentpop].show = false;
			 	switch (this.currentpop) {
			 		case 0:
			 			let r = await this.$u.api.goto({
			 				id: this.order_id || ""
			 			});
			 			this.initList();
			 
			 			uni.showToast({
			 				icon: "success",
			 				title: "已开始"
			 			})
			 			break;
			 		case 1:
			 			let {
			 				data
			 			} = await this.$u.api.receive({
			 				id: this.order_id || ""
			 			});
			 			uni.showToast({
			 				icon: "success",
			 				title: "取餐成功"
			 			});
			 			this.initList();
			 			break;
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
			 showfn(item){
				 this.unitnum = "";
				 this.unitid = item.id;
				 this.unit = item.product?.unit || "次";
				 this.show = true;
			 },
			 sering(item){
				this.$util.navTo('/pages2/service/noservice?id='+item.id); 
			 },
			 tagStyle(status){
				 let index = this.clist.findIndex(v=>v.order_status_text==status);
				 return index>-1 ? {
					 'color':this.clist[index].color,
					 'backgroundColor':this.clist[index].backgroundColor
				 } : {}; 
			 },
			 // 服务未进行
			 nojxfn(e){
				 this.$util.navTo('/pages2/service/noservice')
			 }
		 }
	 }
</script>

<style scoped lang="scss">
	.linethrough{
		text-decoration: line-through;
	}
	.h120{
	   height: 120rpx;
	}
	.pagebox{
		padding: 0rpx !important;
	}
	.user-section{
		padding: 20rpx;
	}
	.popupcon{
		width: 700rpx;
		height: 400rpx;
		padding: 20rpx;
		.title{
			font-size: 32rpx;
			font-weight: 800;
			color: #000000;
		}
		.line80{
			line-height: 80rpx;
			text-align: center;
			font-size: 32rpx;
			font-weight: 800;
			
		}
	}
	.statusbtn{
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
	.tagnum{
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
	.m-b-24{
		margin-bottom: 24rpx;
	}
	.h130{
		height: 130rpx;
		.wh130{
			width: 130rpx;
			height: 130rpx;
		}
	}
	
	::v-deep.tabs{
		background-color: transparent !important;
	}
	
	.wh170{
		width: 120rpx;
		height: 120rpx;
		border-radius: 50%;
		margin-right: 20rpx;
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
		height: 200rpx;
	}
	
</style>