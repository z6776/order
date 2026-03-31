<template>
	<view class="pagebox">
		 <view class="p20 bg-fff radius-20 m-b-30">
		 	  <view class="m-b-20">
				   <text class="fz-32 fz-000000">问题/建议描述</text>
				   <text class="fz-ff0000">*</text>
		 	  </view>
			 <textarea v-model="form.feedback" placeholder="请描述具体建议/问题发生过程,越详细越能高效处理哦" cols="30" rows="10" class="ints"></textarea>
		 </view>
		 
		 <view class="p20 bg-fff radius-20">
		 	 <view class="m-b-30 fz-32 fz-000000 fz-weight">
		 	 	  请将您遇到的问题图片上传
		 	 </view>
			 <view class="basecolor fz-28">
			 	 有效的图片信息有助于解决问题哦~
			 </view>
			 <u-upload :action="action"  :show-tips="false" :show-progress="false" :file-list="fileList" ref="uupload"></u-upload>
		 </view>
		 
		 <view class="boxFixed bgt">
		 		 <mybtn msg="提交" @handclick="submit" />
		 </view>
		 
	
	</view>
</template>

<script>
	import { baseUrl } from '../../common/const';
	// 
	export default{
		data(){
			return{
				feedback:"",
				action:baseUrl+'/api/common/upload',
				fileList: [
					
				]
			}
		},
		methods:{
			// 提交
			async submit(e){
				if(!this.feedback){
					 return this.$u.toast("请输入描述");
				};
				let files = [];
				this.$refs.uupload.lists.map(s=>{
					console.log(s,"vvvvvvvvv");
					if(s && s.response && s.response.data){
						files.push(s.response.data.url)
					}
				})
				uni.showLoading({
					title:"提交中..."
				});
				const res = await this.$u.api.feedback({
					desctxt:this.feedback || "", //string	是	描述
					attachfiles:files.join(",") // 	string	否	附件
				});
				this.$util.navTo("/pages2/submitSuccess/index?type=fk")
				console.log(e);
			}
		}
	}
</script>

<style scoped lang="scss">
	.ints{
		width: 100%;
		border-radius: 20rpx;
		background: #eeeeee;
		padding: 10rpx 20rpx;
	}
</style>