export default{
	data(){
		return{
			bgColorOpa:{
				background: 'transparent'
			},
			_my_address:"武汉",
		}
	},
	filters: {
		filterdetail(html) {
			if(!html) return
			//控制小程序中图片大小
			let newContent = html.replace(/<img[^>]*>/gi, function(match, capture) {
				match = match.replace(/style="[^"]+"/gi, '').replace(/style='[^']+'/gi, '');
				match = match.replace(/width="[^"]+"/gi, '').replace(/width='[^']+'/gi, '');
				match = match.replace(/height="[^"]+"/gi, '').replace(/height='[^']+'/gi, '');
				return match;
			});
			newContent = newContent.replace(/style="[^"]+"/gi, function(match, capture) {
				match = match.replace(/width:[^;]+;/gi, 'max-width:100%;').replace(/width:[^;]+;/gi, 'max-width:100%;');
				return match;
			});
			newContent = newContent.replace(/<br[^>]*\/>/gi, '');
			newContent = newContent.replace(/\<img/gi, '<img style="max-width:100%;height:auto;display:inline-block;margin:10rpx auto;"');
			return newContent;
		}
	},
	onLoad(){
		uni.showShareMenu({
		  withShareTicket: true,
		  menus: ['shareAppMessage', 'shareTimeline']
		});
	},
	onShow(){
		const address =  uni.getStorageSync("_my_address");
		if(address){
			this._my_address = address;
		}
	},
	onPageScroll(e){
		if(e.scrollTop>30){
			this.bgColorOpa = {
				background: '#F7BF35'
			}
		}else{
			this.bgColorOpa = {
				background: 'transparent'
			}
		}
	},
	methods:{
		// 去选择地址
		_go_address_fn(){
			uni.navigateTo({
				url: '/pages5/address/index'
			});
		},
	}
	}
