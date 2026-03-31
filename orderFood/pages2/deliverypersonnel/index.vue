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
			
		  <view class="">
		  	<view class="m-b-10">
		  			<qcaddress :msg.sync="qcd" align="left"  @init="initList"  :timevalue.sync="selfpcikup_id" defaultmsg="全部取餐点"/>
		  	</view>
		  	<view class="m-t-10 m-b-10">
				  <selectcom :msg.sync="subtypetxt" :list="sublist" align="right"  @init="initList" :timevalue.sync="subtype" defaultmsg="配送类型"/>
		  	</view>
		  </view>
		  
		  
		  <!-- 列表搜索项目 -->
		  <view class="d-flex m-t-20 m-b-30">
			 <view class="tabs">
				<u-tabs active-color="#FACE51" inactive-color="#979797" :list="tablist" :is-scroll="false" :current="current" @change="change"></u-tabs>
			 </view>
			 <view class="manyitem d-flex f-end" @click.stop="$util.navTo('/pages2/deliverypersonnel/manyorder')">
			 	 <view class="itembox">
			 	 	   多单送达
			 	 </view>
			 </view>
		  </view>
		  
		  <mescroll-body @init="mescrollInit" @down="downCallback" @up="upCallback">
		  <view class="p20 m-b-30 bg-fff radius-20 p-relative" v-for="(item,index) in list" :key="item.id">
		  	 <view class="d-flex f-start">	
		  	 	  <text class="fz-28 fz-000000">{{ $util.orderTypefn(item.subtype) }}-{{ $util.parseTime(item.getdate,"{m}-{d}") }}</text>
				  <text class="fz-28 fz-000000 m-l-20 m-r-auto">{{ $util.isam(item.isam) }}</text>
				  <text class="statusbtn radius-10 bg-3964FF fz-fff">{{ current==0 ? '未送达' : '已送达' }}</text>
		  	 </view>
			 
			 <view class="p-b-30 borderbottom">
			 	
			 </view>
			 
			 <view class="d-flex f-start m-b-20 m-t-20">
			 	 <text class="fz-707070 fz-28">姓名:</text>
					 <text class="fz-000000 fz-28 m-r-auto">{{ $util.isNull(item.user,"username")|| "" }}({{ $util.hideMiddleFourOfPhoneNumber($util.isNull(item.user,"mobile")) || "" }})</text>
					 <image :src="$util.cdnurl('phoneicon.png')" class="wh40" mode="" @click.stop="$util.makePhone($util.isNull(item.user,'mobile'))"></image>
			 </view>
			
			 <view class="d-flex f-start m-t-20">
				 <text class="fz-707070 fz-28 m-r-10">自提点:</text>
				 <text class="m-r-auto fz-000000">{{ item.selfpcikup.name || "" }}</text>
			 </view>
			 <view class="d-flex f-start m-b-20 m-t-20">
				 <text class="fz-707070 fz-28 m-r-10">下单时间:</text>
				 <text class="m-r-auto fz-000000"> {{ $util.parseTime(item.createtime,"{y}-{m}-{d} {h}:{i}") }}</text>
			 </view>
			 
			 <view class="d-flex f-start m-t-20" v-for="(v,i) in item.orderProduct" :key="v.id">
			 	 <image :src="$util.getImgurl(v.image)" mode="aspectFill" @click.stop="$util.lookimg(v.image)" class="wh60 m-r-10 radius-10"></image>
				 <text class="m-r-auto">{{ v.title || "" }}</text>
				 <text>x {{ v.number || "" }} </text>
			 </view>
			 
			 <view class="d-flex f-start m-t-20">
			 	 <image v-for="(e,n) in $util.toarr(item.received_url)"  :src="$util.getImgurl(e)"  :key="n" @click.stop="$util.lookimgarr(n,item.received_url)" mode="aspectFill" class="wh120 m-r-10 radius-10"></image>
			 </view>
			 
			 <view class="p-b-30 borderbottom">
					
			 </view>
			 <view class="m-t-20 d-flex f-start">
				 <view class="w30 m-r-auto fz-707070 fz-28">
				 	 共 {{ item.orderProduct.length }} 件
				 </view>
				 <view class="normalbtn fz-fff radius-50 bg-fff borderFACE51" @click.stop="apply(item)" v-if="current==0">
				 	 申请转单
				 </view>
				 <view class="normalbtn m-l-20 fz-fff radius-50 bg-FACE51" @click.stop="applydd(item)" v-if="current==0">
				 	  确认送达
				 </view>
				 <view class="normalbtn fz-fff radius-50 bg-fff borderFACE51" @click.stop="txfn(item)" v-if="false">
				 	 再次提醒
				 </view>
			 </view>
		  </view>
		  </mescroll-body>
		  
		  
		  <uni-popup ref="popup" type="center" background-color="#fff">
				<view class="p20 bg-fff radius-20 w700">
					<view class="d-flex j-center fz-000000 fz-32 m-b-20">
						 转单原因
					</view>
					<view style="width: 300rpx;" class="border w-100 m-b-20">
						<qiaoSelect showField="username"  :dataList="orgArray" phText="选择转单人" phColor="#999999"  searchKey="username" :showObj="showObj"  :disabled="false" @change="selectChange"></qiaoSelect>
					</view>
					<view class="d-flex f-start">
						<textarea placeholder="请输入转单原因" v-model="reason" name="" id="" cols="30" rows="10"></textarea>
					</view>
					
					<mybtn msg="确认" @handclick="confirm" width="300rpx" marginTop="30rpx" height="60rpx" />
				</view>
		  	</uni-popup>
			
			
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
	import MescrollMixin from "@/utils/mescroll.js";
	import selectDate from "@/components/selectDate/index";
	import selectcom from "@/components/selectcom";
	import qcaddress from "@/components/qcaddress";
	import { baseUrl } from "@/common/const.js";
	import qiaoSelect from "../../uni_modules/qiao-select/components/qiao-select/qiaoSelect.vue";
	 export default{
		 mixins:[MescrollMixin],
		 components:{
			 qiaoSelect,
			 qcaddress,
			 selectcom,
			 selectDate
		 },
		 data(){
			 return {
				 showObj:{},
				 action:baseUrl+'/api/common/upload',
				 fileList: [],
				 reason:"",
				 selfpcikup_id:"",
				 qcd:"",
				 subtypetxt:"",
				 subtype:"",
				 // 购买类型:1=自取,2=配送到家,3=配送到自提点
				 sublist:[{
					 title:"自取",
					 value:1
				 },{
					 title:"配送到家",
					 value:2
				 },
				 {
					 title:"配送到自提点",
					 value:3
				 }],
				 startTime:"",
				 endTime:"",
				 list:[],
				  tablist: [{
				 	name: '未送达',
					type:2
				 }, {
				 	name: '已送达',
					type:1
				 }],
				 current: 0,
				 datetimerange:"",  // 时间范围选择
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				 deliveryorder_id:"",
				 orgArray:[],
				 mechId:""
			 }
		 },
		 onLoad(){
			 this.getlist();
		 },
		 methods:{
			 selectChange(e) {//返回选择的对象，如果输入框清空，返回null
			 	if (e) {
			 		this.mechId = e.id;
			 		
			 		// /api/delivery/assign
			 	} else {
			 		this.mechId = ''
			 	}
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
			 // 
			 txfn(){
				 
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
					 return this.$u.toast("请上传送达图片");
				 }
				 files = files.join(",");
				 let data = await this.$u.api.received({
					 received_url:files,//	string	否	图片
					 order_ids:this.orderid || "",//	string	否	订单ID	 
				 });
				 uni.showToast({
				 	title:"确认成功",
				 	icon:"success",
				 })
				 this.cancel();
				 this.initList();
			 },
			 // 申请转单
			 apply(item){
				 this.deliveryorder_id = item.id;
				 this.reason = "";
				
				 this.$refs.popup.open();
			 },
			 // 送达
			 applydd(item){
				 this.orderid = item.order_id;
				  this.$refs.upload.clear();
				  // this.fileList = [];
				 this.$refs.popupdd.open();
			 },
			 async confirm(){
				 // /api/delivery/toChange；
				 let data = await this.$u.api.toChange({
					 reason:this.reason || "",
					 deliveryorder_id:this.deliveryorder_id || "",
					 new_admin_id:this.mechId || ""
				 });
				 uni.showToast({
					title:"申请成功",
				 	icon:"success",
				 })
				  this.$refs.popup.close();
				 this.initList();
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
			    let data = await this.$u.api.getDeliveryOrders({
					isam:this.value || "",
					selfpcikup_id:this.selfpcikup_id || "",//	integer	否	自提点id
					startTime:this.startTime || "",//	string	否	开始时间
					endTime:this.endTime || "",//	string	否	结束时间
					subtype:this.subtype || "",//	integer	否	购买类型:1=自取,2=配送到家,3=配送到自提点
					is_received:this.tablist[this.current].type || "",//	string	否	是否送达：1是2否
					tit:this.keyword || "",//string	否	名称或手机号
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
	.content{
		min-height: 100vh;
		padding: 30rpx 20rpx 20rpx 20rpx;
	}
	.w700{
		width: 700rpx;
		// height: 500rpx;
	}
	.wh120{
		width: 120rpx;
		height: 120rpx;
	}
	::v-deep.bgtime{
		padding: 0 40rpx;
		width: 100% !important;
		height: 60rpx;
		border-radius: 60rpx;
		background-color: #FFFFFF;
		font-weight: 500;
		font-size: 32rpx;
		color: #979797;
		.drop{
			width: 100% !important;
		}
		.wh30{
			width: 35rpx;
			height: 35rpx;
		}
	}
	
	.w600{
		width: 600rpx;
	}
	::v-deep.mescroll-body {
		min-height: 500px !important;
	}
	.wh60{
		width: 60rpx;
		height: 60rpx;
	}
	.tabs{
		::v-deep.u-tabs{
			background-color: transparent !important;
		}
		width: 50%;
	}
	
	.statusbtn{
		width: 120rpx;
		height: 60rpx;
		background: #FEE8C7;
		border-radius: 0rpx 20rpx 0rpx 20rpx;
		font-weight: 500;
		font-size: 32rpx;
		color: #FB7A35;
		text-align: center;
		line-height: 60rpx;
		position: absolute;
		right: 0;
		top: 0;
	}
	.wh347{
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
	
	.borderFACE51{
		color: #FACE51 !important;
		border: 2rpx solid #FACE51;
	}
	
	.manyitem{
		width: 50%;
		.itembox{
			width: 160rpx;
			height: 60rpx;
			background: #FFFFFF;
			border-radius: 8rpx 8rpx 8rpx 8rpx;
			border: 2rpx solid #FACE51;
			font-weight: 500;
			font-size: 28rpx;
			color: #494949;
			text-align: center;
			line-height: 60rpx;
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
	}
	.wh48{
		width: 48%;
		height: 200rpx;
	}
	
</style>