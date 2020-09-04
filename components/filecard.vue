<template>
    <div class="filecard-content">
        <nuxt-link :to="{name: 'folders-id',params:{id:'情報工学通信実験'}}">
            <el-card class="file-card" shadow="hover">
                <div class="report-details">
                    <el-rate
                    v-model="value"
                    disabled
                    show-score
                    text-color="#ff9900"
                    score-template="{value}">
                    </el-rate>
                    <el-tag class="report-period" size="mini">1Q</el-tag>
                    <el-tag class="report-grade" size="mini">B1</el-tag>
                    <div class="download">
                        <i class="el-icon-download"></i>
                        <h5>6</h5>
                    </div>

                </div>
                <h5 class="report-title">情報通信工学実験</h5>
                <p class="report-exp">第4回Arduinoの実験レポートです。</p>
            </el-card>
        </nuxt-link>
    </div>
</template>
<script>
  export default {
    data() {
      return {
        value: 3.7
      }
    }
  }
</script>

<style scoped>
.filecard-content{
    display: inline-block;
}
.file-card{
    width: 300px;
    height: 120px;
    margin: 15px;
    border-radius: 15px;
}
.report-details{
    position: relative;
}
.report-period{
    position: absolute;
    right: -10px;
    top: -12px;
}
.report-grade{
    position: absolute;
    top: -12px;
    right: 30px;
}
.report-exp{
    margin: 0;
    padding: 0;
    height: 75px;
    overflow: scroll;
}
.report-title{
    margin: 0;
    padding: 0;
}
.download{
    position: absolute;
    display: flex;
    right: -10px;
    top: 75px;
}
</style>