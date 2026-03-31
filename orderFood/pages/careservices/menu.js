
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
			let typelist = await this.$u.api.getYanglaoType({
				status:""
			});
			this.typelist = typelist;
			let id = typelist[0]?.id;
			this.currentCateId = typelist[0]?.id;
		    this.initList();
		},
		async upCallback(page){
			let {data} = await this.$u.api.getYanglaoList({
				name:this.keyword || "",//	string	否	养老服务标题
				category_id:this.currentCateId,//	integer	否	分类ID
				sort:"",//	string	否	排序字段
				order:"",//	string	否	排序规则
				page:page.num,
				pagesize:page.size
			});
			if(page.num==1){
				this.products = [];
			}
			this.products =  [...this.products,...data];
			this.mescroll.endSuccess(data.length, page.size == data.length);
		 }
	}
}