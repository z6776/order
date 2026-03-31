<template>
	<view class="txts">
		<text class="fz-707070 fz-32" :style="{color,fontSize}">{{minute}}:{{seconds}}</text>
	</view>
</template>

<script>
	export default {
		name:"Countdown",
		props:{
			color:{
				type:String,
				require:false
			},
			fontSize:{
				type:String,
				require:false
			},
			min_time:{
				type:Number,
				require:true
			},
			createtime:{
				type:Number,
				require:true
			}
		},
		data() {
			return {
				minute:"00",
				seconds:"00",
				timer:""
			}
		},
		computed: {
			minutefn() {
				return this.minute
			},
			secondsfn(){
				return this.seconds
			}
		},
		created() {
			this.timer = setInterval(()=>{
			   this.init()
			},1000)
		},
		methods: {
			 // 初始化时间
			 init(){
				 const new_timeStamp =  Number(new Date().getTime());
				 // 间隔时间 min_time   开始时间 createtime;
				 // 倒计时时间戳
				 const end_time = Math.floor(this.createtime*1000+Number(this.min_time*60*1000)-new_timeStamp)
				 
				  // console.log(this.createtime,end_time,"订单创建时间");
				 // 转分钟
				 this.minute = Math.floor(end_time/1000/60);
				 // 转秒
				 this.seconds =  Math.floor(end_time% (1000*60)   /1000) < 10 ? "0"+ Math.floor(end_time%(1000*60)/1000) : Math.floor(end_time%(1000*60)/1000);
				 
				 this.$forceUpdate()
			 }
		}
	}
</script>

<style scoped lang="scss">
.txts{
	
}
</style>