<template>
  <div id="form">
    <BookInfo :book="book"></BookInfo>
    <hr />
    <el-form ref="form" :model="form" :rules="rules" label-width="120px">
      <el-form-item label="読了日">
        <el-date-picker type="date" v-model="form.read"></el-date-picker>
      </el-form-item>
      <el-form-item label="感想" prop="memo">
        <el-input type="textarea" size="large" v-model="form.memo"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="createBook">登録</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
  import {mapGetters, mapActions} from 'vuex'
  import BookInfo from './BookInfo.vue'
  import BookSearch from './BookSearch.vue'
  import { UPDATE_CURRENT } from './../../mutation-types'
  import axios from 'axios';
  import store from './../../store.js'

  export default {
    name: 'book-form',
    store: store,
    components:{
      BookInfo,
      // BookSearch
    },
    data(){
      return {
        book: {}, //選択中の書籍情報
        form: {
          read: new Date(), //読了日
          memo: '',          //感想
        },
        rules:{
          memo:[
            { required: true, message: '入力願います', trigger: 'change'}
          ]
        }
      }
    },
    computed: mapGetters([ 'current']),
    created(){ //ページロード時の処理
      if (!this.current){ //選択中の書籍がない場合、トップページにリダイレクト
        this.$router.push('/')
      }
      this.book = Object.assign({}, this.current) //選択中の書籍情報をbook{}に入れる
    },
    methods: {
      ...mapActions([UPDATE_CURRENT]), //アクションとメソッドを紐つけ
      // onsubmit(){ //登録ボタンで、データ登録
      //   this.$refs['form'].validate((valid) => { //検証に成功したらストアに反映
      //     if (valid){
      //       this[UPDATE_CURRENT](null) //選択中の書籍情報リセット
      //       this.$notify({ //処理成功の通知メッセージ
      //         title: '処理成功の通知メッセージ',
      //         message: this.$createElement('p',{style: 'color:#009'},'読書情報の登録に成功'),
      //         duration: 2000
      //       })
      //       this.form.read = new Date() // フォームの内容をクリア
      //       this.form.memo = ''
      //       this.$router.push('/') //トップページにリダイレクト
      //     }
      //   })
      // },
      createBook(){
        this.$refs['form'].validate((valid) => { //検証に成功したらストアに反映
          if (valid){
            axios.post('/api/books', { books: { title: this.book.title, image: this.book.image, 
              author:this.book.author, description: this.book.description, 
              body: this.form.memo, readed_at: this.form.read, bid: this.book.bid} }).then((response) => {
            // this.books.unshift(response.data.book);
            }, (error) => {
              aleart("error");
            }); 
            this.$router.push('/')
              this.$notify({ //処理成功の通知メッセージ
              title: `”${this.book.title}”`,
              message: this.$createElement('p',{style: 'color:#000'},'の好きな理由を投稿しました！'),
              duration: 2000
            })
          }
        })
      }
    }
  }
</script>
