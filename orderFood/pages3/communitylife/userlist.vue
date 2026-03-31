<template>
	<view class="content p20">
	        <!-- <mescroll-body @init="mescrollInit" @down="downCallback" @up="upCallback"> -->
	        	<view class="d-flex f-start b20 bg-fff p20" v-for="(item,index) in apply">
					<image :src="$util.getImgurl($util.isNull(item.user,'avatar'))" class="wh130" mode=""></image>
					<text class="fz-500 fz-28 m-l-30 m-r-auto" style="color: rgba(0, 0, 0, .5);">{{ $util.isNull(item.user,'username') || "" }}</text>
					<text class="fz-500 fz-28 " style="color: rgba(0, 0, 0, .5);">{{$util.parseTime(item.createtime,"{y}-{m}-{d} {h}:{i}:{s}")   || "" }}</text>
	        	</view>
	        <!-- </mescroll-body> -->
	</view>
</template>

<script>
	 export default{
		 data(){
			 return {
				 apply:[],
				 options:{},
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg'
			 }
		 },
		 onLoad(options){
		 			 this.options = options;
					 this.getDetail();
		 },
		 methods:{
			 async getDetail(){
			 				 let {apply} = await this.$u.api.getYanglaoActivityInfo({
			 				    id:this.options.id
			 				 });
			 				 if(apply){
			 					 this.apply = apply;
			 				 }
			 },
		 }
	 }
</script>

<style scoped lang="scss">
	.content{
		min-height: 100vh;
		background-color: #FAFAFA;
		padding: 30rpx 20rpx 20rpx 20rpx;
	}
	.wh130{
		width: 130rpx;
		height: 130rpx;
		border-radius: 50%;
	}
	
</style>