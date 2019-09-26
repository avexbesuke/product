<template>
  <div>
    <div class="image"><img :class="{ linkable }" :src="book.image" /></div>
      <div class="details">
        <ul>
          <li :class="{ linkable }" >タイトル:{{book.title}} </li>
          <li>作者{{book.author}}</li>
        </ul>
    </div>
    <div v-if="this.bids != null">
      <div v-if="this.bids.indexOf(book.bid)">
        <input type="button" @click="onclick" value="マイベスト"/>
      </div>
      <div v-else>マイベスト！</div>
      </div>
    </div>
</template>

<script>
import { mapActions } from 'vuex'
import { UPDATE_CURRENT } from './../../mutation-types'

import store from './../../store.js'

import axios from 'axios';

export default {
  name: 'book-info',
  store: store,
  props: {
    index: { type: Number },
    linkable: { type: Boolean, default: true },
    book: { type: Object },
    bids: { type: Array },
  },
  methods: {
    ...mapActions([UPDATE_CURRENT]),
    onclick() {
      this[UPDATE_CURRENT](this.book) 
      this.$router.push('/form').catch(err => {})
    },
  }
}
</script>

<style scoped>
.image {
  float:left;
}

.image img {
  height: 180px;
}

.details {
  float: left;
}

.details li {
  list-style-type: none;
  text-align: left;
}

.clearfix {
  width: 100%;
  margin-bottom: 10px;
}

.clearfix:after {
  content: "";
  display: block;
  clear: both;
}
</style>
