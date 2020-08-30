<template>
      <div class="header-content">
                <img src="~/assets/images/reportoken-logo_header.png" class="reportoken-logo_header">
          <el-autocomplete
            class="serch-input"
            v-model="state"
            :fetch-suggestions="querySearchAsync"
            placeholder="検索"
            @select="handleSelect"
          ></el-autocomplete>
          <div class="page-link">
            <!-- <nuxt-link to="/homePage" class="link-detail">ホーム</nuxt-link> -->
            <nuxt-link to="/historyPage" class="link-detail">履歴</nuxt-link>
            <nuxt-link to="/walletPage" class="link-detail">ウォレット</nuxt-link>
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


locale.use(lang)
Vue.use(ElementUI)
export default {
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
}
</script>

<style>
.header-content{
  display: flex;
  width: 100%;
  height: 8vh;
  background-color:#8cbef0;
}

.reportoken-logo_header{
  padding: 10px;
  width: 48px;
  height: 48px;
}
.serch-input{
  padding: 10px;
  padding-top: 10px;
}

.page-link{
  position: absolute;
  right: 30px;
  top: 20px;
}

.link-detail{
  text-decoration: none;
  color: #f4f4f4;
  font-size: 16px;
  padding: 8px;
}

</style>