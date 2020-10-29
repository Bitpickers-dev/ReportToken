<template>
    　<div class="app-layout">
            <Header />
        <div class="main-contents">
    <div class="main-content">
       <h1>レポート情報</h1>
       <p>{{shareUserAddress}}</p>
       <p>レポートの識別子は{{reportIndex}}</p>
             <div class="report-info">
                 <Filecard :report="report"/>
                 <div class="report-table_info">
                 </div>
             </div>
            <Upload />
      </div>
            </div>
        </div>
</template>
<script>
import Header from '~/components/header.vue'
import Filecard from '~/components/filecard.vue'
import { db,firebase } from '~/plugins/firebase'

export default {
    components:{
        Header,
        Filecard
    },
    mounted(){
      const reportId = this.$route.params.id
      this.reportIndex = reportId.slice(-1)
      this.shareUserAddress = reportId.slice(0,42)
      // console.log("repotIndex is ",this.reportIndex)
      // console.log("shareUserAddress is ",this.shareUserAddress)
      db.collection('reports').where("shareUser", "==", this.shareUserAddress).get().then((querySnapshot) => {
            querySnapshot.forEach((doc) => {
              // console.log(doc.data().index)
              if(this.reportIndex == doc.data().index){
                this.reports.push(doc.data())
                this.report = this.reports[0]
              }
            })
      })
    },
    data() {
      return {
        reportIndex:null,
        shareUserAddress:null,
        report:null,
        reports:[]
      }
    },
    methods: {
      formatter(row, column) {
        return row.address;
      }
    }
}
</script>
<style>
.report-info{
    text-align: center;
}
.report-table_info{
    margin-left: 10%;
    width: 80%;
    text-align: center;
}
</style>