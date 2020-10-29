<template>
    <div class="filecard-content">
            <el-card class="file-card" shadow="hover">
                <div class="report-details" v-if="report != null">
                    <div class="download">
                        <i class="el-icon-download"></i>
                        <h5>{{report.downloads}}</h5>
                    </div>
                <h5>{{report.university}}</h5>
                <h5 class="report-title">{{report.subject}}</h5>
                <p class="report-exp">{{report.detail}}</p>
                </div>
            </el-card>
    </div>
</template>
<script>
import { db,firebase } from '~/plugins/firebase'
  export default {
    props:['report'],
    data() {
      return {
        value: 3.7,
        reportIndex:0,
        shareUserAddress:"",
        reports:[],
        Report:null,
      }
    },
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
.report-semester{
    position: absolute;
    top: -9px;
    right: -5px;
}
.report-grade{
    position: absolute;
    top: -9px;
    right: 50px;
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
    margin-top: 10px;
}
.download{
    position: absolute;
    display: flex;
    right: -10px;
    top: 75px;
}
</style>