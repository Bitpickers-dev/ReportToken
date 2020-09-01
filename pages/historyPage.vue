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
        <Upload />
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

    .home-btn{
      text-align: center;
      padding: 10px;
    }
</style>