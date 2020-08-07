<template>
  <div class="">
    <div class="app-layout">
      <div class="header-content">
        <img src="https://pbs.twimg.com/profile_images/1238812638387163136/xVj9-uVR_400x400.jpg" width="50px" height="50px" class="reportoken-logo" alt="">
          <el-autocomplete
            class="serch-input"
            v-model="state"
            :fetch-suggestions="querySearchAsync"
            placeholder="検索"
            @select="handleSelect"
          ></el-autocomplete>
          <div class="hoge">
            <el-link　style="font-size:20px;"   href="https://element.eleme.io" target="_blank">ホーム</el-link>
            <el-link　style="font-size:20px;"   href="/walletPage.vue" target="_blank">ウォレット</el-link>
            <el-link　style="font-size:20px;"   href="https://element.eleme.io" target="_blank">履歴</el-link>
          </div>
      </div>
      <div class="main-contents">
        <div class="side-content">
          <!-- <h3>マイフォルダー</h3> -->
          <Folder />
        </div>
        <div class="main-content">
          <nuxt />
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
// import Folder from '~/components/forlder.vue'


locale.use(lang)
Vue.use(ElementUI)
  export default {
    components:{
      // Folder
    },
    data() {
      return {
        links: [],
        state: '',
        timeout:  null
      };
    },
    methods: {
      loadAll() {
        return [
          { "value": "Ethereum", "link": "https://ethereum.org/ja/" },
          { "value": "Solidity", "link": "https://solidity-jp.readthedocs.io/ja/latest/" },
         ];
      },
      querySearchAsync(queryString, cb) {
        var links = this.links;
        var results = queryString ? links.filter(this.createFilter(queryString)) : links;

        clearTimeout(this.timeout);
        this.timeout = setTimeout(() => {
          cb(results);
        }, 3000 * Math.random());
      },
      createFilter(queryString) {
        return (link) => {
          return (link.value.toLowerCase().indexOf(queryString.toLowerCase()) === 0);
        };
      },
      handleSelect(item) {
        console.log(item);
      }
    },
    mounted() {
      this.links = this.loadAll();
    }
  };
</script>

<style>
html {
  font-family: 'Oswald', sans-serif;
}

h3{
  text-align: center;
}
.main-contents{
 display: flex;
}

.header-content{
  display: flex;
  width: 100%;
  height: 10vh;
  background-color:#8cbef0;
}

.reportoken-logo{
  padding: 10px;
  border-radius: 50%;
}
.serch-input{
  padding: 10px;
  padding-top: 20px;
}

.hoge{
  position: absolute;
  right: 30px;
  top: 50px;
}





.side-content {
  height: 90vh;
  width: 600px;
  background-color:#fafafa;
}

.main-content{
  height: 90vh;
  width: 100%;
  background-color:#f4f4f4;
}




</style>
