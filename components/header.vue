<template>
      <div class="header-content">
                <img src="~/assets/images/reportoken-logo_header.png" class="reportoken-logo_header">
            <el-input placeholder="レポート名で検索" v-model="input" class="serch-input">
              <el-button slot="append" icon="el-icon-search"></el-button>
            </el-input>
          <div class="page-link">
            <!-- <nuxt-link to="/homePage" class="link-detail">ホーム</nuxt-link> -->
            <nuxt-link to="/serchPage" class="link-detail">検索</nuxt-link>
            <nuxt-link to="/historyPage" class="link-detail">履歴</nuxt-link>
            <nuxt-link to="/walletPage" class="link-detail">ウォレット</nuxt-link>
            <el-badge is-dot class="item">
            <el-dropdown>
              <span class="el-dropdown-link">
                <i class="el-icon-bell"></i>
              </span>
              <el-dropdown-menu slot="dropdown">
                <el-dropdown-item>
                  <nuxt-link to="/historyPage" class="link-detail_notification">                 
                    <p>Aさんが「情報通信工学実験」を購入しました</p>
                    <p class="timestamp">2020/09/03</p>
                  </nuxt-link>
                </el-dropdown-item>
                <el-dropdown-item>
                  <nuxt-link to="/historyPage" class="link-detail_notification">                 
                    <p>Bさんが「情報通信工学実験」を購入しました</p>
                    <p class="timestamp">2020/09/04</p>
                  </nuxt-link>
                </el-dropdown-item>
                <el-dropdown-item>
                  <nuxt-link to="/historyPage" class="link-detail_notification">                 
                    <p>Aさんが「情報倫理期末レポート」を購入しました</p>
                    <p class="timestamp">2020/09/12</p>
                  </nuxt-link>
                </el-dropdown-item>
                <el-dropdown-item>
                  <nuxt-link to="/historyPage" class="link-detail_notification">                 
                    <p>Bさんが「化学中間レポート」を購入しました</p>
                    <p class="timestamp">2020/09/13</p>
                  </nuxt-link>
                </el-dropdown-item>
                <el-dropdown-item>
                  <nuxt-link to="/historyPage" class="link-detail_notification">                 
                    <p>Eさんが「情報倫理中間レポート」を購入しました</p>
                    <p class="timestamp">2020/09/15</p>
                  </nuxt-link>
                </el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
            </el-badge>
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
  width: 300px;
}
.page-link{
  position: absolute;
  right: 30px;
  top: 20px;
}
.el-icon-message-solid{
  color: #fff;
}
.el-dropdown-link {
    cursor: pointer;
}
.el-icon-bell{
  color: #f4f4f4;
}
.notification-btn{
  background-color: #8cbef0;
}
.timestamp{
  color: rgb(184, 184, 184);
  font-size: 12px;
  position: relative;
  right: -220px;
  bottom: 15px;
}
.link-detail_notification{
  text-decoration: none;
}
.link-detail{
  text-decoration: none;
  color: #f4f4f4;
  font-size: 16px;
  padding: 8px;
}

</style>