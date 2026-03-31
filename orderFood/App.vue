<script>
	/**
	 * vuex管理登陆状态，具体可以参考官方登陆模板示例
	 */
	import {
		mapMutations,
	} from 'vuex';
	export default {
		globalData:{
			x:0,
			y:0,  
			is375:true,
			isIphoneX:false
		},
		methods: {
			...mapMutations(['SET_MEMBER', 'SET_OPENID','SET_MEMBERCOPY']),
			// 当前时间大于昨天的最晚下单点清空购物车
			async getDefault(){
				let end = uni.getStorageSync("timeend") || "";
				if(new Date() > new Date(end) || !end){
					uni.setStorageSync("cart",[]);
				}
				// 设置今天的最晚时间
				let data = await this.$u.api.attentionOrder({
					key:"order_endtime"
				});
				let h = data.split(":");
				let d = new Date();
				d.setHours(h[0],h[1],0);
				uni.setStorageSync("timeend",this.$util.parseTime(d,"{y}-{m}-{d} {h}:{i}:{s}"));
			},
			checkIsIPhoneX(){
			   wx.getSystemInfo({
			     success: (res) => {
					 // 计算首页悬浮按钮的偏移量
					 let x2 = parseInt(res.windowWidth) - 50;
					 let y2 = parseInt(res.windowHeight);
						 this.globalData.y = parseInt(y2 * 0.82);
						 this.globalData.x = parseInt(x2);
					 // 
					  if(res.windowWidth>375){
						  this.globalData.is375 = false;
						  console.log(this.is375,"this.is375this.is375this.is375");
					  }else{
						  this.globalData.is375 = true;
					  }
			       //根据安全高度判断,判断设备是否为刘海屏 有刘海的背景图文字会相对偏下
			       if (res.statusBarHeight > 20) {
			         this.globalData.isIphoneX = true
			       } else {
			         this.globalData.isIphoneX = false
			       }
			     }
			   })
			 },
			// #ifdef H5
			// 检查登录状态
			async checkLogin() {
				let result = await this.$u.api.userStatus();
				if (!result) {
					// 若没有登录则清空个人信息
					this.SET_MEMBER({});
				}
			},
			// #endif
			// #ifdef MP-WEIXIN
			async wechatMiniLogin() {
				let [error, loginRes] = await uni.login({
					provider: 'weixin'
				});
				// 0f3E9LFa1tthsL0OqfGa1wCBcG0E9LF6
				if (loginRes.hasOwnProperty('code')) {
					let data = await this.$u.api.userAuthSession({
						code: loginRes.code
					});
					if (data) {
						this.SET_OPENID(data.openid)
						if (data.hasOwnProperty('userInfo') && data.userInfo.token && data.userInfo.token != '') {
							this.SET_MEMBERCOPY(data.userInfo);
						}
					}
				} else {
					//this.$u.toast('登录失败');
				}
			}
			// #endif
		},
		onLaunch: function() {
			console.log('App Launch');
			// 获取最新版本
			const updateManager = uni.getUpdateManager();
			// 判断是否有新版本
			updateManager.onCheckForUpdate(function(res) {
			  if (res.hasUpdate) {
			    console.log('有新版本可以更新')
			  } else {
			    console.log('当前已是最新版本')
			  }
			})
			// 监听更新包下载完成事件
			updateManager.onUpdateReady(function(){
			  uni.showModal({
			    title: '更新提示',
			    content: '新版本已经准备好，是否重启应用？',
			    showCancel: false,
			    success: function(res) {
			      if (res.confirm) {
			        // 调用 applyUpdate 强制小程序重启并使用新版本
			        updateManager.applyUpdate()
			      }
			    }
			  })
			})
			// 监听更新包下载失败事件
			updateManager.onUpdateFailed(function() {
			  uni.showModal({
			    title: '更新提示',
			    content: '新版本下载失败！',
			    showCancel: false
			  })
			})
			this.checkIsIPhoneX();
		},
		onShow: function(){
			console.log('App Show');
			this.getDefault();
			// #ifdef MP-WEIXIN
			this.wechatMiniLogin();
			// #endif
			// 检查用户登录情况
			// #ifdef H5
			this.checkLogin();
			// #endif
			
		},
		onHide: function() {
			console.log('App Hide');
		}
	};
</script>

<style lang="scss">
	@import "uview-ui/index.scss";
	@import "utils/font.css";
	@import "utils/mp.css";
	@import "utils/global.css";
	@import "utils/wh.css";
	//@import "~@/node_modules/uview-ui/index.scss";
	/*每个页面公共css */
	@import '~@/static/style/app.scss';
	
	view,
	scroll-view,
	swiper,
	swiper-item,
	cover-view,
	cover-image,
	icon,
	text,
	rich-text,
	progress,
	button,
	checkbox,
	form,
	input,
	label,
	radio,
	slider,
	switch,
	textarea,
	navigator,
	audio,
	camera,
	image,
	video {
		box-sizing: border-box;
		background-repeat: no-repeat;
	}
	
	textarea{
		width: 100%;
		border-radius: 20rpx;
		background: #eeeeee;
		padding: 10rpx 20rpx;
	}
	
	image{
	  opacity: 1;
	  animation-name: fade;	
	  animation-duration: .3s;/* 淡入时间 */
	  animation-timing-function: linear;
	  animation-direction: alternate;
	}
	
	@keyframes fade{
		from{ opacity: 0.9 }
		to{ opacity: 1 }
	}

	
	/* 骨架屏替代方案 */
	.Skeleton {
		background: #f3f3f3;
		padding: 20upx 0;
		border-radius: 8upx;
	}
	
	/* 图片载入替代方案 */
	.image-wrapper {
		font-size: 0;
		background: #f3f3f3;
		border-radius: 4px;
	
		image {
			width: 100%;
			height: 100%;
			transition: .6s;
			opacity: 0;
	
			&.loaded {
				opacity: 1;
			}
		}
	}
	
	.clamp {
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
		display: block;
	}
	
	.common-hover {
		background: #f5f5f5;
	}
	
	/*边框*/
	.b-b:after,
	.b-t:after {
		position: absolute;
		z-index: 3;
		left: 0;
		right: 0;
		height: 0;
		content: '';
		transform: scaleY(.5);
		/* border-bottom: 1px solid $border-color-base; */
	}
	
	.b-b:after {
		bottom: 0;
	}
	
	.b-t:after {
		top: 0;
	}
	
	/* button样式改写 */
	uni-button,
	button {
		height: 80upx;
		line-height: 80upx;
		font-weight: normal;
		&::after{
			border: none !important;
		}
		&.no-border:before,
		&.no-border:after {
			border: none !important;
		}
	}
	
	uni-button[type=default],
	button[type=default] {
	}
	
	
	
	
	/* input 样式 */
	.input-placeholder {
		color: #999999;
	}
	
	.placeholder {
		color: #999999;
	}
	

</style>
