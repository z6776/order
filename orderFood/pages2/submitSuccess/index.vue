<template>
	<view class="content">
	   <u-navbar :title="title" :is-back="false" :background="bgColorOpa" :border-bottom="false">
	   	<view class="p-l-20" @click="$util.back()">
	   		<u-icon name="arrow-left" size="32" color="#000000" bold></u-icon>
	   	</view>
	   </u-navbar>
	   
	   <image :src="title=='提交成功' ?   $util.cdnurl('submitsuc.png')  : $util.cdnurl('fksuc.png')" mode="" class="h807"></image>
	</view>
</template>

<script>
	 export default{
		 data(){
			 return {
				 title:"",
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg'
			 }
		 },
		 onLoad(query){
			 if(query.type=='fk'){
				  this.title = "反馈成功";
			 }else{
				  this.title = "提交成功";
			 }
			
		 },
		 methods:{
			 
		 }
	 }
</script>

<style scoped lang="scss">
	.content{
		min-height: 100vh;
	}
	.h807{
		position: absolute;
		width: 100%;
		height: 807rpx;
		top: 0;
	}
	
</style>