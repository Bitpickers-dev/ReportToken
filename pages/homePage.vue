<template>
  <div class="app-layout">
    <Header/>
    <div class="main-contents">
      <div class="side-content">
        <Folder/>
      </div>
      <div class="main-content">
        <el-button @click="RP1()">hello</el-button>
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
      reportsAbove:[],
      RPTable:[],
      downloadsArray:[],
    }
  },
  mounted(){
        db.collection('reports').orderBy('downloads', 'desc').get().then((querySnapshot) => {
            querySnapshot.forEach((doc) => {
                // console.log(doc.id, "=>" ,doc.data())
                this.reports.push(doc.data())
                // console.log(this.reports)
                this.report = this.reports[0]

            })
        })

  },
  methods:{
    RP1(){
      this.HPF();
    },
    HPF(){
      const n = this.reports.length
      for(let i=0;i < n;i++){
        this.RPTable.push({
          userAddress: this.reports[i].shareUser,
          RP:0
        })
        // console.log(this.RPTable[i])
      }

      let median = this.reports[Math.floor(n/2)].downloads;
      

      
      
      
    },
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
