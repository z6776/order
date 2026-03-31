<template>
	<view class="content">
		<block v-for="(item,n) in grouponlist" :key="item.id">
			<view class="bg-fff p20 radius-20 m-b-20 p-b-0"  v-if="item.grouponList && item.grouponList.length">
				<view class="row d-flex f-start p-b-30 borderbottom">
					<image v-if="item.num==2" src="../../../static/images/two.png" mode="aspectFill" class="wh96"></image>
					<image v-if="item.num==5" src="../../../static/images/five.png" mode="aspectFill" class="wh96"></image>
					<image v-if="item.num==10" src="../../../static/images/ten.png" mode="aspectFill" class="wh96"></image>
					<view class="fz-000000 fz-32 fz-weight m-r-20" v-if="item.num!=2 && item.num!=5 && item.num!=10">
						{{item.num}}人团
					</view>
					<view class="line">
						|
					</view>
					<text class="price">拼成后价格</text>
					<text class="m-r-auto redprice">￥{{ item.price || ""  }}</text>
					<text class="price">已拼成 {{ item.oknum }} 份</text>
				</view>
				
				<view class="row d-flex f-start p-b-20 p-t-20" v-for="(v,i) in item.grouponList" :key="v.id">
					<image  :src="$util.cdnurl(v.user1.avatar)"  class="wh60 m-r-10 fs-0" mode=""></image>
					<text class="fz-28 fz-000000 fz-bold m-r-20 line1 max200">{{ v.user1.username || "匿名用户" }}</text>
					<text class="normal fs-0  m-r-auto" >还需要 {{ v.num-v.current_num }}人拼团成功</text>
					<view class="btn" hover-class="op9" @click.stop="canyu(v,item)" v-if="v.user_id && v.user_id!=member.id">
						 参与拼团
					</view>
				</view>
			</view>
		</block>
	   
	</view>
</template>

<script>
	import { mapState } from "vuex";
	 export default{
		 props:{
			 grouponlist:{
				 type:Array,
				 default:[]
			 }
		 },
		 computed:{
			 ...mapState(["member"])
		 },
		 data(){
			 return {
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg'
			 }
		 },
		 onLoad(){
			 
		 },
		 methods:{
			 // 参与拼团
			 canyu(v,item){
				// let props_text = this.skuList?.join(",");
				// item.productin.props_text = this.info.use_spec ? props_text : '';
				 let groupon = [{
				 	...item
				 }];
				 uni.setStorageSync("groupon",groupon);
				 // activity_id
				 return this.$util.navTo('/pages2/orderconfirm/index?type=groupon&activity_id='+item.activity_id+"&groupon_id="+v.id+"&activityProduct_id="+item.id);
			 }
		 }
	 }
</script>

<style scoped lang="scss">
	.max200{
		width: 200rpx;
	}
	.wh60{
		width: 60rpx;
		height: 60rpx;
		border-radius: 50%;
	}
	.normal{
		font-weight: 500;
		font-size: 28rpx;
		color: rgba(0,0,0,0.5);
	}
	.btn{
		 width: 160rpx;
		 height: 60rpx;
		 background: #FACE51;
		 border-radius: 100rpx 100rpx 100rpx 100rpx;
		 font-weight: 500;
		 font-size: 28rpx;
		 color: #000000;
		 text-align: center;
		 line-height: 60rpx;
	}
	.price{
		font-weight: 800;
		font-size: 28rpx;
		color: #D9D9D9;
	}
	.redprice{
		font-weight: 800;
		font-size: 28rpx;
		color: #FF0000;
	}
	.line{
		margin-right: 20rpx;
		font-weight: 800;
		font-size: 28rpx;
		color: #D9D9D9;
	}
	.content{
		// min-height: 100vh;
		background-color: #FAFAFA;
		// padding: 30rpx 20rpx 20rpx 20rpx;
		.wh96{
			width: 96rpx;
			height: 36rpx;
			margin-right: 20rpx;
		}
	}
	
</style>