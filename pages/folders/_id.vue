<template>
  　
  <div class="app-layout">
    <Header />
    <div class="main-contents">
      <div class="main-content">
        <h1>レポート情報</h1>
        <p>{{ shareUserAddress }}</p>
        <p>レポートの識別子は{{ reportIndex }}</p>
        <div class="report-info">
          <Filecard :report="report" />
          <div class="report-table_info"></div>
          <div class="report-info_detail" v-if="report != null">
            <h3>レポートの詳細</h3>
            <h5>{{ report.university }}</h5>
            <p class="report-exp">{{ report.detail }}</p>
          </div>
          <el-button @click="getReport">レポートを見る</el-button>
          <div class="" v-if="reportHash != null">
            <h1>{{ reportHash }}</h1>
            <a :href="`https://ipfs.io/ipfs/${reportHash}`" target="brank"
              >レポートはこちら</a
            >
            <img
              :src="`https://ipfs.io/ipfs/${reportHash}`"
              alt="共有したレポートの画像"
              style="width: 20vw"
            />
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
import Filecard from "~/components/filecard.vue";
import { db, firebase } from "~/plugins/firebase";

export default {
  components: {
    Header,
    Filecard,
  },
  async mounted() {
    const reportId = this.$route.params.id;
    this.reportIndex = reportId.slice(-1);
    this.shareUserAddress = reportId.slice(0, 42);
    let accounts = await this.$web3.eth.getAccounts();
    this.userAddress = accounts[0];
    // console.log("repotIndex is ",this.reportIndex)
    // console.log("shareUserAddress is ",this.shareUserAddress)
    await db
      .collection("reports")
      .where("shareUser", "==", this.shareUserAddress)
      .get()
      .then((querySnapshot) => {
        querySnapshot.forEach((doc) => {
          // console.log(doc.data().index)
          if (this.reportIndex == doc.data().index) {
            this.reports.push(doc.data());
            this.report = this.reports[0];
          }
        });
      });
  },
  data() {
    return {
      reportIndex: null,
      shareUserAddress: null,
      userAddress: null,
      report: null,
      reports: [],
      reportHash: null,
      amount: null,
      sendValue: null,
      number: null,
    };
  },
  methods: {
    formatter(row, column) {
      return row.address;
    },

    async getReport() {
      if (this.shareUserAddress == this.userAddress) {
        let ret = await this.$reportInfoContract.methods
          .getOwnerReport(this.reportIndex)
          .call();
        console.log(ret);
        this.reportHash = ret;
      } else {
        let decimals = await this.$web3.utils.toBN(18);
        this.amount = 1000000000000;
        this.sendValue = await this.amount.valueOf(
          this.$web3.utils.toBN(10).pow(decimals)
        );
        let Ret = await this.$reportTokenContract.methods
          .transfer(this.shareUserAddress, this.sendValue)
          .send({ from: this.userAddress });
        console.log(this.$reportTokenContract);
        console.log(Ret);
        this.number = Ret;
        let ret = await this.$reportInfoContract.methods
          .getReport(this.reportIndex, this.shareUserAddress)
          .call();
        console.log(ret);
        this.reportHash = ret;
      }
    },
  },
};
</script>
<style>
.report-info {
  text-align: center;
}
.report-table_info {
  margin-left: 10%;
  width: 80%;
  text-align: center;
}
</style>
