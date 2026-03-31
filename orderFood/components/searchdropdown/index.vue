<template>
	<view class="search d-flex" :style="{'max-height':maxHeight+'px'}">
		<view class="d-flex" @click.stop="showfn('0')">
			<text class="fz-28 fz-weight fz-666666 m-r-4">{{ rotateList[0]['list'][rotateList[0]['current']].name }}</text>
			<image src="../../static/yxyp.png" class="wh28" mode="aspectFill"  :class="{'rotate':rotateList[0].flag,'iconarrow':true}"></image>
		</view>
		<view class="d-flex" @click.stop="(e)=>showfn('1')">
			<text class="fz-28 fz-weight fz-666666 m-r-4">{{ rotateList[1]['list'][rotateList[1]['current']].name }}</text>
			<image src="../../static/yxyp.png" class="wh28" mode="aspectFill"  :class="{'rotate':rotateList[1].flag,'iconarrow':true}"></image>
		</view>
		<view class="d-flex" @click.stop="(e)=>showfn('2')">
			<text class="fz-28 fz-weight fz-666666 m-r-4">{{ rotateList[2]['list'][rotateList[2]['current']].name }}</text>
			<image src="../../static/yxyp.png" class="wh28" mode="aspectFill"  :class="{'rotate':rotateList[2].flag,'iconarrow':true}"></image>
		</view>
		<!-- city选择 -->
		<view class="city" :style="{'height':minheight}" v-if="show" @click="closefn()" @touchmove.stop> 
			<view class="citylist" @click.stop>
				<view class="city_item line1" v-for="(item,index) in list" :class="{active:index==rotateList[type].current}" @click="selectItem(index)">
					 {{item.name || ""}}
				</view>
				<view class="w24" v-for="(item,index) in 3">
				</view>
			</view>
		</view>
	</view>
</template>

<script>
export default {
	props:{
		title:{
			type:String,
			default:""
		}
	},
	watch:{
		title:{
			handler(val){
			 	if(val){
					let cur = this.rotateList[1]['list'].findIndex(v=>v.name==val);
					if(cur>=0){
						this.rotateList[1].current = cur; 
					}
				}
			}
		}
	},
	data(){
		return{
			rotateList:[{
				emit:"getsq",
				current:0,
				select:"",
				flag:false,
				list:[{
					name:"全部社区"
				},{
					name:"1区"
				},{
					name:"2区"
				},{
					name:"3区"
				},{
					name:"4区"
				},{
					name:"5区"
				},{
					name:"6区"
				}]
			},{
				emit:"getxq",
				current:0,
				flag:false,
				list:[]
			},
			{
				    emit:"getorder",
					current:0,
					flag:false,
					// 1.待付款 2.待取餐 3.待评价 4，已完成 5.已取消 6.退款 ,7.拼团中,
					list:[
					{
						name:"订单状态",
						id:""
					},
					{
						name:"待取餐",
						id:2
					},{
						name:"待评价",
						id:3
					},{
						name:"已完成",
						id:4
					},{
						name:"退款/售后",
						id:6
					}]
			}],
			list:[],
			maxHeight:40,
			minheight:"",
		    show:false	,
		    type:0
		}
	},
	mounted(){
		const area = uni.createSelectorQuery().in(this);
		this.$nextTick(()=>{
			area.select('.search').boundingClientRect(B=>{
				 this.maxHeight = B.bottom+"px";
				 this.$emit("getBottom",B.top);
			}).exec();
		});
		// 获取小区列表
		this.getValiages();
	},
	methods: {
		// 获取小区列表
		async getValiages(){
			let data = await this.$u.api.getVillageList();
			this.rotateList[1].list = data?.data;
			this.rotateList[1].list.unshift({
				name:"全部小区",
				value:"0"
			});
		},
		closefn(){
			this.show = false;
			for (let i = 0; i <  this.rotateList.length; i++) {
				this.rotateList[i].flag = false;
			};
		},
		selectOrder(index){
			for (let i = 0; i <  this.rotateList.length; i++) {
				this.rotateList[i].flag = false;
			};
			this.show = false;
			if(this.rotateList[index].orderby=='asc'){
				this.rotateList[index].orderby='desc';
			}else{
				this.rotateList[index].orderby='asc';
			}
		},
		selectItem(index){
			this.$set(this.rotateList[this.type],"current",index);
			this.show = false;
			this.rotateList[this.type].flag = false;
			this.$emit(this.rotateList[this.type].emit,this.list[index].value);
		},
		showfn(type){
			// 与之前选项不同的不隐藏弹窗;
			let index = this.rotateList.findIndex(v=>v.flag);
			if(index>-1 && index!=type){
				this.show = true;
			}else{
				this.show = !this.show;
			}
			for (let i = 0; i <  this.rotateList.length; i++) {
				if(i!=type){
					this.rotateList[i].flag = false;
				}
			};
			this.rotateList[type].flag = !this.rotateList[type].flag;
			this.list = this.rotateList[type].list;
			this.type = type;
			console.log(this.rotateList,"this.listthis.list");
			console.log(type,"typetypetypetypetypetype");
		},
		handleClose() {
			if (!this.show) {
				return;
			}
			this.$emit('close', {});
		},
		px(num) {
			return uni.upx2px(num) + 'px';
		}
	}
};
</script>

<style scoped lang="scss">
.search{
	padding: 20rpx;
	width: 710rpx;
	border-radius: 20rpx 20rpx 0rpx 0rpx;
	position: relative;
	.city{
		left: -20rpx;
		right: -20rpx;
		position: absolute;
		top: 80rpx;
		z-index: 11;
		background-color: rgba(0, 0, 0, .3);
		.citylist{
			padding: 20rpx;
			display: flex;
			justify-content: space-between;
			flex-wrap: wrap;
			background-color: #FFFFFF;
			.city_item{
				color: #666666;
				font-size: 28rpx;
				border: 2rpx solid #999999;
				width: 24%;
				border-radius: 10rpx;
				text-align: center;
				line-height: 60rpx;
				margin-bottom: 30rpx;
			}
			.w24{
				width: 24%;
			}
		}
	
		
	}
}
.active{
	border: 2rpx solid transparent !important;
	background-color: #FACE51;
	color: #fff !important;
}
.iconarrow{
	width: 28rpx;
	height: 20rpx;
	transition: transform .3s linear;
}
.rotate{
	transform: rotate(180deg);
}

.m-r-4{	
	margin-right: 4rpx;
}
</style>
