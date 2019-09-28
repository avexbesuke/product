<template>  
  <div id="form">
    <hr />
    <h2 class="form-h2">"{{book.title}}" が好きな理由</h2>
    <div class="emotion-list">
      <div class="emotion-list__view">
        <div class="emotion-list__view__data">
          <img v-if="book.image.length != 0" :class="{ linkable }" :src="book.image" class="data__image"/>
          <img v-else :class="{ linkable }" src="../../assets/noimage.png" class="data__image"/>
          <el-form ref="form" :model="form" :rules="rules" label-width="120px">
            <div class="data">
              <div class="title">
                <div class="readed_at">
                  <span class="date-label">読了日</span>
                  <el-date-picker type="date" v-model="form.read"></el-date-picker>
                </div>
              </div>
            </div>
            <div class="lead-menu">
                <el-form-item prop="memo">
                  <p class="lead-menu">この本が好きな理由</p>
                  <el-input type="textarea" maxlength="200"
                    resize="none" v-model="form.memo"></el-input>
                </el-form-item>
                <div class="tag-btn">
                  <el-input type="text" maxlength="8"
                      resize="none" v-model="form.tag" class="emotion-tag" placeholder="タグ付け(感動,シリアス)"></el-input>
                  <el-button type="primary" @click="createBook" class="emotion-btn">登録</el-button>
                </div>
            </div>
          </el-form>
        </div>
      </div>
    </div>
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
      ...mapActions([UPDATE_CURRENT]),
      createBook(){
        this.$refs['form'].validate((valid) => { //検証に成功したらストアに反映
          if (valid){
            axios.post('/api/emotions', { books: { title: this.book.title, image_url: this.book.image, 
              author:this.book.author, synopsis: this.book.description, 
              body: this.form.memo, readed_at: this.form.read, bid: this.book.bid, tag_list:this.form.tag} }).then((response) => {
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

<style>
.el-form-item{
  margin-bottom: 0px !important;
}

.el-form-item__content{
  margin-left: 0px !important;
}

.el-form{
  padding: 0 30px;
}

.el-textarea{
  height: 200px;
  width: 400px;
}

.el-textarea__inner{
  height: 200px;
  width: 400px;
  resize: none;
  padding: 0 12px;
  border-radius: 5px;
  background-color: rgba(238, 238, 238, 0.1);
}

.el-input__inner{
  width: 220px !important;
}
</style>

<style scoped>

.form-h2{
  padding: 20px 40px;
  font-size: 38px;
  font-weight: bold;
}

.emotion-list{
  word-wrap:break-all;
  display: flex;
  margin: 0 0 20px 0;
}

.emotion-list__view{
  padding: 20px 70px 40px 40px;
}

.emotion-list__view__data{
  display: flex;
  position: relative;
  width: 150%;
}

.data__image{
  width: 186px;
  height: 276px;
}

.lead-menu{
  font-size: 18px;
  width: 400px;
}

.tag-btn{
  display: flex;
  margin-top: 5px;
}

.emotion-tag{
  width: 60px;
}

.emotion-btn{
  margin-left: 270px !important;
}

</style>