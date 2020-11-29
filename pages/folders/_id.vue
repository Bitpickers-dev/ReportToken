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
          <el-button v-if="!canWatch" @click="getReport"
            >レポートを見る</el-button
          >
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
    await db
      .collection("reports")
      .where("shareUser", "==", this.shareUserAddress)
      .get()
      .then((querySnapshot) => {
        querySnapshot.forEach((doc) => {
          if (this.reportIndex == doc.data().index) {
            this.reports.push(doc.data());
            this.report_doc = doc.id;
            this.report = this.reports[0];
          }
        });
      });
    await db
      .collection("reports")
      .get()
      .then((querySnapshot) => {
        querySnapshot.forEach((doc) => {
            this.allReports.push(doc.data());
        });
      });
    await db
      .collection("users")
      .doc(this.userAddress)
      .collection("buying_list")
      .get()
      .then((querySnapshot) => {
        querySnapshot.forEach((doc) => {
          this.buying.push(doc.data());
        });
      });
    for (let i = 0; i < this.allReports.length; i++) {
      if(this.buying.length > i){
        console.log(this.report_doc)
        console.log( this.buying[i].report_doc)
        if (this.report_doc == this.buying[i].report_doc) {
          this.canWatch = true;
          let ret = await this.$reportInfoContract.methods
            .getReport(this.reportIndex, this.shareUserAddress)
            .call();
          this.reportHash = ret;
          break;
        }
      }
      if (this.shareUserAddress == this.userAddress) {
        this.canWatch = true;
        console.log(this.reportIndex)
        let ret = await this.$reportInfoContract.methods
          .getOwnerReport(this.reportIndex)
          .call();
          console.log(ret)
        this.reportHash = ret;
        console.log("fefefe",ret)
        break;
      }
    }
  },
  data() {
    return {
      canWatch: false,
      reportIndex: null,
      shareUserAddress: null,
      userAddress: null,
      report: null,
      reports: [],
      reportHash: null,
      amount: null,
      sendValue: null,
      number: null,
      report_doc: null,
      buying: [],
      allReports:[]
    };
  },
  methods: {
    formatter(row, column) {
      return row.address;
    },

    async getReport() {
      if (this.shareUserAddress != this.userAddress) {
        let decimals = await this.$web3.utils.toBN(18);
        this.amount = 1000000000000;
        this.sendValue = await this.amount.valueOf(
          this.$web3.utils.toBN(10).pow(decimals)
        );
        //TODO: トークンがなかったらmyPageに誘導
        let Ret = await this.$reportTokenContract.methods
          .transfer(this.shareUserAddress, this.sendValue)
          .send({ from: this.userAddress });
        this.number = Ret;
        await db
          .collection("users")
          .doc(this.userAddress)
          .collection("buying_list")
          .add({
            report_doc: this.report_doc,
            buyAt: new Date(),
          });

          // ダウンロード数が+1される
        await db.collection('reports').doc(this.report_doc).update({
          downloads: firebase.firestore.FieldValue.increment(1),
          currentDownloads: firebase.firestore.FieldValue.increment(1),
        })
        let ret = await this.$reportInfoContract.methods
          .getReport(this.reportIndex, this.shareUserAddress)
          .call();
        this.reportHash = ret;
      } else {
        console.log("error!");
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
