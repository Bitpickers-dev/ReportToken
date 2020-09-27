<template>
  　
  <div class="app-layout">
    <Header/>
    <div class="main-contents">
      <div class="side-content">
        <Folder/>
      </div>
      <div class="main-content">
        <h1>ウォレット</h1>
        <div class="home-btn">
          <el-button type="primary">
            <nuxt-link to="/homePage" class="link-detail">HOMEへ</nuxt-link>
          </el-button>
        </div>
        <div class="about-account">
          <h4>アカウント</h4>
          <el-avatar src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png"></el-avatar>
          <p>0x5A2B93AB2bAe9D319b49d1AeB54840f1C8D0918c</p>
        </div>
        <h3>所持中のレポートークン:50RPT</h3>
        <div class="wallet_btn">
          <el-button type="primary" icon="el-icon-s-promotion" class="send_btn">送信する</el-button>
          <el-button type="primary" icon="el-icon-sell" class="receive_btn">取得する</el-button>
        </div>
        <div class="wallet-detail_content">
          <el-tabs type="card">
            <el-tab-pane label="送信履歴">
              <p>2020/08/24 10RPT to 0x5A2B93AB2bAe9D319b49d1Adkrid40f1Cdaferfa</p>
              <p>2020/08/20 10RPT to 0x5A2B93AB2bAe9D319b49d1Adkrid40f1C8D0918c</p>
              <p>2020/08/15 10RPT to 0x5A2B93AB2bAe9D319b49daerfaerfaergd3r4f4r</p>
              <p>2020/08/02 10RPT to 0x5A2B93AB2bAe9D31afrfsergfrtghvd0495jeg94</p>
            </el-tab-pane>
            <el-tab-pane label="取得履歴">
              <p>2020/08/24 +50RPT from 0x5A2Bdkeijadofislerfjleiorfnse0f1C8D0918c</p>
              <p>2020/08/20 +40RPT from 0x5A2B93AB2bAe9D319b49d1Adkrid40f1C8D0918c</p>
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

var Web3 = require('web3');
var web3 = new Web3();
web3.setProvider(new web3.providers.HttpProvider('http://localhost:7545'));
web3.eth.defaultAccount = web3.eth.accounts[0]
//todo
//ABIを記述する

var _purchaseReport = web3.eth.contract(abi).at("0x9a935ACDB7bBa49D31F63A41093E2d62733E8591").transfer.sendTransaction("送信先のアドレス", 送りたい金額);
console.log(_purchaseReport);

var _purchaseToken = web3.eth.contract(abi).at("0x9a935ACDB7bBa49D31F63A41093E2d62733E8591").balance.sendTransaction("送信先のアドレス", 購入したい金額);
console.log(_purchaseToken);

var _withdraw = web3.eth.contract(abi).at("0x9a935ACDB7bBa49D31F63A41093E2d62733E8591").balance.sendTransaction("送信先のアドレス", 購入したい金額);
console.log(_withdraw);

export default {
  components: {
    Header
  },
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
