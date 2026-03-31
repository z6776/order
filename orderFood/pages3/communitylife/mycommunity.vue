<template>
	<view class="content">
		<mescroll-body @init="mescrollInit" @down="downCallback" @up="upCallback">
	        <view class="d-flex f-warp p20">
	        	<view class="wh48 fs-0 m-b-20"  v-for="(item,i) in list"  :key="i" >
	        		 <a-item :info="item" @initList="initList" isme/>
	        	</view>
	        </view>
		</mescroll-body>
	</view>
</template>

<script>
	import MescrollMixin from "@/utils/mescroll.js";
	import aItem from "./a-item";
	 export default{
		 mixins:[MescrollMixin],
		 components: {
		 	aItem
		 },
		 data(){
			 return {
				 list: [],
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				 keyword:""
			 }
		 },
		 onLoad(){
			
		 },
		 methods:{
			 	initList(){
			 		this.list = [];
			 		 this.mescroll.resetUpScroll();
			 	},
			 	async upCallback(page){
			 	   let {data} = await this.$u.api.MyYanglaoActivity({
			 	       page:page.num,
			 	       pagesize:page.size
			 	   });
			 	   if(page.num==1){
			 	       this.list = [];
			 	   }
			 	   this.list =  [...this.list,...data];
				    this.mescroll.hideTopBtn();
			 	   this.mescroll.endSuccess(data.length, page.size == data.length);
			 	},
		 }
	 }
</script>

<style scoped lang="scss">
	.content{
		min-height: 100vh;
		background-color: #FAFAFA;
		padding: 20rpx 20rpx 20rpx 20rpx;
	}
	
</style>