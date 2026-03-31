<template>
	<view class="content">
		<image :src="$util.cdnurl('minebg.png')" class="minebg" mode=""></image>
		<view class="bgf7bf35">
			<u-navbar title="社区生活" :is-back="false" :background="bgColorOpa" :border-bottom="false">
				<view class="p-l-20" @click="$util.back()">
					<u-icon name="arrow-left" size="32" color="#000000" bold></u-icon>
				</view>
			</u-navbar>
			<msearch v-model="keyword" @search="initList"/>
		</view>
		<mescroll-body @init="mescrollInit" @down="downCallback" @up="upCallback">
			<view class="d-flex f-warp p20">
				<view class="wh48 fs-0 m-b-20"  v-for="(item,i) in list"  :key="i" >
					 <a-item :info="item"/>
				</view>
			</view>
		</mescroll-body>
	</view>
</template>

<script>
	import msearch from "@/components/m-search/index.vue";
	import aItem from "./a-item";
	import MescrollMixin from "@/utils/mescroll.js";
	export default {
		mixins:[MescrollMixin],
		components: {
			msearch,
			aItem
		},
		data() {
			return {
				list: [
					// {
					//     status:"未开始",
					// 	image: "../../static/emptyCart.jpg",
					// 	title: "健康之源",
					// 	desc: "健康的重要性，如何保持健康的重要性，如何保持...",
					// 	time: "08/30 08:30-09:00",
					// 	address: "新创福养老中心",
					// 	sq:"新创福养老中心社区",
					// 	pnum: 500
					// }, {
					// 	status:"进行中",
					// 	image: "../../static/emptyCart.jpg",
					// 	title: "读书会",
					// 	desc: "养老社区读书会",
					// 	time: "08/30 08:30-09:00",
					// 	address: "新创福养老中心",
					// 	sq:"新创福养老中心社区",
					// 	pnum: 500
					// }, {
					// 	status:"已结束",
					// 	image: "../../static/emptyCart.jpg",
					// 	title: "健康之源",
					// 	desc: "健康的重要性，如何保持健康的重要性，如何保持...",
					// 	time: "08/30 08:30-09:00",
					// 	address: "新创福养老中心",
					// 	sq:"新创福养老中心社区",
					// 	pnum: 500
					// }, {
					// 	status:"已结束",
					// 	image: "../../static/emptyCart.jpg",
					// 	title: "健康之源",
					// 	desc: "养老社区读书会",
					// 	time: "08/30 08:30-09:00",
					// 	address: "新创福养老中心",
					// 	sq:"新创福养老中心社区",
					// 	pnum: 500
					// }
				],
				keyword: "",
				src: 'https://cdn.uviewui.com/uview/album/1.jpg'
			}
		},
		onLoad() {

		},
		methods: {
			tagStyle(status){
					 let bg = [{
						 title:"未开始",
						 color:"#FB7A35"
					 },{
						 title:"进行中",
						 color:"#9EF98A"
					 },
					 {
						 title:"已结束",
						 color:"#979797"
					 },
					 {
						 title:"已取消",
						 color:"#979797"
					 }];
					 let index = bg.findIndex(v=>v.title==status);
					 return index>-1 ? bg[index].color : "#979797";
					 				 
			},
			// 搜索列表
			searchtit(e){
			   this.keyword = e;
			   this.initList();
			},
			initList(){
				this.list = [];
				 this.mescroll.resetUpScroll();
			},
			async upCallback(page){
			   let {data} = await this.$u.api.getYanglaoActivity({
			       name:this.keyword || "",//string	否	名称或手机号
			       page:page.num,
			       pagesize:page.size
			   });
			   console.log(data,"datatata");
			   if(page.num==1){
			       this.list = [];
			   }
			   this.list =  [...this.list,...data];
			   this.mescroll.endSuccess(data.length, page.size == data.length);
			},
			change(index) {
			   this.current = index;
			  this.initList();
			}

		}
	}
</script>

<style scoped lang="scss">
	.content {
		min-height: 100vh;
	}

	.minebg {
		position: fixed;
		top: 0;
		left: 0;
		right: 0;
		width: 100%;
		height: 100vh;
		z-index: -1;
	}

	.bgf7bf35 {
		box-sizing: border-box;
		padding: 20rpx;
	}
</style>