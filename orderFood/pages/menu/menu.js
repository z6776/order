
import MescrollMixin from "@/utils/mescroll.js";
export default{
	 mixins:[MescrollMixin],
	data(){
		return{
			typelist:[],
			products:[]
		}
	},
	onLoad(){
		console.log("onloadonloadonloadonload");
		this.getCaryList();
	},
	methods:{
		mescrollInit(mescroll) {
			this.mescroll = mescroll;
			this.mescroll.optUp.toTop.bottom = 240;
			this.mescroll.optUp.empty.zIndex = 9999;
			this.mescroll.optUp.auto = false;
			this.mescroll.optDown.auto = false;
			
			console.log(this.mescroll,"this.mescrollthis.mescroll")
		},
		// 初始化列表
		initList(){
			 this.products = [];
			 this.mescroll.resetUpScroll();
		},
		// 搜索列表
		searchtit(e){
			this.keyword = e;
			this.initList();
		},
		// 获取类型列表
		async getCaryList(){
		    const typelist = await this.$u.api.getProductType();
			this.typelist = typelist;
			let id = typelist[0]?.id;
			this.currentCateId = typelist[0]?.id;
		    this.initList();
		},
		async upCallback(page){
			
			let {data} = await this.$u.api.getProductList({
				category_id:this.currentCateId || "",
				page:page.num,
				pagesize:page.size,
				title:this.keyword
			});
			console.log(data,"datatata");
			if(page.num==1){
				this.products = [];
			}
			this.products =  [...this.products,...data];
			this.mescroll.endSuccess(data.length, page.size == data.length);
		 }
	}
}