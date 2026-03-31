<template>
	<view class="content">
		<!-- <navbar :title="title" colors="#000000" bgColor="#ffffff"/> -->
		<rich-text :nodes="content|formatRichText"></rich-text>
		
	</view>
</template>

<script>
	// import { getxy } from "@/api/api.js";
	export default{
		data(){
			return{
				content:"",
				flag:0,
				msg:"",
				key:""  // 后端配置的key
 			}
		},
		filters: {
			formatRichText(html) {
				if(!html) return
				//控制小程序中图片大小
				let newContent = html.replace(/<img[^>]*>/gi, function(match, capture) {
					match = match.replace(/style="[^"]+"/gi, '').replace(/style='[^']+'/gi, '');
					match = match.replace(/width="[^"]+"/gi, '').replace(/width='[^']+'/gi, '');
					match = match.replace(/height="[^"]+"/gi, '').replace(/height='[^']+'/gi, '');
					return match;
				});
				newContent = newContent.replace(/style="[^"]+"/gi, function(match, capture) {
					match = match.replace(/width:[^;]+;/gi, 'max-width:100%;').replace(/width:[^;]+;/gi, 'max-width:100%;');
					return match;
				});
				newContent = newContent.replace(/<br[^>]*\/>/gi, '');
				newContent = newContent.replace(/\<img/gi, '<img style="max-width:100%;height:auto;display:inline-block;margin:10rpx auto;"');
				return newContent;
			}
		},
		onLoad(query){
			if(query.key){
				this.key = query.key;
			}
			if(query.title){
				this.title = decodeURIComponent(query.title);
				uni.setNavigationBarTitle({
					title:query.title
				});
				this.getdetail();
			}
		},
		methods:{
			// 关于我们
			async getdetail(type){
				let data = await this.$u.api.attentionOrder({
					key:this.key
				});
				this.content = data;
			}
			
		}
	}
</script>

<style scoped lang="scss">
	.content{
		// padding: 20rpx 20rpx;
		padding-bottom: 100rpx;
	}
	.fixtxt{
		position: fixed;
		right: 0rpx;
		left: 0;
		bottom: 60rpx;
		text-align: center;
		height: 80rpx;
		line-height: 80rpx;
		font-size: 32rpx;
		color: red;
		// 
		font-size: 28rpx;
		font-family: PingFang SC-Medium, PingFang SC;
		font-weight: 500;
		color: #ffffff;
		background-color:#4EE7D5;
	}
</style>