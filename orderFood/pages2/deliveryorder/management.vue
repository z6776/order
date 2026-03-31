<template>
	<view class="content">
		<view class="bgf7bf35">
			<u-navbar title="人员管理" :is-back="false" :background="bgColorOpa" :border-bottom="false">
				<view class="p-l-20" @click="$util.back()">
					<u-icon name="arrow-left" size="32" color="#000000" bold></u-icon>
				</view>
			</u-navbar>
			<!-- 搜索 -->
			<view class="d-flex search">
				<input class="ints" type="text" placeholder="请输入配送员姓名/手机号" @input="searchtit"/>
				<view class="rightslot" @click="initList">
					<image  :src="$util.cdnurl('search.png')" mode="" class="wh38"></image>
					<text class="fz-32">搜索</text>
				</view>
			</view>
		</view>
		 <mescroll-body @init="mescrollInit" @down="downCallback" @up="upCallback">
			<view class="p20">
				  <view class="item p20 bg-fff radius-20 m-b-20" v-for="(item,index) in list" :key="item.id">
					   <view class="row m-b-20 d-flex f-start">
						   <text class="fz-500 fz-32 fz-000000  max100">{{ $util.isNull(item.user,'username') || "" }}</text>
						   <text class="fz-500 fz-32 fz-707070">(</text>
						   <text class="fz-500 fz-32 fz-707070">{{  $util.isNull(item.user,'mobile') || ""  }}</text>
						   <text class="fz-500 fz-32 fz-707070">)</text>
						   <!-- <text>{{ <item class="user sex"></item> }}</text> -->
						   <text class="m-r-auto tag">{{ item.workstatus==1?'工作中' : '休息' }}</text>
						   <image src="../../static/user/edit.png" mode="aspectFill" class="wh40" @click.stop="openfn(item)"></image>
					   </view>
					   
					<!--   <view class="d-flex m-t-10 m-b-10">
						   <text>全部取餐点</text>
						   <u-switch v-model="item.checked"></u-switch>
					   </view> -->
						  
					   <view class="">
							负责取餐点:<text v-for="(v,i) in item.selfpickup">{{ i==item.selfpickup.length-1 ?v.name : v.name+"," }}</text>
							<!-- 小区A-取餐点A、小区A-取餐点B、小区B-取餐点B -->
					   </view>
				  </view>
				</view>
			</mescroll-body>
			
			<uni-popup ref="popup" type="center" background-color="#fff" @touchmove.stop>
				<view class="p20 bg-fff radius-20 wh700">
					<view class="d-flex j-center fz-000000 fz-32 m-b-20">
						 修改
					</view>
					<view class="d-flex f-start">
						 <text class="fz-000000 fz-28">工作状态</text>
						   <selectcom :msg.sync="worklabel" align="left"  :list="worklist"  :timevalue.sync="workvalue" defaultmsg="工作状态"/>
					</view>
					<view class="d-flex m-b-20 f-start">
						 <text class="fz-000000 fz-28 w112">取餐点</text>
						 <view class="flex-1 w-100">
							  <!-- <qcaddress :msg.sync="qcd" align="left"  @init="initList1"  :timevalue.sync="selfpickup_id" defaultmsg="取餐点"/> -->
						 	<zxz-uni-data-select
							collapseTags
							isEdit
							:total_list="total_list"
							@inputChange="inputChange"
							@scdown="scrolltolower"
							@close="closefn"
							filterable
							multiple
							v-model="valiage_value"
							:localdata="valiage_range"
							@change="valiageCheckfn"/>
						 </view>
					</view>
					<mybtn msg="确认" @handclick="confirm" width="300rpx" height="60rpx" />
				</view>
			 </uni-popup>
			
			
	</view>
</template>

<script>
	import selectcom from "@/components/selectcom";
	import MescrollMixin from "@/utils/mescroll.js";
	import qcaddress from "@/components/qcaddress";
	import valiageCheck from "./valiageCheck.js";
	 export default{
		 components:{
			 qcaddress,
			 selectcom
		 },
		 mixins:[MescrollMixin,valiageCheck],
		 data(){
			 return {
				 total_list:[],
				 valiage_pagesize:9999,
				 qcd:"",
				 selfpickup_id:"",
				 id:"",
				 worklist:[{
					 title:"工作中",
					 value:1
				 },{
					 title:"休息",
					 value:2
				 }],
				 qclist:[{
					 title:"小区1",
					 value:1
				 },{
					 title:"小区2",
					 value:2
				 },{
					 title:"小区3",
					 value:3
				 }],
				 show:false, // 工作状态
				 worklabel:"",
				 workvalue:"",
				 qclabel:"",
				 qcvalue:"",
				 workstatus:"",
				 qctype:"",
				 form:{},
				 status:[],
				 list:[],
				 keyword:"",
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				 user_id:"",
				 // worklistCopy:[],
			 }
		 },
		 onLoad(){
			 this.initList1();
		 },
		 methods:{
			 // 重写小区列表
			 async getValiageListOnly(e){
				 console.log(11);
			 	let {data,total} = await this.$u.api.getVillageSe({
			 		pagesize:this.valiage_pagesize,
			 		page:this.pagevaliage,
			 		name:this.valiage_name_key || ""
			 	});
				let arr = [];
				// 第二版改动
				for (let i = 0; i < data.length; i++) {	
					let item = data[i];
					// if(item.selfpickups && Array.isArray(item.selfpickups) && item.selfpickups.length){
					// for (let j = 0; j < item.selfpickups.length; j++) {
					// 		let n = item.selfpickups[j];
							arr.push({
								value: `${item?.id}`,
								village_id: item.village_id,
								selfpcikup_id: item.id,
								text: `${item?.village?.name}-${item.name}`
							});
					    // }
				}
			 	this.valiage_range = [...this.valiage_range,...arr];
			
			 	if(!data || data.length < 10){
			 		this.is_valiage_end = true;
			 	}
			 },
			 
			 // 初始化列表
			 async initList1(e){
				 let {data} = await this.$u.api.getVillageSe({
				 	pagesize:this.valiage_pagesize,
				 	page:this.pagevaliage,
				 	name:""
				 });
				 let arr = [];
				 for (let i = 0; i < data.length; i++) {
				 	let item = data[i];
				 	// if(item.selfpickups && Array.isArray(item.selfpickups) && item.selfpickups.length){
				 	// for (let j = 0; j < item.selfpickups.length; j++) {
				 	// 		let n = item.selfpickups[j];
				 			arr.push({
				 				value: `${item?.id}`,
				 				village_id: item.village_id,
				 				selfpcikup_id: item.id,
				 				text: `${item?.village?.name}-${item.name}`
				 			});
				 	    // }
				 }
				 this.total_list = arr;
			 },
			 openfn(item){
				 let index = this.worklist.findIndex(values=>values.value==item.workstatus);
				 if(index > -1){
					 this.workvalue = this.worklist[index].value;
					 this.worklabel = this.worklist[index].title;
				 }else{
					 this.workvalue = "";
					 this.worklabel = "";
				 }
				 this.id = item.id;
				 this.user_id = item.user_id;
				 if(item.selfpickup && item.selfpickup.length){
					 let arr = [];
					 for (let s of item.selfpickup) {
					 	arr.push(s.id+'')
					 };
					  this.valiage_value = arr;
					  console.log(this.valiage_value,"valiage_value")
				 }else{
					 this.valiage_value = [];
				 }
				 // debugger;
				 this.$refs.popup.open();
			 },
			 // 
			 async confirm(){	
				 // /api/delivery/setAdmin
				if(!this.workvalue){
					return this.$u.toast("请选择工作状态");
				}
				// if(!this.valiage_value || !this.valiage_value.length){
				// 	return this.$u.toast("请选择自提点");
				// }
				uni.showLoading({
					mask:true
				});
				let selfpickup_id = this.valiage_value.join(",");
				 let data = await this.$u.api.setAdmin({
					 user_id:this.user_id || "",
					 workstatus:this.workvalue || "",//	string	否	传则修改工作状态
					 admin_id:this.id || "",//	string	否	id
					 selfpickup_id,//	string	否	自提点id
				 });
				 this.$refs.popup.close();
				 
				 uni.showToast({
				 	icon:"success",
					title:"修改成功"
				 })
				 this.initList()
			 },
			  // 初始化列表
			  initList(){
			     this.list = [];
				 this.workvalue = "";
				 this.selfpickup_id = "";
				 this.qcd = "";
				 this.worklabel = "";
			     this.mescroll.resetUpScroll();
			 },
			 // 搜索列表
			 searchtit(e){
			    this.keyword = e.detail.value;
			    this.initList();
			 },
			 async upCallback(page){
			    let data = await this.$u.api.getAdminList({
			        page:page.num,
			        pagesize:page.size,
			        tit:this.keyword
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
	.max100{
		max-width: 180rpx;
		white-space: nowrap;
		    text-overflow: ellipsis;
		    overflow: hidden;
	}
	.w112{
		width: 112rpx;
		text-align: justify;
		text-align-last: justify;
		margin-right: 40rpx;
		flex-shrink: 0;
		white-space: nowrap;
	}
	.wh700{
		width: 700rpx;
	}
	.content{
		min-height: 100vh;
		background-color: #FAFAFA;
	}
	.wh500{
		width: 700rpx;
		height: 400rpx;
	}
	.wh38{
		width: 38rpx;
		height: 38rpx;
		
	}
	.tag{
		padding: 10rpx 20rpx;
		border-radius: 50rpx;
		font-weight: 500;
		font-size: 28rpx;
		color: #FB7A35;
		background-color: #FEE8C7;
		margin-left: 20rpx;
	}
	.search{
		position: relative;
		height: 60rpx;
		border-radius: 90rpx;
		z-index: 999;
		.ints{
			border-radius: 90rpx;
			padding-left: 20rpx;
			padding-right: 140rpx;
			height: 100%;
			background-color: rgba(255, 255, 255, 0.25);
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
	.bgf7bf35{
		box-sizing: border-box;
		background: linear-gradient(to bottom,#F9DA77,#F7BF35 30%);
		padding: 20rpx;
	}
	
</style>