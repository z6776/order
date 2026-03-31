<template>
	<view :class="[trans? 'transbtn' : 'mybtn']" :style="{background,borderRadius:radius,fontSize,marginTop,width,height,lineHeight:height,color,borderColor:color}" @click.stop="handClick" hover-class="op9">
			{{msg}}
	</view>
</template>

<script>
	export default {
		props:{
			background:{
				type:String,
				default:"#FACE51"
			},
			fontSize:{
				type:String,
				default:""
			},
			trans:{
				type:Boolean,
				default:false
			},
			color:{
				type:String,
				default:""
			},
			height:{
				type:String,
				default:""
			},
			width:{
				type:String,
				default:""
			},
			marginTop:{
				type:String,
				default:""
			},
			radius:{
				type:String,
				default:""
			},
			msg:{
				type:String,
				default:"提交"
			}
		},
		data(){
            return{

            }
        },
        methods:{
			handClick(){
				this.$emit("handclick");
			}
        }
	}
</script>

<style scoped lang="scss">
	.transbtn{
		width: 642rpx;
		height: 80rpx;
		margin: 0 auto;
		background: #fff;
		background-repeat: no-repeat;
		background-size: cover;
		text-align: center;
		line-height: 80rpx;
		color: #83C5F8;
		border-radius: 50rpx;
		border: 2rpx solid #83C5F8;

	}
.mybtn{
	width: 642rpx;
	height: 80rpx;
	margin: 0 auto;
	font-weight: 800;
	background-repeat: no-repeat;
	background-size: cover;
	text-align: center;
	line-height: 80rpx;
	color: #000000;
	border-radius: 50rpx;
	
}
</style>