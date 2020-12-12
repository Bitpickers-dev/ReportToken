<template>
  　
  <div class="app-layout">
    <Header />
    <div class="main-contents">
      <div class="main-content">
        <h1>レポート情報</h1>
        <div class="report-info">
          <Filecard :report="report" />
          <div class="report-table_info"></div>
          <div class="report-info_detail" v-if="report != null">
            <h3>レポートの詳細</h3>
            <h5>{{ report.university }}</h5>
            <p class="report-exp">{{ report.detail }}</p>
            <div class=""  v-if="
                report.amount != 0 && report.amount > ownAmount / 100000000000
              ">

            <h4>
              レポートの価格 :
              {{ report.amount }}RPT<br />しかし、あなたが持っているのは{{
                ownAmount / 100000000000
              }}RPTです。
            </h4>
                <el-button type="primary">
                  <nuxt-link to="/myPage" class="mypage-link"
                    >トークン購入ページへ</nuxt-link
                  >
                </el-button>
            </div>
            <h4
              v-if="
                report.amount != 0 && report.amount <= ownAmount / 100000000000
              "
            >
              レポートの価格 : {{ report.amount }}RPT<br />あなたは現在{{
                ownAmount / 100000000000
              }}RPT持っています
            </h4>
            <h4 v-if="report.amount == 0">
              このレポートは無償で見ることができます！
            </h4>
          </div>
          <div v-if="!canWatch">
            <el-button
              v-if="report != null && report.amount <= ownAmount / 100000000000"
              @click="getReport"
              >レポートを見る</el-button
            >
          </div>
          <div class="" v-if="reportHash != null">
            <iframe
              :src="`https://ipfs.io/ipfs/${reportHash}`"
              alt="共有したレポートの画像"
              width="75%"
              style="height: 1200px"
            ></iframe>
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
    this.ownAmount = await this.$reportTokenContract.methods
      .balanceOf(this.userAddress)
      .call();
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
    if (this.report.amount == 0) {
      this.canWatch = true;
      let ret = await this.$reportInfoContract.methods
        .getReport(this.reportIndex, this.shareUserAddress)
        .call();
      this.reportHash = ret;
      console.log(
        "買ってはいないけど、無償提供だハッシュ値は",
        this.reportHash
      );
    }
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
      if (this.buying.length > i) {
        console.log(this.report_doc);
        console.log(this.buying[i].report_doc);
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
        console.log(this.reportIndex);
        let ret = await this.$reportInfoContract.methods
          .getOwnerReport(this.reportIndex)
          .call();
        console.log(ret);
        this.reportHash = ret;
        console.log("fefefe", ret);
        break;
      }
    }
  },
  data() {
    return {
      ownAmount: null,
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
      allReports: [],
    };
  },
  methods: {
    formatter(row, column) {
      return row.address;
    },

    async getReport() {
      if (this.shareUserAddress != this.userAddress) {
        let decimals = await this.$web3.utils.toBN(18);
        this.amount = 100000000000 * this.report.amount;
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
        await db
          .collection("reports")
          .doc(this.report_doc)
          .update({
            downloads: firebase.firestore.FieldValue.increment(1),
            currentDownloads: firebase.firestore.FieldValue.increment(1),
          });
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
.mypage-link {
  text-decoration: none;
  color: white;
  font-size: 20px;
  padding: 8px;
}
.report-table_info {
  margin-left: 10%;
  width: 80%;
  text-align: center;
}
</style>
