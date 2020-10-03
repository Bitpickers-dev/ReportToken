<template>
    <div class="filecard-content">
            <el-card class="file-card" shadow="hover">
                <div class="report-details">
                    <el-rate
                    v-model="value"
                    disabled
                    show-score
                    text-color="#ff9900"
                    score-template="{value}">
                    </el-rate>
                    <!-- <div class="report-tags" v-for="period in report[0]." :key="period">
                        <el-tag class="report-period" size="mini"></el-tag>
                    </div> -->
                    <el-tag class="report-grade" size="mini">B1</el-tag>
                    <div class="download">
                        <i class="el-icon-download"></i>
                        <h5>{{report.downloads}}</h5>
                    </div>

                </div>
                <h5 class="report-title">{{report.subject}}</h5>
                <p class="report-exp">{{report.detail}}</p>
            </el-card>
    </div>
</template>
<script>
// console.log(report)
  export default {
    props:['report'],
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