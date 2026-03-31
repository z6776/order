
// 获取小区列表
export default{
	// /api/village/getVillageList
	data(){
		return{
			form:{},// 表单
			rangevalue:[0,0],
			columnList1:[],
			columnList2:[],
			valiagelist:[]
		}
	},
	mounted(){
		this.getVillageList();
	},
	methods:{
		// 获取小区列表
		async getVillageList(){
			const {data} = await this.$u.api.getVillageList();
			this.columnList1 = data;
			this.getSelfpickupList(data[0].id);
		},
		// 获取自提点列表
		async getSelfpickupList(id){
			// uni.showLoading({
				
			// });
			const data = await this.$u.api.getSelfpickupList({
				village_id:id
			});
			this.columnList2 = data;
			// 小区，自提点
			this.valiagelist = [[...this.columnList1],[...data]];
			// uni.hideLoading();
		}
		
		
	}
}