<template>
    <view class="page">
        <view class="p20 bg-fff">
			<u-search @search="confirm"  placeholder="请输入幸福食堂商品名称/养老服务项目名称"  v-model="keyword" :show-action="false"></u-search>
        </view>
		
		<view class="p20 p-t-0">
			<view class="history" v-if="isLogin">
			    <view class="title d-flex p-r-20">
					<text>历史记录</text>
					<view class="iconboxs" @click="delfn()" v-if="history_list && history_list.length">
						<u-icon name="trash" color="#666666" size="32"></u-icon>
					</view>
			    </view>
			    <view class="history_box">
			        <view class="history_li d-flex" v-for="(item,index) in history_list"  @click="delitem(index,1)">
						<text class="m-r-10">{{item.title || ""}}</text>
						<view class=""  @click.stop="delitem(index,2)">
								<u-icon name="close" size="28" color="#000000"></u-icon>
						</view>
					
			        </view>
			    </view>
			    <view class="history_bottom" v-if="!history_list || history_list.length==0">
			        暂无搜索历史
			    </view>
			</view>
			<!--  -->
			<view class="history" style="margin-top: 50rpx;" v-if="false">
			    <view class="title">
			        热门搜索
			    </view>
			    <view class="history_box">
			        <view class="history_li" v-for="(item,index) in hot_list">
			            {{item}}
			        </view>
			    </view>
			    <view class="history_bottom" v-if="!hot_list || hot_list.length==0">
			        暂无热门历史
			    </view>
			</view>
		</view>
      
    </view>
</template>

<script>
	import { mapGetters }  from "vuex";
    export default {
		computed:{
				...mapGetters(['isLogin']),
		},
        data() {
            return {
				history_list:[],
                keyword:''
            }
        },
		onLoad() {
			// this.getlist('history');
			// this.getlist('hot');
		},
		onShow(){
			let arr = uni.getStorageSync("histotylist");
			if(arr && arr.length){
				this.history_list = arr;
			}
		},
        methods: {
			confirm(e){
				this.$util.navTo('/pages/index/qualitymerchants?title='+e,false)
				this.save()
			},
			delfn(){
				uni.showModal({
					title: '提示',
					content: '确定清空历史记录?',
					success: ({
						confirm
					}) => {
						if (confirm) {
							uni.removeStorageSync("histotylist");
							this.history_list = [];
						}
					}
				})
			},
			// 删除
			delitem(index,type){
				if(type==2){
					this.history_list.splice(index,1);
					uni.setStorageSync("histotylist",[...this.history_list])
				}else{
					this.$util.navTo('/pages/index/qualitymerchants?title='+this.history_list[index].title)
					this.save()
				}
			},
			del(i){
				this.$set(this.history_list[i],"active",true)
			},
			// 增加历史搜索
			save(){
				console.log(this.keyword,"我的关键字")
				if(this.keyword){
					 uni.setStorageSync("histotylist",[...this.history_list,{title:this.keyword}])
				}
			},
			getlist(type){
				let data = {
					page:1,
					list_rows:9999,
					type
				}
				this.$api.request('/api/search/getSearch','get',data).then(res=>{
					   if(type=='history'){
						   this.history_list = res.data;
					   }else{
						    this.hot_list = res.data;
					   }
				})
			},
            // 搜索事件
            search(){
              
            }
        }
    }
</script>

<style lang="scss" scoped>
    .page{
		min-height: 100vh;
		background-color: #ffffff;
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
</style>
