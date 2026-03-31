<template>
	<view class="upload" :style="{marginLeft}">
		<u-upload
		:file-list="imglistshow"
		 :uploadText="uploadText"
		 @on-success="afterRead" 
		 @on-remove="deletePic"
		 ref="uUpload"
		 :action="action"
		 :show-tips="false"
		 :custom-btn="customBtn"
		 :show-progress="false"
		 :max-count="maxCount"
		 :deletable="deletable"
		 >
		 </u-upload>
	</view>
</template>

<script>
	import {baseUrl} from "@/common/const.js"
	export default {
		props:{
			imglistshow:{
				type:Array,
				default:[]
			},
			customBtn:{
				type:Boolean,
				default:false
			},
			disabled:{
				type:Boolean,
				default:false
			},
			deletable:{
				type:Boolean,
				default:true
			},
			imgEdit:{
				type:String,
				default:""
			},
			marginLeft:{
				type:String,
				default:"0px"
			},
			width:{
				type:[Number,String],
				default:80
			},
			height:{
				type:[Number,String],
				default:80
			},
			uploadText:{
				type:String,
				default:null
			},
			maxCount:{
				type:Number,
				default:6
			},
			maxLength:{
				type:Number,
				default:9
			}
		},
	
		watch:{
			imglistshow:{
				handler(val){
					if(val){
						this.fileList1 = val;
						this.joinimg(val);
					}
				},
				deep:true
			}
		},
		data(){
            return{
				action:BaseUrl+"/api/common/upload",
                fileList1:[]
            }
        },
        methods:{
            // 删除图片
            deletePic(e,lists) {
            	this.fileList1.splice(e.index,1);
				this.joinimg(this.fileList1);
				this.$forceUpdate();
				console.log(e,this.fileList1,"删除删除");
				// this.$emit("delete",this.fileList1);
            },
            // 读取后的处理函数
             async afterRead(e) {
				 console.log(e,"我的上传")
            	if(e.code && e.code==1){
            		try{
            			uni.showLoading({
            				title:"上传中,请稍等",
            				mask:true
            			});
            			
						 this.fileList1.push({
							url: e.data.fullurl,
							durl: e.data.url
						 });	 
            			
						if(this.fileList1.length>6){
							this.fileList1 = this.fileList1.slice(0,6);
							this.$api.msg("最多上6张图片");
						}
						this.joinimg(this.fileList1);
            			setTimeout(()=>{
            				uni.hideLoading();
            			},1000)
            		}catch(e){
            			this.$api.msg("上传失败，请重新上传");
            			uni.hideLoading();
            		}
            	}else if(e && e.file && e.file.url){
					 // let res = await this.$upload(e.file.url);
					 // this.fileList1.push({
					 // 	url: res.data.fullurl,
					 // 	durl: res.data.url
					 // });
					 // this.joinimg(this.fileList1);
					 // this.$emit("comfirm",this.fileList1);
				}
            },
			// 传给后端的图片
			joinimg(imglist){
				if(!imglist || !Array.isArray(imglist) || !(imglist.length>0)){
					this.$emit("getimg","")
				}else{
					let arr = [];
					for (var i = 0; i < imglist.length; i++) {
						  let item = imglist[i];
						  arr.push(item.durl)
					};
					if(arr && arr.length>0){
						this.$emit("getimg",arr.join(","))
					}
					
				}
			}
        }
	}
</script>

<style scoped lang="scss">
.upload{
	margin-left: 36rpx;
}
</style>