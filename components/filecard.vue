<template>
    <div class="filecard-content">
            <el-card class="file-card" shadow="hover">
                <div class="report-details">
                    <!-- <el-rate
                    v-model="value"
                    disabled
                    show-score
                    text-color="#ff9900"
                    score-template="{value}">
                    </el-rate> -->
                    <div class="report-semester" v-for="semester in report.semester" :key="semester">
                        <el-tag class="report-semester" size="mini">{{semester}}</el-tag>
                    </div>
                    <div class="report-grade" v-for="grade in report.grade" :key="grade">
                        <el-tag class="report-grade" size="mini">{{grade}}</el-tag>
                    </div>
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
import { db,firebase } from '~/plugins/firebase'
  export default {
    props:['report'],
    data() {
      return {
        value: 3.7
      }
    },
    mounted(){
        // const reportId = this.$route.params.id
        // this.reportIndex = reportId.slice(-1)
        // this.shareUserAddress = reportId.slice(0,42)

        // db.collection('reports').where("shareUser", "==", this.shareUserAddress).get().then((querySnapshot) => {
        //     querySnapshot.forEach((doc) => {
        //         if(this.reportIndex == doc.data().index){
        //             console.log(doc.id, "=>" ,doc.data())
        //             this.reports.push(doc.data())
        //             console.log(this.reports)
        //             this.report = this.reports[0]
        //         }

        //     })
        // })
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