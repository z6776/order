import Vue from 'vue';
import { getToken } from "./getToken.js";
import { baseUrl,cdnimgurl } from "../common/const.js";
import { validate } from "./validate.js";
// 接口域名
// 图片显示
const cdnurl = (url,sub='/newstatic/') => {
	if(!url){
		return;
	}
	if(url.includes("http")){
		return url;
	}
  return cdnimgurl+sub+url
}
// 图片显示
const getImgurl = (url) => {
	if(!url){
		return;
	}
	if(url.includes("http") || url.includes("base64")){
		return url;
	}
	// baseUrl
  return cdnimgurl + url
}

const back=()=>{
	// 避免分享进入的回不到首页
	let pages = getCurrentPages();
	if(pages.length>1){
		return uni.navigateBack();
	}
	uni.switchTab({
		url:"/pages/index/newindex"
	})
	
}

// 图片上传
const upload = (file) => {
	if (!file) {
		return
	}
   console.log(getToken(),"getToken()getToken()");
	return new Promise((reslove, reject) => {
		uni.uploadFile({
			url: baseUrl+'/api/common/upload',
			filePath: file,
			name: 'file',
			header: {
				"token": getToken() || ""
			},
			success: (uploadFileRes) => {
				reslove(JSON.parse(uploadFileRes.data))
			},
			fail(err) {
				reject(err)
			}
		});
	})
}


// 计算导航栏的中心点
function top_Win(){
	let res = uni.getMenuButtonBoundingClientRect();
	return res.top+(res.height/4)-1+"px"; //胶囊上边距离顶部的距离/胶囊高度/4
}

// 日期格式化
function parseTime(time, pattern) {
	if (arguments.length === 0 || !time) {
		return ""
	}
	const format = pattern || '{y}-{m}-{d} {h}:{i}:{s}'
	let date
	if (typeof time === 'object') {
		date = time
	} else {
		if ((typeof time === 'string') && (/^[0-9]+$/.test(time))) {
			time = parseInt(time)
		} else if (typeof time === 'string') {
			time = time.replace(new RegExp(/-/gm), '/').replace('T', ' ').replace(new RegExp(/\.[\d]{3}/gm), '');
		}
		if ((typeof time === 'number') && (time.toString().length === 10)) {
			time = time * 1000
		}

		date = new Date(time)
	}
	const formatObj = {
		y: date.getFullYear(),
		m: date.getMonth() + 1,
		d: date.getDate(),
		h: date.getHours(),
		i: date.getMinutes(),
		s: date.getSeconds(),
		a: date.getDay()
	}
	const time_str = format.replace(/{(y|m|d|h|i|s|a)+}/g, (result, key) => {
		let value = formatObj[key]
		// Note: getDay() returns 0 on Sunday
		if (key === 'a') {
			return ['日', '一', '二', '三', '四', '五', '六'][value]
		}
		if (result.length > 0 && value < 10) {
			value = '0' + value
		}
		return value || 0
	})
	return time_str
}

// 选择地址
function getaddress(){
	// 获取地址
	let _t = this;
	return new Promise((reslove,reject)=>{
		uni.chooseLocation({
			success: function(res) {
				if (res.name) {
					reslove(res);
				} else {
					reject({code:500,msg:"用户未选择地址"})
				}
			}
		});
	})
}

// 图片预览
 function lookimg(img){
	if(img){
		uni.previewImage({
			urls:[getImgurl(img)],
			success(res){
			},
			fail(err){
			}
		})
	}
}

// 存储数据
 function savedata(data){
	if(!data){
		return
	}
	uni.setStorageSync("pageData",data);
}

function getpagedata(){
	let data = JSON.parse(JSON.stringify(uni.getStorageSync("pageData")));
	this.$nextTick(()=>{
		uni.removeStorageSync("pageData")
	});
	return data;
}

// 确认弹窗
function xhmodal(title){
	return new Promise((reslove,reject)=>{
		uni.showModal({
			title,
			success(res){
				if(res.confirm){
					reslove();
				}else{
				}
			}
		})
	})
}

// 提示
function success(tit,back){
	if(back){
		uni.showToast({
			icon:"success",
			title:tit||"提交成功!"
		});
		setTimeout(()=>{
			if(Vue.prototype.$util.prePage().initList){
				Vue.prototype.$util.prePage().initList();
			}
			console.log("back");
			 uni.navigateBack();	
		},1500); 
	}else{
		uni.showToast({
			icon:"success",
			title:tit||"提交成功!"
		});
	}
}

// 数组去重
function uniqueArrayObjectsById(arr) {
    return arr.reduce((acc, current) => {  
	 const isExisting = acc.some(item => item.coach_id === current.coach_id);  
	    if (!isExisting) {  
		   acc.push(current);  
	   }  
	    return acc;  
    }, []);  
}

//  拨打电话
function makePhone(phone) {
    uni.makePhoneCall({
    	phoneNumber:phone
    })
}

//  打开定位
 function openLocation(longitude,latitude,name,address) {
	 if(typeof longitude!='number' || typeof latitude!='number'){
		 longitude = Number(longitude);
		 latitude = Number(latitude);
	 }
   uni.openLocation({
	longitude,
	latitude,
	name,
	address,
	fail(err) {
		console.log(err,"errrerrrr");
	}
   })
}

// 跳转判断是否登录
const navTo = (url, check = true) => {
	if (check && !Vue.prototype.$store.state.member.token) {
		url = '/pages/components/pages/login/newlogin';
	}
	uni.navigateTo({
		url: url
	});
}

// 支付
const xhpay = (data)=>{
	if(!data || Object.keys(data).length==0){
		return 
	}
	return new Promise(async (reslove,reject)=>{
		uni.requestPayment({
			...data,
			package:"prepay_id="+data.prepay_id,
			signType:"MD5",
			nonceStr:data.nonce_str,
			success:(res)=>{
				reslove(res)
			},
			fail:(err)=>{
				reject(err)
			}
		})
	})
	
}

const orderTypefn = (type)=>{
	return type==1 ? "自取" :  type==2 ? "配送到家"  : type==3 ? "配送到自提点" : '';
}

const isam = (type)=>{
	return type==1 ? "上午" :  type==2 ? "下午"  :  '';
}

const approveresult = (type)=>{
	return type==1 ? "审核中" :  type==2 ? "已同意"  : type==3 ? "已拒绝" : '';
}

const hideMiddleFourOfPhoneNumber = (phoneNumber) =>  {
	if(!phoneNumber)return "";
  // 手机号前三位  
  const firstThree = phoneNumber.slice(0, 3);  
  // 手机号后四位  
  const lastFour = phoneNumber.slice(-4);  
  // 生成中间四个星号  
  const middleStars = '****';  
  
  // 拼接结果  
  return `${firstThree}${middleStars}${lastFour}`;  
} 

const makeCopy = (str)=>{
	if(!str){
		return;
	}
	uni.setClipboardData({
	    data: String(str), // 必须字符串
	    success: function () {
			uni.showToast({
				icon:"none",
				title:"已复制到剪切板"
			})
	        console.log('success');
	    }
	});
}

function	lookimgarr(i,images){
				if(imgsfn(images) && imgsfn(images).length){
					let arr = imgsfn(images).map(v=>getImgurl(v)).filter(v=>v!=undefined);
					uni.previewImage({
						urls:arr,
						current:i
					})
				}
			}
		function imgsfn(picimages){
				if(!picimages)return [];
				return picimages.split(",");
			}
			

const toarr = (str)=>{
	if(!str){
		return [];
	}
	return str.split(",");
}

const isNull = (obj,key)=>{
	if(!obj || !Object.keys(obj).length || !obj[key]){
		return ""
	}
	return obj[key];
}

const jsonToarr = (str)=>{
	if(!str || typeof str!='string'){
		return "";
	}
	let obj = JSON.parse(str);
	if(obj.address && obj.door_number){
		return obj.address+"-"+obj.door_number;
	}
	if(obj.address || obj.door_number){
		return obj.address || obj.door_number;
	}
}

const jsontoobj = (str)=>{
	if(!str || typeof str!='string'){
		return {};
	}
	let obj = JSON.parse(str);
	if(obj.name || obj.mobile){
		return obj;
	}	
}

const ylStatus = (status)=>{
	if(!status || typeof status!='string'){
		return "";
	}
	// const STATUS_1 = 1 ;// 未开始
	//   const STATUS_2 = 2 ;// 进行中
	//     const STATUS_3 = 3 ;// 已结束
	//     const STATUS_4 = 4 ;// 已取消
	let arr = [{value:1,label:"未开始"},{value:2,label:"进行中"},{value:3,label:"已结束"},{value:4,label:"已取消"}];
	return arr.find(v=>v.value==status)?.label;
}

const  toJson = (str) => {
				 if(!str || !(typeof str=='string')){
					 return {}
				 }
				 return JSON.parse(str);
			 }
			 
 const objectToQueryString=(obj)=>{
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
			 }
			 
			 
		const isShowcon=(item)=>{
			   if(!item.createtime){
				   return false;
			   };
			 	let canceltime = Vue.prototype.$store.state.canceltime;
			 	let createtime = parseTime(item.createtime,"{y}-{m}-{d} {h}:{i}:{s}") ;
			 	let d = new Date(createtime).getTime();
			 	let end = new Date().getTime() - d;
			 	if((new Date().getTime() - d) > 10*60*1000){
			 		return false;
			 	}
			 	return true;
			 }


module.exports = {
	isShowcon,
	objectToQueryString,
	ylStatus,
	toJson,
	jsontoobj,
	jsonToarr,
	isNull,
	imgsfn,
	lookimgarr,
	toarr,
	approveresult,
	makeCopy,
	isam,
	hideMiddleFourOfPhoneNumber,
	orderTypefn,
	xhpay,
	openLocation,
	makePhone,
	uniqueArrayObjectsById,
	success,
	xhmodal,
	getpagedata,
	savedata,
	lookimg,
	getaddress,
	parseTime,
	top_Win,
	upload,
	getImgurl,
	cdnurl,
	navTo,
	back,
	validate
}














