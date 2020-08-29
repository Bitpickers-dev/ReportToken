<template>
  <div class="">
    <div class="app-layout">
        <Header />
      <div class="main-contents">
        <div class="side-content">
          <Folder />
        </div>
        <div class="main-content">
          
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


locale.use(lang)
Vue.use(ElementUI)
  export default {
    components:{
        Header
    },
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






.side-content {
  height: 90vh;
  width: 400px;
  background-color:#fafafa;
}

.main-content{
  height: 90vh;
  width: 100%;
  background-color:#f4f4f4;
}




</style>
