<template>
    <div class="footer-main_content">
    <el-divider></el-divider>
      <div class="footer-content">
          <div class="footer-content_title">
            <nuxt-link to="/">
                    <img src="~/assets/images/reportoken-logo_header.png" class="reportoken-logo_footer">
            </nuxt-link>
            <p>全ての学生のための<br>レポート共有アプリ</p>
          </div>
          <div class="footer-content_about">
              <h5>About</h5>
              <nuxt-link to="/tutorialPage" class="footer-link">
                <p>レポートークンについて</p>
              </nuxt-link>
              <nuxt-link to="/tutorialPage" class="footer-link">
                <p>よくある質問</p>
              </nuxt-link>
              <nuxt-link to="/tutorialPage" class="footer-link">
                <p>使い方</p>
              </nuxt-link>
              <nuxt-link to="/tutorialPage" class="footer-link">
                <p>Bitpickersについて</p>
              </nuxt-link>
          </div>
          <div class="footer-content_legal">
            <h5>利用規約</h5>
            <nuxt-link to="/tutorialPage" class="footer-link">
                <p>プライバシーポリシー</p>
            </nuxt-link>  
          </div>
          <div class="footer-content_links">
            <h5>お問い合わせ</h5> 
            <nuxt-link to="/tutorialPage" class="footer-link">
                <p>開発ロードマップ</p>
            </nuxt-link>  
            <a href="https://github.com/Nishino0719/ReportToken" target="_brank" class="footer-link">
                <p>GitHub</p>
            </a>  
          </div>
      </div>
        <el-divider></el-divider>
        <div class="copyright-text">
            <p>&copy; Bitpickers</p>
        </div>
    </div>
</template>

<script>
export default {
     data() {
      return {
      };
    },
}
</script>

<style scoped>

.footer-main_content{
  height: 250px;
}
.footer-content{
  display: flex;
  background-color:#f4f4f4;
  height:180px
}

p{
    color: black;
    font-size: 0.9rem;
    padding-top: 15px;
}

.reportoken-logo_footer{
  padding: 10px;
  width: 50px;
  height: 50px;
  margin-left: 50px;

}

.footer-link{
    text-decoration: none;
}

.footer-link:hover{
    text-decoration: underline;
    
}

.footer-content_title{
    position: relative;
    /* margin: 0 auto; */
    margin-right: auto;
}
.footer-content_title p{
    color: #93a5b1;
    width: 150px;
    position: absolute;
    left: 50px;
    top: 50px;
    padding-top: 5px;
    font-size: 0.8rem;
}
.footer-content_about{
    margin: 0 auto;
}
.footer-content_legal{
    margin: 0 auto;

}
.footer-content_links{
    margin: 0 auto;

}
.copyright-text{
    text-align: center;
    padding-bottom: 20px;
    color: #93a5b1;
}


</style>