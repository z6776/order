<template>
	<view class="content">
	      <web-view :src="src"></web-view>  
	</view>
</template>

<script>
	 export default{
		 data(){
			 return {
				 src:""
			 }
		 },
		 onLoad(query){
			 this.src = query.url;
		 },
		 methods:{
			 
		 }
	 }
</script>

<style scoped lang="scss">
	.content{
		min-height: 100vh;
		background-color: #FAFAFA;
		padding: 30rpx 20rpx 20rpx 20rpx;
	}
	
</style>