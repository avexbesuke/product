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
      <input v-if="this.bids.indexOf(book.bid) == -1" class="best-btn" type="button" @click="onclick" value="マイベストにする"/>
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
  padding: 0.5em 1em;
  text-decoration: none;
  color: #67c5ff;
  border: double 4px #67c5ff;
  border-radius: 3px;
  transition: .4s;
}

.readed{
  color: #ffef15 !important;
  transition: .3s !important;
  font-size: 20px !important;
  border-bottom: solid 0.5px !important;
  border-color: #3d00e6 !important;
}

.bested-btn{
  background: #fffbef;
  display: inline-block;
  padding: 0.5em 1em;
  text-decoration: none;
  color: #930ea5;
  border: double 4px #9e0992;
  border-radius: 3px;
}

.best-btn:hover {
  background: #fffbef;
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
}

.book-title, .book-author{
  max-width: 250px;      
  max-height: 24px;
  text-overflow: ellipsis;
  overflow: hidden;
  white-space: nowrap;
}
</style>
