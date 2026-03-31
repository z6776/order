// 自提点列表混入
export default {
	data() {
		return {
			valiage_pagesize:10,
			pagevaliage:1,
			valiage_range: [],
			valiage_value: "",
			valiage_name_key:"",
			is_valiage_end:false,
			is_valiage_id:""
		}
	},
	mounted() {
		let pages = getCurrentPages();
		// 获取当前页面的路由
		let currentPageRoute = pages[pages.length - 1].route;
		// 确认订单页面需要回显自提点 自行处理初始化逻辑
		// if(currentPageRoute!='pages2/orderconfirm/index'){
			this.getValiageListOnly();
		// }
	},
	methods: {
		// 删除显示全部
		closefn(){
			console.log("关闭");
			 this.inputChange("");
		},
		// 
		scrolltolower(e){
			console.log(e,"123123");
			if(!this.is_valiage_end){
				this.pagevaliage++;
				this.getValiageListOnly();
			}
		},
		// 输入
		inputChange(e){
			this.pagevaliage = 1;
			this.valiage_name_key = e;
			this.is_valiage_end = false;
			this.is_valiage_id = "";
			this.valiage_range = [];
			this.getValiageListOnly();
		},
		// 获取小区列表
		async getValiageListOnly(fn){
			// 
			let {data} = await this.$u.api.getVillageSe({
				pagesize:this.valiage_pagesize,
				page:this.pagevaliage,
				name:this.valiage_name_key || ""
			});
			let arr = [];
			// 第二版改动
			for (let i = 0; i < data.length; i++) {	
				let item = data[i];
				// if(item.selfpickups && Array.isArray(item.selfpickups) && item.selfpickups.length){
				// for (let j = 0; j < item.selfpickups.length; j++) {
				// 		let n = item.selfpickups[j];
						arr.push({
							value: `${item.village_id}-${item?.id}`,
							village_id: item.village_id,
							selfpcikup_id: item.id,
							text: `${item?.village?.name}-${item.name}`
						});
				    // }
			   }
			// };
			this.valiage_range = [...this.valiage_range,...arr];
			if(!data || data.length < 10){
				this.is_valiage_end = true;
			};
		},
		// 切换地点
		valiageCheckfn(e) {
			if(e){
				this.form.village_id = e.village_id; // 小区id
				this.form.selfpcikup_id = e.selfpcikup_id; // 自提点id
			}else{
				console.log(this.valiage_value,"清空");
				this.form.village_id = ""; // 小区id
				this.form.selfpcikup_id = ""; // 自提点id
			}
		}
	}
}