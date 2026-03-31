<template>
	<view class="content">
		<!-- 列表搜索项目 -->
		<view class="subsection m-b-30" v-if="isYL">
			<u-subsection :list="tablist" :current="current" @change="sectionChange" inactive-color="#979797" mode="subsection" active-color="#FACE51"></u-subsection>
		</view>
		<!-- <block v-if="current==0"> -->
		<mescroll-body @init="mescrollInit" @down="downCallback" @up="upCallback">
			<view class="p30 bg-fff  radius-20 m-b-30" v-for="(item,index) in list" :key="item.id">
				<block v-if="current===0">
					<view class="d-flex f-start">
						 <text class="fz-28 fz-500 fz-707070 m-r-20">{{ $util.parseTime(item.createtime,"{y}-{m}-{d} {h}:{i}") }}</text>
						 <view class="m-r-auto">
						 	<u-icon name="star-fill" color="#F2CB51" size="32" v-for="(item,i) in item.rate"></u-icon>
							<u-icon name="star-fill" color="#979797" size="32" v-for="(item,i) in (5-item.rate)"></u-icon>
						 </view>
						 <view class="wh60 d-flex j-center" @click.stop="opendel(item.id)">
						 	<image :src="$util.cdnurl('delbtnres.png')" class="wh40" mode=""></image>
						 </view>
					</view>
					<view class="menu m-b-20">
						{{ item.comment || "" }}
					</view>
					<view class="d-flex f-start">
						 <image v-for="(v,i) in $util.toarr(item.picture)"  @click.stop="$util.lookimgarr(i,item.picture)" :key="i"  :src="$util.getImgurl(v)" class="wh160 radius-20" mode=""></image>
					</view>
					<view class="d-flex m-t-20 f-start">
						 <image :src="$util.getImgurl($util.isNull(item.product,'image'))"   class="wh100rpx m-r-10 fs-0" mode=""></image>
						 <view class="d-c-flex a-start">
						 	 <text class="fz-500 fz-28 fz-707070">{{ item.product.title ||"" }}</text>
							 <text  class="fz-500 fz-28 fz-707070 m-t-16">¥ {{ item.product.sales_price || "" }}</text>
						 </view>
					</view>
				</block>
				
				<block v-else>
					<view class="d-flex f-start">
						 <text class="fz-28 fz-500 fz-707070 m-r-20">{{ $util.parseTime(item.createtime,"{y}-{m}-{d} {h}:{i}") }}</text>
						 <view class="m-r-auto">
						 	<u-icon name="star-fill" color="#F2CB51" size="32" v-for="(item,i) in Number(item.score)"></u-icon>
							<u-icon name="star-fill" color="#979797" size="32" v-for="(item,i) in (5-item.score)"></u-icon>
						 </view>
						 <view class="wh60 d-flex j-center" @click.stop="opendel(item.id)">
						 	<image :src="$util.cdnurl('delbtnres.png')" class="wh40" mode=""></image>
						 </view>
					</view>
					<view class="menu m-b-20">
						{{ item.pjtxt || "" }}
					</view>
					<view class="d-flex f-start">
						 <image v-for="(v,i) in $util.toarr(item.pjimages)"  @click.stop="$util.lookimgarr(i,item.pjimages)" :key="i"  :src="$util.getImgurl(v)" class="wh160 radius-20" mode=""></image>
					</view>
					<view class="d-flex m-t-20 f-start">
						 <image :src="$util.getImgurl($util.isNull(item.product,'coverimage'))"   class="wh100rpx m-r-10 fs-0" mode=""></image>
						 <view class="d-c-flex a-start">
						 	 <text class="fz-500 fz-28 fz-707070">{{ item.product.name ||"" }}</text>
							 <text  class="fz-500 fz-28 fz-707070 m-t-16">¥ {{ item.product.price || "" }}</text>
						 </view>
					</view>
				</block>
				
			</view>
		</mescroll-body>
		
			<u-modal v-model="show" confirm-color="#FACE51" show-cancel-button :content="content" @confirm="delitem"></u-modal>
		<!-- </block> -->
			
		
	</view>
</template>

<script>
	import MescrollMixin from "@/utils/mescroll.js";
	import { mapState } from "vuex";
	export default {
		mixins:[MescrollMixin],
		data() {
			return {
				content:"确认删除?",
				show:false,
				current: 0,
				list:[],
				tablist: [{
					name: "幸福食堂"
				}, {
					name: "养老服务"
				}],
				src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				ids:""
			}
		},
		onLoad() {

		},
		methods: {
				...mapState(["isYL"]),
			opendel(id){
				this.ids = id;
				  return this.show = true;	
			},
			async delitem(){
				let fnname = this.current==1 ? 'deleteyanglaoEvaluate' :  'deleteEvaluate';
					const res = await this.$u.api[fnname]({
					   id:this.ids,
					})
				   this.initList()
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
				let fnname = this.current==1 ? 'yanglaomyEvaluate' :  'myEvaluate';
				let data = await this.$u.api[fnname]({
				  	order_id:"",//	string	否	服务订单ID
				  	product_id:"",//	string	否	服务ID
				  	all:"1",//	string	否	传则全部
				  	picture:'',//	string	否	传则查图片
				  	page:page.num,
				  	pagesize:page.size
				});
				if(page.num==1){
				    this.list = [];
				}
				this.list =  [...this.list,...data.data];
				this.mescroll.endSuccess(data.data.length, page.size == data.data.length);
			},
			// 切换tab
			sectionChange(e) {
				this.current = e;
				 this.initList();
			}
		}
	}
</script>

<style scoped lang="scss">
	.content {
		min-height: 100vh;
		background-color: #FAFAFA;
		padding: 0rpx 20rpx 20rpx 20rpx;
	}
	.wh100rpx{
		border-radius: 20rpx;
		width: 100rpx;
		height: 100rpx;
	}
	
	.wh60{
		width: 60rpx;
		height: 60rpx;
		.wh40{
			width: 40rpx;
			height: 40rpx;
		}
	}

	.tabs {
		::v-deep.u-tabs {
			background-color: transparent !important;
		}

		width: 50%;
	}
	
	.basecolor{
		color: rgba(0,0,0,0.5);
	}
	.wh160{
		width: 160rpx;
		height: 160rpx;
		margin-right: 20rpx;
	}
	.whbg{
		position: fixed;
		width:100%;
		height: 100%;
		inset: 0;
		z-index: -1;
	}
	.wh144{
		width: 144rpx;
		height: 32rpx;
	}
	.w-100{
		width: 100%;
	}
	.linethrough{
		text-decoration: line-through;
	}
	.wh120{
		width: 60rpx;
		height: 60rpx;
	}
	.wh80{
		border-radius: 20rpx;
		width: 200rpx;
		height: 200rpx;
	}
	.wh48{
		width: 48rpx;
		height: 48rpx;
	}
	::v-deep.u-navbar-inner{
		margin-right: 0 !important;
	}
	.slot-wrap{
		width: 100%;
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 0 20rpx;
		.wh33{
			width: 33.3%;
		}
	}

	.manyitem {
		width: 50%;

		.itembox {
			font-weight: 500;
			font-size: 28rpx;
			color: #FACE51;
			width: fit-content;
			padding: 15rpx 52rpx;
			border-radius: 50rpx;
			text-align: center;
			background-color: #fff;
		}
	}
</style>