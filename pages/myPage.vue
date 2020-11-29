<template>
  　
  <div class="app-layout">
    <Header />
    <div class="reward-content">
      <h3>ご褒美を受け取ってください</h3>
      <el-button style="text-align:center" @click="reward">テスト用のボタン</el-button>
    </div>
    <div class="main-contents">
      <div class="main-content__notuser" v-if="ownAddress == null">
        <el-alert
          title="エラー"
          type="error"
          description="Metamaskと連携ができないためマイページが開けません。"
          show-icon
          :closable="false"
        >
        </el-alert>
      </div>
      <div class="main-content" v-if="ownAddress != null">
        <div class="about-account">
          <h4>アカウント</h4>
          <el-avatar
            src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png"
          ></el-avatar>
          <p>{{ ownAddress }}</p>
        </div>
        <h3>所持中のレポートークン:50RPT</h3>
        <div class="wallet_btn">
          <el-button type="primary" @click="dialog = true">購入する</el-button>
          <el-drawer
            title="トークンの購入量を指定してください"
            :before-close="handleClose"
            :visible.sync="dialog"
            direction="ltr"
            custom-class="demo-drawer"
            ref="drawer"
          >
            <div class="demo-drawer__content">
              <el-form :model="form">
                <el-form-item label="購入量" :label-width="formLabelWidth">
                  <el-input v-model="form.amount" autocomplete="off"></el-input>
                </el-form-item>
              </el-form>
              <div class="demo-drawer__footer">
                <el-button @click="cancelForm">キャンセル</el-button>
                <el-button
                  type="primary"
                  @click="$refs.drawer.closeDrawer()"
                  :loading="loading"
                >
                  {{ loading ? "購入しています ..." : "購入" }}
                </el-button>
              </div>
            </div>
          </el-drawer>
        </div>
        <div class="purchased-report">
          <h3>購入したレポート</h3>
          <Filecards :reports="purchasedReport" />
        </div>
        <div class="wallet-detail_content"></div>
      </div>
      <div class="side-content">
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
      ownAddress: null,
      dialog: false,
      loading: false,
      formLabelWidth: "80px",
      timer: null,
      inputNumber: 0,
      toAddress: null,
      amount: 0,
      purchaseValue: 0,
      sendValue: 0,
      ownAmount: 0,
      form: {
        amount: null,
      },
      purchasedReport: [],
      buying: [],
      count: 0,
    };
  },
  methods: {
    async reward() {
      let ret = await this.$reportTokenContract.methods
        .withdraw(this.ownAddress)
        .send({
          from: this.ownAddress,
        });
      console.log(ret)
  },

    async handleClose(done) {
      if (this.loading) {
        return;
      }
      await this.$confirm(this.form.amount + "RPTを本当に購入しますか？").then(
        (_) => {
          this.loading = true;
          this.timer = setTimeout(() => {
            done();
            // animation takes time
            setTimeout(() => {
              this.loading = false;
            }, 400);
          }, 2000);
        }
      );
      await this.purchaseToken().catch((_) => {});
    },
    async cancelForm() {
      this.loading = false;
      this.dialog = false;
      clearTimeout(this.timer);
    },
    async purchaseToken() {
      let decimals = await this.$web3.utils.toBN(18);
      this.amount = await this.$web3.utils.toBN(this.form.amount);
      this.sendValue = await this.amount.valueOf(
        this.$web3.utils.toBN(10).pow(decimals)
      );
      let ret = await this.$reportTokenContract.methods
        .purchaseToken(this.ownAddress, this.sendValue)
        .send({
          from: this.ownAddress,
          value: this.sendValue,
        });
      this.number = ret;
    },
  },
  async mounted() {
    let accounts = await this.$web3.eth.getAccounts();
    this.ownAddress = accounts[0];
    if (this.ownAddress != null) {
      db.collection("users")
        .doc(this.ownAddress)
        .collection("buying_list")
        .get()
        .then((querySnapshot) => {
          querySnapshot.forEach((doc) => {
            this.buying.push(doc.data());
          });
        });
      await db
        .collection("reports")
        .get()
        .then((querySnapshot) => {
          querySnapshot.forEach((doc) => {
            if (doc.data().shareUser == this.ownAddress) {
              this.shareReports.push({ id: doc.id, ...doc.data() });
            }
            if (this.buying.length != 0 && this.buying != null) {
              let count = 0;
              for (let i = 0; i < this.buying.length; i++) {
                if (this.buying[count].report_doc == doc.id) {
                  this.purchasedReport.push(doc.data());
                }
                count++;
              }
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
  min-height: 700px;
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

element.style {
  width: 26%;
}

.el-drawer.ltr,
.el-drawer__container {
  top: 50px;
  bottom: 1;
  width: 50%;
  height: 57%;
}

.el-input__inner {
  width: 93%;
  margin-left: -30px;
}
</style>
