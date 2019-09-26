<template>
  <div id="search">
    <el-form :inline="true">
      <el-form-item>
        <el-input type="text" size="large" v-model="keyword"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" size="large" @click='onclick'>検索</el-button>
      </el-form-item>
    </el-form>
    <hr />
    <div class="a">
      <div class="b" v-for="(book,i) of books">
        <font-awesome-icon icon="book" :id="book.bid" class="read-btn" @click="readclick"/>
        <BookInfo :bids="bids" :linkble="true" :book="book" :index="i + 1" :key="book.isbn">
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
        keyword: '', //検索キーワード
        books: [], //検索結果配列
        bids:  []
      }
    },
    created: function(){
      this.bids = new Array()
      axios.get('/api/books').then((response) => {
        for(let bid in response.data.books){
          this.bids.push(response.data.books[bid])
        }
      })
    },
    methods: {
      ...mapActions([UPDATE_BID]),
      onclick: function(){ //検索ボタンを押すと書籍検索
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
              image: img ? img.smallThumbnail : '',
              bid: bid,
            })
          }
        })
      },
      readclick(){
        console.log('押した')
        axios.post('/api/reads', {}).then((response) => {
          //通信後の処理
          }, (error) => {
            aleart("error");
        }); 
      }
    }
  }
</script>

<style>
.a{
  display: flex;
}
</style>