
export function getToken(){
	return uni.getStorageSync("app_config_data")?.member?.token || "";
}

export function setToken(Token){
	uni.setStorageSync("Token",Token);
}

export function removeToken(){
	uni.removeStorageSync("Token")
}




