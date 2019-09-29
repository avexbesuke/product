import Vue from 'vue'
import Vuex from 'vuex'
import { UPDATE_CURRENT,} from './mutation-types'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    books:[],
    current: null, 
    bids: null, 
  },
  getters:{ 
    current(state){ 
      return state.current
    },
  },
  mutations:{
    [UPDATE_CURRENT](state, payload){ 
      state.current = payload
    },
  },
  actions:{ 
    [UPDATE_CURRENT]({ commit }, payload){
      commit(UPDATE_CURRENT,payload)
    },
  },
})