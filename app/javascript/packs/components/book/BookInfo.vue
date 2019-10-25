<template>
  <div class="menu">
    <div class="image-field">
      <font-awesome-icon v-if="this.read_bids.indexOf(book.bid) >= 0" icon="book" :id="book.bid" class="read-btn" @click="readclick" :class="{readed: isActive}"/>
      <font-awesome-icon v-else icon="book" :id="book.bid" class="read-btn" @click="readclick" :class="{readed: isActive==false}"/>
      <img v-if="book.image.length != 0" :src="book.image" class="info-image"/>
      <img v-else src="../../assets/noimage.png" class="info-image"/>
    </div>
    <p class="book-title">{{book.title}}</p>
    <p v-if="book.author.length != 0" class="book-author">{{book.author}}</p>
    <p v-else class="author">作者情報なし</p>
      <input v-if="this.bids.indexOf(book.bid) == -1" class="best-btn" type="button" @click="onclick" value="マイベストにする！"/>
      <p v-else class="bested-btn">マイベスト！</p>
  </div>
</template>

<script>
import { mapActions } from 'vuex'
import { UPDATE_CURRENT } from './../../mutation-types'
import axios from 'axios';

export default {
  name: 'book-info',
  data: function(){
    return {
      isActive: true,
    }
  },
  props: {
    index: { type: Number },
    book: { type: Object },
    bids: { type: Array },
    read_bids: { type: Array },
  },
  methods: {
    ...mapActions([UPDATE_CURRENT]),
    onclick() {
      this[UPDATE_CURRENT](this.book) 
      this.$router.push('/form').catch(err => {})
    },
    readclick(){
      this[UPDATE_CURRENT](this.book) 
      axios.post('/api/reads', {books: { title: this.book.title, image_url: this.book.image, 
        author:this.book.author, synopsis: this.book.description, 
        bid: this.book.bid}}).then((response) => {
          this.isActive = !this.isActive
          if (this.isActive==false) {
            this.$notify({ 
              title: `”${this.book.title}”を`,
              message: this.$createElement('p',{style: 'color:#000'},'読書履歴に登録しました！'),
              duration: 4000
            })
          } else{
            this.$notify({ 
              title: `”${this.book.title}”を`,
              message: this.$createElement('p',{style: 'color:#000'},'読書履歴から削除しました！'),
              duration: 4000
            })
          }
        }, (error) => {
          aleart("error");
      }); 
    }
  }
}
</script>

<style scoped>
.best-btn{
  display: inline-block;
  padding: 0em 1em;
  text-decoration: none;
  color: #000000;
  border-radius: 3px;
  transition: .4s;
  max-width: 165px;
  height: 38px;
}

.readed{
  color: #00a008!important;
  transition: .3s !important;
  font-size: 20px !important;
  cursor: pointer;
}

.bested-btn{
  background: #00a008;
  display: inline-block;
  padding: 0.5em 1em;
  text-decoration: none;
  color: #ffffff;
  border-radius: 3px;
  text-align: center;
  width: 133px;
  height: 22px;
}

.best-btn:hover {
  background: #00a008;
  color: #ffffff;
}

.image-field{
  position: relative;
}

.info-image {
  width: 121px;
  height: 181px;
}

.read-btn{
  position: absolute;
  right: 70px;
  color: #000000;
  transition: .3s;
  font-size: 20px;
  border-bottom: solid 0.5px;
  cursor: pointer;
}

.book-title, .book-author{
  max-width: 250px;      
  max-height: 24px;
  text-overflow: ellipsis;
  overflow: hidden;
  white-space: nowrap;
}
</style>
