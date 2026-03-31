export default {
	data(){
		return{
			ylcaryId:"",// 养老的类型id
			pagexf:1,// 幸福食堂的分页
			ylcategory:[],// 养老服务的分类
			yllist:[],  // 养老服务的列表
			pageyl:1,// 养老服务的分页
			isxfend:false, // 幸福食堂的结束分页
			isylend:false, // 养老服务的结束分页
		}
	},
	onLoad(){
		this.getcarygory();
	},
	methods:{
		// 切换养老服务类型
		changeYltype(e){
			this.ylcaryId = e;
			this.inityl();
		},
		// 初始化
		inityl(){
			this.pageyl = 1;
			this.yllist = [];
			this.getyllist();
		},
		// 服务列表
		async getyllist(){
			let {data} = await this.$u.api.getYanglaoList({
				name:"",//	string	否	养老服务标题
				category_id:this.ylcaryId,//	integer	否	分类ID
				sort:"",//	string	否	排序字段
				order:"",//	string	否	排序规则
				pagesize:10,//	integer	否	大小
				page:this.pageyl //	integer	否	第几页
			});
		    this.yllist = [...this.yllist,...data];
			if(data.length < 10){
				// 没有更多了
				this.isylend = true;
			}
		},
		// 服务分类列表
		async getcarygory(){
			let data = await this.$u.api.getYanglaoType({
				status:""
			});
		    this.ylcategory = data;
		},
		// 下单的分页
		scrolltolower(e){
			if(this.isxfend)return;
			this.pagexf++;
			this.getProduct();
		}
	}
}