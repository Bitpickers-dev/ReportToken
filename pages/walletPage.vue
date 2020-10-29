<template>
  　
  <div class="app-layout">
    <Header/>
    <div class="main-contents">
      <div class="side-content">
        <Folder/>
      </div>
      <div class="main-content">
        <div class="about-account">
          <h4>アカウント</h4>
          <el-avatar src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png"></el-avatar>
          <p>0x5A2B93AB2bAe9D319b49d1AeB54840f1C8D0918c</p>
        </div>
        <h3>所持中のレポートークン:50RPT</h3>
        <div class="wallet_btn">

          <!--          <h2>Token Address</h2>-->
          <!--          <input type="text" id="token-address" size="80" oninput="onAddressChange()">-->
          <!--          <h2>Recipients Address</h2>-->
          <!--          <input type="text" id="to-address" size="80">-->
          <!--          <h2>Decimals</h2>-->
          <!--          <input type="number" id="decimals" size="40" readonly="">-->
          <!--          <h2>Amount</h2>-->
          <!--          <input type="number" id="amount" size="40">-->
          <!--          <div>-->
          <!--            <button id="send" onclick="send()">Send ERC20 Token</button>-->
          <!--          </div>-->

          <el-button type="primary" icon="el-icon-sell" class="receive_btn">取得する</el-button>
        </div>
        <div class="wallet-detail_content">
          <el-tabs type="card">
            <el-tab-pane label="送信履歴">
              <p>2020/08/24 10RPT to 0x5A2B93AB2bAe9D319b49d1Adkrid40f1Cdaferfa</p>
            </el-tab-pane>
            <el-tab-pane label="取得履歴">
              <p>2020/08/24 +50RPT from 0x5A2Bdkeijadofislerfjleiorfnse0f1C8D0918c</p>
            </el-tab-pane>
          </el-tabs>
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
      number: 0,
      inputNumber: 0
    }
  },
  methods: {
    getNumber: async function () {
      let ret = await this.$reportTokenContract.methods.get().call()
      console.log(this.$reportTokenContract)
      console.log(ret)
      this.number = ret
    },

    purchaseToken: async function () {
      let ret = await this.$reportTokenContrat.methods.purchaseToken(ownAddress, sendValue).call()
      console.log(this.$reportTokenContract)
      console.log(ret)
      this.number = ret
    },

    setNumber: async function () {
      let accounts = await this.$web3.eth.getAccounts()
      let account = accounts[0]
      console.log(accounts)
      console.log(this.inputNumber)
      let ret = await this.$reportTokenContract.methods.set(this.inputNumber).send({from: account})
      console.log(ret)
    },
  },

  mounted() {
    console.log('Current Block Number')
    this.$web3.eth.getBlockNumber().then(console.log)
  }


}
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
.side-content{
  width: 300px;
}

.about-account {
  text-align: center;
}

.wallet_btn {
  text-align: center;
}

.wallet-detail_content {
  max-height: 50vh;
  overflow: scroll;
}
</style>
