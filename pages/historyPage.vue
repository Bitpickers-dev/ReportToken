<template>
    <div class="history-content">
        <Header />
        <h1>履歴</h1>
        <div class="home-btn">
            <el-button type="primary">
                <nuxt-link to="/homePage" class="link-detail">HOMEへ</nuxt-link>
            </el-button>
        </div>
    </div>
</template>
<script>
import Header from '~/components/header.vue'
export default {
    components:{
        Header
    },
}
</script>
<style>
.link-detail{
  text-decoration: none;
  color: #f4f4f4;
  font-size: 16px;
  padding: 8px;
}
    .home-btn{
      text-align: center;
      padding: 10px;
    }
</style>