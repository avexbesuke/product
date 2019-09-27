<template>
  <div id="search">
    <el-form :inline="true">
      <el-form-item>
        <el-input type="text" size="large" v-model="keyword" placeholder="好きな本を探す"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" size="large" @click='onclick'>検索</el-button>
      </el-form-item>
    </el-form>
    <hr class="book-hr"/>
    <div class="book-container">
      <div class="book-content" v-for="(book,i) of books">
        <BookInfo :bids="bids" :read_bids="read_bids" :linkble="true" :book="book" :index="i + 1" :key="book.isbn">
        </BookInfo>
      </div>
    </div>
  </div>
</template>

<script>
  import BookInfo from './BookInfo.vue'
  import store from './../../store.js'
  import { mapActions } from 'vuex'
  import { throttle, debounce } from 'lodash';
  import { UPDATE_CURRENT,UPDATE_BID } from './../../mutation-types'
  import axios from 'axios';
  export default {
    name: 'book-search',
    store: store,
    components: {
      BookInfo
    },
    data(){
      return {
        keyword: '', 
        books: [], 
        bids:  [],
        read_bids: []
      }
    },
    created: function(){
      this.bids = new Array()
      axios.get('/api/emotions').then((response) => {
        for(let bid in response.data.books){
          this.bids.push(response.data.books[bid])
        }
      })
      this.read_bids = new Array()
      axios.get('/api/reads').then((response) => {
        for(let bid in response.data.reads){
          this.read_bids.push(response.data.reads[bid])
        }
      })
      console.log(this.read_bids)
      this.delayFunc = _.debounce(this.onclick,200);
    },
    watch:{
      keyword: function(newValue,oldValue){
        if (this.keyword != ''){
          this.delayFunc();
        }
      }
    },
    methods: {
      ...mapActions([UPDATE_BID]),
      onclick: function(){ 
        this.$http('https://www.googleapis.com/books/v1/volumes?q='
        + this.keyword)
        .then((response) => {      //帰ってきたデータ(response)をjsonで取得
          return response.json()
        })
        .then((data) => { //json文字列の内容をbooks配列に格納
          this.books = []
          for (let book of data.items){
            let bid     = book.id
            let authors = book.volumeInfo.authors
            let img     = book.volumeInfo.imageLinks
            this.books.push({
              title: book.volumeInfo.title,
              description: book.volumeInfo.description,
              author: authors ? authors.join(',') : '',
              image: img ? img.thumbnail : '',
              bid: bid,
            })
          }
        })
      },
    }
  }
</script>

<style>
/* .el-form{
  height: 40px;
}

.book-hr{
  margin: 5px 0 0 0;
}

.book-container{
  display: flex;
  flex-wrap: wrap;
  flex-direction: row;
  position: relative;
  margin: 0 0 0 30px;
}
.book-content{
  width: 250px;
  height: 300px;
  min-width: 250px;
  min-height: 300px;
  text-align: center;
  margin: 10px;
} */
</style>