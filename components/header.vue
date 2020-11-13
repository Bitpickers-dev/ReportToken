<template>
  <div class="header-content">
    <nuxt-link to="/">
      <img
        src="~/assets/images/reportoken-logo_header.png"
        class="reportoken-logo_header"
      />
    </nuxt-link>
    <div class="page-link">
      <!-- <nuxt-link to="/homePage" class="link-detail">ホーム</nuxt-link> -->

      <nuxt-link to="/serchPage" class="link-detail"
        ><i class="el-icon-search"></i
      ></nuxt-link>
      <nuxt-link to="/myPage" class="link-detail"
        ><i class="el-icon-user"></i
      ></nuxt-link>
    </div>
  </div>
</template>

<script>
import Vue from "vue";
import ElementUI from "element-ui";
import "element-ui/lib/theme-chalk/index.css";
import lang from "element-ui/lib/locale/lang/ja";
import locale from "element-ui/lib/locale";

locale.use(lang);
Vue.use(ElementUI);
export default {
  data() {
    return {};
  },
};
</script>

<style>
.header-content {
  display: flex;
  width: 100%;
  height: 6vh;
  background-color: #f4f4f4;
}

.reportoken-logo_header {
  padding: 10px;
  padding-top: 5px;
  width: 50px;
  height: 50px;
  margin-left: 50px;
}

.page-link {
  position: absolute;
  right: 30px;
  top: 20px;
}
.el-icon-message-solid {
  color: #fff;
}

.link-detail_notification {
  text-decoration: none;
}
.link-detail {
  text-decoration: none;
  color: black;
  font-size: 20px;
  padding: 8px;
}
</style>
