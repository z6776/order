<template>
	<view :class="{'content':true,'d-flex':true,'f-start':left,'a-start':start,'p-l-0':ispadding}" @click="change"
	data-type="text"
	:data-text="title" 
	class="draw_canvas"
	:style="{border,marginTop,paddingRight}">
        <view class="title" :style="{color:titlecolor,maxWidth:titwidth,width:titlewidth}" v-if="title">{{title}}</view>
		<slot name="title"/>
		<view :class="{slt:true,'flex-1':left}">
			<slot />
		</view>
	</view>
</template>

<script>
	export default {
		props:{
			titlewidth:{
				type:String,
				default:""
			},
			whiteSpace:{
				type:String,
				default:"nowrap"
			},
			paddingRight:{
				type:String,
				default:""
			},
			titwidth:{
				type:String,
				default:""
			},
			ispadding:{
				type:Boolean,
				default:false
			},
			titlecolor:{
				type:String,
				default:"#000000"
			},
			marginTop:{
				type:String,
				default:""
			},
			start:{
				type:Boolean,
				default:false
			},
			left:{
				type:Boolean,
				default:false
			},
			border:{
				type:String,
				default:""
			},
			title:{
				type:String,
				default:""
			}
		},
		data(){
			return{
				
			}
		},
		methods:{
			change(){
				this.$emit("change")
			}
		}
	}
</script>

<style scoped lang="scss">
.content{
	padding-top: 40rpx;
	padding-bottom: 40rpx;
	border-bottom: 2rpx solid #F9F9F9;
	padding-left: 32rpx;
	.title{
		font-size: 32rpx;
		font-family: PingFang SC-Medium, PingFang SC;
		font-weight: 500;
		color: #000000;
	}
}
.p-l-0{
	padding-left: 0rpx !important;
}
</style>