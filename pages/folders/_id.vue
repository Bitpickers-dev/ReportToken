<template>
    　<div class="app-layout">
            <Header />
        <div class="main-contents">
            <div class="side-content">
            <Folder />
            </div>
    <div class="main-content">
       <h1>レポート情報</h1>
             <div class="home-btn">
                <el-button type="primary">
                        <nuxt-link to="/homePage" class="link-detail">HOMEへ</nuxt-link>
                </el-button>
             </div>
             <div class="report-info">
                 <Filecard />
                 <div class="report-table_info">
                    <el-table
                        :data="tableData"
                        :default-sort = "{prop: 'date', order: 'descending'}"
                        style="width: 100%"
                        >
                        <el-table-column
                        prop="date"
                        label="日付"
                        sortable
                        width="120">
                        </el-table-column>
                        <el-table-column
                        prop="name"
                        label="ユーザー名"
                        width="180">
                        </el-table-column>
                        <el-table-column
                        prop="address"
                        label="アドレス"
                        :formatter="formatter">
                        </el-table-column>
                    </el-table>
                 </div>
             </div>
            <Upload />
      </div>
            </div>
        </div>
</template>
<script>
import Header from '~/components/header.vue'
import { db,firebase } from '~/plugins/firebase'

export default {
    components:{
        Header
    },
    mounted(){
      const reportId = this.$route.params.id
      const reportIndex = reportId.slice(-1)
      const shareUserAddress = reportId.slice(0,42)
      console.log("repotIndex is ",reportIndex)
      console.log("shareUserAddress is ",shareUserAddress)
    },
    data() {
      return {
        tableData: [{
          date: '2020/05/03',
          name: 'Aoi',
          address: '0x1062Bb912a6D1B43D901DE9087E5B1200Db877f8'
        }, {
          date: '2020/05/02',
          name: 'Oshita',
          address: '0x1062Bb912a6D1B43D901DE9087E5B1200Db877f8'
        }, {
          date: '2020/07/04',
          name: 'Onishi',
          address: '0x1062Bb912a6D1B43D901DE9087E5B1200Db877f8'
        }, {
          date: '2020/07/04',
          name: 'Nishino',
          address: '0x1062Bb912a6D1B43D901DE9087E5B1200Db877f8'
        }, {
          date: '2020/07/04',
          name: 'Onishi',
          address: '0x1062Bb912a6D1B43D901DE9087E5B1200Db877f8'
        }, {
          date: '2020/06/01',
          name: 'Konishi',
          address: '0x1062Bb912a6D1B43D901DE9087E5B1200Db877f8'
        }]
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

    .home-btn{
      text-align: center;
      padding: 10px;
    }
.report-info{
    text-align: center;
}
.report-table_info{
    margin-left: 10%;
    width: 80%;
    text-align: center;
}
</style>