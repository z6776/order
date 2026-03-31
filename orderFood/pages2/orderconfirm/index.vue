<template>
	<view class="content">
		<view class="subsection">
			<u-subsection :list="list" v-if="showsub" :current="curNow" @change="sectionChange" inactive-color="#979797"
				mode="subsection" active-color="#FACE51"></u-subsection>
		</view>

		<block v-if="curNow==0">
			<view class="form">
				<view class="form-item d-flex  p-t-20 p-b-20 borderbottom">
					<view class="label fz-707070 fz-28 fz-weight m-r-100 fs-0">姓名</view>
					<input v-model="form.usernmae" type="text" placeholder="请填写姓名" class="ints"
						placeholder-class="placeholderClass" style="text-align: right;" />
				</view>
				<view class="form-item d-flex  p-t-20 p-b-20 borderbottom">
					<view class="label fz-707070 fz-28 fz-weight m-r-100 fs-0">手机号</view>
					<input v-model="form.phone" type="text" placeholder="请填写手机号" class="ints"
						placeholder-class="placeholderClass" style="text-align: right;" />
				</view>

				<view class="form-item d-flex  p-t-20 p-b-20 borderbottom" @click="showpicker=true">
					<view class="label fz-707070 fz-28 fz-weight  fs-0 m-r-20">自提点</view>
					<view class="flex-1">
						<zxz-uni-data-select @close="closefn" :isEnd="is_valiage_end" @scdown="scrolltolower"
							@inputChange="inputChange" @change="valiageCheckfn" placeholder="请选择自提点" filterable
							v-model="valiage_value" :localdata="valiage_range" />
					</view>
					<!-- 
						 <view class="d-flex f-start">							 
							 <picker mode='multiSelector' @change="changeztd" @columnchange="bindPickerChange" range-key="name" :value="rangevalue" :range="valiagelist">
							 	  <view class="uni-input">{{ form.village_id ?  villagename +" - " + selfpcikupname : '请选择自提点' }}</view>
							 </picker>
							 <u-icon name="arrow-right" size="28" color="#000000"></u-icon>
						 </view> -->
				</view>

				<view class="form-item d-flex  p-t-20 p-b-20  a-start">
					<view class="label fz-707070 fz-28 fz-weight m-r-10 fs-0">订单备注</view>
					<textarea v-model="form.remark" id="" cols="30" rows="10" class="p20 bgareas"
						placeholder="请输入订单备注或者建议内容"></textarea>
					<!-- <input v-model="form.remark" type="text" placeholder="请输入订单备注或者建议内容" class="ints fz-right" placeholder-class="placeholderClass"/> -->
				</view>
			</view>

			<view class="form p-b-20 m-t-20" @click="seltimefn()">
				<view class="form-item d-flex p-t-20">
					<view class="label fz-707070 fz-32 fz-weight m-r-100 fs-0">期望配送时间</view>
					<view class="d-flex f-start">
						<text class="fz-32 fz-000000">{{ $util.parseTime(timeSel,"{m}-{d}")  }} {{ TimeRanges }}</text>
						<u-icon name="arrow-right" size="28" color="#000000"></u-icon>
					</view>
				</view>
				<view class="form-item d-flex f-start message">
					今日点餐,明日送达,请选择明日堂食/配送时间
				</view>
				<view class="d-c-flex kitchen">
					<view class="">
						{{ $util.parseTime(timeSel,"{m}月{d}日") }}
					</view>
					<view class="">
						{{ TimeRanges=='上午' ? "午餐" : "晚餐" }}
					</view>
				</view>
				<view class="f-center pstime">
					配送时间 {{ $util.parseTime(timeSel,"{m}月{d}日") }}
					{{ TimeRanges=='上午' ? "11:30-12:00" : "16:00-17:30" }}
				</view>
			</view>
		</block>

		<block v-if="curNow==1">
			<view class="form">
				<navigator url="/pages/components/pages/address/address?source=1" class="address-section radius-20">
					<view class="order-content">
						<view class="order-content d-c-flex a-start" v-if="addressData && addressData.name">
							<view class="d-flex f-start">
								<text class="dottag fs-0">默认</text>
								<text class="m-l-20 fz-707070 fz-28">{{ addressData.address|| ""  }}</text>
							</view>
							<view class="cen">
								<text class="address fz-32">{{ addressData.door_number|| ""  }}</text>
								<view class="top m-t-20">
									<text class="name fz-28">{{ addressData.name|| ""  }}</text>
									<text class="mobile fz-28">{{ addressData.mobile || ""  }}</text>
								</view>
							</view>
						</view>
						<block v-else>
							<image :src="$util.cdnurl('addressicon.png')" mode="aspectFill" class="wh36"></image>
							<view class="cen m-l-20">请选择收货地址</view>
							<u-icon name="arrow-right" size="28" color="#000000"></u-icon>
						</block>
					</view>
				</navigator>
				<view class="form-item d-flex  p-t-20 p-b-20 borderbottom" @click="showpicker=true" v-if="false">
					<view class="label fz-707070 fz-28 fz-weight  fs-0 m-r-20">自提点</view>
					<view class="flex-1">
						<zxz-uni-data-select @close="closefn" :isEnd="is_valiage_end" @scdown="scrolltolower"
							@inputChange="inputChange" placeholder="请选择自提点" filterable @change="valiageCheckfn"
							v-model="valiage_value" :localdata="valiage_range" />
					</view>
				</view>

				<view class="form p-b-20 p-t-0" @click="seltimefn()">
					<view class="form-item d-flex">
						<view class="label fz-707070 fz-32 fz-weight m-r-100 fs-0">期望配送时间</view>
						<view class="d-flex f-start">
							<text class="fz-32 fz-000000">{{ $util.parseTime(timeSel,"{m}-{d}")  }}
								{{ TimeRanges }}</text>
							<u-icon name="arrow-right" size="28" color="#000000"></u-icon>
						</view>
					</view>
					<view class="form-item d-flex f-start message">
						今日点餐,明日送达,请选择明日堂食/配送时间
					</view>
					<view class="d-c-flex kitchen">
						<view class="">
							{{ $util.parseTime(timeSel,"{m}月{d}日") }}
						</view>
						<view class="">
							{{ TimeRanges=='上午' ? "午餐" : "晚餐" }}
						</view>
					</view>
					<view class="f-center pstime">
						配送时间 {{ $util.parseTime(timeSel,"{m}月{d}日") }}
						{{ TimeRanges=='上午' ? "11:30-12:00" : "16:00-17:30" }}
					</view>
				</view>

				<view class="form-item d-flex f-start  p-t-20 p-b-20 a-start">
					<view class="label fz-707070 fz-28 fz-weight m-r-10 fs-0">订单备注</view>
					<textarea class="p20 bgareas" v-model="form.remark" id="" cols="30" rows="10"
						placeholder="请输入订单备注或者建议内容"></textarea>
					<!-- <input v-model="form.remark" type="text" placeholder="请输入订单备注或者建议内容"  class="fs-0 ints fz-right" placeholder-class="placeholderClass"/> -->
				</view>
			</view>
		</block>

		<block v-if="curNow==2">
			<view class="form">
				<view class="form-item d-flex p-t-20" @click="kshow=true">
					<view class="label fz-707070 fz-28 fz-weight m-r-100 fs-0">堂食食堂</view>
					<view class="d-flex f-start">
						<text>{{ kname || "请选择食堂" }}</text>
						<u-icon name="arrow-right" size="28" color="#000000"></u-icon>
					</view>
				</view>
				<view class="fz-28 m-t-20" style="color: #1861fb;" v-if="kobj.address"
					@click.stop="$util.openLocation(kobj.longitude,kobj.latitude,kname,kobj.address)">
					{{ kobj.address || "" }}
				</view>
				<view class="p-b-20 borderbottom">

				</view>
				<view class="form-item d-flex  p-t-20 p-b-20 borderbottom">
					<view class="label fz-707070 fz-28 fz-weight m-r-100 fs-0">姓名</view>
					<input v-model="form.usernmae" type="text" placeholder="请填写姓名" class="ints"
						placeholder-class="placeholderClass" style="text-align: right;" />
				</view>
				<view class="form-item d-flex  p-t-20 p-b-20 borderbottom">
					<view class="label fz-707070 fz-28 fz-weight m-r-100 fs-0">手机号</view>
					<input type="text" v-model="form.phone" placeholder="请填写手机号" class="ints"
						placeholder-class="placeholderClass" style="text-align: right;" />
				</view>

				<view class="form p-0 p-b-20 m-t-20" @click="seltimefn()">
					<view class="form-item d-flex p-t-20">
						<view class="label fz-707070 fz-32 fz-weight m-r-100 fs-0">期望堂食时间</view>
						<view class="d-flex f-start">
							<text class="fz-32 fz-000000">{{ $util.parseTime(timeSel,"{m}-{d}")  }}
								{{ TimeRanges }}</text>
							<u-icon name="arrow-right" size="28" color="#000000"></u-icon>
						</view>
					</view>
					<view class="form-item d-flex f-start message">
						今日点餐,明日送达,请选择明日堂食/配送时间
					</view>
					<view class="d-c-flex kitchen">
						<view class="">
							{{ $util.parseTime(timeSel,"{m}月{d}日") }}
						</view>
						<view class="">
							{{ TimeRanges=='上午' ? "午餐" : "晚餐" }}
						</view>
					</view>
					<view class="f-center pstime">
						配送时间 {{ $util.parseTime(timeSel,"{m}月{d}日") }}
						{{ TimeRanges=='上午' ? order_gettimesw : order_gettimexw }}
					</view>
				</view>

				<view class="form-item d-flex f-start  p-t-20 p-b-20 a-start">
					<view class="label fz-707070 fz-28 fz-weight m-r-10 fs-0">订单备注</view>
					<textarea class="p20 bgareas" v-model="form.remark" id="" cols="30" rows="10"
						placeholder="请输入订单备注或者建议内容"></textarea>

				</view>
			</view>
		</block>


		<!-- 商品信息 -->
		<view class="p20 radius-20 m-b-20 p20 bg-fff m-t-20">
			<view class="fz-32 fz-000000 fz-weight">
				商品信息
			</view>
			<view class="d-flex f-start p-b-30 borderbottom p-t-30" v-for="(item,index) in shoplist" :key="index">
				<image :src="$util.getImgurl(item.image)" mode="aspectFill" class="wh130 fs-0 m-r-20"></image>
				<view class="d-c-flex a-start flex-1">
					<view class="fz-32 fz-000000 d-flex f-start">
						<view class="tagStyle m-r-10" v-if="item.isAc==1">福利抢购</view>
						<view class="">
							{{item.title || ""}}
						</view>
					</view>
					<view class="d-flex f-start m-t-20 m-b-20">
						<text class="basecolor">
							<block v-if="item.props_text">
								{{item.props_text || "" }}
							</block>
							<block v-if="item.desc">
								{{item.desc || ""}}
							</block>

						</text>
					</view>
					<view class="d-flex f-start w-100">
						<text class="fz-FF2525 m-r-20">￥{{item.sales_price || ""}}</text>
						<text class="m-r-auto fz-28 fz-999999">x{{item.number ||""}}</text>
						<block v-if="curNow!=2">
							<text>打包费:</text>
							<text>￥{{item.packing_price || "0"}}元</text>
						</block>
					</view>
				</view>
			</view>
		</view>
		<view class="form">
			<view class="form-item d-flex  p-t-10 p-b-10">
				<view class="label fz-707070 fz-28 fz-weight m-r-100 fs-0">总金额</view>
				<view class="">
					￥{{total}}元
				</view>
			</view>
			<view class="form-item d-flex  p-t-10 p-b-10 " v-if="curNow!=2">
				<view class="label fz-707070 fz-28 fz-weight m-r-100 fs-0">打包费</view>
				<view class="">
					￥{{dtotal}}元
				</view>
			</view>
			<view class="form-item d-flex  p-t-10 p-b-10 " v-if="curNow==1 && !isDy">
				<view class="label fz-707070 fz-28 fz-weight m-r-100 fs-0">配送费</view>
				<view class="">
					￥ {{ delivery_price }}元
				</view>
			</view>
			<!-- v-if="isShowYh" -->
			<view class="form-item d-flex  p-t-10 p-b-10 " @click="goCoupon()">
				<view class="label fz-707070 fz-28 fz-weight m-r-100 fs-0">优惠券</view>
				<view class="d-flex f-start">
					<text>{{ coupon.title || "请选择优惠券" }}</text>
					<u-icon name="arrow-right" size="28" color="#000000" v-if="!coupon.title"></u-icon>
					<view class="m-l-20" v-else @click.stop="delCoupon()">
						<u-icon name="close" size="28" color="#000000" v-if="coupon.title"></u-icon>
					</view>
				</view>
			</view>

			<view class="form-item p-t-10 p-b-10 " v-if="position.score && isShowYh"
				@click="checked=!checked,buyfn('total')">
				<view class="label fz-707070 fz-28 fz-weight m-r-100 fs-0  d-flex">
					<text class="fz-28 fz-500 fz-707070">使用福豆抵,可抵扣 {{ scorefn }} 元,剩余{{ position.score }}福豆</text>
					<radio :checked="checked" style="transform: scale(.8)" color="#FACE51" />
				</view>
				<view class="m-t-10">
					<text class="fz-28 m-t-10"
						style="color: #1861fb;">当前{{ position.score || "0.00" }}福豆,50福豆可抵扣1元</text>
				</view>
				<view class="m-t-10">
					<text class="fz-28 m-t-10"
						style="color: #ff0000;">最大可抵扣订单金额{{reduce_break}}</text>
				</view>
				
			</view>

			<view class="form-item d-flex f-end  p-t-10 p-b-10">
				<view class="label fz-707070 fz-28 fz-weight m-r-100 fs-0">
					<text>共{{shoplist.length}}件</text>
					<text>合计:￥</text>
					<text>{{ hjtotal }}</text>
				</view>
			</view>
		</view>

		<view class="form m-t-30">
			<view class="fz-28 fz-000000 m-b-20">
				注意事项
			</view>
			<view class="">
				<rich-text :nodes="richttext | filterdetail"></rich-text>
			</view>
		</view>

		<!-- 食堂列表 -->
		<u-select v-model="kshow" value-name="id" label-name="name" :list="klist" @confirm="rconfirm"></u-select>

		<!-- 选择上午下午 -->
		<u-popup v-model="show" mode="center" border-radius="20">
			<view class="p20 popup">
				<view class="d-flex j-center fz-32 fz-000000 fz-weight">
					选择送达时间
				</view>

				<view class="d-flex m-t-20">
					<view class="fz-000000 fz-weight">
						{{ $util.parseTime(timeSel,"{m}-{d}")  }}
					</view>
					<view class="d-flex f-start">
						<text class="btn basecolor m-r-20" @click="selTimeRanges(0)"
							:class="{'active':popupTimeRanges==='上午'}">上午</text>
						<text class="btn basecolor" @click="selTimeRanges(1)"
							:class="{'active':popupTimeRanges==='下午'}">下午</text>
					</view>
				</view>

				<view class="fz-29 basecolor m-t-20">
					说明:上午配送时间为{{ order_gettimesw }},下午配送时间为{{ order_gettimexw }}
				</view>

				<mybtn msg="确认" width="300rpx" @handclick="confirm" height="60rpx" marginTop="30rpx" />
			</view>
		</u-popup>

		<!-- 底部操作菜单 -->
		<view class="page-bottom">
			<view class="p-b-btn">
				<text class="m-r-20 fz-000000 fz-32">合计:</text>
				<text class="fz-FF2525 fz-32">￥{{ hjtotal }}</text>
				<text class="fz-FACE51 fz-24 m-l-10" v-if="discount_price">优惠券减免{{ discount_price }}</text>
			</view>

			<view class="action-btn-group m-r-10" v-if="positionfn(5)">
				<button type="" class="action-btn no-border buy-now-btn" @click="openzf()">代支付</button>
			</view>
			<view class="action-btn-group">

				<button type="" class="action-btn no-border buy-now-btn" @click="buyfn()">立即支付</button>
			</view>
		</view>

		<uni-popup ref="popup" type="center" background-color="#fff" @touchmove.stop>
			<view class="p20 bg-fff radius-20 wh500">
				<view class="d-flex j-center fz-000000 fz-32 m-b-20">
					代支付
				</view>
				<view style="width: 300rpx;" class="border w-100">
					<zxz-uni-data-select @close="closefnzf" :isEnd="zfend" @scdown="scrolltolowerzf"
						@inputChange="inputChangezf" placeholder="选择代支付人员" filterable @change="selectChange"
						v-model="user_id" :localdata="userList" />
				</view>
				<mybtn msg="确认支付" @handclick="confirmzp" marginTop="100rpx" width="300rpx" height="60rpx" />
			</view>
		</uni-popup>

	</view>
</template>
<script>
	// import valiage from "./valiage.js";
	import valiageCheck from "@/pages2/deliveryorder/valiageCheck";
	import dafjs from "./user.js";
	import {
		mapState,
		mapMutations
	} from "vuex";
	import qiaoSelect from "../../uni_modules/qiao-select/components/qiao-select/qiaoSelect.vue";
	export default {
		// mixins:[valiage],  // 第一版
		mixins: [valiageCheck, dafjs], // 第二版
		components: {
			qiaoSelect
		},
		data() {
			return {
				orgArray: [], // 人员列表
				showObj: {},
				valiage_pagesize: 9999,
				checked: false,
				kobj: {}, // 食堂具体地址
				kid: "",
				kname: "",
				kshow: false,
				form: {},
				showsub: false,
				type: "",
				addressData: {},
				index: 0,
				showpicker: false, // 级联显示
				popupTimeRanges: "",
				show: false,
				TimeRanges: "上午",
				time: "",
				tablist: [],
				list: [{
						name: '配送到自提点',
						type: 3,
						// 配送到自提点的验证
						rules: [{
								name: "usernmae",
								rule: ["required"],
								msg: ["请输入姓名"]
							},

							{
								name: "phone",
								rule: ["required"],
								msg: ["请输入联系电话"]
							},
							{
								name: "selfpcikup_id",
								rule: ["required"],
								msg: ["请选择自提点"]
							},
							{
								name: "village_id",
								rule: ["required"],
								msg: ["请选择小区"]
							}
						]
					},
					{
						name: '配送到家',
						type: 2,
						// 配送到家的验证
						rules: []
					},
					{
						name: '堂食',
						type: 1,
						// 堂食的验证
						rules: [{
								name: "usernmae",
								rule: ["required"],
								msg: ["请输入姓名"]
							},
							{
								name: "phone",
								rule: ["required"],
								msg: ["请输入联系电话"]
							},
						]
					}
				],
				curNow: 0,
				src: 'https://cdn.uviewui.com/uview/album/1.jpg',
				shoplist: [],
				villagename: "",
				selfpcikupname: "",
				richttext: "",
				activity_id: "",
				groupon_id: "",
				order_gettimexw: "",
				order_gettimesw: "",
				klist: [], // 食堂列表
				activityProduct_id: "",
				delivery_mprice: 0, // 大于这个值不收配送费
				coupon: {},
				hjtotal: "",
				discount_price: "",
				reduce_break:""

			}
		},
		computed: {
			...mapState(['delivery_price', 'position', 'latlng', 'member', 'isYL']),
			scorefn() {
				if (this.position && this.position.score) {
					return Math.floor((Number(this.position.score) / 50)).toFixed(0);
				}
				return 0;
			},
			timeSel(){
				let date = new Date();
				// date.setFullYear(2024,date.getMonth()-1,30)
				date.setDate(date.getDate() + 1);
				return date;
			},
			// 总金额
			total() {
				let total = this.shoplist.reduce((cur, item) => {
					if (!item.number) {
						item.number = 1
					}
					return (cur + (Number(item.sales_price) * item.number))
				}, 0);
				return total.toFixed(2);
			},
			// 打包费
			dtotal() {
				let total = this.shoplist.reduce((cur, item) => {
					if (!item.number) {
						item.number = 1
					}
					return cur + (Number(item.packing_price) * item.number)
				}, 0);
				return total.toFixed(2);
			},
			isShowYh() {
				return this.shoplist.every(v => v.category_id != '18');
			},
			// hjtotal(){
			// 福豆抵扣金额
			// let score = this.checked && this.scorefn ? this.scorefn : 0;
			// 福豆抵扣金额
			// let coupon = this.coupon && this.coupon.value ? Number(this.coupon.value) : 0;
			// 堂食不收打包费和配送费
			// if(this.curNow==2){
			// 	return (Number(this.total)-score-coupon).toFixed(2);
			// }
			// 配送到自提点不收配送费
			// 	if(this.curNow==0){
			// 		console.log(this.total,this.dtotal,score,"Number(this.total + this.dtotal-score)Number(this.total + this.dtotal-score)");
			// 		return (Number(this.total)+Number(this.dtotal)-score-coupon).toFixed(2);
			// 	}
			// 	let d = Number(this.dtotal)+Number(this.total) > this.delivery_mprice ? 0  : Number(this.delivery_price);
			// 	return (Number(this.dtotal)+Number(this.total)+d-score-coupon).toFixed(2);
			// },
			isDy() {
				return Number(this.dtotal) + Number(this.total) > this.delivery_mprice;
			}
		},
		onUnload() {},
		onLoad(query) {
			// 拼团数据格式不同
			if (query.type == 'groupon') {
				let list = uni.getStorageSync("groupon");
				this.activity_id = query.activity_id; // 活动id
				this.shoplist = [list[0]?.productin];
				this.activityProduct_id = query.activityProduct_id;
				this.groupon_id = query.groupon_id; // 团id
			} else {
				let list = [];
				// 购物车进来的不同
				if (query.iscart) {
					list = uni.getStorageSync("shopcart");
				} else {
					list = uni.getStorageSync("shopnormal");
				}
				this.activity_id = query.activity_id;
				this.shoplist = list;
				// this.showsub = true;
			};
			this.showTs((show) => {
				// 拼团秒杀商品不显示堂食 show后台设置的0不显示堂食 1显示
				let flag = this.shoplist.some(v => v.isAc);
				if (query.type == 'groupon' || query.type == 'seckill' || flag || show === '0') {
					this.list = this.list.filter(v => v.type != 1);
				}
				this.showsub = true;
			});

			// 订单类型|| "seckill";
			this.type = query.type;
			this.getNear();
			this.getDefault();
			this.getrich();
			this.getdetail();
			this.getKitchen();
		},
		onShow() {
			uni.removeStorageSync("order");
			setTimeout(() => {
				this.buyfn('total');
			}, 500);
			this.delsStorage();
			this.getreduce_break()
		},
		methods: {
             ...mapMutations(["SET_POSITION"]),
			delCoupon() {
				this.coupon = {};
				this.buyfn('total');
			},
			seltimefn() {
				let flag = this.shoplist.some(v => v.isAc);
				if (flag) return;
				this.show = true;
				this.popupTimeRanges = this.TimeRanges;
			},
			rconfirm(e) {
				this.kname = e[0].label;
				this.kid = e[0].value;
				let index = this.klist.findIndex(v => v.id == e[0].value);
				if (index > -1 && this.klist[index].address) {
					const {
						latitude,
						longitude,
						address
					} = this.klist[index];
					this.kobj = {
						latitude,
						longitude,
						address
					};
				} else {
					this.kobj = {};
				}
			},
			async showTs(fn) {
				let data = await this.$u.api.attentionOrder({
					key: 'ps_type'
				});
				fn(data);
			},
			async getreduce_break(){
				let data = await this.$u.api.attentionOrder({
					key: 'reduce_break'
				});
				this.reduce_break = (Number(data)*100).toFixed(2)+"%"
				console.log(data,"datadatadatadata");
			},
			async getKitchen() {
				let {
					data
				} = await this.$u.api.getVillageList({
					vtype: 2
				});
				this.klist = data;
			},
			// 获取最近小区自提点
			async getNear() {
				// if(this.latlng?.lat){
				let data = await this.$u.api.getVillage({
					lat: this.latlng?.lat || "", //	float	是	经度
					lng: this.latlng?.lng || "", //float	是	纬度
					type: 1, //	integer	否	类型:1=产品,2=服务
				});
				if (data) {
					// 食堂没有自提点
					if (data.vtype == '2') {
						this.rconfirm([{
							label: data.name,
							value: data.id
						}]);
					} else {
						// 其余两个有自提点
						// this.is_valiage_id = data?.selfpcikup?.id;
						// 自提点的分页回显
						// this.getValiageListOnly(()=>{
						this.form.village_id = data?.id; // 小区id
						this.form.selfpcikup_id = data?.selfpcikup?.id; // 自提点id
						this.valiage_value = `${data?.id}-${data?.selfpcikup?.id}`;
						// this.closefn();
						// });
					};
					// 上单选择配送到家的默认的addressjson
					if (data?.user?.address_id && data?.user?.address_json && typeof data?.user?.address_json == 'string') {
						let obj = JSON.parse(data?.user?.address_json);
						this.form.usernmae = obj.name || "";
						this.form.phone = obj.mobile || "";
					} else {
						this.form.usernmae = data?.user?.usernmae || "";
						this.form.phone = data?.user?.phone || "";
					}
				}
				// }
			},
			async getdetail(type) {
				let flag = this.shoplist.some(v => v.isAc);
				if (flag) {
					this.TimeRanges = "下午";
				}
				let order_gettimesw = await this.$u.api.attentionOrder({
					key: 'order_gettimesw'
				});
				let order_gettimexw = await this.$u.api.attentionOrder({
					key: 'order_gettimexw'
				});
				let delivery_mprice = await this.$u.api.attentionOrder({
					key: 'delivery_mprice'
				});
				if (delivery_mprice) {
					this.delivery_mprice = delivery_mprice;
				}

				this.order_gettimexw = order_gettimexw;
				this.order_gettimesw = order_gettimesw;
			},
			async getrich() {
				let data = await this.$u.api.attentionOrder({
					key: "attention_order"
				});
				this.richttext = data
			},
			async getDefault() {
				let res = await this.$u.api.getDefaultsAddress();
				this.addressData = res;
			},
			delsStorage() {
				uni.removeStorageSync("shoplist");
			},
			// 获取优惠券
			goCoupon() {
				uni.setStorageSync("shoplist", this.shoplist);
				this.$u.route({
					url: "/pages/components/pages/balance/coupon",
					params: {
						type: 'getcoupon',
						status: this.list[this.curNow].type,
						// ids:ids && ids.length ? ids.join(",") : "",
						price: this.hjtotal
					}
				})
			},
			// 自提点
			changeztd(e) {
				this.form.village_id = this.columnList1[e.detail.value[0]].id; // 小区id
				this.villagename = this.columnList1[e.detail.value[0]].name;
				this.form.selfpcikup_id = this.columnList2[e.detail.value[1]].id; // 自提点id
				this.selfpcikupname = this.columnList2[e.detail.value[1]].name; // 自提点id
			},
			// 切换
			bindPickerChange(e) {
				if (e.detail.column == 0) {
					let id = this.columnList1[e.detail.value].id;
					// 切换自提点
					this.getSelfpickupList(id);
				}
			},
			// 确认时间
			confirm() {
				this.TimeRanges = this.popupTimeRanges;
				this.show = false;
			},
			selTimeRanges(t) {
				if (t) {
					return this.popupTimeRanges = "下午";
				}
				return this.popupTimeRanges = "上午";
			},
			// 选择项目
			sectionChange(index) {
				this.curNow = index;
				this.buyfn('istotal');
			},
			filterData(data) {
				let _d = data;
				switch (this.curNow) {
					case 0:
						_d.address_id = "";
						break;
					case 1:
						_d.usernmae = "";
						_d.phone = "";
						_d.selfpcikup_id = "";
						_d.village_id = this.addressData.village_id;
						break;
					case 2:
						_d.address_id = "";
						_d.selfpcikup_id = "";
						_d.village_id = this.kid || "";
					default:
						break;
				};
				let flag = this.shoplist.some(v => v.isAc);
				if (!(this.type == 'groupon' || this.type == 'seckill' || flag)) {
					_d.activity_id = "";
				}
				if (!this.type == 'groupon') {
					_d.activityProduct_id = "";
					_d.groupon_id = "";
				}
				return _d;
			},
			async buyfn(istotal, url) {
			   
				// 活动商品和普通商品循环调两次
				// 普通商品id
				let ids = [];
				let number = [];
				// 秒杀商品id
				let a_ids = [];
				let a_number = [];
				for (let s of this.shoplist) {
					if (!s.isAc) {
						ids.push(s.id);
						number.push(s.number);
					} else {
						this.activity_id = s.activity_id;
						a_ids.push(s.id);
						a_number.push(s.number);
					}
				};	
				let data = {
					subtype: this.list[this.curNow].type, //	是	购买类型:1=自取,2=配送到家,3=配送到自提点
					activity_id: this.activity_id || "", //	integer	是	活动id
					activity_type: this.type || "normal", //	integer	是	seckill=秒杀groupon=拼团normal=正常产品
					score: this.checked ? this.position.score : '', //	integer	是	使用积分
					activityProduct_id: this.activityProduct_id || "", //	integer	是	活动商品ID：创团需必传
					groupon_id: this.groupon_id || "", //	integer	是	团ID
					getdate: this.$util.parseTime(this.timeSel, "{y}-{m}-{d}"), //	integer	是	取餐日期
					isam: this.TimeRanges == '上午' ? 1 : 2, //	integer	是	1=上午2=下午
					selfpcikup_id: this.form?.selfpcikup_id || "", //	integer	是	自提点ID
					village_id: this.form?.village_id || "", //	integer	是	小区ID
					usernmae: this.form?.usernmae || "", //	integer	是	姓名
					phone: this.form?.phone || "", //	integer	是	电话
					type: this.curNow == 0 || this.curNow == 1 ? 2 : 1, //	integer	是	购买类型:1=自取,2=外卖
					address_id: this.addressData?.id || "", //	integer	是	外卖配送地址id
					shop_id: "6", //	integer	是	商店id
					mobile: this.form?.phone || "", //	string	是	联系电话
					gettime: "", //	string	是	取餐时间
					pay_type: "", //	string	是	支付类型
					remark: this.form.remark || "", //	string	是	备注
					product_id: ids, //	array	是	商品id数组
					spec: [], //	array	是	商品规格数组
					number: number, //	array	是	商品数量数组
					coupon_id: this.coupon?.id || "", //	integer	是	优惠券id
					activityProduct_ids: a_ids, //	array	是	秒杀商品id数组
					activityNumbers: a_number, //	array	是	秒杀商品数量数组
					user_id: this.user_id || ""
				};
				// 
				this.shoplist.forEach((item, index) => {
					// 秒杀的不参与规格
					if (item.props_text && !item.isAc) {
						data.spec.push(item.props_text.replace(/,/g, '|'));
					} else if (!item.isAc) {
						data.spec.push('');
					}
				});
				if (istotal) {
					let _p = await this.$u.api.calculation(data);
					if (_p) {
						this.hjtotal = _p.total_price;
					};
					return;
				}
				if (!this.position.mobile) {
					uni.hideLoading();
					this.$util.xhmodal("请完善手机号后重试").then(res => {
						this.$util.navTo("/pages/components/pages/mine/userinfo")
					})
					return
				};


				const callback = () => {
					if (this.curNow == 1 && !this.addressData?.id) {
						return this.$u.toast("请选择地址");
					};
					if (this.curNow == 2 && !this.kid) {
						return this.$u.toast("请选择食堂");
					}
					const _d = this.filterData(data);
					uni.showLoading({
						mask: true
					})
					this.$util.validate(_d, this.list[this.curNow].rules).then(async res => {
						// console.log(_d,"表单提交");
						let _url = url == '123' ? 'daisub' : 'orderSubmit';
						let _p = await this.$u.api[_url](_d);
						// 刷新福豆
						if (this.checked) {
							this.getUserInfo();
						}
						uni.setStorageSync("order", _p);
						this.delCart([...ids, ...a_ids]);
						this.coupon = {};
						if (url == '123') {
							this.$util.success("支付成功");
							setTimeout(() => {
								uni.reLaunch({
									url: "/pages/index/newindex"
								})
							}, 1500);
						} else {
							this.$util.navTo('/pages2/money/pay');
							uni.hideLoading()
						}


					});
				}
				
				// 混合商品需要提示下午配送
				if (ids.length && a_ids.length) {
					uni.hideLoading();
					this.$util.xhmodal("请注意本单为混合商品,仅支持下午配送").then(response => {
						callback();
					});
				} else {
					callback();
				}


				// /api/order/submit	
			},
			async getUserInfo() {
				let data = await this.$u.api.userindex();
				if (data) {
					this.SET_POSITION(data);
				}
			},
			delCart(ids) {
				let cart = uni.getStorageSync('cart') || [];
				// 使用filter方法过滤掉要删除的商品ID  
				let updatedCart = cart.filter(element => !ids.includes(element.id));
				// 将更新后的购物车数组存储回本地存储  
				uni.setStorageSync("cart", updatedCart);
			},
			positionfn(n) {
				if (this.position.rule && this.position.rule.length) {
					return this.position.rule.some(v => v.id == n);
				}
				return false
			}
			// delCart(ids){
			//  let cart = uni.getStorageSync('cart') || [];
			//  for (let j = 0; j < cart.length; j++) {
			//  	let element = cart[j];
			// 	for (let i = 0; i < ids.length; i++) {
			// 		 let item = ids[i];
			// 		 if(item==element.id){
			// 			 cart.splice(j,1);
			// 		 }
			// 	}
			// 	j--;
			//  }
			//  // let ap = cart;
			//  uni.setStorageSync("cart",cart);
			// }
		}
	}
</script>

<style scoped lang="scss">
	.content {
		min-height: 100vh;
		background-color: #FAFAFA;
		padding-bottom: 220rpx;

		.form {
			background: #FFFFFF;
			border-radius: 20rpx 20rpx 10rpx 20rpx;
			padding: 20rpx;
			background-color: #fff;

			.title {
				font-weight: 800;
				font-size: 32rpx;
				color: #000000;
			}
		}
	}

	.active {
		background-color: #FACE51;
		border: 2rpx solid #FACE51 !important;
	}

	.popup {
		width: 600rpx;
		padding-left: 40rpx;
		padding-right: 40rpx;
		border-radius: 20rpx;
	}

	.btn {
		width: 100rpx;
		height: 50rpx;
		border-radius: 20rpx;
		line-height: 50rpx;
		text-align: center;
		color: #000000;
		border: 2rpx solid #979797;

	}

	.dottag {
		width: fit-content;
		padding: 5rpx 20rpx;
		background-color: #FEE8C7;
		color: #FF0000;
		border-radius: 20rpx;
	}

	.form {
		width: 100%;
	}

	.wh500 {
		width: 700rpx;
		height: 400rpx;
	}

	.pstime {
		text-align: center;
		font-weight: 500;
		font-size: 32rpx;
		color: #000000;
		margin-top: 20rpx;
	}

	.kitchen {
		font-weight: 800;
		font-size: 48rpx;
		color: #FB7A35;
		margin-top: 30rpx;
		margin-bottom: 30rpx;
	}

	.message {
		font-weight: 500;
		font-size: 24rpx;
		color: rgba(255, 0, 0, 0.5);
		margin-top: 4rpx;
	}

	/* 底部操作菜单 */
	.page-bottom {
		position: fixed;
		left: 0upx;
		bottom: 0;
		z-index: 98;
		display: flex;
		padding: 0 20rpx;
		padding-top: 14rpx;
		padding-bottom: calc(env(safe-area-inset-bottom) + 30rpx);
		justify-content: space-between;
		align-items: center;
		width: 100%;
		background: #fff;
		/* box-shadow: 0 0 20upx 0 rgba(0, 0, 0, .5); */
		border-radius: 16upx;

		.action-btn-group {
			display: flex;
			width: 240rpx;
			height: 80upx;
			border-radius: 100px;
			overflow: hidden;
			/* box-shadow: 0 20upx 40upx -16upx #fa436a;
			box-shadow: 1px 2px 5px rgba(219, 63, 96, 0.4);
			background: linear-gradient(to right, #ffac30, #fa436a, #F56C6C); */
			margin-left: 20upx;
			position: relative;

			.add-cart-btn {
				background-color: #333333 !important;
				font-weight: 800;
				font-size: 28rpx;
				color: #FFFFFF;
			}

			.buy-now-btn {
				background-color: #FACE51 !important;
				font-weight: 800;
				font-size: 28rpx;
				color: #000000;
			}

			.only {
				width: 360rpx !important;
			}

			.action-btn {
				display: flex;
				align-items: center;
				justify-content: center;
				width: 240upx;
				height: 100%;
				padding: 0;
				border-radius: 0;
				background: transparent;
			}
		}

	}

	.bgareas {
		background-color: #F3F3F3;
		border-radius: 10rpx;
		padding-top: 16rpx;
		padding-left: 28rpx;
	}

	.wh130 {
		border-radius: 20rpx;
		width: 130rpx;
		height: 130rpx;
	}

	.address-section {
		padding: 20rpx 0rpx;
		padding-left: 0rpx;
		background: #fff;
		position: relative;

		.order-content {
			display: flex;
			align-items: center;

			.wh36 {
				width: 36rpx;
				height: 36rpx;
				flex-shrink: 0;
				margin-right: 20rpx;
			}
		}

		.icon-shouhuodizhi {
			flex-shrink: 0;
			display: flex;
			align-items: center;
			justify-content: center;
			width: 90upx;
			color: #888;
			font-size: 44upx;
		}

		.cen {
			display: flex;
			flex-direction: column;
			flex: 1;
			font-weight: 500;
			font-size: 28rpx;
			color: #333333;

		}

		.name {
			font-size: 34upx;
			margin-right: 24upx;
		}

		.address {
			margin-top: 16upx;
			margin-right: 20upx;
			color: $font-color-light;
		}

		.icon-you {
			font-size: 32upx;
			color: $font-color-light;
		}

		.a-bg {
			position: absolute;
			left: 0;
			bottom: 0;
			display: block;
			width: 100%;
			height: 5upx;
		}
	}

	.subsection {
		padding: 32rpx 18rpx;
	}

	.tagStyle {
		width: fit-content;
		height: 40rpx;
		background: #FFE2BE;
		border-radius: 10rpx 10rpx 10rpx 10rpx;
		font-weight: 500;
		font-size: 20rpx;
		color: #FB7A35;
		padding: 8rpx 10rpx;
	}
</style>