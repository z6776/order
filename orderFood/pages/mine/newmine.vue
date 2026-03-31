<template>
	<view class="container">
		<image :src="$util.cdnurl('minebg.png')"  class="minebg" mode=""></image>
        <navbar  placeholder :bg-color="bgColorOpa"/>
		<!-- @click="$util.navTo('/pages/userinfo/userinfo')" 
		 1.没登录
		   新用户显示默认头像
		   authSession接口给的默认头像
		   老用户显示默认头像
		   authSession接口给的默认头像
		 2.登录了
		   显示index接口的头像会刷新position的头像
		-->
		<view class="user-section" @click.stop="$util.navTo('/pages/components/pages/mine/userinfo')">
			<view class="user-info-box">
				<view class="portrait-box">
					<block v-if="!isLogin">
						<image class="portrait" :src="membercopy.avatar ? $util.getImgurl(membercopy.avatar)  : $util.cdnurl('missing-face.png')"></image>
					</block>
					<block v-else>
						<image class="portrait" :src="position.avatar ? $util.getImgurl(position.avatar)  : $util.cdnurl('missing-face.png')"></image>
					</block>
				</view>
				<view class="info-box" v-if="member.token">
					<view class="d-flex f-start">
						<text class="username m-r-10">{{position.welcome||""}}</text>
						<image src="../../static/user/edit.png" class="wh40" mode="aspectFill"></image>
					</view>
					<view class="expert d-flex j-center" v-if="position.rule && position.rule.length">
						<text v-for="(item,i) in position.rule" :key="i">{{ i==position.rule.length-1 ? item.name  : item.name + ","  }}</text>
					</view>
					 <!-- @click.stop="goexpert()" -->
				</view>
				<view class="m-l-30 fz-32 fz-fff fz-weight" v-else @click.stop="$util.navTo('/pages/components/pages/login/newlogin')">
					请先登录
				</view>
			</view>
		</view>
		<!-- 余额充值 -->
		<view class="w-100 d-flex align-items-center p20 radius-20" v-if="false">
			<view class="d-c-flex " @tap="serv({type:'pages',pages:'/pages/components/pages/balance/mybalance'})">
				<view class="value font-size-extra-lg font-weight-bold text-color-base ">
					<!-- {{ member.money ? member.money : 0 }} -->
					 {{ position.money || "0" }}
				</view>
				<view class="font-size-sm text-color-assist m-t-10">余额</view>
			</view>
			<view class="d-c-flex" @tap="serv({type:'pages',pages:'/pages/components/pages/balance/coupon?pagetype=mine'})">
				<view class="value font-size-extra-lg font-weight-bold text-color-base">
					 {{ position.coupon || "0" }}
				</view>
				<view class="font-size-sm text-color-assist m-t-10" >优惠券</view>
			</view>
			
			<view class="d-c-flex" @tap="serv({type:'pages',pages:'/pages/components/pages/balance/fd'})">
				<view class="value font-size-extra-lg font-weight-bold text-color-base">
					 {{ position.score || "0" }}
				</view>
				<view class="font-size-sm text-color-assist m-t-10">福豆</view>
			</view>
			
			<view class="d-c-flex" @tap="$util.navTo('/pages2/mycollection/index')">
				<view class="value font-size-extra-lg font-weight-bold text-color-base">
					{{ position.collect || "0" }}
					<!-- 0 -->
				</view>
				<view class="font-size-sm text-color-assist m-t-10">收藏</view>
			</view>
		</view>
		<!-- 余额 我的项目 -->
		<view class="product d-flex j-center m140 radius-20" @click="lookbal()" v-if="false">
			<!-- <u-image :src="$util.cdnurl('expertvip.png')" width="100%"  height="100%"  border-radius="20rpx"   mode="aspectFill" ></u-image> -->
			<image :src="$util.cdnurl('expertvip.png')" class="wh100" mode=""></image>
		</view>
		
		<view class="cover-container radius-20">
			<!-- 订单 -->
			<view class="order-header">
				<view class="title">我的订单</view>
				<view class="item" @click="$util.navTo('/pages2/order/order?state=0')">全部
		 		   <u-icon name="arrow-right" size="24" color="#999999"></u-icon>
				</view>
			</view>
			<view class="order-section radius-20">
				<view class="order-item" @click="$util.navTo('/pages2/order/order?state=1')" hover-class="common-hover"
					:hover-stay-time="50">
					<image src="../../static/user/myfp.png" mode="aspectFill" class="yticon"></image>
					<text class="num" v-if="orderNumst.st_1 > 0">{{orderNumst.st_1}}</text>
					<text class="fz-28 fz-707070 fz-500">待支付</text>
				</view>
				<view class="order-item" @click="$util.navTo('/pages2/order/order?state=2')" hover-class="common-hover"
					:hover-stay-time="50" v-if="false">
					<image src="../../static/user/ptz.png" mode="aspectFill" class="yticon"></image>
					<text class="num" v-if="orderNumst.st_7 > 0">{{orderNumst.st_7}}</text>
					<text class="fz-28 fz-707070 fz-500">拼团中</text>
				</view>
				<view class="order-item" @click="$util.navTo('/pages2/order/order?state=3')" hover-class="common-hover"
					:hover-stay-time="50">
					<image src="../../static/user/daifahuo.png" mode="aspectFill" class="yticon"></image>
					<text class="num" v-if="orderNumst.st_2 > 0">{{orderNumst.st_2}}</text>
					<text class="fz-28 fz-707070 fz-500">待取餐</text>
				</view>
				<view class="order-item" @click="$util.navTo('/pages2/order/order?state=4')" hover-class="common-hover"
					:hover-stay-time="50">
					<image src="../../static/user/daishouhuo.png" mode="aspectFill" class="yticon"></image>
					<text class="num" v-if="orderNumst.st_3 > 0">{{orderNumst.st_3}}</text>
					<text class="fz-28 fz-707070 fz-500">待评价</text>
				</view>
				<view class="order-item" @click="$util.navTo('/pages2/order/order?state=5')" hover-class="common-hover"
					:hover-stay-time="50">
					<image src="../../static/user/daipingjia.png" mode="aspectFill" class="yticon"></image>
					<text class="num" v-if="orderNum.uncomment > 0">{{orderNum.uncomment}}</text>
					<text class="fz-28 fz-707070 fz-500">已取消</text>
				</view>
				<view class="order-item" @click="$util.navTo('/pages2/order/order?state=7')" hover-class="common-hover" :hover-stay-time="50">
					<image src="../../static/user/returb.png" mode="aspectFill" class="yticon"></image>
					<text class="num" v-if="orderNumst.st_6 > 0">{{orderNumst.st_6}}</text>
					<text class="fz-28 fz-707070 fz-500 fz-nowrap">退款/售后</text>
				</view>
			</view>
			
			</view>
			
			<view class="cover-container radius-20" v-if="isYL">
				<!-- 订单 -->
				<view class="order-header">
					<view class="title">养老服务订单</view>
					<view class="item" @click="$util.navTo('/pages2/order/ylorder?state=0')">查看更多
			 		   <u-icon name="arrow-right" size="24" color="#999999"></u-icon>
					</view>
				</view>
				<view class="order-section radius-20">
					<view class="order-item" @click="$util.navTo('/pages2/order/ylorder?state=1')" hover-class="common-hover"
						:hover-stay-time="50">
						<image src="../../static/images/order/yy.png" mode="aspectFill" class="yticon"></image>
						<text class="num" v-if="orderNumyl.yl_1 > 0">{{orderNumyl.yl_1}}</text>
						<text class="fz-28 fz-707070 fz-500">待预约</text>
					</view>
					<view class="order-item" @click="$util.navTo('/pages2/order/ylorder?state=2')" hover-class="common-hover"
						:hover-stay-time="50">
						<image src="../../static/images/order/fw.png" mode="aspectFill" class="yticon"></image>
						<text class="num" v-if="orderNumyl.yl_2 > 0">{{orderNumyl.yl_2}}</text>
						<text class="fz-28 fz-707070 fz-500">待服务</text>
					</view>
					<view class="order-item" @click="$util.navTo('/pages2/order/ylorder?state=3')" hover-class="common-hover"
						:hover-stay-time="50">
						<image src="../../static/images/order/zf.png" mode="aspectFill" class="yticon"></image>
						<text class="num" v-if="orderNumyl.yl_5 > 0">{{orderNumyl.yl_5}}</text>
						<text class="fz-28 fz-707070 fz-500">待支付</text>
					</view>
					<view class="order-item" @click="$util.navTo('/pages2/order/ylorder?state=5')" hover-class="common-hover"
						:hover-stay-time="50">
						<image src="../../static/images/order/wc.png" mode="aspectFill" class="yticon"></image>
						<text class="num" v-if="orderNumyl.yl_7 > 0">{{orderNumyl.yl_7}}</text>
						<text class="fz-28 fz-707070 fz-500">已完成</text>
					</view>
					<view class="order-item" @click="$util.navTo('/pages2/order/ylorder?state=6')" hover-class="common-hover" :hover-stay-time="50">
						<image src="../../static/images/order/qx.png" mode="aspectFill" class="yticon"></image>
						<text class="num" v-if="orderNumyl.yl_f1 > 0">{{orderNumyl.yl_f1}}</text>
						<text class="fz-28 fz-707070 fz-500 fz-nowrap">已取消</text>
					</view>
				</view>
				
				</view>
				
			<!-- 浏览历史 -->
			<view class="cover-container radius-20" v-if="false">
			<view class="history-section icon radius-20">
				<view class="fz-32 fz-333333 fz-weight m-b-20">常用工具</view>
				
				<view class="history-section-box">
					<view class="order-item" @click="$util.navTo('/pages/components/pages/address/address')" hover-class="common-hover"
						:hover-stay-time="50">
						<image src="../../static/user/address.png" mode="aspectFill" class="yticon"></image>
						<!-- <text class="num" v-if="orderNum.uncomment > 0">{{orderNum.uncomment}}</text> -->
						<text class="fz-28 fz-707070 fz-500">地址管理</text>
					</view>
					
					<view class="order-item" @click="$util.navTo('/pages2/feedback/index')" hover-class="common-hover" :hover-stay-time="50">
						<image src="../../static/user/yjfk.png" mode="aspectFill" class="yticon"></image>
						<!-- <text class="num" v-if="orderNum.refund > 0">{{orderNum.refund}}</text> -->
						<text class="fz-28 fz-707070 fz-500">意见反馈</text>
					</view>
					
					<view class="order-item" v-if="isYL" @click="$util.navTo('/pages3/communitylife/mycommunity')" hover-class="common-hover" :hover-stay-time="50">
						<image src="../../static/user/myzh.png" mode="aspectFill" class="yticon"></image>
						<!-- <text class="num" v-if="orderNum.refund > 0">{{orderNum.refund}}</text> -->
						<text class="fz-28 fz-707070 fz-500">我的报名</text>
					</view>
					
					<view class="order-item" @click="$util.navTo('/pages2/myevaluate/index')" hover-class="common-hover"
						:hover-stay-time="50">
						<image src="../../static/user/mypj.png" mode="aspectFill" class="yticon"></image>
						<!-- <text class="num" v-if="orderNum.unpaid > 0">{{orderNum.unpaid}}</text> -->
						<text class="fz-28 fz-707070 fz-500">我的评价</text>
					</view>
					
					<view class="order-item" v-if="positionfn(3)"  @click="$util.navTo('/pages2/centeradministrator/index')" hover-class="common-hover"
						:hover-stay-time="50">
						<image src="../../static/user/mygz.png" mode="aspectFill" class="yticon"></image>
						<!-- <text class="num" v-if="orderNum.undelivered > 0">{{orderNum.undelivered}}</text> -->
						<text class="fz-28 fz-707070 fz-500">中心管理员</text>
					</view>
					<!--     -->
					<view class="order-item" v-if="positionfn(5)"   @click="$util.navTo('/pages2/salescustomerservice/index')" hover-class="common-hover" :hover-stay-time="50">
						<image src="../../static/user/liulan.png" mode="aspectFill" class="yticon"></image>
						<!-- <text class="num" v-if="orderNum.refund > 0">{{orderNum.refund}}</text> -->
						<text class="fz-28 fz-707070 fz-500">销售客服</text>
					</view>
					<!--  -->
					<view class="order-item" v-if="positionfn(6)"  @click="$util.navTo('/pages2/productionpersonnel/index')" hover-class="common-hover" :hover-stay-time="50">
						<image src="../../static/user/daili.png" mode="aspectFill" class="yticon"></image>
						<!-- <text class="num" v-if="orderNum.refund > 0">{{orderNum.refund}}</text> -->
						<text class="fz-28 fz-707070 fz-500">生产人员</text>
					</view>
					<view class="order-item" v-if="positionfn(10)" @click="$util.navTo('/pages2/service/index')" hover-class="common-hover" :hover-stay-time="50">
						<image src="../../static/user/fuwu.png" mode="aspectFill" class="yticon"></image>
						<!-- <text class="num" v-if="orderNum.refund > 0">{{orderNum.refund}}</text> -->
						<text class="fz-28 fz-707070 fz-500">服务人员</text>
					</view>
					
					
					<view class="order-item" v-if="positionfn(7)"   @click="$util.navTo('/pages2/distributionsupervisor/index')" hover-class="common-hover" :hover-stay-time="50">
						<image src="../../static/user/peisong.png" mode="aspectFill" class="yticon"></image>
						<text class="num" v-if="orderNum.unaudited > 0">{{orderNum.unaudited > 99 ? '99+' : orderNum.unaudited}}</text>
						<text class="fz-28 fz-707070 fz-500">配送主管</text>
					</view>
					<!--   -->
					<view class="order-item" v-if="positionfn(8)"  @click="$util.navTo('/pages2/deliverypersonnel/index')" hover-class="common-hover" :hover-stay-time="50">
						<image src="../../static/user/psperson.png" mode="aspectFill" class="yticon"></image>
						<!-- <text class="num" v-if="orderNum.refund > 0">{{orderNum.refund}}</text> -->
						<text class="fz-28 fz-707070 fz-500">配送员</text>
					</view>
					<view class="w25">
						
					</view>
					<view class="w25">
						
					</view>
					<view class="w25">
						
					</view>
				
				</view>
			</view>
		</view>
	</view>
</template>
<script>
	import { mapState ,mapGetters ,mapMutations } from "vuex";
	export default {
		data() {
			return {
				imgList:[{
					image:"https://opscos.msksoft.cn/chushanghui/static/shopcity2/user.png",
	image:"https://opscos.msksoft.cn/chushanghui/static/shopcity2/user.png"
				},{
					image:"https://opscos.msksoft.cn/chushanghui/static/index/user.png"
				}],
				coverTransform: 'translateY(0px)',
				coverTransition: '0s',
				moving: false,
				orderNumyl:{},
				orderNumst:{}
			}
		},
	  
		onLoad() {

		},
		onShow() {
			this.getUserInfo();	
			if (this.isLogin) {
				// this.getOrderNum();
			} else {
				this.orderNumyl = {}
				
				this.orderNumst = {}
			}
		},
		// #ifndef MP
		onNavigationBarButtonTap(e) {
			const index = e.index;
			if (index === 0) {
				this.navTo('/pages/set/set');
			} else if (index === 1) {
				// #ifdef APP-PLUS
				const pages = getCurrentPages();
				const page = pages[pages.length - 1];
				const currentWebview = page.$getAppWebview();
				currentWebview.hideTitleNViewButtonRedDot({
					index
				});
				// #endif
				uni.navigateTo({
					url: '/pages/notice/notice'
				})
			}
		},
		// #endif
		computed: {
			...mapState(['member',"position","isYL",'membercopy']),
			...mapGetters(['isLogin']),
			growthValue() {
				if (!this.isLogin) return 0
				const {
					currentValue,
					needValue
				} = this.member
				return currentValue / (currentValue + needValue) * 100
			}
		},
		methods: {
			...mapMutations(["SET_POSITION"]),
			positionfn(n){
				if(this.position.rule && this.position.rule.length){
					return this.position.rule.some(v=>v.id==n);
				}
				return false
			},
			lookbal(){
				if(!this.position.level){
					return this.$u.toast("您还不是会员");
				}
				this.$util.navTo('/pages/components/pages/balance/member')
			},
			async getUserInfo() {
				if (this.isLogin) {
					let data = await this.$u.api.userindex();
					let { st,yg} = await this.$u.api.subscript();
					if(st){
						this.orderNumst = st;
					}
					if(yg){
						this.orderNumyl = yg;
					}
					
					if (data) {
						this.SET_POSITION(data);
					}
				}
			},
			login(){
				uni.navigateTo({
					url:"/pages/components/pages/login/newlogin"
				})
			},
			serv(item) {
				switch (item.type) {
					case 'pages':
						if (!this.isLogin) {
							this.login()
							return
						}
						uni.navigateTo({
							url: item.pages
						})
						break;
					case 'miniprogram':
						uni.navigateToMiniProgram({
							appId: item.app_id
						})
						break;
					case 'menu':
						uni.navigateTo({
							url: '/pages/components/pages/mine/service?id=' + item.id + '&name=' + item.name
						})
						break;
					case 'content':
						uni.navigateTo({
							url: '/pages/components/pages/mine/content?id=' + item.id + '&name=' + item.name
						})
						break;
				}
			},
			/* 去我的会员 */
			goexpert(){
				this.$util.navTo('/pagesc/members/index');
			},
			invitefn(i){
				if(i==0){
					this.$util.navTo('/pagesc/invite/invite');
				}else{
					this.$util.navTo('/pagesc/invitationtojoin/index');
				}
			},
			payfn(){
				this.$util.navTo('/pagesc/rechargebalance/index');
			},
			/**
			 *  会员卡下拉和回弹
			 *  1.关闭bounce避免ios端下拉冲突
			 *  2.由于touchmove事件的缺陷（以前做小程序就遇到，比如20跳到40，h5反而好很多），下拉的时候会有掉帧的感觉
			 *    transition设置0.1秒延迟，让css来过渡这段空窗期
			 *  3.回弹效果可修改曲线值来调整效果，推荐一个好用的bezier生成工具 http://cubic-bezier.com/
			 */
			coverTouchstart(e) {
				if (pageAtTop === false) {
					return;
				}
				this.coverTransition = 'transform .1s linear';
				startY = e.touches[0].clientY;
			},
			coverTouchmove(e) {
				moveY = e.touches[0].clientY;
				let moveDistance = moveY - startY;
				if (moveDistance < 0) {
					this.moving = false;
					return;
				}
				this.moving = true;
				if (moveDistance >= 500 && moveDistance < 550) {
					moveDistance = 500;
				}

				if (moveDistance > 0 && moveDistance <= 500) {
					this.coverTransform = `translateY(${moveDistance}px)`;
				}
			},
			coverTouchend() {
				if (this.moving === false) {
					return;
				}
				this.moving = false;
				this.coverTransition = 'transform 0.3s cubic-bezier(.21,1.93,.53,.64)';
				this.coverTransform = 'translateY(0px)';
			},
			// 获取订单数量
			async getOrderNum() {
				let data = this.$u.api.OrderCount();
				if (data) {
					this.orderNum = {
						unpaid: data.unpaid ? data.unpaid : 0,
						undelivered: data.undelivered ? data.undelivered : 0,
						unreceived: data.unreceived ? data.unreceived : 0,
						uncomment: data.uncomment ? data.uncomment : 0,
						refund: data.refund ? data.refund : 0
					};
				}
			}
		}
	}
</script>
<style lang='scss'>
	page {
		/* background: #f5f5f5; */
		 padding-bottom: 150rpx;
	}
	
	.user-section{
		position: relative;
		z-index: 999;
	}
	
	.minebg{
		position: fixed;
		 top: 0;
		 left: 0;
		 right: 0;
		 width: 100%;
		 height: 100vh;
		 z-index: -1;
	}
	
	.swiper{
		 height: 200rpx;
	}

	%flex-center {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
	}

	%section {
		display: flex;
		justify-content: space-around;
		align-content: center;
		background: #fff;
		border-radius: 10upx;
	}
	.wh28{
		width: 28rpx;
		height: 28rpx;
	}
	.product{
		width: 714rpx;
		height: 140rpx;
		border-radius: 20rpx;
	}
	.yj{
		background-image: url('https://opscos.msksoft.cn/chushanghui/static/index/yj.png');
	}
	.zh{
		background-image: url('https://opscos.msksoft.cn/chushanghui/static/index/zh.png');
		padding-left: 40rpx !important;
	}
	.yj,.zh{
		background-repeat: no-repeat;
		background-size: 100% 160rpx;
		font-weight: 800;
		font-size: 32rpx;
		color: #FFFFFF;
		width: 50%;
		height: 160rpx;
		padding-top: 40rpx;
		padding-left: 20rpx;
	}
	
	.container{
		padding: 20rpx;
		/* background-image: url('https://opscos.msksoft.cn/chushanghui/static/index/userbg.png'); */
		background-repeat: no-repeat;
		background-size: 100% 470rpx;
		padding-bottom: 80rpx;
		min-height: 100vh;
	}
	
	.user-info-box {
		height: 180upx;
		display: flex;
		align-items: center;
		position: relative;
		z-index: 1;
        .info-box{
			width: 100%;
		}
		.portrait {
			width: 130upx;
			height: 130upx;
			border-radius: 50%;
		}
		.username {
			font-weight: 800;
			font-size: 36rpx;
			color: #000000;
			margin-left: 20upx;
		}
		.tagsm{
			width: fit-content;
			padding: 5rpx 8rpx;
			background: #62C395;
			border-radius: 8rpx 8rpx 8rpx 8rpx;
			text-align: center;
			line-height: 42rpx;
			font-weight: 500;
			font-size: 24rpx;
			color: #FFFFFF;
			margin-right: auto;
			margin-left: 20rpx;
		}
		
	}
	.w25{
		width: 25%;
	}
	.expert{
		width: fit-content;
		justify-content: flex-start;
		flex-wrap: wrap;
		align-items: center;
		/* height: 50rpx; */
		background: rgba(255,255,255,0.5);
		border-radius: 100rpx 100rpx 100rpx 100rpx;
		font-weight: 500;
		font-size: 28rpx;
		color: #935200;
		margin-left: 20rpx;
		margin-top: 24rpx;
		padding-left: 30rpx;
		padding-right: 30rpx;
	}

	.vip-card-box {
		display: flex;
		flex-direction: column;
		color: #f7d680;
		height: 240upx;
		background: linear-gradient(left, rgba(0, 0, 0, .7), rgba(0, 0, 0, .8));
		border-radius: 16upx 16upx 0 0;
		overflow: hidden;
		position: relative;
		padding: 20upx 24upx;

		.card-bg {
			position: absolute;
			top: 20upx;
			right: 0;
			width: 380upx;
			height: 260upx;
		}

		.b-btn {
			position: absolute;
			right: 20upx;
			top: 16upx;
			width: 132upx;
			height: 40upx;
			text-align: center;
			line-height: 40upx;
			font-size: 22upx;
			color: #36343c;
			border-radius: 20px;
			background: linear-gradient(left, #f9e6af, #ffd465);
			z-index: 1;
		}

		.tit {
			color: #f7d680;
			margin-bottom: 28upx;

			.yticon {
				width: 46rpx;
				height: 46rpx;
				margin-right: 16upx;
			}
		}

		.e-b {
			color: #d8cba9;
			margin-top: 10upx;
		}
	}

	.cover-container {
		background: #f5f5f5;
		padding-bottom: 20upx;
	}

	.tj-sction {
		@extend %section;
		.tj-item {
			@extend %flex-center;
			flex-direction: column;
			height: 140upx;
			color: #75787d;
		}

		.num {
			margin-bottom: 8upx;
		}
	}

	.order-header {
		@extend %section;
		padding: 28upx 0 0;
		border-radius: 10upx 10upx 0 0;
		margin-top: 20upx;

		.title {
			font-weight: 800;
			font-size: 32rpx;
			color: #000000;
			width: 50%;
			margin-left: 30upx;
		}

		.item {
			width: 50%;
			text-align: right;
			margin-right: 8upx;
		}
	}

	.order-section {
		@extend %section;
		border-radius: 20upx;
		padding: 20upx 10rpx;
		.order-item {
			@extend %flex-center;
			width: 120upx;
			height: 120upx;
			border-radius: 10upx;
			font-weight: 500;
			font-size: 26rpx;
			color: #000000;
			position: relative;
			.num {
				border: 4rpx solid #FACE51;
				width: 40rpx;
				height: 40rpx;
				color: #FACE51;
				text-align: center;
				border-radius: 40rpx;
				position: absolute;
				background: #ffffff;
				top: 0;
				right: 18rpx;
			}
		}

		.yticon {
			width: 46rpx;
			height: 46rpx;
			margin-bottom: 10rpx;
		}

		.icon-shouhoutuikuan {
			font-size: 44upx;
		}
	}

	.history-section {
		padding: 30rpx 20rpx;
		margin-top: 20upx;
		background: #fff;
		border-radius: 10upx;
		/* display: flex; */
		/* flex-wrap: wrap; */
		.history-section-box {
			@extend %section;
			border-radius: 20upx;
			flex-wrap: wrap;
			.order-item {
				@extend %flex-center;
				width: 25%;
				height: 120upx;
				border-radius: 10upx;
				font-weight: 500;
				font-size: 26rpx;
				color: #000000;
				position: relative;
		
				.num {
					border: 4rpx solid #FACE51;
					width: 40rpx;
					height: 40rpx;
					color: #FACE51;
					text-align: center;
					border-radius: 40rpx;
					position: absolute;
					background: #ffffff;
					top: 0;
					right: 18rpx;
				}
			}
		
			.yticon {
				width: 46rpx;
				height: 46rpx;
				margin-bottom: 10rpx;
			}
		
			.icon-shouhoutuikuan {
				font-size: 44upx;
			}
		}
		.sec-header {
			display: flex;
			align-items: center;
			line-height: 40upx;
			margin-left: 30upx;

			.yticon {
				font-size: 44upx;
				color: #5eba8f;
				margin-right: 16upx;
				line-height: 40upx;
			}
		}

		.h-list {
			white-space: nowrap;
			padding: 30upx 30upx 0;

			image {
				display: inline-block;
				width: 160upx;
				height: 160upx;
				margin-right: 20upx;
				border-radius: 10upx;
			}
		}
	}

	.love {
		text-align: center;
		font-size: 100rpx;
		margin: 50rpx 0;
	}
</style>