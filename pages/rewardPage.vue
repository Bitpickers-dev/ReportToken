<template>
    　<div class="app-layout">
            <Header />
        <div class="main-contents">
            <div class="side-content">
            <Folder />
            </div>
    <div class="main-content">
       <h1>ご褒美</h1>
             <div class="home-btn">
                <el-button type="primary">
                        <nuxt-link to="/homePage" class="link-detail">HOMEへ</nuxt-link>
                </el-button>
             </div>
             <div class="reward-content">
                 <h2>おめでとうございます🎉</h2>
                 <h3>あなたはこのアプリに貢献したのでご褒美を贈呈します。下のボタンを押してください</h3>
                 <el-button @click="inspection()">検証する</el-button>
             </div>
        <h3>今セメスターランキング</h3>
                 <div class="ranking-table_info">
                    <el-table
                        :data="tableData"
                        style="width: 100%"
                        >
                        <el-table-column
                        prop="rank"
                        label="順位"
                        width="90">
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
            </div>
        </div>
</template>
<script>
import Header from '~/components/header.vue'
export default {
    components:{
        Header
    },
    data() {
      return {
        tableData: [{
          rank: '1',
          name: 'Aoi',
          address: '0x1062Bb912a6D1B43D901DE9087E5B1200Db877f8'
        }, {
          rank: '2',
          name: 'Oshita',
          address: '0x1062Bb912a6D1B43D901DE9087E5B1200Db877f8'
        }, {
          rank: '3',
          name: 'Onishi',
          address: '0x1062Bb912a6D1B43D901DE9087E5B1200Db877f8'
        }, {
          rank: '4',
          name: 'Nishino',
          address: '0x1062Bb912a6D1B43D901DE9087E5B1200Db877f8'
        }, {
          rank: '5',
          name: 'Onishi',
          address: '0x1062Bb912a6D1B43D901DE9087E5B1200Db877f8'
        }, {
          rank: '6',
          name: 'Konishi',
          address: '0x1062Bb912a6D1B43D901DE9087E5B1200Db877f8'
        }]
      }
    },
    methods: {
      formatter(row, column) {
        return row.address;
      },
      inspection(){
        this.$notify({
          title: '検証しています...',
          message: '検証に成功するとご褒美としてETHが送信されます。',
          type: 'info'
        });
      }
    }
}
</script>
<style scoped>

    .home-btn{
      text-align: center;
      padding: 10px;
    }
.ranking-table_info{
    margin-left: 10%;
    width: 80%;
    text-align: center;
}

.reward-content{
    text-align: center;
    margin: 20px;
}
</style>