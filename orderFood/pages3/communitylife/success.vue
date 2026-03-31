<template>
	<view class="content d-c-flex f-start">
	        <image src="../../static/images/newStatic/success.png" class="wh200 falling-image" mode=""></image>
			<view class="fz-32 fz-500 m-b-136 m-t-30" style="color: rgba(0,0,0,0.5);">
				报名成功
			</view>
			<mybtn msg="返回" @handclick="$util.back()"/>
	</view>
</template>

<script>
	 export default{
		 data(){
			 return {
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg'
			 }
		 },
		 onLoad(){
			 
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
	.m-b-136{
		margin-bottom: 136rpx;
	}
	.wh200{
		width: 200rpx;
		height: 200rpx;
	}
	
	.falling-image {  
	  position: relative; /* 或者 absolute/fixed，根据你的布局需求 */  
	  animation: fallAndBounce 1s ease-out forwards; /* 动画名称、持续时间、动画曲线和填充模式 */  
	}  
	  
	@keyframes fallAndBounce {  
	  0% {  
	    top: -100px; /* 初始位置在可视区域之上 */  
	    opacity: 0; /* 初始透明度为0，使动画开始时不可见 */  
	  }  
	  10% {  
	    opacity: 1; /* 降落过程中变得可见 */  
	  }  
	  70% {  
	    top: 0; /* 下降到初始位置 */  
	  }  
	  80% {  
	    top: -20px; /* 第一次弹跳向上 */  
	  }  
	  90% {  
	    top: 0; /* 弹回到初始位置 */  
	  }  
	  95% {  
	    top: -30px; /* 第二次弹跳向上，但幅度减小 */  
	  }  
	  100% {  
	    top: 0; /* 最终停留在初始位置 */  
	  }  
	}
	
</style>