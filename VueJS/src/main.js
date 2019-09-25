import Vue from 'vue'
import App from './App.vue'

import BootstrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
Vue.use(BootstrapVue)

Vue.config.productionTip = false
Vue.config.productionTip = false

import Raphael from 'raphael/raphael'
global.Raphael = Raphael

import VueGoodTablePlugin from 'vue-good-table';
// import the styles
import 'vue-good-table/dist/vue-good-table.css'

Vue.use(VueGoodTablePlugin);

Vue.use(VueRouter)

//import axios from 'axios'
import VueRouter from 'vue-router'
import User from "./components/User";
import ChartManager from "./components/ChartManager";
import Listing from "./components/Listing";

//Vue.use(axios)

const routes = [
    { path: '/stats', component: ChartManager },
    { path: '/user', component: User },
    { path: '/listing', component: Listing },
]
const router = new VueRouter({
    routes // short for `routes: routes`
})

new Vue({
    render: h => h(App),
    router
}).$mount('#app')
