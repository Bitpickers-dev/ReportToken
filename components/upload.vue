<template>
        <div class="upload_content">
                <nuxt-link to="/uploadPage" class="link-detail">
                    <el-button type="primary" class="upload_btn" circle>
                        <h3>共有</h3>
                        <i class="el-icon-upload2"></i>
                    </el-button>
                </nuxt-link>
        </div>
</template>

<style scoped>
.upload_content{
    position: fixed;
    z-index: 2;
    bottom: 60px;
    right: 60px;
}
.upload_btn{
    width: 100px;
    height: 100px;
box-shadow:  5px 5px 37px #b8b8b8, 
             -5px -5px 37px #ffffff;
}
</style>