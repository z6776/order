<template>
    <view class="page">
        <view class="p20 bg-fff p-b-0">
			<u-search @change="searchtit"  placeholder="请输入幸福食堂商品名称/养老服务项目名称"  v-model="keyword" :show-action="false"></u-search>
        </view>
		<view class=" m-b-10" v-if="isYL">
			<u-tabs :list="list" :is-scroll="false" active-color="#FACE51" inactive-color="#606266" :current="current" @change="change"></u-tabs>
		</view>
		 <mescroll-body @init="mescrollInit" @down="downCallback" @up="upCallback">
		<view class="content p20" :class="{'flexC':current==1}">
			<block v-if="current==0">
				<view class="wh49 radius-20" v-for="(item,index) in products" @click="$util.navTo('/pages2/shopdetail/index?id='+item.id,false)">
					<view class="wh170">
						 <image :src="$util.getImgurl(item.image)" mode="aspectFill" class="wh100 radiusimg"></image>
					</view>
					<view class="listbox">
						<view  class="fz-32 u-line-1 text-align-left">{{item.title || ""}}</view>
						<view class="fz-28 fz-999999 u-line-1 m-t-30 m-b-30 text-align-left mar-bottom-30">{{item.desc || ""}}</view>
						<view class="zhuanfatxt d-flex m-t-10">
							<view class="d-flex f-start">
								 <text class="fz-32 fz-FF2727">￥</text>
								 <text class="fz-32 fz-FF2727">{{item.sales_price || ""}}</text>
							</view>
							<view class="fz-28 fz-999999" v-if="item.sales>0">
								已售{{item.sales}}+
							</view>
						</view>
					</view>
				</view> 
			</block>
			<block v-else>
				<view class="good m-b-20" v-for="(good, key) in products" :key="good.id" @click="$util.navTo('/pages/careservices/detail?id='+good.id+'&pagetype=yl',false)">
					<image mode="aspectFill" :src="$util.getImgurl(good.coverimage)" class="image radius-20"></image>
					<view class="right">
						<text class="name">{{ good.name }}</text>
						<!-- <text class="tips">{{ good.desc }}</text> -->
						<view class="price_and_action d-flex f-start">
							<text class="price fz-FF2525">￥{{ good.price }}</text>
							<text class="fz-28 fz-FF2525">/{{ good.unit }}</text>
						</view>
				
					</view>
				</view>
			</block>
			
		</view>
		</mescroll-body>

		
	
    </view>
</template>

<script>
	import MescrollMixin from "@/utils/mescroll.js";
	import { mapGetters,mapState,mapMutations  } from "vuex";
    export default {
		 mixins:[MescrollMixin],
		 computed:{
			 ...mapState(["isYL"])
		 },
        data() {
            return {
					list: [{
						name: '商品'
					}, {
						name: '服务项目'
					}],
					current: 0,
                keyword:'',
				products:[]
            }
        },
		onLoad(query) {
			this.keyword = query.title;
			this.initList()
		},
		methods:{
			// 进入页面不自动刷新列表
			mescrollInit(mescroll) {
				this.mescroll = mescroll;
				this.mescroll.optUp.toTop.bottom = 240;
				this.mescroll.optUp.empty.zIndex = 9999;
				this.mescroll.optUp.auto = false;
				this.mescroll.optDown.auto = false;
				console.log(this.mescroll,"this.mescrollthis.mescroll")
			},
			// 
			searchtit(e){
				console.log(e);
				this.keyword = e;
				this.initList();
			},
			initList(){
				 this.products = [];
				 this.mescroll.resetUpScroll();
			},
			async upCallback(page){
			       let fnname = this.current==0 ? 'getProductList' :'getYanglaoList';
				   let tit = this.current==0 ? {
					   'title':this.keyword
				   } : {
					   'name':this.keyword
				   };
				 		let {data} = await this.$u.api[fnname]({
				 			page:page.num,
							pagesize:page.size,
				 			...tit
				 		});
						console.log(data,"datatata");
						if(page.num==1){
							this.products = [];
						}
				 		this.products =  [...this.products,...data];
						this.mescroll.endSuccess(data.length, page.size == data.length);
			 },
			change(index) {
				this.current = index;
				this.initList();
			}
		}
    }
</script>

<style lang="scss" scoped>
	.radiusimg{
		border-radius: 20rpx 20rpx 0 0;
	}
	.flexC{
		flex-direction: column;
	}
	.good {
		display: flex;
		align-items: center;
		//margin-bottom: 30rpx;
		padding: 15rpx 0;
		background-color: #ffffff;
		padding-bottom: 30rpx;
		.image {
			width: 160rpx;
			height: 160rpx;
			margin-right: 20rpx;
			border-radius: 8rpx;
		}
	
		.right {
			flex: 1;
			height: 160rpx;
			overflow: hidden;
			display: flex;
			flex-direction: column;
			align-items: flex-start;
			justify-content: space-between;
			padding-right: 14rpx;
	
			.name {
				font-size: $font-size-base;
				margin-bottom: 10rpx;
				width: 100%;
				overflow: hidden;
				text-overflow: ellipsis;
				white-space: nowrap;
			}
	
			.tips {
				width: 100%;
				height: 40rpx;
				line-height: 40rpx;
				overflow: hidden;
				text-overflow: ellipsis;
				white-space: nowrap;
				font-size: $font-size-sm;
				color: $text-color-assist;
				margin-bottom: 10rpx;
			}
	
			.price_and_action {
				width: 100%;
				display: flex;
				justify-content: space-between;
				align-items: center;
	
				.price {
					font-size: $font-size-base;
					font-weight: 600;
				}
	
				.btn-group {
					display: flex;
					justify-content: space-between;
					align-items: center;
					position: relative;
	
					.btn {
						padding: 0 20rpx;
						box-sizing: border-box;
						font-size: $font-size-sm;
						height: 44rpx;
						line-height: 44rpx;
	
						&.property_btn {
							border-radius: 24rpx;
						}
	
						&.add_btn,
						&.reduce_btn {
							padding: 0;
						}
					}
	
					.dot {
						position: absolute;
						background-color: #ffffff;
						border: 1px solid $color-primary;
						color: $color-primary;
						font-size: $font-size-sm;
						width: 36rpx;
						height: 36rpx;
						line-height: 36rpx;
						text-align: center;
						border-radius: 100%;
						right: -12rpx;
						top: -10rpx;
					}
	
					.number {
						width: 44rpx;
						height: 44rpx;
						line-height: 44rpx;
						text-align: center;
					}
				}
			}
		}
	}
    .page{
		min-height: 100vh;
		background-color: #fafafa;
    }
	.iconboxs{
		width: 40rpx;
		height: 40rpx;
	}
    ::v-deep .uicon-true{
        opacity: 0;
        width: 0rpx !important;
    }
    .history{
        margin-top: 30rpx;
        padding-left: 20rpx;
        box-sizing: border-box;
        font-size: 28rpx;
        .title{
            font-weight: bold;
        }
        .history_bottom{
            margin-top: 20rpx;
            text-align: center;
            font-weight: bold;
            color: #C5BEC1;
        }
        .history_box{
            margin-top: 20rpx;
            display: flex;
            flex-wrap: wrap;
           box-sizing: border-box;
        }
    }
    .history_li{
        margin-top: 12rpx;
        padding: 6rpx 16rpx;
        margin-right: 30rpx;
        border-radius: 30rpx;
        background-color: rgba(232, 232, 232, 1);
        color: black;
        text-align: center;
		transform: width .3s linear;
    }
	
	
	.content{
		display: flex;
		justify-content: space-between;
		flex-wrap: wrap;
	}
	
	
	.zhuanfatxt{
		color: rgba(255, 210, 61, 1);
		font-size: 28rpx;
		text-align: center;
		.linethough{
			font-size: 24rpx;
			color: #999999;
			text-decoration: line-through;
		}
	}
	
	.wh170{
		width: 100%;
		height: 340rpx;
	}
	
	.listbox{
		border-radius: 20rpx;
		padding: 20rpx;
		.boxshop{
			padding: 20rpx;
			background-color: rgba(250, 250, 250, 1);
		}
	}
	
	.tit{
		font-size: 24rpx;
		color: #333333;
		font-weight: bold;
		text-align: center;
		min-height: 32rpx;
	}
	.wh49{
		background-color: #fff;
		width: 48%;
		border-radius: 20rpx;
		height: 600rpx;
		margin-bottom: 30rpx;
	}
	.h80{
		height: 80rpx;
	}
	.wh80{
		width: 100rpx;
		height: 100rpx;
		border-radius: 20rpx;
		margin-right: 20rpx;
		flex-shrink: 0;
	}
</style>
