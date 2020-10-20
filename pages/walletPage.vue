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

          <h2>Token Address</h2>
          <input type="text" id="token-address" size="80" oninput="onAddressChange()">
          <h2>Recipients Address</h2>
          <input type="text" id="to-address" size="80">
          <h2>Decimals</h2>
          <input type="number" id="decimals" size="40" readonly="">
          <h2>Amount</h2>
          <input type="number" id="amount" size="40">
          <div>
            <button id="send" onclick="send()">Send ERC20 Token</button>
          </div>

          <el-button type="primary" icon="el-icon-s-promotion" class="send_btn">送信する</el-button>
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

var Web3 = require('web3');
var web3 = new Web3();
//Ganacheのデフォルトのポート番号は7545
web3.setProvider(new web3.providers.HttpProvider('http://localhost:7545'));
//コントラクトを呼び出すアカウントのアドレス
web3.eth.defaultAccount = web3.eth.accounts[0]

//コントラクトのABIを設定
const ReportToken = require("../build/contracts/ReportToken.json");
const abi = ReportToken.abi;
//コントラクトのアドレスを設定
const address = "0xE6cAC61b41fAB602E5C881eB36d86601433D21d5";
//コントラクトのインスタンスを設定
const contract = new web3.eth.Contract(abi, address);

if (process.browser) {
  // windowやdocumentを使う処理を記述
  const toAddress = document.getElementById('to-address').value;
  var amount = web3.toBN(document.getElementById('amount').value);
}

//トランザクション
let _purchaseToken = contract.methods.purchaseToken.sendTransaction("toAddress", amount);
console.log(_purchaseToken);

let _purchaseReport = contract.methods.purchaseReport.sendTransaction("toAddress", amount);
console.log(_purchaseReport);

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
