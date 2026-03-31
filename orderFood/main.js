import Vue from 'vue';
import App from './App';
import util from './common/util';
import store from './store';
import uView from "uview-ui";
import apiurl from "./utils/apiurl";
import mixins from "@/utils/hideNavbar.js";
Vue.config.productionTip = false;
App.mpType = 'app';
import cbtn from "@/components/cbtn";
import comlr from "@/components/comlr";
import navbar from "@/components/navbar";
import xhUpload from "@/components/xh-upload";
import mybtn from "@/components/mybtn";
import listCell from "@/components/list-cell/list-cell";
import phonecom from "@/components/pxf";
 Vue.component('cbtn',cbtn);
 Vue.component('comlr',comlr);  
 Vue.component('navbar',navbar);  
 Vue.component('xhUpload',xhUpload);  
 Vue.component('listCell',listCell);  
 Vue.component('mybtn',mybtn);
  Vue.component('phonecom',phonecom);
Vue.prototype.$store = store;
Vue.prototype.$util = {...util,...apiurl};

Vue.mixin(mixins);
const app = new Vue({
	store,
    ...App
});
Vue.use(uView);

// http拦截器，将此部分放在new Vue()和app.$mount()之间，才能App.vue中正常使用
import httpInterceptor from '@/common/http.interceptor.js'
Vue.use(httpInterceptor, app)

// http接口API集中管理引入部分
import httpApi from '@/common/http.api.js';
Vue.use(httpApi, app);
// Vue.use(newApi, app);

app.$mount();



