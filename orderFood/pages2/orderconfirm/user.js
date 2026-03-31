export default{
	data(){
		return{
			nambo:"",
			user_id:"",
			userList:[],
			pagezf:1,
			zfend:false,
			changeKeyword:""
		}
	},
	onLoad(){
		this.dzbuyfn();
		this.getUserInfo();
	},
	methods:{
		async getUserInfo() {
				let data = await this.$u.api.userindex();
				if (data) {
					this.SET_POSITION(data);
				}
		},
		closefnzf(){
			 this.inputChangezf("");
		},
		inputChangezf(e){
			this.changeKeyword = e;
			this.$u.debounce(this.changeKey,500);
		},
		changeKey(){
			this.pagezf = 1;
			this.nambo = this.changeKeyword;
			this.zfend = false;
			this.user_id = "";
			this.userList = [];
			this.dzbuyfn();
		},
		/*选择人员*/
		selectChange(e){
			if(!e.value){
				return this,$u.toast("不存在此用户");
			}
			this.user_id = e.value;
			
		},
		scrolltolowerzf(e){
			if(this.zfend){
			  return 
			}
			this.pagezf++;
			this.dzbuyfn();
						 console.log("触底触底");
		},
		confirmzp(){
			 if(!this.user_id){
				 return this.$u.toast("请选择用户");
			 }
			 this.buyfn("","123");
		},
		openzf(){
			this.pagezf = 1;
			this.$refs.popup.open();
		},
		// 代支付
		async dzbuyfn(){
			
			 let arr = [];
			 let res = await this.$u.api.userList({
				 nambo:this.nambo || "",//	string	否	名称or电话
				 pagesize:10,//	integer	否	大小
				 page:this.pagezf,//	integer	否	第几页
			 });
			 if(res && res.length){
				 for (let i = 0; i < res.length; i++) {
				 	let item = res[i];
					arr.push({
						value: `${item.id}`,
						text: `${item.username}`
					});
				 }
				 this.userList = [...this.userList,...arr];
		         if(arr.length < 10){
					 this.zfend = true;
				 }
			 }else{
				 // return this.$u.toast("暂无人员")
			 }
		}
	}
}