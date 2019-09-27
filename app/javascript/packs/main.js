import Vue from 'vue/dist/vue.esm.js'
import Vuex from 'vuex'
import Router from './router/router'
import store from './store.js'
import './plugins/element.js'

import BookInfo from './components/book/BookInfo.vue'
import BookForm from './components/book/BookForm.vue'
import BookSearch from './components/book/BookSearch.vue'

import { library } from '@fortawesome/fontawesome-svg-core'
import { faBook } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
library.add(faBook)

Vue.component('font-awesome-icon', FontAwesomeIcon)
Vue.use(Vuex)

// 本番環境では消すのだっけ↓
Vue.config.productionTip = false
Vue.prototype.$http = (url,opts) => fetch(url,opts)

new Vue({
  el: '#app',
  router: Router,
  store: store,
  components:{
    BookInfo,
    BookForm,
    BookSearch
  },
})