<template>
	<view class="content" v-if="loading">
		<view class="carousel">
			<swiper :indicator-dots="listfn.length && listfn.length>1" circula duration="400" indicator-active-color="#ffffff">
				<swiper-item class="swiper-item" v-for="(item,index) in listfn" :key="item.id">
					<view class="image-wrapper">
						<image :src="$util.getImgurl(item)" class="loaded" mode="aspectFill"></image>
					</view>
					<view class="h110"  v-if="type=='groupon' || type=='seckill'">
						
					</view>
				</swiper-item>
			</swiper>
			<view class="bgswiper" v-if="type=='groupon' || type=='seckill'">
				<image :src="type=='groupon' ?   $util.cdnurl('pttit.png') :  type=='seckill' ? $util.cdnurl('flqg.png')  : ''" mode="" class="wh144"></image>	
			</view>
		</view>
		
		<view class="introduce-section m-t-20">
			<view class="price-box">
				<text class="fz-24 fz-FF2525 ">¥</text>
				<text class="m-r-auto fz-FF2525 fz-32 fz-weight">{{info.sales_price || ""}}</text>
				<text class="fz-28 basecolor fz-weight">已售{{info.real_sales || "0"}}件</text>
			</view>
			<text class="title">{{info.title}}</text>
			<view class="bot-row" v-if="info.desc">
				{{ info.desc || "" }}
			</view>
		</view>
		<!-- 活动商品不要规格 -->
		<view class="d-flex m-t-20 m-b-20 bg-fff line80 p-l-20 p-r-20" v-if="info.use_spec && type!='groupon' && type!='seckill'" @click="toggleSpec">
			<text class="label">规格</text>
			<view class="sku basecolor">
				<text class="m-r-20">{{ skuListfn }}</text>
				<u-icon name="arrow-right" size="28" color="#000000"></u-icon>
			</view>
		</view>
		
		<!-- 超值拼团 -->
		<ptcom v-if="type=='groupon'" :grouponlist="grouponlist"/>
		
		<!-- 评价 -->
		<view class="eva-section" v-if="evaluate && evaluate.length">
			<view class="e-header" @click="$util.navTo('/pages2/evaluate/index?product_id='+info.id)">
				<text class="m-r-auto fz-32 fz-000000 fz-bold">商品评价</text>
				<text class="tip">查看更多</text>
				<u-icon name="arrow-right" size="24" color="#000000"></u-icon>
			</view>
			<view class="eva-box" v-for="(item, index) in evaluate" :key="item.id">
				<image class="portrait" :src="$util.getImgurl($util.isNull(item.user,'avatar'))" mode="aspectFill"></image>
				<view class="right">
					<view class="d-flex f-start">
						<text class="name m-r-auto">{{ $util.isNull(item.user,'username')  || "匿名用户" }}</text>
						<u-icon name="star-fill" color="#F2CB51" size="32" v-for="(n,i) in item.rate" :key="i"></u-icon>
						<u-icon name="star-fill" color="#979797" size="32" v-for="(n,k) in (5-item.rate)" :key="k"></u-icon>
						
						<!-- <image src="../../static/index/star.png" v-for="(item,index) in 5" mode="aspectFill" class="wh28 m-r-10"></image> -->
					</view>
					<text class="time m-t-10">{{  $util.parseTime(item.createtime,"{y}-{m}-{d} {h}:{i}:{s}")  }}</text>
					<view class="bot m-t-20">
						<text class="fz-28 fz-bold fz-000000">{{ item.comment || ""}}</text>
					</view>
					<view class="m-t-20">
						 <image v-for="(v,j) in $util.toarr(item.picture)" :key="j"  @click.stop="$util.lookimgarr(j,item.picture)" :src="$util.getImgurl(v)" mode="aspectFill" class="wh140"></image>
					</view>
				</view>
			</view>
		</view>
		
		<view class="detail-desc">
			<view class="d-header">
				<text>图文详情</text>
			</view>
			<view class="">
				<rich-text :nodes="info.desc | filterdetail"></rich-text>
			</view>
		</view>
		<!-- 底部操作菜单 -->
		<view class="page-bottom">
				<cbtn opentype="share">
				 <view class="p-b-btn d-c-flex">
					 <image  :src="$util.cdnurl('share.png')" mode="aspectFill" class="wh40 m-b-10"></image>
					<text class="basecolor fz-28">分享</text>
				 </view>
					</cbtn>
				<!-- <cbtn opentype="contact"> -->
				 <view class="p-b-btn d-c-flex" @click.stop="makeKf()">
					 <image :src="$util.cdnurl('kefu.png')"  mode="aspectFill" class="wh40 m-b-10"></image>
					<text class="basecolor fz-28">客服</text>
				 </view>
					<!-- </cbtn> -->
				<view class="p-b-btn d-c-flex" :class="{active: favorite}" @click="collectShop()">
					 <image :src="flash ?  $util.cdnurl('colleatsel.png')  :    $util.cdnurl('colleat.png')" mode="aspectFill" class="wh40 m-b-10"></image>
					<text class="basecolor fz-28">收藏</text>
				</view>
				
				<!-- 养老订单 -->
				<block v-if="params.pagetype=='yl'">
					<mybtn color="#000000" background="#FACE51" @handclick="yyfn" width="400rpx" height="80rpx" msg="立即预约"/>
				</block>
				
			  <!-- 商品订单 -->
			   <block v-else>
				   <block v-if="type=='groupon'">
				   	<mybtn background="#FB7A35" @handclick="ptshow" color="#fff" width="400rpx" height="80rpx" msg="我要拼团" />
				   </block>
				   
				   <view class="action-btn-group" v-else>
				   	<button type="primary" class="action-btn no-border add-cart-btn" @click="addCart">加入购物车</button>
				   	<button type="primary" class=" action-btn no-border buy-now-btn" @click="buyfn">立即购买</button>
				   </view>
			   </block>
				
		</view>

		<!-- 规格-模态层弹窗 -->
		<view class="popup spec" :class="specClass" @touchmove.stop @click="toggleSpec">
			<!-- 遮罩层 -->
			<view class="mask"></view>
			<view class="layer attr-content" @click.stop="stopPrevent">
				 <view class="d-flex f-end m-t-10 m-b-20" @click="toggleSpec">
				 	 <u-icon name="close" size="32" color="#999999"></u-icon>
				 </view>
				<view class="a-t m-b-30">
					<image class="fs-0" mode="aspectFill" :src="$util.getImgurl(info.image)"></image>
					<view class="right w-100">
						<text class="title line1">{{info.title || ""}}</text>
						<text class="basecolor">{{info.desc || ""}}</text>
						<view class="price-box m-t-30 d-flex f-start">
							<text class="fz-24 fz-FF2525 ">¥</text>
							<text class="m-r-auto fz-FF2525 fz-32 fz-weight">{{info.sales_price || ""}}</text>
							<text class="fz-28 basecolor fz-weight">已售{{info.real_sales || "0"}}件</text>
						</view>
					</view>
				</view>
				<view class="properties" v-if="info.use_spec && type!='groupon' && type!='seckill'">
					<view class="property" v-for="(item, index) in info.specList" :key="index">
						<view class="title">
							<text class="name">{{ item.name }}</text>
							<view class="desc" v-if="item.desc">({{ item.desc }})</view>
						</view>
						
						<view class="values">
							<view class="value" v-for="(value, key) in item.child" :key="key"
								:class="{'default': item.default == value}"
								@tap="changePropertyDefault(index, key)">
								{{ value }}
							</view>
						</view>
					</view>
				</view>
				<view class="d-flex f-start">
					<text class="m-r-20">选择数量</text>
					<u-number-box v-model="value" @change="valChange"></u-number-box>
				</view>
			</view>
		</view>
		
		<u-popup v-model="showpt" border-radius="20" mode="bottom">
				<view class="p20 bg-fff h230">
					<view class="j-center m-b-20  d-flex fz-29 fz-weight fz-000000">
						请选择团队
					</view>
					<view class="itemcur" v-for="(item,index) in grouponlist" :key="index" @click="selccur(item,index)" :class="{'activeitemcur':index==activeitemcur}">
						 {{ item.num || "" }}人团 ￥{{ item.price }}
					</view>
				</view>
		</u-popup>
         <sharecom ref="ShareCanvas" />
		<!-- 分享 -->
		<!-- <share ref="share" :contentHeight="580" :shareList="shareList"></share> -->
	</view>
</template>

<script>
    import ptcom from "./components/index.vue";
	import { mapState,mapGetters } from "vuex";
	import sharecom from "./components/poster.vue"
	export default {
		components:{
			ptcom,
			sharecom
		},
		data() {
			return {
				showpt:false,
				ptlist:[{
					title:"两人团"
				},{
					title:"三人团"
				},{
					title:"五人团"
				}],
				value:1,
				list: [{
						image: 'https://cdn.uviewui.com/uview/swiper/1.jpg',
						title: '昨夜星辰昨夜风，画楼西畔桂堂东'
					},
					{
						image: 'https://cdn.uviewui.com/uview/swiper/2.jpg',
						title: '身无彩凤双飞翼，心有灵犀一点通'
					},
					{
						image: 'https://cdn.uviewui.com/uview/swiper/3.jpg',
						title: '谁念西风独自凉，萧萧黄叶闭疏窗，沉思往事立残阳'
					}
				],
				loading:false,
				couponClass: 'none',
				specClass: 'none',
				specSelected: [],
				favorite: false,
				shareList: [],
				specList: [],
				specChildList: [],
				specTableList: [],
				product: {},
				flash: false,
				id: false,
				countdown: {},
				progress: {
					sold: 1,
					number: 1
				},
				business: false ,// 多商家
				type:"normal",
				params:{}   ,// 路由参数
				info:{},
				activeitemcur:0,
				activity_id:"",  //、 活动id
				grouponlist:[],
				evaluate:[],// 评价列表
				skuList:[],
			};
		},
		computed:{
			...mapState(['latlng']),
				...mapGetters(['isLogin']),
			skuListfn(){
				return this.skuList.length ? this.skuList.join("") : "";
			},
			listfn(){
			    let imgs = this.info?.images;
				return imgs ? this.info.images.split(",") : [];
			}
		},
		async onShareAppMessage(e){
			
			try{
				uni.showLoading({
					title:"分享图片生成中...",
					mask:true
				});
				const imageurl = await this.$refs.ShareCanvas.setGoodsShareCanvas(this.info);
				uni.hideLoading();
				return {
					path:`/pages2/shopdetail/index?${this.objectToQueryString(this.params)}`,
					imageUrl:imageurl,
					title: this.info?.title
				};
			}catch(err){
				
			}
		},
		onLoad(options) {
		    this.params = options;
			if(options.type){
				this.type = options.type;
			}
		},
		onShow() {
			this.getDetail();
		},
		methods: {
			objectToQueryString(obj) {  
			    let queryString = '';  
			    for (let key in obj) {  
			        if (obj.hasOwnProperty(key)) {  
			            let value = encodeURIComponent(obj[key]); // 对值进行编码  
			            if (queryString) {  
			                queryString += '&';  
			            }  
			            queryString += `${encodeURIComponent(key)}=${value}`;  
			        }  
			    }  
			    return queryString;  
			},
			// 拨打客服电话
			makeKf(e){
				if(!this.latlng.valiagephone){
					return this.$u.toast("该小区暂未设置手机号");
				}
				this.$util.makePhone(this.latlng.valiagephone);
				// 在这里处理单击事件的逻辑
				// 例如打开链接、执行动作等
			},
			// 去我的预约
			yyfn(){
			   	this.$util.navTo('/pages3/booknow/index');
			},
			// 模仿php
			in_array(search, array) {
				for (var i in array) {
					if (array[i] == search) {
						return true;
					}
				}
				return false;
			},
			changePropertyDefault(index, key) { //改变默认属性值
				if(!Array.isArray(this.info.specList)){
					this.info.specList = JSON.parse(this.info.specList);
				}
				if(!Array.isArray(this.info.specTableList)){
					this.info.specTableList = JSON.parse(this.info.specTableList);
				}
				console.log(typeof this.info.specList);
				// 
				if (this.in_array(this.info?.specList[index]?.child[key], this.info?.specList[index]?.disable)) {
					console.log(11)
					return;
				}
				
				if (!this.info?.specList[index] || !this.info?.specList[index]?.child[key]) {
					return;
				}
			
				this.info.specList[index].default = this.info.specList[index].child[key];
				// this.info.number = 1;
				let specSelectedName = [];
				
				for (let item of this.info.specList) {
					if (item.default) {
						specSelectedName.push(item.default);
					}
				}
			          
				for (let item of this.info.specTableList) {
					if (item.value.join(' ') == specSelectedName.join(' ')) {
						this.info.market_price = parseFloat(item.market_price).toFixed(2);
						this.info.sales_price = parseFloat(item.sales_price).toFixed(2);
						this.info.stock = item.stock;
						this.info.image = item.image ? item.image : this.info.image;
					}
				}
				if(specSelectedName.length){
					 this.skuList = JSON.parse(JSON.stringify(specSelectedName));
				}
				this.$forceUpdate();
			},
			// 选择拼团
			selccur(item,i){
				this.activeitemcur = i;
				console.log(this.skuList,"this.skuListthis.skuListthis.skuList");
				//  let props_text = this.skuList?.join(",");
				// item.productin.props_text = this.info.use_spec ? props_text : '';
				let groupon = [{
					...item
				}];
				uni.setStorageSync("groupon",groupon);
				// activity_id
				this.showpt = false;
				return this.$util.navTo('/pages2/orderconfirm/index?type=groupon&activity_id='+item.activity_id+"&activityProduct_id="+item.id);
			},
			ptshow(){
				this.showpt = true;
			},
			// 收藏商品
			async collectShop(){
				if (!this.isLogin) {
				    return this.$util.navTo("/pages/components/pages/login/newlogin");
				}
				  await this.$u.api.addCollect({product_id:this.params.id,type:1});
				 this.flash = !this.flash;
			},
			getGoodSelectedProps(good, type = 'text') { //计算当前饮品所选属性
				if (good.use_spec) {
					let props = [];
					if(!Array.isArray(good.specList)){
						good.specList = JSON.parse(good.specList);
					}
					good.specList.forEach(values => {
						if (type === 'text') {
							props.push(values.default)
						}
					})
					return type === 'text' ? props.join(',') : props
				}
				return ''
			},
			// 购买的弹窗
			buyfn(){
				  let props_text = this.skuList?.join(",");
				if(this.specClass!='none'){
					let activity_id = this.activity_id ? this.activity_id : "";
					let cart = [{
						...this.info,
						number:this.value,
						props_text:this.info.use_spec ? props_text : '',
						isAc:this.params.type=='seckill' ? 1 : 0,
						activity_id
					}];
					// type=seckill&id=100&activity_id=9
					uni.setStorageSync("shopnormal",cart);
					this.toggleSpec();
					return this.$util.navTo('/pages2/orderconfirm/index?type='+this.type+"&activity_id="+activity_id);
				}
				this.toggleSpec();
			},
			// 当前的值
			valChange(e) {
			     console.log('当前值为: ' + e.value)
			},
			// 为0时刷新页面
			timeup() {
				this.getDetail(this.id, this.flash ? this.flash : 0);
			},
			// 获取商品详情
			async getDetail() {
				uni.showLoading({
					mask:true
				})
                 const res = await this.$u.api.getProductInfo({
					 type:this.params.type || "normal",//	string	是	类型;seckill=秒杀groupon=拼团normal=正常产品
					 id:this.params.id,//	integer	是	产品ID
					 activity_id:this.params.activity_id || ""//	integer	是	活动id
				 });
				 // type=seckill&id=5&activity_id=1
				 // 拼团
				 if(Array.isArray(res.info) && this.params.type=='groupon'){
					 // 取价格最低的
					  this.info = this.findCheapestItem(res.info)?.productin || {};
					  // 价格与普通的不同
					  this.info.sales_price = this.findCheapestItem(res.info)?.price;
					  this.grouponlist = res.info;
				 }else if(this.params.type=='seckill'){
					 // 秒杀
					  this.info = res.info.productin;
					  this.info.sales_price = res.info.price;
					  this.activity_id =res.info.activity_id;
				 }else{
					 // 普通商品
					  if(res.info.use_spec && !Array.isArray(res.info.specList)){
						  res.info.specList = JSON.parse(res.info.specList)
					  }
					  if(res.info.use_spec && !Array.isArray(res.info.specTableList)){
					  	   res.info.specTableList = JSON.parse(res.info.specTableList)
					  }
					  this.info = res.info;
					  // 默认第一个
					  // 
					  if(res.info.use_spec){
						  for (let i = 0; i < res.info.specList.length; i++) {
						  	this.changePropertyDefault(i, 0);
						  }
					  }
				 };
				
				 // 商品评价
				 this.evaluate = res.evaluate;
				 this.loading = true;
				 uni.hideLoading();
				 if(this.isLogin){
					  this.isCollectfn()
				 }
				
			},
			findCheapestItem(items) {  
			  let cheapestItem = null; 
			  let minPrice = Infinity;
			  // 遍历数组中的每个对象  
			  for (let i = 0; i < items.length; i++) {  
			    if (Number(items[i].price)  < minPrice) {  
			      minPrice = items[i].price;  
			      cheapestItem = items[i];  
			    }  
			  }  
			  
			  return cheapestItem;  
			}, 
			// 查看商品是否被收藏
			async isCollectfn(){
				// type 1产品 2 服务
				 const data = await this.$u.api.isCollect({product_id:this.params.id,type:this.params.pagetype=='yl' ? 2 : 1});
				 if(data){
					 this.flash = true;
				 }else{
					 this.flash = false;
				 }
			},
			//领取优惠券开关
			toggleCoupon() {
				if (this.couponClass === 'show') {
					this.couponClass = 'hide';
					setTimeout(() => {
						this.couponClass = 'none';
					}, 250);
				} else if (this.couponClass === 'none') {
					this.couponClass = 'show';
				}
			},
			//规格弹窗开关
			toggleSpec() {
				if (this.specClass === 'show') {
					this.specClass = 'hide';
					setTimeout(() => {
						this.specClass = 'none';
					}, 250);
				} else if (this.specClass === 'none') {
					this.specClass = 'show';
				}
			},
			//选择规格
			selectSpec(index, pid) {
				let list = this.specChildList;
				list.forEach(item => {
					if (item.pid === pid) {
						this.$set(item, 'selected', false);
					}
				})

				this.$set(list[index], 'selected', true);
				//存储已选择
				/**
				 * 修复选择规格存储错误
				 * 将这几行代码替换即可
				 * 选择的规格存放在specSelected中
				 */
				this.specSelected = [];
				//console.log(list)
				list.forEach(item => {
					if (item.selected === true) {
						this.specSelected.push(item.name);
					}
				})

			},
			//分享
			share() {
				this.$refs.share.toggleMask();
			},
			//收藏
			async toFavorite() {
				if (this.flash) {
					this.$api.msg('秒杀商品不能收藏');
					return;
				}
				let is_login = await this.$api.checkLogin();
				if (is_login) {
					this.favorite = !this.favorite;
					let bool = await ProductFavorite({
						id: this.product.product_id
					});
					if (!bool) {
						this.favorite = !this.favorite;
					}
				}
			},
			//添加购物车
			async addCart() {
				if (!this.isLogin) {
									return this.$util.navTo("/pages/components/pages/login/newlogin");
								}
			   let cart = uni.getStorageSync("cart") || [];
			   let props_text = this.skuList?.join(",");
			  // 不用规格
			  if(!this.info.use_spec){
				  if(cart.some(v=>v.id==this.info.id)){
				  	 return this.$u.toast("该商品已在购物车");
				  }
			  }
			  // 用规格
			  if(this.info.use_spec){	
				  if(cart.some(v=>v.id==this.info.id && v.props_text==props_text)){
				  	 return this.$u.toast("该商品已在购物车");
				  }
			  }
			  this.info.number = 1;
			  let activity_id = "";
			  // 秒杀前端处理活动商品
			  if(this.params.type=='seckill'){
				  this.info.isAc = 1;
				  activity_id = this.activity_id || "";
			  }
			   cart = [...cart,{...this.info,props_text,activity_id}];
			   uni.setStorageSync("cart",cart);
			    return this.$u.toast("加入成功");
			},
			stopPrevent() {},
			// 计算百分比
			percentage(number, sold) {
				if (!sold) {
					return 0;
				}
				return parseInt(sold / number * 100);
			},
			// 查看图片
			previewImage(index) {
				uni.previewImage({
					current: this.product.images_text[index],
					urls: this.product.images_text,
					indicator: "number",
					loop: true
				})
			},
			// 进入店铺
			insideStore() {
				let id = 0;
				this.$api.navTo("/pages/business/index?id=" + id, false);
			}
		},

	}
</script>

<style lang='scss' scoped>
	page {
		background: #F5F5F5;
		min-height: 100vh;	
	}
	.properties {
		width: 100%;
		border-top: 2rpx solid $bg-color-grey;
		padding: 10rpx 30rpx 0;
		padding-left: 0;
		display: flex;
		flex-direction: column;
	
		.property {
			width: 100%;
			display: flex;
			flex-direction: column;
			margin-bottom: 30rpx;
			padding-bottom: -16rpx;
	
			.title {
				width: 100%;
				display: flex;
				justify-content: flex-start;
				align-items: center;
				margin-bottom: 20rpx;
	
				.name {
					font-size: 26rpx;
					color: $text-color-base;
					margin-right: 20rpx;
				}
	
				.desc {
					flex: 1;
					font-size: $font-size-sm;
					color: $color-primary;
					overflow: hidden;
					text-overflow: ellipsis;
					white-space: nowrap;
				}
			}
	
			.values {
				width: 100%;
				display: flex;
				flex-wrap: wrap;
	
				.value {
					border-radius: 8rpx;
					background-color: $bg-color-grey;
					padding: 16rpx 30rpx;
					font-size: 26rpx;
					color: $text-color-assist;
					margin-right: 16rpx;
					margin-bottom: 16rpx;
	
					&.default {
						background-color: #FACE51;
						color: $text-color-white;
					}
				}
			}
		}
	}
	.line80{
		line-height: 80rpx;
		.label{
			font-size: 28rpx;
			color: #000000;
			font-weight: bold;
		}
	}
	.h230{
		height: 550rpx;
	}
	.content{
		padding-bottom: 220upx;
	}
	
	.wh140{
		width: 140rpx;
		height: 140rpx;
		border-radius: 20rpx;
		margin-right: 24rpx;
	}
	
	.time{
		font-weight: 500;
		font-size: 24rpx;
		color: rgba(0,0,0,0.5);
	}

	.icon-you {
		color: #888;
	}

	.carousel {
		height: 750upx;
		position: relative;
		
        .bgswiper{
			position: absolute;
			bottom: 0;
			left: 0;
			right: 0;
			width: 100%;
			height: 100rpx;
			z-index: 2;
			padding: 26rpx 16rpx 16rpx 32rpx;
			.wh144{
				width: 144rpx;
				height: 35rpx;
			}
		}
		swiper {
			height: 100%;
		}

		.image-wrapper {
			width: 100%;
			height: 100%;
		}

		.swiper-item {
			display: flex;
			justify-content: center;
			align-content: center;
			height: 750upx;
			overflow: hidden;
            .h110{
				background-color: transparent;
				backdrop-filter: blur(40px);
				 background-color: rgba(255, 255, 255, 0.4); /* 半透明背景 */  
				opacity: .7;
            	position: absolute;
            	bottom: 0;
            	left: 0;
            	right: 0;
            	width: 100%;
            	height: 100rpx;
            }
			image {
				width: 100%;
				height: 100%;
			}
		}

	}

	/* 标题简介 */
	.introduce-section {
		background: #fff;
		padding: 20upx 30upx;
		.title {
			display: block;
			font-weight: 800;
			font-size: 32rpx;
			color: #333333;
			margin-bottom: 10rpx;
		}

		.price-box {
			display: flex;
			align-items: baseline;
			height: 64upx;
			padding: 10upx 0;
			font-size: 26upx;
		}
		
		.price {
			
		}
		.m-price {
			text-decoration: line-through;
		}

		.coupon-tip {
			align-items: center;
			padding: 4upx 10upx;
			color: #fff;
			border-radius: 6upx;
			line-height: 1;
			transform: translateY(-4upx);
		}
		.bot-row {
			display: flex;
			/* height: 50upx; */
			color: rgba(0, 0, 0, .5);
			text {
				/* flex: 1; */
			}
		}
	}
	
	/* 选择规格 */
	.selsku{
		padding: 20rpx;
		margin-top: 20rpx;
		margin-bottom: 20rpx;
		background-color: #fff;
	}
	.activeitemcur{
		color: #fff !important;
		border: 2rpx solid #FACE51 !important;
		background-color: #FACE51 !important;
	}
	
		.itemcur{
			display: inline-block;
			width: fit-content;
			padding: 20rpx 30rpx;
			border-radius: 90rpx;
			color: #000000;
			border: 2rpx solid #979797;
			margin-right: 20rpx;
		}
	/* 分享 */
	.share-section {
		display: flex;
		align-items: center;
		background: linear-gradient(left, #fdf5f6, #fbebf6);
		padding: 12upx 30upx;

		.share-icon {
			display: flex;
			align-items: center;
			width: 70upx;
			height: 30upx;
			line-height: 1;
			border: 1px solid $uni-color-primary;
			border-radius: 4upx;
			position: relative;
			overflow: hidden;
			font-size: 22upx;
			color: $uni-color-primary;

			&:after {
				content: '';
				width: 50upx;
				height: 50upx;
				border-radius: 50%;
				left: -20upx;
				top: -12upx;
				position: absolute;
				background: $uni-color-primary;
			}
		}
	

		.icon-xingxing {
			position: relative;
			z-index: 1;
			font-size: 24upx;
			margin-left: 2upx;
			margin-right: 10upx;
			color: #fff;
			line-height: 1;
		}

		.tit {
			margin-left: 10upx;
		}

		.icon-bangzhu1 {
			padding: 10upx;
			font-size: 30upx;
			line-height: 1;
		}

		.share-btn {
			flex: 1;
			text-align: right;
			color: $uni-color-primary;
		}

		.icon-you {
			margin-left: 4upx;
		}
	}

	.c-list {
		background: #fff;

		.c-row {
			display: flex;
			align-items: center;
			padding: 20upx 30upx;
			position: relative;
		}

		.tit {
			width: 140upx;
		}

		.con {
			flex: 1;
			color: $font-color-dark;

			.selected-text {
				margin-right: 10upx;
			}
		}

		.bz-list {
			height: 40upx;

			text {
				display: inline-block;
				margin-right: 30upx;
			}
		}

		.con-list {
			flex: 1;
			display: flex;
			flex-direction: column;
			color: $font-color-dark;
			line-height: 40upx;
		}

		.red {
			color: $uni-color-primary;
		}
	}

	/* 评价 */
	.eva-section {
		display: flex;
		flex-direction: column;
		padding: 20upx 30upx;
		background: #fff;
		.e-header {
			display: flex;
			align-items: center;
			height: 70upx;

			.tit {
				color: $font-color-dark;
				margin-right: 4upx;
			}

			.tip {
				flex: 1;
				text-align: right;
			}

			.icon-you {
				margin-left: 10upx;
			}
		}
	}

	.eva-box {
		display: flex;
		padding: 20upx 0;

		.portrait {
			flex-shrink: 0;
			width: 70upx;
			height: 70upx;
			border-radius: 50%;
		}

		.right {
			flex: 1;
			display: flex;
			flex-direction: column;
			padding-left: 26upx;
           padding-top: 16upx;
		   .name{
			   font-weight: 500;
			   font-size: 28rpx;
			   color: #000000;
		   }
			.con {
				padding: 20upx 0;
			}

			.bot {
				display: flex;
				justify-content: space-between;
			}
		}
	}

	.business {
		background: #fff;
		margin-top: 16upx;

		padding: 30upx;

		.logo {
			display: inline-block;
			padding: 0 10upx 0 0;

			.image {
				width: 100upx;
				height: 100upx;
				border-radius: 6upx;
			}
		}

		.title {
			font-size: 30upx;
			display: inline-block;
			vertical-align: top;

			.star {
				font-size: 20upx;
				background: #c9c8cb;
				color: #ffffff;
				padding: 4upx 8upx;
				border-radius: 20upx;
				line-height: 20upx;

				.start {
					display: inline-block;
				}
			}
		}

		.button {
			display: inline-block;
			font-size: 27upx;
			line-height: 90upx;
			float: right;

			.btn1 {
				display: inline-block;
				border-radius: 30upx;
				border: 1upx solid #ffac30;
				color: #F56C6C;
				padding: 10upx 20upx;
				margin-right: 10upx;
				line-height: 30upx;
			}

			.btn2 {
				display: inline-block;
				background: linear-gradient(to right, #ffac30, #fa436a, #F56C6C);
				border-radius: 30upx;
				color: #ffffff;
				padding: 10upx 20upx;
				line-height: 30upx;
			}
		}
	}

	/*  详情 */
	.detail-desc {
		background: #fff;
		margin-top: 16upx;
        padding-bottom: 20rpx;
		.d-header {
			display: flex;
			justify-content: center;
			align-items: center;
			height: 80upx;
			color: $font-color-dark;
			position: relative;

			text {
				padding: 0 20upx;
				background: #fff;
				position: relative;
				z-index: 1;
			}

			&:after {
				position: absolute;
				left: 50%;
				top: 50%;
				transform: translateX(-50%);
				width: 300upx;
				height: 0;
				content: '';
				border-bottom: 1px solid #ccc;
			}
		}
	}

	/* 规格选择弹窗 */
	.attr-content {
		padding: 10upx 30upx;

		.a-t {
			display: flex;

			image {
				width: 170upx;
				height: 170upx;
				flex-shrink: 0;
				/* margin-top: -40upx; */
				border-radius: 8upx;
			}

			.right {
				display: flex;
				flex-direction: column;
				padding-left: 24upx;
				line-height: 42upx;
                .title{
					width: 500rpx;
				}
				.price {
					color: $uni-color-primary;
					margin-top: 20rpx;
					margin-bottom: 20rpx;
				}

				.selected-text {
					margin-right: 10upx;
				}
			}
		}

		.attr-list {
			display: flex;
			flex-direction: column;
			padding-top: 30upx;
			padding-left: 10upx;
		}

		.item-list {
			padding: 20upx 0 0;
			display: flex;
			flex-wrap: wrap;

			text {
				display: flex;
				align-items: center;
				justify-content: center;
				background: #fff;
				margin-right: 20upx;
				margin-bottom: 20upx;
				border-radius: 100upx;
				min-width: 60upx;
				height: 60upx;
				padding: 0 20upx;
				font-weight: 500;
				font-size: 28rpx;
				color: #999999;
				border: 2rpx solid #999999;
			}

			.selected {
				border: 2rpx solid transparent;
				background: #4DD88D;
				color: #fff;
			}
		}
	}

	/*  弹出层 */
	.popup {
		position: fixed;
		left: 0;
		top: 0;
		right: 0;
		bottom: 0;
		z-index: 99;

		&.show {
			display: block;

			.mask {
				animation: showPopup 0.2s linear both;
			}

			.layer {
				animation: showLayer 0.2s linear both;
			}
		}

		&.hide {
			.mask {
				animation: hidePopup 0.2s linear both;
			}

			.layer {
				animation: hideLayer 0.2s linear both;
			}
		}

		&.none {
			display: none;
		}

		.mask {
			position: fixed;
			top: 0;
			width: 100%;
			height: 100%;
			z-index: 1;
			background-color: rgba(0, 0, 0, 0.4);
		}

		.layer {
			position: fixed;
			z-index: 99;
			bottom: 0;
			width: 100%;
			min-height: 40vh;
			border-radius: 10upx 10upx 0 0;
			background-color: #fff;
            padding-bottom: 220rpx;
			.btn {
				height: 66upx;
				line-height: 66upx;
				border-radius: 100upx;
				color: #fff;
				margin: 30upx auto 20upx;

			}
		}

		@keyframes showPopup {
			0% {
				opacity: 0;
			}

			100% {
				opacity: 1;
			}
		}

		@keyframes hidePopup {
			0% {
				opacity: 1;
			}

			100% {
				opacity: 0;
			}
		}

		@keyframes showLayer {
			0% {
				transform: translateY(120%);
			}

			100% {
				transform: translateY(0%);
			}
		}

		@keyframes hideLayer {
			0% {
				transform: translateY(0);
			}

			100% {
				transform: translateY(120%);
			}
		}
	}

	/* 底部操作菜单 */
	.page-bottom {
		position: fixed;
		left: 0upx;
		bottom: 0;
		z-index: 9999;
		display: flex;
		padding: 0 20rpx;
		padding-left: 46rpx;
		padding-top: 42rpx;
		padding-bottom: calc(env(safe-area-inset-bottom) + 10rpx);
		justify-content: space-between;
		align-items: center;
		width: 100%;
		background: #fff;
		/* box-shadow: 0 0 20upx 0 rgba(0, 0, 0, .5); */
		border-radius: 16upx;
		.wh48{
			width: 48rpx;
			height: 48rpx;
			
		}
	}
	
	
	.action-btn-group {
		display: flex;
		height: 76upx;
		border-radius: 100px;
		overflow: hidden;
		/* box-shadow: 0 20upx 40upx -16upx #fa436a;
		box-shadow: 1px 2px 5px rgba(219, 63, 96, 0.4);
		background: linear-gradient(to right, #ffac30, #fa436a, #F56C6C); */
		margin-left: 20upx;
		position: relative;
	    .add-cart-btn{
			 background-color: #FACE51 !important;
			 font-weight: 800;
			 font-size: 28rpx;
			 color: #FFFFFF;
		}
		.buy-now-btn{
			 background-color: #FB7A35 !important;
			 font-weight: 800;
			 font-size: 28rpx;
			 color: #FFFFFF;
		}
		.only {
			width: 360rpx !important;
		}
	
	/* 	&:after {
			content: '';
			position: absolute;
			top: 50%;
			right: 50%;
			transform: translateY(-50%);
			height: 28upx;
			width: 0;
			border-right: 1px solid rgba(255, 255, 255, .5);
		} */
	
		.action-btn {
			display: flex;
			align-items: center;
			justify-content: center;
			width: 180upx;
			height: 100%;
			font-size: $font-base;
			padding: 0;
			border-radius: 0;
			background: transparent;
		}
	}

	.flash {
		height: 100upx;
		background: linear-gradient(to right, #ffac30, #fa436a, #F56C6C);
		display: flex;
		flex-direction: row;
		position: relative;

		.sales_price {
			.symbol {
				font-size: 30upx;
				display: inline;
			}

			color: #fff;
			font-size: 50upx;
		}

		.left {
			font-size: 28upx;
			padding: 10upx;

			.market_price {
				color: #DCDFE6;
				text-decoration: line-through;
			}

			.sold {
				color: #E4E7ED;
			}
		}

		.right {
			height: 100%;
			width: 300upx;
			position: absolute;
			right: 0;
			padding: 4upx;
			margin-right: 20upx;

			.time {
				font-size: 30upx;
				color: #fffa30;
				text-align: center;

				.uni-countdown {
					display: inline-flex;
				}
			}

			.progress {
				position: absolute;
				bottom: 7rpx;
				right: 10upx;
			}

			.flashDone {
				font-size: 40rpx;
				height: 90rpx;
				line-height: 90rpx;
			}
		}
	}



	/* 优惠券列表 */
	.content-coupon {
		padding-bottom: 100rpx;
		max-height: 800rpx;
		overflow: auto;
	}

	.retract {
		position: fixed;
		bottom: 0;
		width: 700rpx;
		z-index: 100;
		margin: 20rpx 25rpx;
		color: #ffffff;
		background: #fa436a;
	}

	.coupon-item {
		display: flex;
		flex-direction: column;
		background: #fff;

		.con {
			display: flex;
			align-items: center;
			position: relative;
			height: 120upx;
			padding: 0 30upx;

			&:after {
				position: absolute;
				left: 0;
				bottom: 0;
				content: '';
				width: 100%;
				height: 0;
				border-bottom: 1px dashed #f3f3f3;
				transform: scaleY(50%);
			}
		}

		.left {
			display: flex;
			flex-direction: column;
			justify-content: center;
			flex: 1;
			overflow: hidden;
			height: 100upx;
		}

		.title {
			font-size: 32upx;
			color: $font-color-dark;
			margin-bottom: 10upx;
		}

		.time {
			
			font-size: 24upx;
		}

		.right {
			display: flex;
			flex-direction: column;
			justify-content: center;
			align-items: center;
			font-size: 26upx;
			height: 100upx;
			
		}

		.price {
			font-size: 44upx;

			&:before {
				content: '￥';
				font-size: 34upx;
			}
		}

		.tips {
			font-size: 24upx;
			line-height: 60upx;
			padding-left: 30upx;
		}

		.circle {
			position: absolute;
			left: -6upx;
			bottom: -10upx;
			z-index: 10;
			width: 20upx;
			height: 20upx;
			background: #f3f3f3;
			border-radius: 100px;

			&.r {
				left: auto;
				right: -6upx;
			}
		}
	}
	.wh28{
		width: 28rpx;
		height: 28rpx;
	}
</style>
