<template>
  <div>
    <Header />
    <div class="image-content">
      <img src="~/assets/images/b0207.png" class="report-img">
    </div>
    <h3>一人でレポートに悩む日々とはもうお別れ</h3>
      <h2>〜これは、学生のための世界初の分散型レポート共有アプリ〜</h2>
    <div class="image-content">
      <img src="~/assets/images/b0302.png" class="report-img">
    </div>
    <Tutorial/>
    <Footer/>
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
  data() {
    return {}
  }
}
</script>
<style scoped>
body {
  margin: 0;
}
h1 {
  padding-left: 10px;
  text-align: center;
}
h3, h2{
  text-align: center;
  background-color:#f4f4f4;
}
h5 {
  text-align: center;
}
p {
  text-align: center;
}
.reportoken-logo {
  text-align: center;
  width: 50px;
  height: 50px;
  padding: 0 15px;
}
.subtitle {
  display: flex;
  margin: 0 auto;
  width: auto;
  background-color:#f4f4f4;
}
.image-content {
  text-align: center;
  background-color:#f4f4f4;
}
.report-img {
  width: 300px;
  height: auto;
  text-align: center;
}
.link-detail_top {
  text-decoration: none;
}
.home-btn {
  text-align: center;
  padding: 10px;
}
</style>
