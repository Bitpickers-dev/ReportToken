<template>
    <div>
      <h1>ようこそ</h1>
      <h3>一人でレポートに悩む日々とはもうお別れ</h3>

      <div class="image-content">
        <img src="~/assets/images/b0207.png" class="report-img">
      </div>
      <h3>レポートークンとは、大学生を主とした学生のためのレポートの譲渡アプリです。</h3>
      <div class="image-content">
        <img src="~/assets/images/b0301.png" class="report-img">
      </div>
      <!-- <nuxt-link to="/homePage" class="link-detail_top">ホームへ</nuxt-link> -->
      <div class="home-btn">
        <el-button type="primary">
            <nuxt-link to="/homePage" class="link-detail">HOMEへ</nuxt-link>
        </el-button>
      </div>
    </div>
</template>

<script>
import Vue from 'vue';
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import lang from 'element-ui/lib/locale/lang/ja'
import locale from 'element-ui/lib/locale'


locale.use(lang)
Vue.use(ElementUI)
export default {
  
}
</script>
<style scoped>
    body{
        margin: 0;
    }
    h1{
      padding-left: 10px;
      text-align: center;
    }
    h3{
      text-align: center;
    }
    h5{
      text-align: center;
    }
    .image-content{
      text-align: center;
    }
    .report-img{
      width: 300px;
      height: auto;
    }
    .link-detail_top{
      text-decoration: none;
    }
    .home-btn{
      text-align: center;
    }
</style>