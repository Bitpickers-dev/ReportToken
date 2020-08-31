<template>
    <div class="calousel">
        <el-carousel :interval="15000" arrow="always">
          <el-carousel-item v-for="item in 8" :key="item">
              <div v-if="item == 1">
                <h1>レポートークンチュートリアル</h1>
                <p>本アプリの使い方のチュートリアルです。</p>
                <p>使い方をすでに知っている方はロゴをクリックしてレポートークンを始めてください。</p>
                <div class="img-center">
                    <nuxt-link to="/homePage" class="link-detail">
                      <img src="~/assets/images/reportoken-tutorial.png" style="width:130px;height:auto;">
                    </nuxt-link>
                </div>
              </div>
              <div v-if="item == 2">
                <h1>{{item-1}}.MetamaskをChromeに追加する</h1>
                <p>本アプリはMetamaskと連携しています。MetamaskとはGoogleChromeの拡張機能です。</p>
                <p>⚠︎Metamaskを追加しないと本アプリは使用することができません。</p>
                <p>下の画像をクリックでMetamaskをChromeに追加</p>
                <div class="img-center">
                   <a href="https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn?hl=ja" class="link-detail" target="blank">
                      <img src="~/assets/images/metamask.svg" style="width:100px;height:auto;">
                   </a>
                </div>
              </div>
              <div v-if="item == 3">
                <h1>{{item-1}}.ETHを取得する</h1>
                <p>レポートを取得するにはレポートークンが必要です。レポートークンはETHを使って取得することができます。</p>
                <p>ETH(イーサ)は暗号資産であり、Metamaskをインストールしている人は誰でも購入することができます。</p>
                <div class="img-center">
                      <img src="~/assets/images/b0307.png" style="width:130px;height:auto;margin:0 auto;">
                </div>
              </div>
              <div v-if="item == 4">
                <h1>{{item-1}}.レポートークンを取得する</h1>
                <p>所有しているETHを使ってレポートークンを取得します。</p>
                <p style="padding-bottom:0;">レポートークンを見たいレポートに送信することによってレポートを見ることができます。</p>
                <div class="img-center">
                      <img src="~/assets/images/b0301.png" style="width:160px;height:auto;margin:0 auto;padding-top:0;">
                </div>
              </div>
              <div v-if="item == 5">
                <h1>{{item-1}}.レポートを探す</h1>
                <p>自分が見たいと思うレポートを検索します。</p>
                <p>先ほど取得したレポートークンを送信してレポートを見ます。</p>
                <div class="img-center">
                      <img src="~/assets/images/b0208.png" style="width:130px;height:auto;margin:0 auto;padding-top:0;">
                </div>
              </div>
              <div v-if="item == 6">
                <h1>{{item-1}}.レポートを見る</h1>
                <p>所持しているレポートークンを送信して共有されたレポートを見ることができます。</p>
                <p>共有してくれた相手にはレポートークンが送信されます。</p>
                <h4 style="text-align:center;margin:0;padding:0;padding-top:5px">もう一人では、悩まない。</h4>
                <div class="img-flex">
                      <img src="~/assets/images/b0423.png" style="width:130px;height:auto;padding-top:0;">
                      <img src="~/assets/images/b0424.png" style="width:130px;height:auto;padding-top:0;">
                </div>
              </div>
              <div v-if="item == 7">
                <h1>{{item-1}}.レポートを共有する</h1>
                <p>今度はあなたが書いたレポートを共有しましょう!</p>
                <p>誰かがきっとあなたのレポートを求めています。レポートが閲覧されたらレポートークンを取得できます。</p>
                <h4 style="text-align:center;margin:0;padding:0;padding-top:5px">もう一人では、悩ませない。</h4>
                <div class="img-flex">
                      <img src="~/assets/images/b0423.png" style="width:130px;height:auto;padding-top:0;">
                      <img src="~/assets/images/b0424.png" style="width:130px;height:auto;padding-top:0;">
                </div>
              </div>
              <div v-if="item == 8">
                <h1>ここでチュートリアルは終了です。お疲れ様でした</h1>
                <h4>本アプリではセメスターで頑張った人へのご褒美があります</h4>
                <p>本アプリに貢献した度合いを示すPoC(Proof of Contribute)という独自アルゴリズムを開発しました。</p>
                <p>PoCを使ってセメスター毎にランキングを作成し、上位に入った方にご褒美としてETHを還元します。</p>
                <h4>
                    <a href="https://docs.google.com/document/d/10qbXv29_khkfTspkmpGD7JL8YUpoq1gE8EWXJfOIKCg/edit" class="link-detail" style="margin:0;padding:0">詳しくはこちら</a>
                </h4>
                <div class="img-center">
                      <img src="~/assets/images/b0550.png" style="width:130px;height:auto;margin:0 auto;padding-top:0;" class="tutorial-last_image">
                </div>
              </div>
              
          </el-carousel-item>
        </el-carousel>
      </div>
</template>

<script>
export default {
    
}
</script>

<style scoped>
    h1{
        text-align: center;
    }
    h2{
        text-align: center;
    }
    h4{
        text-align: center;
        padding: 0;
        margin: 0;
    }
    p{
        text-align: center;
        padding: 0;
        margin: 0;
    }
      .el-carousel__item h3{
        color: #475669;
        font-size: 18px;
        opacity: 0.75;
        line-height: 300px;
        margin: 0;
      }

      .el-carousel__item:nth-child(2n) {
        background-color: #d3dce6;
      }

      .el-carousel__item:nth-child(2n+1) {
        background-color: #c4e1ff;
      }
      .home-btn{
        text-align: center;
        padding: 10px;
      }
      .img-center{
          text-align: center;
      }
      .link-detail{
          color: black;
      }
      .img-flex{
          display: flex;
          margin: 0 auto;
          width: 260px;
      }
      .tutorial-last_image{
        
      }
</style>