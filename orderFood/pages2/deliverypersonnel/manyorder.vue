<template>
	<view class="content">
		<view class="m-t-20 d-flex f-warp">
			<view class="wh347">
				<selectDate  msg="请选择开始日期" :time.sync="startTime" @init="initList" />
			</view>
			<view class="wh347">
				<selectDate  msg="请选择结束日期" :time.sync="endTime" @init="initList"/>
			</view>
		</view>
	
		  
		<mescroll-body @init="mescrollInit" @down="downCallback" @up="upCallback">
		<!-- 全部取餐点 -->
		<view class="m-t-20 m-b-20">
			 <qcaddress :msg.sync="qcd" align="left"  @init="initList"  :timevalue.sync="selfpcikup_id" defaultmsg="全部取餐点"/>
		</view>
		
		<view class="changeTime d-flex f-start m-t-20 m-b-20">
			<view class="m-r-10 fz-28 fz-000000 fz-weight">
				 选择时段:
			</view>
			<u-radio-group v-model="value">
						<u-radio 
						active-color="#FACE51"
						@change="radioGroupChange"
							v-for="(item, index) in listtab" :key="index" 
							:name="item.name"
						>
							{{item.keyname}}
						</u-radio>
					</u-radio-group>
		</view>
		
		<view class="btnall m-t-30" @click="linquall()" v-if="list && list.length">
			   {{ allchecked() ? '取消全选' : '全选' }}
		</view>
		
		<!--  -->
		<view class="p20 m-b-30 bg-fff radius-20 p-relative" v-for="(item,index) in list" :key="item.id" @click="select(index)">
			 <view class="d-flex f-start">	
			 	  <text class="fz-28 fz-000000">{{ $util.orderTypefn(item.subtype) }}-{{ $util.parseTime(item.getdate,"{m}-{d}") }}</text>
				  <text class="fz-28 fz-000000 m-l-20 m-r-auto">{{ $util.isam(item.isam)  }}</text>
				  <radio style="transform: scale(.7);" color="#FACE51" :checked="item.select"/>
			 </view>
					 <view class="p-b-10 borderbottom">
					 	
					 </view>
					 
					 <view class="d-flex f-start m-b-20 m-t-20">
					 	 <text class="fz-707070 fz-28">姓名:</text>
						 <text class="fz-000000 fz-28 m-r-auto">{{ $util.isNull(item.user,"username")|| "" }}({{ $util.hideMiddleFourOfPhoneNumber($util.isNull(item.user,"mobile")) || "" }})</text>
						 <image :src="$util.cdnurl('phoneicon.png')" class="wh40" mode="" @click.stop="$util.makePhone($util.isNull(item.user,'mobile'))"></image>
					 </view>
					 
					<!-- <view class="d-flex f-start m-t-20">
						 <text class="fz-707070 fz-28 m-r-10">姓名:</text>
						 <text class="m-r-auto fz-000000">{{ item.usernmae || "" }}({{ $util.hideMiddleFourOfPhoneNumber(item.phone) || "" }})</text>
						 <image  :src="$util.cdnurl('phoneicon.png')"  class="wh40" mode="" @click="$util.makePhone(item.phone)"></image>
					 </view> -->
					 <view class="d-flex f-start m-t-20">
						 <text class="fz-707070 fz-28 m-r-10">自提点:</text>
						 <text class="m-r-auto fz-000000">{{ item.selfpcikup.name }}</text>
					 </view>
					 <view class="d-flex f-start m-b-20 m-t-20">
						 <text class="fz-707070 fz-28 m-r-10">下单时间:</text>
						 <text class="m-r-auto fz-000000"> {{ $util.parseTime(item.createtime,"{y}-{m}-{d} {h}:{i}") }}</text>
					 </view>
					 
					 <view class="d-flex f-start m-t-20" v-for="(v,index) in item.orderProduct" :key="v.id">
					 	 <image :src="$util.getImgurl(v.image)" mode="aspectFill" class="wh40 m-r-10"></image>
						 <text class="m-r-auto">{{ v.title || "" }}</text>
						 <text>x {{ v.number || "" }}</text>
					 </view>
		</view>
		</mescroll-body>
		<view class="boxFixed bgt" v-if="list && list.length">
			 <mybtn msg="确认送达" @handclick="sdfn" />
		</view>
		
		<uni-popup ref="popupdd" type="center" background-color="#fff">
			<view class="p20 bg-fff radius-20 w600">
				<view class="d-flex j-center fz-000000 fz-32 m-b-20">
					 确认订单送达?
				</view>
				<view class="d-c-flex  m-t-30 m-b-30">
						<u-upload  :auto-upload="true"  :action="action" ref="upload" :show-progress="false" :file-list="fileList" ></u-upload>
						<view class="">
							<text class="fz-ff0000 fz-28">*</text>
							<text class="fz-000000 fz-28 fz-000000">请先上传送达的商品图片</text>
						</view>
				</view>
				<view class="d-flex">
					<mybtn  msg="取消" @handclick="cancel" width="200rpx" height="60rpx" />
					<view class="m-l-20">
						
					</view>
					<mybtn msg="确认" @handclick="confirmdd" width="200rpx" height="60rpx" />
				</view>
			</view>
		</uni-popup>
	</view>
</template>

<script>
	import qcaddress from "@/components/qcaddress";
	import MescrollMixin from "@/utils/mescroll.js";
	import { baseUrl } from "@/common/const.js";
	import selectDate from "@/components/selectDate/index";
	 export default{
		 components:{
			 qcaddress,
			 selectDate
		 },
		 mixins:[MescrollMixin],
		 data(){
			 return {
				 listtab: [
					{
						name: '',
						keyname:"全部",
						disabled: false
					},
					{
						name: '1',
						keyname:"上午",
						disabled: false
					},
					{
						name: '2',
						keyname:"下午",
						disabled: false
					}
				],
				// u-radio-group的v-model绑定的值如果设置为某个radio的name，就会被默认选中
				value: '',
				 startTime:"",
				 endTime:"",
				 action:baseUrl+'/api/common/upload',
				 fileList: [],
				 selfpcikup_id:"",
				 qcd:"",
				 list:[],
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg'
			 }
		 },
		 computed:{
			
		 },
		
		 methods:{
			 		// 选中任一radio时，由radio-group触发
			 		radioGroupChange(e) {
						 this.value  = e;
						 	 this.initList();
			 			console.log(e,"radioGroupChangeradioGroupChange");
			 		},
			 allchecked(){
			 		 return this.list.every(v=>v.select);
			 },
			 // 全选
			 linquall(){
				 if(this.allchecked()){
					 for (let s of this.list) {
					 	s.select =false;
					 }
				 }else{
					 for (let s of this.list) {
					 	s.select =true;
					 }
				 }
				 console.log(this.list," this.list this.list this.list this.list");
				 this.$forceUpdate();
			 },
			 select(index){
				 this.$set(this.list[index],"select",!this.list[index].select);
				 this.$forceUpdate();
			 },
			 // 确认取消
			 cancel(){
			 	this.$refs.popupdd.close(); 
			 },
			 async confirmdd(){
				 // api/delivery/received;
				 let files = [];
				 files = this.$refs.upload.lists.map(v=>{
					if(v.response && v.progress==100){
						return v.response.data.url;
					}
				 }).filter(item=>item!=undefined);
				 if(!files.length){
					 // files = "";
					 return this.$u.toast("请上传送达图片");
				 }else{
					  files = files.join(",");
				 }
				 let arr = [];
				 for (let s of this.list) {
				 	if(s.select){
						arr.push(s.order_id)
					}
				 }
				 if(!arr.length){
					  return this.$u.toast("请选择订单"); 
				 }
				 arr = arr.join(",")
				 
				 let data = await this.$u.api.received({
					 received_url:files,//	string	否	图片
					 order_ids:arr || "",//	string	否	订单ID	 
				 });
				 this.$util.success("送达成功!")
				 this.cancel();
				 this.initList();
			 },
			 sdfn(){
				 let arr = [];
				 for (let s of this.list) {
				 	if(s.select){
						arr.push(s.order_id)
					}
				 }
				 if(!arr.length){
				 	return this.$u.toast("请选择订单"); 
				 }
				 this.$refs.popupdd.open();
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
				 // /api/delivery/getDeliveryOrders
			    let data = await this.$u.api.getDeliveryOrders({
				    isam:this.value || "",
					selfpcikup_id:this.selfpcikup_id || "",
					startTime:this.startTime || "",//	string	否	开始时间
					endTime:this.endTime || "",//	string	否	结束时间
			        is_received:2 || "",
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
	.btnall{
		width: 200rpx;
		height: 80rpx;
		line-height: 80rpx;
		font-weight: 500;
		font-size: 32rpx;
		color: #FFFFFF;
		text-align: center;
		background-color: #FACE51;
		border-radius: 90rpx;
		margin-bottom: 30rpx;
	}
	
	.w600{
		max-width: 700rpx;
	}
	
	.manyitem{
		width: 50%;
		.itembox{
			width: fit-content;
			padding: 15rpx 30rpx;
			border-radius: 10rpx;
			text-align: center;
			background-color: #fff;
		}
	}
	// 
	.cditem{
		width: 48%;
		height: 60rpx;
		line-height: 60rpx;
		padding-left: 10rpx;
		padding-right: 10rpx;
		border-radius: 10rpx;
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
		padding-bottom: 220rpx;
	}
	.wh48{
		width: 48%;
		height: 200rpx;
	}
</style>