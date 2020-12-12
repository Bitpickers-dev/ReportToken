<template>
  　
  <div class="app-layout">
    <Header />
    <div class="main-contents">
      <div class="main-content">
        <div class="step-content">
          <el-steps :active="active" finish-status="success" align-center>
            <el-step
              title="ステップ1"
              description="レポート情報の登録"
            ></el-step>
            <el-step
              title="ステップ2"
              description="レポートアップロード"
            ></el-step>
            <el-step title="ステップ3" description="最終確認"></el-step>
          </el-steps>
          <div class="input-form_contents" v-if="this.active == 0">
            <el-form
              :model="ruleForm"
              :rules="rules"
              ref="ruleForm"
              label-width="150px"
              class="demo-ruleForm"
            >
              <el-form-item
                label="大学名"
                prop="university"
                style="margin-bottom: 5px"
              >
                <el-input v-model="ruleForm.university" class="input-form">{{
                  this.ruleForm.university
                }}</el-input>
              </el-form-item>
              <el-form-item label="科目名" prop="subject">
                <el-input v-model="ruleForm.subject" class="input-form">{{
                  this.ruleForm.subject
                }}</el-input>
              </el-form-item>
              <el-form-item label="レポートの詳細" prop="detail">
                <el-input type="textarea" v-model="ruleForm.detail"></el-input>
              </el-form-item>
              <el-form-item label="レポートの価格(RPT)">
                <el-slider v-model="amount" :step="10"> </el-slider>
              </el-form-item>

              <el-form-item class="next-step_btn">
                <el-button type="primary" @click="submitForm('ruleForm')"
                  >レポートの選択へ進む</el-button
                >
                <el-button @click="resetForm('ruleForm')">リセット</el-button>
              </el-form-item>
            </el-form>
          </div>
          <div class="upload-contents" v-if="this.active == 1">
            <p>科目名:{{ this.ruleForm.subject }}</p>
            <p>レポートの詳細:{{ this.ruleForm.detail }}</p>
            <form onSubmit="onSubmit">
              <input type="file" @change="captureFile" ref="file" />

              <el-button style="margin-top: 12px" @click="next">確認</el-button>
              <el-button style="margin-top: 12px" @click="back">戻る</el-button>
            </form>
          </div>
          <div class="confirm-contents" v-if="this.active == 2">
            <p>大学名:{{ this.ruleForm.university }}</p>
            <p>学年:{{ this.ruleForm.grade }}</p>
            <p>レポートの詳細:{{ this.ruleForm.detail }}</p>
            <!-- <el-popconfirm
              @onConfirm="reportUpload"
              confirmButtonText="確認"
              cancelButtonText="キャンセル"
              icon="el-icon-info"
              iconColor="red"
              title="本アプリはユーザー様に生じた損害について、本アプリの故意または重大な過失を原因とする場合を除いて、一切の責任を負いません。"
            > -->
              <el-button slot="reference" @click="reportUpload">レポートを共有</el-button>
            <!-- </el-popconfirm> -->
            <el-button style="margin-top: 12px" @click="back">戻る</el-button>
          </div>
          <div class="finish-contents" v-if="this.active == 3">
            <h1>あなたの貢献度が上がりました。</h1>
            <h3>お疲れ様でした。レポートが共有されました。</h3>
            <h2>
              誰かにあなたのレポートが閲覧された時、あなたにレポートークンが送信されます
            </h2>
            <!-- 非同期処理をしなきゃいけない。ロードを数秒間入れるとか... -->
            <div class="display-hash" v-if="ipfsHash != ''">
              <iframe :src="`https://ipfs.io/ipfs/${ipfsHash}`" alt="共有したレポートの画像" width="100%" height="100vh" class="iframe-report"></iframe>
              <div class="home-btn">
                <el-button type="primary">
                  <nuxt-link to="/" class="link-detail"
                    >HOMEへ</nuxt-link
                  >
                </el-button>
              </div>
            </div>
            <div class="display-fash" v-else>
              <h5>ファイルをアップロード中です。しばらくお待ちください.....</h5>
            </div>
          </div>
        </div>
      </div>
    </div>
    <Footer />
  </div>
</template>
<script>
import Header from "~/components/header.vue";
import { ipfs } from "~/plugins/ipfs";
import { db, firebase } from "~/plugins/firebase";

export default {
  components: {
    Header,
  },
  data() {
    return {
      amount: 0,
      setBuffer: [],
      ipfsHash: "",
      user: [],
      active: 0,
      visible: false,
      ruleForm: {
        university: "",
        subject: "",
        detail: "",
      },
      rules: {
        university: [
          {
            required: true,
            message: "大学名を記入してください",
            trigger: "blur",
          },
        ],
        subject: [
          {
            required: true,
            message: "科目名を記入してください",
            trigger: "blur",
          },
        ],
        detail: [
          {
            required: true,
            message: "レポートの詳細を記入してください",
            trigger: "blur",
          },
        ],
      },
    };
  },
  async mounted() {
    let accounts = await this.$web3.eth.getAccounts();
    this.userAddress = accounts[0];
    const userRef = db.collection("users").doc(this.userAddress);
    userRef.get().then((doc) => {
      this.user = doc.data();
    });
  },

  methods: {
    captureFile(event) {
      const files = this.$refs.file;
      const fileImg = files.files[0];

      event.preventDefault();
      const file = event.target.files[0];
      const reader = new window.FileReader();
      //ファイルを読み取ってバッファに変えることでIPFSに送信できる
      reader.readAsArrayBuffer(file);

      reader.onloadend = () => {
        this.setBuffer = Buffer(reader.result);
      };
    },
    async reportUpload() {
      //   IPFSにアップロード
      console.log("success")
      await ipfs.add(this.setBuffer).then((value) => {
        this.ipfsHash = value.path;
      });
      console.log(this.ipfsHash)
      let ret = await this.$reportInfoContract.methods
        .setReport(this.ipfsHash)
        .send({ from: this.userAddress });
      //   firestoreにレポートの情報を追加する
      console.log(ret)
      await db
        .collection("users")
        .doc(this.userAddress)
        .update({
          //シェアしたレポートの数をインクリメントする。これがレポートのインデックスになる
          shares: firebase.firestore.FieldValue.increment(1),
        });
      this.user.shares++;
      await db.collection("reports").add({
        university: this.ruleForm.university,
        subject: this.ruleForm.subject,
        detail: this.ruleForm.detail,
        index: this.user.shares,
        shareUser: this.user.address,
        downloads: 0,
        currentDownloads:0,
        amount: this.amount
      });
      if (this.active++ > 2) this.active = 0;
      this.$notify({
        title: "成功",
        message: "レポートの共有に成功しました！",
        type: "success",
      });
    },
    next() {
      if (this.active++ > 2) this.active = 0;
    },
    back() {
      if (this.active-- < 1) this.active = 0;
    },
    submitForm(formName) {
      //   フォームの登録
      this.$refs[formName].validate((valid) => {
        if (valid) {
          if (this.active++ > 2) this.active = 0;
        } else {
          return false;
        }
      });
    },
    onSubmit(formName) {
      //   フォームの登録(うまく挙動しない)

      this.$refs[formName].validate((valid) => {
        if (valid) {
          if (this.active++ > 2) this.active = 0;
        } else {
          return false;
        }
      });
    },
    resetForm(formName) {
      //   フォームのリセット
      this.$refs[formName].resetFields();
    },
    handleClose(done) {
      this.$confirm("本当に閉じてもよろしいですか？")
        .then((_) => {
          done();
        })
        .catch((_) => {});
    },
  },
};
</script>
<style scoped>
.step-content {
  margin: 0;
  padding: 0;
  margin-left: 10%;
  width: 80%;
  padding-top: 50px;
}

.input-form_contents {
  margin-top: 5px;
}
.input-form{
  margin-left: 30px;
}

.next-step_btn {
  text-align: center;
}
.iframe-report{
  height: 100vh;
}

.upload-contents {
  margin-top: 30px;
  text-align: center;
}

.confirm-contents {
  margin-top: 30px;
  margin-bottom: 30px;
  text-align: center;
}
</style>
