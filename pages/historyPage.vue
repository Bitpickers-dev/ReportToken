<template>
    　<div class="app-layout">
            <Header />
        <div class="main-contents">
            <div class="side-content">
            <Folder />
            </div>
    <div class="main-content">
       <h1>履歴</h1>
             <div class="home-btn">
                <el-button type="primary">
                        <nuxt-link to="/homePage" class="link-detail">HOMEへ</nuxt-link>
                </el-button>
             </div>
      </div>
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
    .home-btn{
      text-align: center;
      padding: 10px;
    }
</style>