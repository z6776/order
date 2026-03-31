<template>
	<view class="dropmenu m-b-20">
			  <zxz-uni-data-select ref="select" @close="closefn" :placeholder="defaultmsg" :isEnd="is_valiage_end" @scdown="scrolltolower" @inputChange="inputChange" filterable  v-model="valiage_value"
			  :localdata="valiage_range"
			  @change="valiageCheckfn"/>
			  <!-- <picker mode='multiSelector' class="w-100" @change="changeztd" @columnchange="bindPickerChange" range-key="name" :value="rangevalue" :range="valiagelist">
				  <view class="d-flex w-100">
					   <text class="fz-28 fz-979797 m-r-auto">{{  msg || defaultmsg}}</text>
					   <view class="">
					   	  <image src="../../static/yxyp.png" class="wh30" mode="" v-if="!msg"></image>
					   	  <view class="d-flex j-center wh40"  v-else @click.stop="close">
					   	  	<image src="../../static/images/pay/close.png" class="wh20" mode=""></image>
					   	  </view>
					   </view>
				  </view>
			  </picker> -->
	</view>
</template>

<script>
	import valiageCheck from './valiage.js';
	 export default{
		 // mixins:[valiage],
		  mixins:[valiageCheck],
		 props:{
			 defaultmsg:{
				 type:String,
				 default:""
			 },
			 list:{
				type:Array,
				default:[{
					title:"取餐点",
					value:"1"
				},{
					title:"取餐点2",
					value:"2"
				}]  
			 },
			 align:{
				type:String,
				default:"" 
			 },
			 msg:{
				 type:String,
				 default:""
			 }
		 },
		 data(){
			 return {
				
				 show:false,
				 maxHeight:60,
				 src: 'https://cdn.uviewui.com/uview/album/1.jpg'
			 }
		 },
		 mounted(){
			
		 },
		 methods:{
			 // 
			 getSq(){
				 
			 },
			 // 
			 closefn(){
				 this.$emit("update:msg","");
				 this.$emit("update:timevalue","");
				 this.$emit("init");
				 this.inputChange("");
				 this.$refs.select.toggleSelector();
			 },
			 // 切换
			 bindPickerChange(e){
				 console.log(e,"eeeeeeeeeeee");
				 if(e.detail.column==0){
					 let id = this.columnList1[e.detail.value].id;
					 // 切换自提点
					 this.getSelfpickupList(id);
				 }
			 },
			 // 确认时间
			 changeztd(e){
				 // 自提点
				 // changeztd(e){
					//  this.form.village_id = this.columnList1[e.detail.value[0]].id; // 小区id
					//  this.villagename = this.columnList1[e.detail.value[0]].name;
					//  this.form.selfpcikup_id = this.columnList2[e.detail.value[1]].id; // 自提点id
					//  this.selfpcikupname = this.columnList2[e.detail.value[1]].name; // 自提点id
					//  // debugger;
					//  console.log(e,"eeeeeeeee");
				 // }, 
				 this.show = false;
				 this.$emit("update:msg",this.columnList2[e.detail.value[1]].name);
				 this.$emit("update:timevalue",this.columnList2[e.detail.value[1]].id);
				 this.$emit("init");
			 },
			 // 切换地点
			 valiageCheckfn(e) {
				 if(e){
					 this.$emit("update:msg",e.text);
					 this.$emit("update:timevalue",e.value);
					 this.$emit("init");
				 }
			 	// this.form.village_id = e.village_id; // 小区id
			 	// this.form.selfpcikup_id = e.selfpcikup_id; // 自提点id
			 },
			 open(){
				this.show = !this.show;
			 }
		 }
	 }
</script>

<style scoped lang="scss">
	.content{
		// min-height: 100vh;
		// background-color: #FAFAFA;
		// padding: 30rpx 20rpx 20rpx 20rpx;
	}
	.left{
		left: 0;
	}
	.right{
		right: 0;
	}
	
	.h80{
		max-width: 100%;
		color: #000000;
		height: 80rpx;
		line-height: 80rpx;
	}
	.wh20{
		width: 20rpx;
		height: 20rpx;
	}
	.dropmenu{
		background-color: #FFFFFF;
	}
	.bgtime{
		// padding: 0 40rpx;
		// width: 347rpx;
		// height: 60rpx;
		border-radius: 60rpx;
		// background-color: #FFFFFF;
		// font-weight: 500;
		// font-size: 32rpx;
		// color: #979797;
		
	transition: max-height .3s linear;
	// overflow: hidden;
	position: relative;
	.drop{
		position: absolute;
		top: 60rpx;
		width:347rpx;
		// height: 600rpx;
		background-color: #fff;
		z-index: 99999;
	}
		.wh30{
			width: 35rpx;
			height: 35rpx;
		}
		.wh40{
			height: 60rpx;
			width: 60rpx;
		}
	}
	
</style>