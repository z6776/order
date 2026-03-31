<template>
	<view class="content">
			<mescroll-body @init="mescrollInit" @down="downCallback" @up="upCallback">
		<view class="bg-fff">
			<v-tabs :scroll="false" paddingItem="0" color="#999999" lineColor="#FACE51" lineHeight="6rpx" bold activeColor="#FACE51"
			 	v-model="tabCurrentIndex" field="text" :lineScale="0.3" bgColor="transparent" :tabs="tabList"
			 	@change="changeTab"></v-tabs>
		</view>
		
		<view class="p20">
		<view class="eva-section m-t-20"  v-for="(item,index) in list" :key="item.id">
			<view class="d-flex">
				<image :src="$util.cdnurl($util.isNull(item.user,'avatar'))" class="wh200 b50 m-r-20" mode=""></image>
				<text class="name m-r-auto">{{ $util.isNull(item.user,'username') || "匿名用户" }}</text>
			</view>
			
			<!-- 养老 -->
			<block v-if="params.type=='yl'">
				<view class="p20 radius-20 m-t-20 bg-fff">
					<view class="right">
						<view class="row d-flex m-b-20">
							<text class="fz-24 basecolor m-r-auto">{{ $util.parseTime(item.createtime,"{y}-{m}-{d} {h}:{i}:{s}") || "" }}</text>
							<u-icon name="star-fill" color="#F2CB51" size="32" v-for="(n,i) in Number(item.score)" :key="i"></u-icon>
							<u-icon name="star-fill" color="#979797" size="32" v-for="(p,a) in (5-Number(item.score))" :key="a"></u-icon>
						</view>
						
						<view class="fz-000000 fz-28 m-b-20">
							    {{ item.pjtxt || "" }}
						</view>
						
						<view class="d-flex f-start f-warp">
							<image v-for="(v,j) in $util.toarr(item.pjimages)" @click.stop="$util.lookimgarr(j,item.pjimages)" :key="j" :src="$util.getImgurl(v)" mode="aspectFill" class="wh140"></image>
						</view>
					</view>
				</view>
			</block>
			<block v-else>
				<view class="p20 radius-20 m-t-20 bg-fff">
					<view class="right">
						<view class="row d-flex m-b-20">
							<text class="fz-24 basecolor m-r-auto">{{ $util.parseTime(item.createtime,"{y}-{m}-{d} {h}:{i}:{s}") || "" }}</text>
							<u-icon name="star-fill" color="#F2CB51" size="32" v-for="(n,i) in item.rate" :key="i"></u-icon>
							<u-icon name="star-fill" color="#979797" size="32" v-for="(p,a) in (5-item.rate)" :key="a"></u-icon>
						</view>
						
						<view class="fz-000000 fz-28 m-b-20">
							    {{ item.comment || "" }}
						</view>
						
						<view class="d-flex f-start f-warp">
							<image v-for="(v,j) in $util.toarr(item.picture)" @click.stop="$util.lookimgarr(j,item.picture)" :key="j" :src="$util.getImgurl(v)" mode="aspectFill" class="wh140"></image>
						</view>
					</view>
				</view>
			</block>
			
			
			
		</view>
	</view>
	</mescroll-body>
		</view>
</template>

<script>
	import MescrollMixin from "@/utils/mescroll.js";
	export default{
		mixins:[MescrollMixin],
		data(){
			return {
				tabCurrentIndex:0,
				tabList:[{
					text:"全部(0)"
				},{
					text:"图片(0)"
				},{
					text:"最新(0)"
				}],
				product_id: 0,
				page:1,
				pageSize:20,
				list:[],
				params:{}
			}
		},
		onLoad(options){
			this.params = options;
			// this.product_id = options.product_id;
		},
		methods:{
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
				let fnname = this.params.type=="yl" ? 'yanglaomyEvaluate' :  'myEvaluate';
			   let data = await this.$u.api[fnname]({
			     	order_id:"",//	string	否	服务订单ID
			     	product_id:this.params.product_id || "",//	string	否	服务ID
			     	all:"1",//	string	否	传则全部
			     	picture:this.tabCurrentIndex==1 ? "1" : '',//	string	否	传则查图片
			     	page:page.num,
			     	pagesize:page.size
			   });
			   if(page.num==1){
			       this.list = [];
			   }
			   this.tabList = [{
					text:`全部(${data.allTotal})`
				},{
					text:`图片(${data.pictureTotal})`
				},{
					text:`最新(${data.allTotal})`
				}],
			   this.list =  [...this.list,...data.data];
			   this.mescroll.endSuccess(data.data.length, page.size == data.data.length);
			},
			changeTab(e){
				this.tabCurrentIndex = e;
				  this.initList();
			},
		
		}
	}
</script>

<style lang='scss'>
	.wh28{
		width: 28rpx;
		height: 28rpx;
	}
	.wh140{
		width: 140rpx;
		height: 140rpx;
		border-radius: 20rpx;
		margin-right: 24rpx;
	}
	.wh200{
		width: 80rpx;
		height: 80rpx;
	}
	.content{
		min-height: 100vh;
		background-color: #F5F5F5;
	}
	page{
		background-color: #fff;
	}
	
	.wh80{
		width: 140rpx;
		height: 140rpx;
		border-radius: 20rpx;
		margin-right: 32rpx;
	}
	/* 评价 */
	.eva-section {
		display: flex;
		flex-direction: column;
	}
	
	.eva-box {
		display: flex;
		padding: 30upx 20rpx;
	    border-bottom: 2rpx solid #F7F7F7;
		.portrait {
			flex-shrink: 0;
			width: 80upx;
			height: 80upx;
			border-radius: 100px;
		}
	
		.right {
			flex: 1;
			display: flex;
			flex-direction: column;
			padding-left: 26upx;
				
			.con {
				padding: 20upx 0;
			}
	
			.bot {
				display: flex;
				justify-content: space-between;
			}
		}
	}
</style>
