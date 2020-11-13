<template>
  <div class="app-layout">
    <Header/>
    <div class="main-contents">
      <div class="main-content">
        <div class="account-check">
          <el-alert
            v-if="userAddress == null"
            title="アカウント接続失敗"
            type="error"
            description="「アプリを始める」をクリックしてMetamaskと接続してください"
            show-icon
            :closable="false"
            >
          </el-alert>
            <el-alert
              v-if="userAddress != null"
              title="アカウント接続成功!"
              type="success"
              description="Metamaskとアカウントの接続が成功しました！"
              show-icon>
            </el-alert>
        </div>
        <div class="top-view">
            <div class="top-view_text">
              <h1 class="view-text_en">Share your experience.</h1>
              <p>学生のための世界初分散型レポート共有アプリ</p>
              <p>あなたの知識には価値がある。</p>
              <div class="buttons">
                <el-button type="primary" style="font-weight:bold" @click="connectMetamask()">
                  アプリを始める
                </el-button>
                <el-button type="info" plain>
                  <nuxt-link to="/tutorialPage" class="button-content">レポートークンについて</nuxt-link>
                </el-button>
              </div>
            </div>
          <div class="top-view_media">
            <img src="~/assets/images/top-view.png" class="reportoken-logo">
          </div>
        </div>
        <div v-if="userAddress != null" class="rank-content">
          <Filecards :reports="reports"/>
        </div>

        <Upload v-if="userAddress != null"/>
        <Footer/>
      </div>
    </div>
  </div>
</template>

<script>
import Vue from 'vue'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import lang from 'element-ui/lib/locale/lang/ja'
import locale from 'element-ui/lib/locale'
import Header from '~/components/header.vue'
import { db,firebase } from '~/plugins/firebase'

locale.use(lang)
Vue.use(ElementUI)
export default {
  components: {
    Header
  },
  data(){
    return{
      reports:[],
      users:[],
      userAddress:null,
      reportsAbove:[],
      RP1Table:[],
      RP2Table:[],
      RPTable:[],
      downloadsArray:[],
      tokens:[],
      rp2Receiver:[],
      hitNumber:null,
      totalInssuance:0,
      // receiverIndex:null
    }
  },
  async mounted(){
      await db.collection('users').get().then((querySnapshot) =>{
          querySnapshot.forEach((doc) => {
              this.users.push(doc.data())
          })
      })
        let accounts = await this.$web3.eth.getAccounts()
        this.userAddress = accounts[0]
        console.log("hello")
      let count=0;
      for(let i=0;i < this.users.length;i++){
        if(this.users[i].address == this.userAddress){
          count++;
        }
      }
      if(count == 0){
        await db.collection('users').doc(this.userAddress).set({
          address:this.userAddress,
          purchased_token_amount:0,
          shares:0,
          tokens:0
          //TODO: 他にも初期値を設定するところがあるかもしれないので注意
        })
      }


    db.collection('reports').orderBy('downloads', 'desc').get().then((querySnapshot) => {
        querySnapshot.forEach((doc) => {
            this.reports.push(doc.data())
            this.report = this.reports[0]

        })
    })

  },
  methods:{
    connectMetamask(){
      console.log(this.userAddress)
      this.userAddress = "仮アカウント"
      console.log(this.userAddress)
    }
  },
};
</script>

<style>
html {
  font-family: 'Oswald', sans-serif;
}

h3 {
  text-align: center;
}

.main-contents {
  display: flex;
}

.main-content {
  width: 100%;
  background-color: #f4f4f4;
}

.top-view{
  display: flex;
}
.view-text_en{
  font-weight:700;
  font-size: 2.8rem;
}
.top-view_text{
  margin: 0 auto;
  width: 500px;
  text-align: center;
  padding-top: 100px;
  font-weight:300;
}
@media screen and (max-width:850px){
  .top-view_media img{
    width: 400px;
  }
  .top-view_text{
    margin: 0 auto;
    width: 300px;
    padding-top: 80px;
    font-weight:100;
  }
  .view-text_en{
    font-weight:700;
    font-size: 2.0rem;
  }
}
@media screen and (max-width:750px) {
  .top-view{
    display: block;
    text-align: center;
  }
  .top-view_media img{
    width: 350px;
  }
  .top-view_text{
    margin: 0 auto;
    width: 500px;
    padding-top: 0;
    margin-top: 0;
    font-weight:100;
  }
  .view-text_en{
    font-weight:700;
    font-size: 1.4rem;
  }
}

.top-view_media{
  margin: 0 auto;
}



.buttons{
  display: flex;
  display: block;
  text-align: center;
}

.button-content{
  text-decoration: none;
  color: #0e0e0e;
  font-weight: bold;
}

.reportoken-logo{
  width: 500px;
  height: auto;
}

.rank-content {
  margin: 0 40px;
  height: auto;
  overflow-x: scroll;
  margin-bottom: 10px;
}

</style>
