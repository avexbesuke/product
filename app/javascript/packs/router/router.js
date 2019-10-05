import Vue from 'vue/dist/vue.esm.js'
import Router from 'vue-router'
import BookForm from '../components/book/BookForm.vue'
import BookSearch from '../components/book/BookSearch.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes:[
    {path: '/', name: 'search', component: BookSearch},
    {path: '/maps', name: 'search', component: BookSearch},
    {path: '/pages/*', name: 'search', component: BookSearch},
    {path: '/emotions', name: 'search', component: BookSearch},
    {path: '/reads', name: 'search', component: BookSearch},
    {path: '/books/*', name: 'search', component: BookSearch},
    {path: '/users/*', name: 'search', component: BookSearch},
    {path: '/form', name: 'form', component: BookForm},
    // {path: '*', redirect: '/'}
  ],
})