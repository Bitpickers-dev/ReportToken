<template>
  <div class="app-layout">
    <Header />
    <div class="main-contents">
      <div class="main-content">
        <div class="serch-content">
          <el-input
            placeholder="レポート名で検索"
            v-model="input"
            class="serch-input"
          >
            <el-button slot="append" icon="el-icon-search" @click="getReport"></el-button>
          </el-input>
          <div class="result-search" v-if="searchWord != null">
            <h3 v-if="count == 0">Oops! {{searchWord}}の検索結果は0でした。<br>あなたが最初の共有者になりませんか？</h3>
            <h3 v-if="count != null && count != 0">{{searchWord}}の検索結果は{{count}}件見つかりました。</h3>
          <div v-if="count != null && count != 0" class="rank-content">
            <Filecards :reports="reports" />
          </div>
          </div>
        </div>
      </div>
    </div>
    <Upload />
    <Footer />
  </div>
</template>
<script>
import Header from "~/components/header.vue";
import { db, firebase } from "~/plugins/firebase";


export default {
  components: {
    Header,
  },
  data() {
    return {
      input: "",
      searchWord:"",
      count:null,
      reports:[],
    };
  },
  methods: {
    async getReport(){
      console.log(this.input)
      this.count = 0
      this.searchWord = this.input
      //TODO: get report
      await db
        .collection("reports")
        .where("subject", "==", this.searchWord)
        .get()
        .then((querySnapshot) => {
          querySnapshot.forEach((doc) => {
              this.reports.push(doc.data());
              this.count++
          });
        });
    }
  },
};
</script>
<style scoped>
.main-contents {
  min-height: 600px;
}
.serch-content {
  text-align: center;
}
.serch-input {
  padding: 10px;
  padding-top: 10px;
  width: 400px;
}
</style>
