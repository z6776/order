<template>
	<view class="content p-t-0">
		<mescroll-body @init="mescrollInit" @down="downCallback" @up="upCallback">
		
		
		<view class="tabs m-b-20">
			<u-tabs :list="tablist" active-color="#FACE51;" inactive-color="#606266" :is-scroll="false" :current="current" @change="change"></u-tabs>
		</view>

		<view class="p20 m-b-30 bg-fff radius-20" v-for="(item,index) in list" :key="item.id" @click="godetail(item)">
			<view class="d-flex f-start m-b-30">
				<text>{{ $util.orderTypefn(item.order.subtype) }}-{{ $util.parseTime(item.order.getdate,"{m}-{d}") }}</text>
				<text class="m-r-auto">{{ $util.isam(item.order.isam) }}</text>
				<text>{{tablist[current].name}}</text>
			</view>
			<view class="d-flex m-b-20">
				<scroll-view scroll-x class="scrollx flex-1">
					<image :src="$util.getImgurl(v.image)" :key="v.id" class="loaded" mode="aspectFill" v-for="(v,i) in item.orderProduct">
					</image>
				</scroll-view>
				<view class="d-flex fs-0 scrollright">
					<view class="">
						共 {{item.orderProduct.length }}件
					</view>
					<u-icon name="arrow-right" size="28" color="#000000"></u-icon>
				</view>
			</view>
			
			<view class="d-flex f-start m-t-20">
					 <text class="fz-707070 fz-28 m-r-10">姓名:</text>
					 <text class=" fz-000000 m-r-auto">{{  $util.jsontoobj(item.orderExtend.address_json).name  || "" }}({{ $util.hideMiddleFourOfPhoneNumber($util.jsontoobj(item.orderExtend.address_json).mobile) || "" }})</text>
					 <image :src="$util.cdnurl('phoneicon.png')"  class="wh40" mode="" @click.stop="$util.makePhone(item.phone)"></image>
			</view>
			<view class="d-flex f-start m-t-20">
					 <text class="fz-707070 fz-28 m-r-10">配送员:</text>
					 <text class="fz-000000">{{ item.adminin.username || "" }}</text>
			</view>
			
			<view class="d-flex f-start m-t-20" v-if="item.newAdminin">
				 <text class="fz-707070 fz-28 m-r-10">申请转单给:</text>
				 <text class="fz-000000">{{ $util.isNull(item.newAdminin,"username")  || "" }}</text>
			</view>
			
			<view class="d-flex f-start m-b-20 m-t-20">
				 <text class="fz-707070 fz-28 m-r-10">地址:</text>
				 <text class=" fz-000000"> {{ $util.parseTime(item.createtime,"{y}-{m}-{d} {h}:{i}") }}</text>
			</view>
			<view class="d-flex f-start m-b-20 m-t-20">
				 <text class="fz-707070 fz-28 m-r-10">自提点:</text>
				 <text class=" fz-000000"> {{ item.selfpcikup.name || "" }}</text>
			</view>
			<view class="d-flex f-start m-b-20 m-t-20">
				 <text class="fz-707070 fz-28 m-r-10">下单时间:</text>
				 <text class=" fz-000000"> {{ $util.parseTime(item.createtime,"{y}-{m}-{d} {h}:{i}") }}</text>
			</view>
		

			<view class="p-b-30 borderbottom">

			</view>
			<view class="m-t-20 d-flex f-start">
				<view class="fz-000000 fz-32 m-r-auto">
					实付:￥ {{ item.order.total_price || "" }}
				</view>
				<block v-if="current==0">
					<view class="" @click.stop>
						<mybtn msg='驳回' width="200rpx" height="60rpx" @handclick="(e)=>refn(e,item)" />
					</view>
						
						<view class="m-l-20">
							
						</view>
					<view class="" @click.stop>
						<mybtn msg='同意' @handclick="(e)=>open(e,item)" width="200rpx" height="60rpx" />
					</view>
					
				</block>
				<block v-if="current==1">
					<view class="">
						 <mybtn msg='查看' width="200rpx" height="60rpx" @handclick="(e)=>godetail(item,e)" />
					</view>
				</block>
				
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
				<qiaoSelect showField="username"  :dataList="orgArray" phText="选择配送人员" phColor="#999999"  searchKey="username" :showObj="showObj"  :disabled="false" @change="selectChange"></qiaoSelect>
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
	import MescrollMixin from "@/utils/mescroll.js";
	import qiaoSelect from "../../uni_modules/qiao-select/components/qiao-select/qiaoSelect.vue";
	export default {
		components:{
			qiaoSelect
		},
			mixins:[MescrollMixin],
		data() {
			return {
				reason:"",
				showObj:{},
				orgArray:[],
				list:[],
				tablist: [{
					name: '未审核',
					type:1
				}, {
					name: '已审核',
					type:2
				}],
				current: 0,
				datetimerange: "", // 时间范围选择
				src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				did:"",
				mechId:"",
				refresh:false
			}
		},
		onLoad() {
			this.getlist();
		},
		onShow(){
			if(!this.refresh) return;
			this.initList();
			
		},
		methods: {
			//审核详情
			async godetail(item){
				
				let title = this.current ==0 ? "未审核" : "已审核";
				 let orderid = await this.$u.api.haOrder({id:item.order_id})
				this.$util.navTo('/pages2/orderreview/detail?title='+title+"&id="+orderid+"&zdid="+item.id);
			},
			// 驳回原因
			refn(e,item){
				this.did = item.id;
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
					id:this.did || "",//	string	否	转单申请id
					approveresult:"3",//	string	否	审核结果;1=审核中2=同意3=拒绝
					reject:this.reason || "" //	string	否	拒绝原因
				});
				this.$refs.popupreason.close();
				this.initList()
				uni.showToast({
					icon:"success",
					title:"审核成功"
				});
				console.log(data,"datadatat");
			},
			open(e,item){
				let index = this.orgArray.findIndex(v=>v.id==item.new_admin_id);
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
			selectChange(e){//返回选择的对象，如果输入框清空，返回null
		      console.log(e,"eeeeeee");
				if (e) {
					this.mechId = e.id;
					// /api/delivery/assign
				} else {
					this.mechId = ''
				}
			},
			async confirmzp(item){
				uni.showLoading({
					
				});
				if(!this.mechId){
					return this.$u.toast("请选择配送员");
				}
				// new_admin_id	string	否	新配送员ID
				// id	string	否	转单申请id
				// approveresult	string	否	审核结果;1=审核中2=同意3=拒绝
				// reject	string	否	拒绝原因
				await this.$u.api.assignTool({
					new_admin_id:this.mechId,
					id:this.did || "",
					approveresult:"2"
				});
				this.$refs.popup.close();
				uni.showToast({
					icon:"success",
					title:"指派成功"
				});
							this.initList()
			},
			
			// /api/delivery/getChange
			
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
			   let data = await this.$u.api.getChange({
			       type:this.tablist[this.current].type || "",
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
		background-color: #FAFAFA;
		padding: 30rpx 20rpx 20rpx 20rpx;
	}
	
	.wh500{
		width: 700rpx;
		height: 400rpx;
	}
	.w700{
		width: 700rpx;
		height: 500rpx;
	}

	.linethrough {
		text-decoration: line-through;
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
		height: 200rpx;
	}
</style>