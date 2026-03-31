<template>
	<view class="orderpop">
	     <u-modal showCancelButton v-model="show" :title="title" @cancel="cancel" @confirm="confirm" :content='content' @close="cancel" :closeOnClickOverlay="true" confirmColor="#4cd964" cancelColor="#999999">
		 </u-modal>
	</view>
</template>

<script>
	 export default{
		 props:{
			 isShowSlot:{
				type:Boolean,
				default:false 
			 },
			 show:{
				type:Boolean,
				default:false 
			 },
			title:{
				type:String,
				default:"提示"
			},
			content:{
				require:true,
				type:String,
				default:""
			}
		 },
		 data(){
			 return {
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg'
			 }
		 },
		 onLoad(){
			 
		 },
		 methods:{
			 // 确认取餐
			 confirm(e){
				 this.$emit('confirm',e)
			 },
			 // 取消订单
			 cancel(e){
				this.$emit('update:show',false);
			 }
		 }
	 }
</script>

<style scoped lang="scss">
</style>