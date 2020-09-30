<template>
  　
  <div class="app-layout">
    <Header/>
    <div class="main-contents">
      <div class="side-content">
        <Folder/>
      </div>
      <div class="main-content">
        <h1>履歴</h1>
        <div class="home-btn">
          <el-button type="primary">
            <nuxt-link to="/homePage" class="link-detail">HOMEへ</nuxt-link>
          </el-button>
        </div>
        <div class="report-table_info">
          <el-table
            :data="tableData"
            :default-sort="{prop: 'date', order: 'descending'}"
            style="width: 100%"
          >
            <el-table-column
              prop="reportname"
              label="レポート名"
              sortable
              width="150">
            </el-table-column>
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
        <Upload/>
      </div>
    </div>
  </div>
</template>
<script>
import Header from '~/components/header.vue'

export default {
  components: {
    Header
  },
  data() {
    return {
      tableData: [{
        reportname: '情報工学通信実験',
        date: '2020/05/03',
        name: 'Aoi',
        address: '0x1062Bb912a6D1B43D901DE9087E5B1200Db877f8'
      }, {
        reportname: 'デジタル回路レポート',
        date: '2020/05/02',
        name: 'Oshita',
        address: '0x1062Bb912a6D1B43D901DE9087E5B1200Db877f8'
      }, {
        reportname: 'デジタル回路レポート',
        date: '2020/07/04',
        name: 'Onishi',
        address: '0x1062Bb912a6D1B43D901DE9087E5B1200Db877f8'
      }, {
        reportname: '情報工学通信実験',
        date: '2020/07/04',
        name: 'Nishino',
        address: '0x1062Bb912a6D1B43D901DE9087E5B1200Db877f8'
      }, {
        reportname: '情報工学通信実験',
        date: '2020/07/04',
        name: 'Onishi',
        address: '0x1062Bb912a6D1B43D901DE9087E5B1200Db877f8'
      }, {
        reportname: '解析Ⅱ',
        date: '2020/07/04',
        name: 'Onishi',
        address: '0x1062Bb912a6D1B43D901DE9087E5B1200Db877f8'
      }, {
        reportname: '化学中間レポート',
        date: '2020/07/04',
        name: 'Onishi',
        address: '0x1062Bb912a6D1B43D901DE9087E5B1200Db877f8'
      }, {
        reportname: '情報工学通信実験',
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

.home-btn {
  text-align: center;
  padding: 10px;
}
</style>
