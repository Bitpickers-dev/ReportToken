<template>
    <div>
      <div class="calousel">
        <el-carousel :interval="5000" arrow="always">
          <el-carousel-item v-for="item in 4" :key="item">
              <h3>{{ item }}hello</h3>
          </el-carousel-item>
        </el-carousel>
      </div>
      <div class="home-btn">
        <el-button type="primary">
            <nuxt-link to="/homePage" class="link-detail">HOMEへ</nuxt-link>
        </el-button>
      </div>
      <h3>一人でレポートに悩む日々とはもうお別れ</h3>

      <div class="image-content">
        <img src="~/assets/images/b0207.png" class="report-img">
      </div>
        <div class="subtitle">
          <h2>〜全学生のための世界初の分散型レポート共有アプリ</h2>
          <img src="~/assets/images/reportoken-logo.png" class="reportoken-logo">
          <h2>〜</h2>
      </div>
      <div class="image-content">
        <img src="~/assets/images/b0301.png" class="report-img">
      </div>
      <!-- <nuxt-link to="/homePage" class="link-detail_top">ホームへ</nuxt-link> -->
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
    h2{
      text-align: center;
    }
    h3{
      text-align: center;
    }
    h5{
      text-align: center;
    }
    .reportoken-logo{
      text-align: center;
      width: 50px;
      height: 50px;
      margin-top: 15px;
      padding:0 15px;
    }
    .subtitle{
      display: flex;
      padding-left: 20%;
    }
    .image-content{
      text-align: center;
    }
    .report-img{
      width: 300px;
      height: auto;
      text-align: center;
    }
    .link-detail_top{
      text-decoration: none;
    }

    .carousel{
      width: 300px;
    }
      .el-carousel__item h3{
        color: #475669;
        font-size: 18px;
        opacity: 0.75;
        line-height: 300px;
        margin: 0;
      }

      .el-carousel__item:nth-child(2n) {
        background-color: #99a9bf;
      }

      .el-carousel__item:nth-child(2n+1) {
        background-color: #d3dce6;
      }
    .home-btn{
      text-align: center;
      padding: 10px;
    }
</style>