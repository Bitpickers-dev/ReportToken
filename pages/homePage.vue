<template>
  <div class="app-layout">
    <Header/>
    <div class="main-contents">
      <div class="side-content">
        <Folder/>
      </div>
      <div class="main-content">
        <h5>現在ログインしているアカウントは{{userAddress}}</h5>
        <el-button @click="RP()">RPを実行するボタン</el-button>
        <!-- ランキングコンテンツはcomponentにしてもいいかも -->
        <div class="rank-content">
          <Filecards :reports="reports"/>
          <Upload/>
        </div>
        <div class="tutorial-content">
          <!-- <Tutorial /> -->
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Vue from 'vue';
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import lang from 'element-ui/lib/locale/lang/ja'
import locale from 'element-ui/lib/locale'
import Header from '~/components/header.vue'
import { db,firebase } from '~/plugins/firebase'
// import { median } from 'mathjs/number'

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
              console.log(this.users)
          })
      })
        let accounts = await this.$web3.eth.getAccounts()
        this.userAddress = accounts[0]
        // console.log(this.userAddress)
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
    async RP(){
      this.RP1()
      
      this.RP2()

      for(let i=0;i < this.users.length;i++){
        this.RPTable.push({
          userAddress: this.users[i].address,
          RP: this.RP1Table[i].RP1 + this.RP2Table[i].RP2
        })
        db.collection('winners').add({
          RP: this.RPTable[i].RP,
          winner_address: this.RPTable[i].userAddress
        })
      }
      // console.log(this.RP1Table)
      // console.log(this.RP2Table)
      // console.log(this.RPTable)

    },
    RP1(){
      for(let i=0;i < this.users.length;i++){
        this.RP1Table.push({
          userAddress: this.users[i].address,
          RP1:0
        })
        // console.log(this.RPTable[i])
      }
      this.HPF()
      
    },
    HPF(){
      const n = this.reports.length
      const numOfAbove = Math.floor(n/2)
      console.log(numOfAbove)
      // let median = this.reports[numOfAbove].downloads;
      for(let i=0;i<numOfAbove;i++){
        for(let j=0;j < this.users.length;j++){
          if(this.reports[i].shareUser == this.RP1Table[j].userAddress){
            if(numOfAbove <= 8){
              this.RP1Table[j].RP1 += 4 - 0.5*i
            }else{
              this.RP1Table[j].RP1 += 4 - 4*i
            }
          }
        }
      }
    },
    RP2(){
      for(let i=0;i < this.users.length;i++){
        this.RP2Table.push({
          userAddress: this.users[i].address,
          RP2:0
        })
        // console.log(this.RPTable[i])
      }
      for(let i =0;i< this.users.length;i++){
        this.totalInssuance += this.users[i].purchased_token_amount
      }

      for(let i= 0;i < 5;i++){
        this.hitNumber = Math.floor(Math.random()*100)
        console.log('hitNumber is ',this.hitNumber)
        this.rp2Receiver[i] = this.roulette()
        //search user
        for(let j=0;j < this.users.length;j++){
          if(j == this.rp2Receiver[i]){
            this.RP2Table[j].RP2 += 1
          }
        }
      }
    },
    roulette(){
      let rangeMin = 0
      let rangeMax = 0
      let percentage = 0
      let i = 0

      for(i;i<this.users.length;i++){
        percentage = 100*this.users[i].purchased_token_amount / this.totalInssuance
        rangeMax += percentage
        if(rangeMin <= this.hitNumber && this.hitNumber <= rangeMax){
          break
        }else{
          rangeMin = rangeMax
        }
      }
        return i
    }
  }
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
  height: 92vh;
  width: 100%;
  background-color: #f4f4f4;
}

.side-content {
  height: 92vh;
  width: 300px;
  width: 350px;
}

.rank-content {
  height: 59%;
  overflow-x: scroll;
  margin-bottom: 10px;
}

.tutorial-content {
  /* position: absolute;
  z-index: 1;
  bottom: 0px; */
}
</style>
