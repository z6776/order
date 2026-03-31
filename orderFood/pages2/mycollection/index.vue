<template>
	<view class="content p-t-40">
		<!-- 列表搜索项目 -->
		<view class="d-flex m-b-30" :class="{'f-end':!isYL}">
			<view class="tabs" v-if="isYL">
				<u-tabs :list="tablist" line :is-scroll="false" active-color="#FACE51" inactive-color="#606266" :current="current" @change="change"></u-tabs>
			</view>
			<view class="manyitem d-flex f-end" @click="delflag=!delflag" v-if="list && list.length">
				<view class="itembox">
					{{ delflag ? "完成" : '管理'}} 
				</view>
			</view>
		</view>
		
		<mescroll-body @init="mescrollInit" @down="downCallback" @up="upCallback">
			
		<view class="p20 bg-fff d-flex f-start radius-20 m-b-30" v-for="(item,index) in list" @click="selectItem(index)">
			<view class="dotbox d-flex j-center" :class="{'active':item.select}" v-if="delflag">
				<view class="dot" v-if="item.select">
					
				</view>
			</view>
			 <image :src="$util.getImgurl(item.image || item.coverimage || '')" mode="aspectFill" class="wh80 fs-0 m-r-20"></image>
					 <view class="d-c-flex a-start flex-1 ">
					 	<view class="fz-32 fz-000000 fz-bold d-flex w-100">
							<text>{{item.title || item.name || ""}}</text>
					 	    <view class="wh120 d-flex j-center" @click.stop="opendel(item.co_id)" v-if="!delflag">
					 	    	 <image :src="$util.cdnurl('delbtn.png')"    class="wh40" mode=""></image>
					 	    </view>
					 	</view>
						<view class="d-flex f-start m-t-20 m-b-20">
							{{item.desc || item.shortdesc || ""}}
						</view>
						<view class="d-flex f-start w-100 a-end">
							<text class="fz-24 fz-ff0000">￥</text>
							<text class="fz-FF2525 fz-32 m-r-20">{{item.sales_price || item.price || ""}}</text>
							<text class="linethrough m-r-auto fz-24 basecolor">￥{{item.market_price || ""}}</text>
						</view>
					 </view>
		</view>
		</mescroll-body>
		
		<!-- 底部菜单栏 -->
		<view class="action-section" v-if="delflag">
			 <view class="d-flex f-start m-r-40 m-r-auto" @click="selectItem(1,'all')">
			  	  <view class="dotbox d-flex j-center fs-0 m-r-10" :class="{'active':allchecked}">
			  	  	<view class="dot" v-if="allchecked">
			  	  		
			  	  	</view>
			  	  </view>
				  <text class="fz-28 fz-333333 fz-weight">全选(已选{{ totallen }}件)</text>
			 </view>
			<button type="" class="no-border confirm-btn" @click="opendel()">删除</button>
		</view>
		
			<u-modal v-model="show" confirm-color="#FACE51" show-cancel-button :content="content" @confirm="delitem"></u-modal>
		
		
	</view>
</template>

<script>
	import MescrollMixin from "@/utils/mescroll.js";
	import { mapState } from "vuex";
	export default {
		computed:{
			...mapState(["isYL"])
		},
		mixins:[MescrollMixin],
		data() {
			return {
				content:"确认删除？",
				show:false,
				allchecked:false,
				delflag:false,
				current: 0,
				list:[],
				tablist: [{
					name: "商品"
				}, {
					name: "服务项目"
				}],
				src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				totallen:0,
				ids:""
			}
		},
		watch:{
			list:{
				handler(newval){
					let len = 0;
					for (let s of newval) {
						if(s.select){
							len+=1
						}
					};
					this.totallen = len;
					if(len == newval.length){
						this.allchecked = true;
					}else{
						this.allchecked = false;
					}
				},
				immediate:true,
				deep:true
			}
		},
		onLoad() {

		},
		methods: {
			opendel(id){
				if(id){
					this.ids = id;
					return this.show = true;	
				}
				let list = this.list.map(v=>{
				    if(v.select){
						return v.co_id
					}	
				}).filter(v=>v!=undefined);
				if(list.length){
					this.ids = list.join(",")
				   return this.show = true;	
				}
				return this.$u.toast("请选择项目");
			},
			async delitem(){
				const res = await this.$u.api.operationdeletes({
				   ids:this.ids
			   });
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
			   let {data} = await this.$u.api.getCollect({
			       page:page.num,
			       pagesize:page.size,
				   type:this.current+1
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
			},
			selectItem(i,type){
				if(!this.delflag){
					return this.$util.navTo('/pages2/shopdetail/index?id='+this.list[i].id)
				}
				// debugger;
				if(type){
					for (let s of this.list) {
						if(this.allchecked){
							s.select = false;
						}else{
							s.select = true;
						}
					};
					this.allchecked = !this.allchecked;
					return;
				}
				if(this.list[i].select){
					this.$set(this.list[i],"select",false);
				}else{
					this.$set(this.list[i],"select",true);
				}
				this.$forceUpdate();
			},
		}
	}
</script>

<style scoped lang="scss">
	.content {
		min-height: 100vh;
		background-color: #FAFAFA;
		padding: 0rpx 20rpx 20rpx 20rpx;
	}
	
	.active{
	   border: 2rpx solid #FB7A35 !important;	
	}
	
	/* 底部栏 */
	.action-section {
		position: fixed;
		z-index: 95;
		display: flex;
		align-items: center;
		width: 100%;
		height: 110upx;
		padding: 16rpx 20upx;
		background:#fff;
		bottom: 0;
		left: 0;
		right: 0;
		width: 100%;
		.checkbox {
			height: 52upx;
			position: relative;
	
			image {
				width: 52upx;
				height: 100%;
				position: relative;
				z-index: 5;
			}
		}
	
		.clear-btn {
			position: absolute;
			left: 26upx;
			top: 0;
			z-index: 4;
			width: 0;
			height: 52upx;
			line-height: 52upx;
			padding-left: 38upx;
			color: #fff;
			border-radius: 0 50px 50px 0;
			opacity: 0;
			transition: .2s;
	
			&.show {
				opacity: 1;
				width: 120upx;
			}
		}
	
		.total-box {
			display: flex;
			flex-direction: column;
			text-align: right;
			padding-right: 40upx;
			.price {
				font-weight: bold;
				font-size: 32rpx;
				color: #FF2727;
			}
	
		}
	
		.confirm-btn {
			margin: 0;
			width: 240rpx;
			height: 80rpx;
			background: #FACE51;
			border-radius: 40rpx 40rpx 40rpx 40rpx;
			font-weight: bold;
			font-size: 32rpx;
			color: #000000;			
		}
	}
	
	.dotbox{
		width: 40rpx;
	    height: 40rpx;
		padding: 5rpx;
		background-color: aqua;
		border: 2rpx solid #909090;
		background-color: #fff;
		border-radius: 50%;
		.dot{
			flex-shrink: 0;
			width: 25rpx;
			height: 25rpx;
			border-radius: 50%;
			background-color: #FB7A35;
		}
	}

	.tabs {
		width: 347rpx !important;
		::v-deep.u-tabs {
			background-color: transparent !important;
		}
		// width: 50%;
	}
	
	.basecolor{
		color: rgba(0,0,0,0.5);
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