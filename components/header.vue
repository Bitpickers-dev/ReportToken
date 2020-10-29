<template>
      <div class="header-content">
          <nuxt-link to="/homePage">
                <img src="~/assets/images/reportoken-logo_header.png" class="reportoken-logo_header">
          </nuxt-link>
          <div class="page-link">
            <!-- <nuxt-link to="/homePage" class="link-detail">ホーム</nuxt-link> -->

            <nuxt-link to="/serchPage" class="link-detail"><i class="el-icon-search"></i></nuxt-link>
            <nuxt-link to="/walletPage" class="link-detail"><i class="el-icon-user"></i></nuxt-link>

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
        input:'',
        timeout:  null
      };
    },
    methods: {
      loadAll() {
        return [
          { "value": "情報通信工学", "link": "https://ethereum.org/ja/" },
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
  height: 6vh;
  background-color:#f4f4f4;
}

.reportoken-logo_header{
  padding: 7px;
  width: 50px;
  height: 50px;
}

.page-link{
  position: absolute;
  right: 30px;
  top: 20px;
}
.el-icon-message-solid{
  color: #fff;
}

.link-detail_notification{
  text-decoration: none;
}
.link-detail{
  text-decoration: none;
  color: black;
  font-size: 20px;
  padding: 8px;
}

</style>