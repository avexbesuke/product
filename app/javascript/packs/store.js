import Vue from 'vue'
import Vuex from 'vuex'
import { UPDATE_CURRENT,} from './mutation-types'

Vue.use(Vuex)

export default new Vuex.Store({
  strict: true, //厳密性 本番環境では、消しておく
  state: {
    books:[], //レビューと書籍の情報を格納する
    current: null, //なにに使うか今の所、不明
    bids: null, //本のid入れておく
  },
  getters:{ //ステートの内容を加工・取得
    current(state){ //現在編集中の書籍
      return state.current
    },
  },
  mutations:{
    [UPDATE_CURRENT](state, payload){ //編集中の書籍(current)を更新
      state.current = payload
    },
  },
  actions:{ //ミューテーションに対応する同名のアクションたち
    [UPDATE_CURRENT]({ commit }, payload){
      commit(UPDATE_CURRENT,payload)
    },
  },
})