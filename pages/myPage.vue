<template>
  　
  <div class="app-layout">
    <Header />
    <div class="main-contents">
      <div class="main-content__notuser" v-if="userAddress == null">
        <el-alert
          title="エラー"
          type="error"
          description="Metamaskと連携ができないためマイページが開けません。"
          show-icon
          :closable="false"
        >
        </el-alert>
      </div>
      <div class="main-content" v-if="userAddress != null">
        <div class="about-account">
          <h4>アカウント</h4>
          <el-avatar
            src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png"
          ></el-avatar>
          <p>{{ userAddress }}</p>
        </div>
        <h3>所持中のレポートークン:50RPT</h3>
        <div class="wallet_btn">

          <el-button type="primary" icon="el-icon-sell" class="receive_btn"
            >取得する</el-button
          >
        </div>
        <div class="wallet-detail_content"></div>
      </div>
      <div class="side-content" v-if="userAddress != null">
        <Folder :shareReports="shareReports" />
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
      number: 0,
      shareReports: [],
      userAddress: null,
    };
  },
  methods: {
    purchaseToken: async function () {
      let ret = await this.$reportTokenContrat.methods
        .purchaseToken(ownAddress, sendValue)
        .call();
      this.number = ret;
    },
  },
  async mounted() {
    let accounts = await this.$web3.eth.getAccounts();
    this.userAddress = accounts[0];
    if (this.userAddress != null) {
      db.collection("reports").onSnapshot((snapshot) => {
        snapshot.docChanges().forEach((change) => {
          const doc = change.doc;
          if (
            change.type === "added" &&
            doc.data().shareUser == this.userAddress
          ) {
            this.shareReports.push({ id: doc.id, ...doc.data() });
          }
        });
      });
    }
  },
};
</script>

<style>
body {
  margin: 0;
}

h1 {
  padding-left: 10px;
  text-align: center;
}

p {
  margin-left: 10px;
}
.main-contents {
  min-height: 600px;
}

.side-content {
  width: 300px;
  height: 400px;
  z-index: 1;
}

.about-account {
  text-align: center;
}

.wallet_btn {
  text-align: center;
}

.wallet-detail_content {
  overflow: scroll;
}
</style>
