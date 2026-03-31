<template>
	<view class="content">
		<u-navbar title="订单详情" :is-back="false" :background="bgColorOpa" :border-bottom="false">
			<view class="p-l-20" @click="$util.back()">
				<u-icon name="arrow-left" size="32" color="#000000" bold></u-icon>
			</view>
		</u-navbar>
		
		<view class="person m-b-20 p-b-0">
			<view class="m-b-20 d-flex f-start">
				<image class="wh70"  :src="$util.cdnurl('daizhifu.png')"  mode="" v-if="info.order_status_text=='待付款'"></image>
				<image class="wh70"  :src="$util.cdnurl('daiqucan.png')"  mode="" v-if="info.order_status_text=='待取餐'"></image>
				<image class="wh70" :src="$util.cdnurl('pinjia.png')"   mode="" v-if="info.order_status_text=='已取消'"></image>
				<image class="wh70"   :src="$util.cdnurl('pinjia.png')"  mode="" v-if="info.order_status_text=='待评价'"></image>
				<image class="wh70"  :src="$util.cdnurl('finish.png')" mode=""  v-if="info.order_status_text=='已完成'"></image>
				<text class="fz-333333 fz-32 fz-weight m-r-20">{{ info.order_status_text || "" }}</text>
			</view>
			
			<view class="fz-979797 fz-26 fz-weight d-flex f-start">
				<block v-if="info.order_status_text=='待付款' && $util.isShowcon(info) ">未支付订单将在<countdown color="#FB7A35" fontSize="26rpx" :min_time="10" :createtime="createtime"></countdown>后取消订单,请您尽快支付哦~</block>
			    <block v-if="info.order_status_text=='待取餐'">您的订单准备中</block>
				<block v-if="info.order_status_text=='待评价'">您的订单已完成,请评价~</block>
				<block v-if="info.order_status_text=='已取消'">您的订单超时关闭~</block>				 
			</view>
		</view>

		<view class="supermarket bg-fff radius-20">
			<view class="m-b-20 d-flex">
				<text class="fz-32 fz-333333 fz-weight m-r-10">商品信息</text>
				<text class="fz-28 fz-000000 m-r-10" v-if="info.subtype==2">配送到家</text>
				<text class="fz-28 fz-000000 m-r-10" v-if="info.subtype==1">堂食</text>
				<text class="fz-28 fz-000000 m-r-10" v-if="info.subtype==3">配送点自提</text>
			</view>
			<view class="m-b-30" v-for="(v,i) in info.products" :key="v.id">
				<view class="cart-item" :class="{'endclass':i==1}">
					<view class="image-wrapper m-l-20">
						<image :src="$util.getImgurl(v.image)" @click.stop="$util.lookimg(v.image)" class="loaded" mode="aspectFill"></image>
					</view>
					<view class="item-right p-t-10 p-b-10">
						<view class="d-flex f-start">
							<view class="tagStyle m-r-10" v-if="info.activity_type=='seckill'">福利抢购</view>
							<view class="tagStyle m-r-10" v-if="info.activity_type=='groupon'">超值拼团</view>
							<text class="clamp fz-bold fz-28 fz-000000">{{ v.title || "" }}</text>
						</view>
						<view class="d-flex f-start m-t-10 m-b-10">
							<text class="fz-28 basecolor">￥{{orderpriceone(v)}}x{{ v.number || "1" }} </text>
							<text class="fz-24 basecolor">(另需打包费:￥{{ v.package_price || v.packing_price || "0" }}元)</text>
						</view>
						<view class="fz-28 basecolor m-b-10" v-if="v.spec || v.desc">
							{{ v.spec || "" }}{{v.desc || ""}}
						</view>
						<view class="d-flex">
							<text class="price fz-24 fz-000000 m-r-auto">商品金额￥{{orderpriceone(v)}}元 </text>
							<text class="fz-979797 fz-28 fz-weight">实付：</text>
							<text class="basecolor fz-28 fz-weight">￥{{ orderpricefn(v)|| "" }}</text>
						</view>
					</view>
				</view>
				<view class="d-flex f-end">
					<view class="getOther" v-if="shstatus && v.aftersale_status!=2" @click.stop="shfn(v)">
						申请售后
					</view>
					<view class="tgOther" v-if="!(shstatus && v.aftersale_status!=2) && info.have_paid">
						已退款
					</view>
					
					<view class="getOther m-l-20" @click.stop="$util.navTo('/pages2/shopdetail/index?id='+v.product_id)">
						再来一件
					</view>
				</view>
				
			</view>
			
			<view class="form bg-fff radius-20 p-30-20 d-c-start-flex m-t-30">
				<view class="formitem d-flex">
					<text class="fz-28 fz-weight basecolor">商品总额</text>
					<text class="fz-28  fz-000000">￥{{ info.total_price || "" }}元</text>
				</view>
				<view class="formitem d-flex">
					<text class="fz-28 fz-weight basecolor">优惠金额</text>
					<text class="fz-28  fz-000000">￥{{ info.discount_price || "" }}元</text>
				</view>
				<view class="formitem d-flex">
					<text class="fz-28 fz-weight basecolor">福豆抵扣金额</text>
					<text class="fz-28  fz-000000">￥{{ info.score_discount_price || "" }}元</text>
				</view>
				<block v-if="info.subtype==2">
					<view class="formitem d-flex">
						<text class="fz-28 fz-weight basecolor">配送费</text>
						<text class="fz-28  fz-000000">￥{{ info.delivery_price || "" }}元</text>
					</view>
				</block>
				<block v-if="info.subtype!=1">
					<view class="formitem d-flex">
						<text class="fz-28 fz-weight basecolor">打包费</text>
						<text class="fz-28  fz-000000">￥{{ info.packing_price || "" }}元</text>
					</view>
				</block>
				
				<view class="formitem d-flex">
					<text class="fz-32 fz-weight fz-333333">合计支付</text>
					<text class="fz-32  fz-333333">￥{{ info.total_price|| "" }}元</text>
				</view>
			</view>
		</view>
		
	<!-- 	
		<text class="fz-28 fz-000000 m-r-10" v-if="info.subtype==2">配送到家</text>
		<text class="fz-28 fz-000000 m-r-10" v-if="info.subtype==1">堂食</text>
		<text class="fz-28 fz-000000 m-r-10" v-if="info.subtype==3">配送点自提</text> -->
		
		<view class="form bg-fff radius-20 p-30-20 d-c-start-flex m-t-30" v-if="info.subtype==1">
			<view class="formitem d-flex m-b-20">
				<text class="fz-32 fz-weight fz-333333">堂食信息</text>
			</view>
			<view class="formitem d-flex  a-start">
				<image :src="$util.cdnurl('ztaddress.png')"  class="wh40  m-r-10" mode=""></image>
				<text class="m-r-auto fz-000000 fz-28 fs-0">食堂:</text>
				<text class="fz-28 basecolor w462">{{ $util.isNull(info.village,'name')  || "" }}</text>
			</view>
			
			<view class="formitem d-flex a-start" @click.stop="$util.openLocation($util.isNull(info.village,'longitude'),$util.isNull(info.village,'latitude'),$util.isNull(info.village,'name'),$util.isNull(info.village,'address'))">
				<image  :src="$util.cdnurl('address.png')"  class="wh40  m-r-10" mode=""></image>
				<text class="fz-000000 fz-28 fs-0 m-r-auto">地址:</text>
				<view class="d-c-flex a-start flex-1 m-l-20 fz-right">
						<text class="fz-28 basecolor m-r-20" style="color: #1861fb;">{{ $util.isNull(info.village,'address')  || "" }}</text>
				</view>
			</view>
			
			
			<view class="formitem d-flex  a-start">
				<image  :src="$util.cdnurl('address.png')"  class="wh40  m-r-10" mode=""></image>
				<text class="m-r-auto fz-000000 fz-28">联系人:</text>
				<view class="d-c-flex a-start">
					<view>
						<text class="fz-28 basecolor m-r-20">{{ info.extend.usernmae || "" }}</text>
						<text class="fz-28 basecolor">({{ $util.hideMiddleFourOfPhoneNumber(info.extend.phone)}})</text>
					</view>
				</view>
			</view>
			
			<view class="d-flex ">
				<image  :src="$util.cdnurl('ztclock.png')"  mode="" class="wh40 m-r-10"></image>
				<text class="m-r-auto fz-000000 fz-28">堂食时间:</text>
				<text class="fz-28 basecolor">{{ $util.parseTime(info.getdate,"{y}-{m}-{d}") }}</text>
				<text class="fz-28 basecolor">{{ $util.isam(info.isam) }}</text>
			</view>
			
			<view class="p-b-30 borderbottom">
				
			</view>
			
			<view class="basecolor breakword">
				<text>备注:</text>
				<text>{{ info.remark || "" }}</text>
			</view>
			
		</view>
		
				
		<view class="form bg-fff radius-20 p-30-20 d-c-start-flex m-t-30" v-if="info.subtype!=1">
			<view class="formitem d-flex">
				<text class="fz-32 fz-weight fz-333333">配送信息</text>
			</view>
			<!-- 配送到家 -->
			<block v-if="info.subtype==2">
				<view class="formitem d-flex f-start">
					<image  :src="$util.cdnurl('ztaddress.png')"  class="wh40 m-r-10" mode=""></image>
					<text class="fz-000000 fz-28 m-r-auto">地址</text>
					<text class="basecolor fz-28" v-if="info.address">{{ info.address.address  || "" }}</text>
					<text class="basecolor fz-28" v-if="info.address">{{ info.address.door_number || "" }}</text>
				</view>
				<view class="formitem d-flex f-start" @click.stop="$util.makePhone(info.address.mobile)">
					<image  :src="$util.cdnurl('phone.png')"  class="wh40 m-r-10" mode=""></image>
					<text class="fz-000000 fz-28 m-r-auto">联系人</text>
					<text class="fz-28 basecolor m-r-20">{{ info.address.name || "" }}</text>
					<text class="fz-28 basecolor" v-if="info.address && info.address.mobile">{{ $util.hideMiddleFourOfPhoneNumber(info.address.mobile)  || "" }}</text>
				</view>
			</block>
			<!-- 配送到自提点 -->
			<block v-else>
				<view class="formitem d-flex f-start">
					<image  :src="$util.cdnurl('ztaddress.png')"  class="wh40 m-r-10" mode=""></image>
					<text class="fz-000000 fz-28 m-r-auto">自提点</text>
					<!-- 金东方海棠花园 - -->
					<text class="basecolor fz-28" v-if="info.village">{{ info.village.name || "" }}</text>
					<text class="basecolor fz-28" v-if="info.selfpcikup">{{ info.selfpcikup.name || "" }}</text>
				</view>
				<view class="formitem d-flex f-start">
					<image  :src="$util.cdnurl('phone.png')"  class="wh40 m-r-10" mode=""></image>
					<text class="fz-000000 fz-28 m-r-auto">联系人</text>
					<text class="fz-28 basecolor m-r-20">{{ info.extend.usernmae || "" }}</text>
					<text class="fz-28 basecolor" v-if="info.extend">{{ $util.hideMiddleFourOfPhoneNumber(info.extend.phone)  || "" }}</text>
				</view>
			</block>
			
			<block v-if="info.subtype==2 || info.subtype==3">
				<view class="d-flex f-start">
					<image  :src="$util.cdnurl('ztclock.png')"  mode="" class="wh40 m-r-10"></image>
					<text class="m-r-auto fz-000000 fz-28">配送时间:</text>
					<text class="fz-28 basecolor">{{ $util.parseTime(info.getdate,"{y}-{m}-{d}") }}</text>
					<text class="fz-28 basecolor">{{ $util.isam(info.isam) }}</text>
				</view>
				<view class="d-flex f-start">
					<image  :src="$util.cdnurl('psicon.png')"   mode="" class="wh40 m-r-10"></image>
					<text class="m-r-auto fz-000000 fz-28">配送员:</text>
					<text class="fz-28 basecolor">{{ info.admin.username || "" }}</text>
					<text class="fz-28 basecolor" v-if="info.admin.mobile" @click.stop="$util.makePhone(info.admin.mobile)">（{{ info.admin.mobile || "" }}）</text>
				</view>
			</block>
			
			
			<view class="basecolor breakword">
				<text>备注:</text>
				<text>{{  info.remark || "" }}</text>
			</view>
		</view>
		
		<view class="form bg-fff radius-20 p-30-20 d-c-start-flex m-t-30">
			<view class="formitem d-flex">
				<text class="fz-weight fz-32 fz-333333">订单信息</text>
			</view>
			<view class="formitem d-flex f-start" @click="$util.makeCopy(info.out_trade_no)">
				<text class="fz-494949 fz-28 m-r-auto">订单号:</text>
				<text class="fz-494949 fz-28 borderRight">{{ info.out_trade_no || "" }}</text>
				<view class="copy" @click.stop="$util.makeCopy(info.out_trade_no)">复制</view>
			</view>
			
			<view class="formitem d-flex f-start">
				<text class="m-r-auto  fz-333333">下单时间:</text>
				<text class="fzs">{{ info.createtime || "" }}</text>
			</view>
			
			<view class="formitem d-flex f-start">
				<text class="m-r-auto  fz-333333">支付时间:</text>
				<text class="fzs">{{ info.paidtime || "" }}</text>
			</view>
			<view class="formitem d-flex f-start">
				<text class="m-r-auto  fz-333333">取餐时间:</text>
				<text class="fzs">{{ $util.parseTime(info.getdate,"{y}-{m}-{d}") }}{{ $util.isam(info.isam) }}</text>
			</view>
		</view>
		
		<view class="form m-t-30 p20 bg-fff" v-if="info.subtype!=1 && info.receivedtime">
			   <view class="">
			   	    送达信息
			   </view>
			   <view class="">
				  <text>送达时间:</text>
				  <text>{{ $util.parseTime(info.receivedtime,"{y}-{m}-{d} {h}:{i}") }}</text>
			   </view>
			   	
				<view class="d-flex f-start f-warp">
					<image v-for="(item,i) in $util.toarr(info.received_url)" @click.stop="$util.lookimgarr(i,info.received_url)" :src="$util.getImgurl(item)" mode="" class="wh150 radius-20"></image>
				</view>
		</view>
		
	
		
		<view class="form m-t-30 p20 bg-fff radius-20">
			   <view class="">
			   	    注意事项
			   </view>
			   <view class="">
			   	   <rich-text :nodes="richttext | filterdetail"></rich-text>
			   </view>
		</view> 
		
		<view class="boxFixedcopy" v-if="info.order_status_text!='已取消' && info.order_status_text!='退款/售后' && info.order_status_text!='拼团中'">
			<view class="btn shbtn" v-if="info.order_status_text=='待付款' && $util.isShowcon(info)" @click.stop="contiute()">
				继续支付
			</view>
			
			<view class="btn shbtn" v-if="shstatus" :class="[{'flex-1':info.order_status_text=='已完成'}]"  @click.stop="shfn()">
				申请售后
			</view>
			
			<view class="btn flex-1"  v-if="info.order_status_text=='待付款'" @click.stop="btnclick(0)">
				取消订单
			</view>
			
			<view class="btn" v-if="info.order_status_text=='待取餐'" @click.stop="btnclick(1)" >
				确认取餐
			</view>
			
			<view class="btn"  v-if="info.order_status_text=='待评价'" @click.stop="pjfn()">
				去评价
			</view>
		</view>

		<orderpop :show.sync="cancelList[currentpop]['show']" :content="cancelList[currentpop]['msg']" @confirm="confirm" :isShowSlot="false">

		</orderpop>
	</view>
</template>

<script>
	  import countdown from "@/components/countdown";
	import {
		labelList
	} from "./datajs.js";
	import orderpop from "@/components/orderpop/index.vue";
	export default {
		components: {
			orderpop,
			countdown
		},
		data() {
			return {
				richttext:"",
				info:{},
				timestamp:86400,
				form: {},
				showApply: false,
				currentpop: 0,
				cancelList:[{
									 msg:"确认取消?",
									 show:false
				},{
									 msg:"确认取餐?",
									 show:false
				},{
									 // msg:"申请换货?",
									 // show:false
				},{
									 // msg:"上传单号",
									 // show:false
				}],
				status: "",
				src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				id:""
			}
		},
		computed: {
			shstatus(){
			   let item = this.info;
				return item.order_status_text=='待取餐' || item.order_status_text=='待评价' || item.order_status_text=='已完成';
			},
			labellistfn() {
				return labelList[this.status_text]
			},
			createtime(){
				console.log(new Date(this.info.createtime).getTime()/1000,"new Date(this.info.createtime).getTime()/1000");
				return new Date(this.info.createtime).getTime()/1000;
			}
		},
		onLoad(query) {
			this.status = query.status;
			this.id = query.id;
			this.getrich();
		},
		onShow() {
					this.getdetail();
			uni.removeStorageSync("order");
		},
		methods: {
			// 申请售后
			shfn(v){
				let d = new Date();
				let aftertime = this.$store.state.aftertime;
				d.setHours(aftertime[0],aftertime[1] || "0",aftertime[2] || '0');
				
				
				// console.log(d,"大于晚上9点需要");
				// 大于晚上23点需要联系客服
				if(new Date() > d){
					return this.$u.toast("请前往首页联系客服");
				};
				if(v){
					return this.$util.navTo('/pages2/aftersales/index?id='+this.id+'&price='+v.price+'&product_id='+v.product_id)
				}
				this.$util.navTo('/pages2/aftersales/index?id='+this.id+'&price='+this.info.total_price+'&product_id=')
			},
			// <view class="tagStyle m-r-10" v-if="info.activity_type=='seckill'">福利抢购</view>
			// <view class="tagStyle m-r-10" v-if="info.activity_type=='groupon'">超值拼团</view>
			orderpriceone(v){
				if(this.info.activity_type=='seckill' || this.info.activity_type=='groupon'){
					 return v.activityProduct?.price;
				}
				return v?.price;
			},
			orderpricefn(v){
				let number = v.number ?  Number(v.number) :  1;
				if(this.info.activity_type=='seckill' || this.info.activity_type=='groupon'){
					 return (Number(v.activityProduct?.price) * number).toFixed(2);
				}
				return (Number(v?.price) * number).toFixed(2);
			},
			// 继续支付
			contiute(){
				let createtime = "";
				if(this.info.createtime){
					createtime = (new Date(this.info.createtime).getTime())/1000;
				}
				uni.setStorageSync("order",{...this.info,createtime});
				this.$util.navTo('/pages2/money/pay?pagetype=contiute')
			},
			async getrich () {
				let data = await this.$u.api.attentionOrder({
					key:"attention_order"
				});
				this.richttext = data
			console.log(data,'res')
			},
			// 订单详情
			async getdetail(){
				let data = await this.$u.api.orderDetail({
					id:this.id
				});
				if(data.order_status_text=='配送中'){
					data.order_status_text='待取餐';
				}
				// 拼团中 拼团成功了待参团
				this.info = data;
			},
			pjfn(item){
				 uni.setStorageSync("evaluate",this.info.products);
				 this.$util.navTo('/pages2/order/evaluate?id='+this.id);
			},
			back(){
				uni.navigateBack();
			},
			// 点击按钮
			btnclick(e){
			 this.currentpop = e;
			 this.cancelList[e].show = true;
			},
			// 确认时间
			async confirm(e){
				
				this.cancelList[this.currentpop].show = false;
				switch (this.currentpop){
					case 0:
					let  r = await this.$u.api.cancelOrder({
						id:this.id || ""
					});
				   this.$util.success("取消成功","back");
						break;
					case 1:
					   let {data} = await this.$u.api.receive({
						   id:this.id || ""
					   });
					    this.$util.success("取餐成功","back");
						break;
					case 2:
						uni.showToast({
							icon:"success",
							title:"申请成功"
						})
						break;
					case 3:
						this.showApply = false;
						break;	
					default:
						break;
				}
			}
		}
	}
</script>

<style scoped lang="scss">
	.w462{
		width: 462rpx;
		text-align: right;
	}
	
	.intform {
		width: 100%;
		border: 2rpx solid #999999;
		padding-left: 20rpx;
		border-radius: 20rpx;
		height: 80rpx;
		line-height: 80rpx;
		margin-top: 30rpx;
	}
	
	.tagStyle{
		width: fit-content;
		height: 40rpx;
		background: #FFE2BE;
		border-radius: 10rpx 10rpx 10rpx 10rpx;
		font-weight: 500;
		font-size: 20rpx;
		color: #FB7A35;
		padding: 8rpx 10rpx;
	}
	
	.line32{
		line-height: 32rpx;
	}
	
	.wh150{
		width: 200rpx;
		height: 200rpx;
		margin-right: 20rpx;
	}
	
	.copy{
		flex-shrink: 0;
		width: fit-content;
		padding: 0 10rpx;
		height: 40rpx;
		font-weight: 500;
		font-size: 28rpx;
		color:#000000;
		text-align: center;
		// padding: 5rpx 20rpx;
		// border-radius: 50rpx;
		// font-size: 28rpx;
		line-height: 40rpx;
		// border: 1rpx solid #666666;
	}
	.borderRight{
		padding-right: 20rpx;
		position: relative;
		margin-right: 10rpx;
		&::after{
			content: "";
			position: absolute;
			width: 2rpx;
			height: 60%;
			top: 50%;
			transform: translateY(-50%);
			background-color: #979797;
			right: 0;
			bottom: 0;
		}
	}
    .tgOther{
		width: fit-content;
		padding: 0 30rpx;
		color: #FF0000;
		text-align: center;
		border: 2rpx solid #FF0000;
		border-radius: 70rpx;
		margin-top: 10rpx;
	}
	.getOther {
		width: fit-content;
		padding: 0 30rpx;
		color: #000000;
		text-align: center;
		border: 2rpx solid #666666;
		border-radius: 70rpx;
		margin-top: 10rpx;
	}

	::v-deep.placeholderClass {
		color: #999999;
		font-size: 28rpx;
	}

	.content {
		min-height: 100vh;
		padding: 30rpx 20rpx;
		background: linear-gradient( 193deg, #F9F0A3 0%, rgba(255,255,255,0) 100%);
		padding-bottom: calc(240rpx + env(safe-area-inset-bottom));
        padding-top: 20rpx;
		.form {
			line-height: 60rpx;
			padding-top: 15rpx;
			padding-bottom: 15rpx;
		}

		.wh46 {
			width: 46rpx;
			height: 46rpx;
		}

		.person {
			padding: 20rpx 30rpx 20rpx 20rpx;
		}


        .w300{
			width: 300rpx;
		}
		.supermarket {
			padding: 30rpx 20rpx 30rpx 20rpx;

			.endclass {
				// border-bottom: 2rpx solid #F9F9F9;
				// padding-bottom: 30rpx;
			}

			.cart-item {
				display: flex;
				position: relative;
				align-items: center;

				.image-wrapper {
					width: 160upx;
					height: 160upx;
					flex-shrink: 0;
					position: relative;

					image {
						border-radius: 8upx;
					}
				}

				.checkbox {
					position: absolute;
					left: -16upx;
					top: -16upx;
					z-index: 8;
					font-size: 44upx;
					line-height: 1;
					padding: 4upx;
					background: #fff;
					border-radius: 50px;
				}

				.item-right {
					display: flex;
					flex-direction: column;
					flex: 1;
					overflow: hidden;
					position: relative;
					padding-left: 20upx;

					.title,
					.price {
						height: 40upx;
						line-height: 40upx;
					}

					.attr {
						font-weight: bold;
						font-size: 24rpx;
						color: #999999;
						height: 50upx;
						line-height: 50upx;
					}

					.price {
						height: 50upx;
						line-height: 50upx;
					}
				}

				.del-btn {
					padding: 4upx 10upx;
					font-size: 34upx;
					height: 50upx;
				}

				.invalid {
					position: absolute;
					right: 0;
					bottom: 0;
					background: #999999;
					color: #ffffff;
					padding: 6upx 12upx;
					border-radius: 10upx;
					font-size: 26upx;
					margin-right: 50upx;
					margin-bottom: 32upx;
				}
			}
		}
	}
	
	.shbtn{
	  color: #000000 !important;
	  border: 2rpx solid #000000 !important;
	  border-radius: 90rpx !important;
	  background: transparent !important;	
	}
	
	.boxFixedcopy {
	    position: fixed;
	    left: 0;
	    right: 0;
	    bottom: 0;
	    min-height: 200rpx;
	    background-color: #FFFFFF;
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	    z-index: 10;
		padding: 0 20rpx;
	}

	.btn {
		font-weight: 800;
		font-size: 28rpx;
		color: #FFFFFF;
		text-align: center;
		line-height: 80rpx;
		width: 48%;
		height: 80rpx;
		border: 2rpx solid #FACE51;
		background: #FACE51;
		border-radius: 40rpx 40rpx 40rpx 40rpx;
		margin-top: 40rpx;
	}

	.button {
		height: 100rpx;
	}
	.wh70{
		width: 70rpx;
		height: 70rpx;
	}
	
	.fzs{
		font-weight: 500;
		font-size: 28rpx;
		color: rgba(0,0,0,0.5);
	}
</style>