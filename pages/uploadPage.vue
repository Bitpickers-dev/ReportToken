<template>
  　
  <div class="app-layout">
    <Header/>
    <div class="main-contents">
      <div class="main-content">
        <div class="step-content">
          <el-steps :active="active" finish-status="success" align-center>
            <el-step title="ステップ1" description="レポート情報の登録"></el-step>
            <el-step title="ステップ2" description="レポートアップロード"></el-step>
            <el-step title="ステップ3" description="最終確認"></el-step>
          </el-steps>
          <div class="input-form_contents" v-if="this.active == 0">
            <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="120px" class="demo-ruleForm">
              <el-form-item label="大学名" prop="university" style="margin-bottom:5px;">
                <el-input v-model="ruleForm.university">{{ this.ruleForm.university }}</el-input>
              </el-form-item>
              <el-form-item label="学年" prop="grade" style="margin-bottom:10px;">
                <el-checkbox-group v-model="ruleForm.grade">
                  <el-checkbox label="B1(1年)" name="grade"></el-checkbox>
                  <el-checkbox label="B2(2年)" name="grade"></el-checkbox>
                  <el-checkbox label="B3(3年)" name="grade"></el-checkbox>
                  <el-checkbox label="B4(4年)" name="grade"></el-checkbox>
                  <el-checkbox label="M1(1年)" name="grade"></el-checkbox>
                  <el-checkbox label="M2(2年)" name="grade"></el-checkbox>
                </el-checkbox-group>
              </el-form-item>
              <el-form-item label="セメスター情報" prop="semester" style="margin-bottom:20px;">
                <el-checkbox-group v-model="ruleForm.semester">
                  <el-checkbox label="1Q" name="semester"></el-checkbox>
                  <el-checkbox label="2Q" name="semester"></el-checkbox>
                  <el-checkbox label="3Q" name="semester"></el-checkbox>
                  <el-checkbox label="4Q" name="semester"></el-checkbox>
                  <el-checkbox label="前期" name="semester"></el-checkbox>
                  <el-checkbox label="後期" name="semester"></el-checkbox>
                </el-checkbox-group>
              </el-form-item>
              <el-form-item label="科目名" prop="subject">
                <el-input v-model="ruleForm.subject">{{ this.ruleForm.subject }}</el-input>
              </el-form-item>
              <el-form-item label="レポートの詳細" prop="detail">
                <el-input type="textarea" v-model="ruleForm.detail"></el-input>
              </el-form-item>
              <el-form-item label="ユーザー名表示" prop="isDisplay">
                <el-switch v-model="ruleForm.isDisplay"></el-switch>
              </el-form-item>

              <el-form-item class="next-step_btn">
                <el-button type="primary" @click="submitForm('ruleForm')">レポートの選択へ進む</el-button>
                <el-button @click="resetForm('ruleForm')">リセット</el-button>
              </el-form-item>
            </el-form>
          </div>
          <div class="upload-contents" v-if="this.active == 1">
            <p>科目名:{{ this.ruleForm.subject }}</p>
            <p>レポートの詳細:{{ this.ruleForm.detail }}</p>
            <form onSubmit="onSubmit">
              <input type="file" @change="captureFile" ref="file">


              <el-button style="margin-top: 12px;" @click="next">最終確認に進む</el-button>
              <el-button style="margin-top: 12px;" @click="back">戻る</el-button>
            </form>
          </div>
          <div class="confirm-contents" v-if="this.active == 2">
            <p>大学名:{{ this.ruleForm.university }}</p>
            <p>学年:{{ this.ruleForm.grade }}</p>
            <p>セメスター:{{ this.ruleForm.semester }}</p>
            <p>科目名:{{ this.ruleForm.subject }}</p>
            <p>レポートの詳細:{{ this.ruleForm.detail }}</p>
            <p>ユーザー名の表示:{{ this.ruleForm.isDisplay }}</p>
            <el-popconfirm
              @onConfirm="reportUpload"
              confirmButtonText='確認'
              cancelButtonText='キャンセル'
              icon="el-icon-info"
              iconColor="red"
              title="本アプリはユーザー様に生じた損害について、本アプリの故意または重大な過失を原因とする場合を除いて、一切の責任を負いません。"
            >
              <el-button slot="reference">レポートを共有</el-button>
            </el-popconfirm>
            <el-button style="margin-top: 12px;" @click="back">戻る</el-button>
          </div>
          <div class="finish-contents" v-if="this.active == 3">
            <h1>あなたの貢献度が上がりました。</h1>
            <h3>お疲れ様でした。レポートが共有されました。</h3>
            <h2>誰かにあなたのレポートが閲覧された時、あなたにレポートークンが送信されます</h2>
            <!-- 非同期処理をしなきゃいけない。ロードを数秒間入れるとか... -->
            <div class="display-hash" v-if="ipfsHash != ''">
              <p>共有されたレポートのハッシュ値は{{ ipfsHash }}です!</p>
              <a :href="`https://ipfs.io/ipfs/${ipfsHash}`" target="brank">レポートはこちら</a>
              <img :src="`https://ipfs.io/ipfs/${ipfsHash}`" alt="共有したレポートの画像" style="width:20vw;">
              <div class="home-btn">
                <el-button type="primary">
                  <nuxt-link to="/homePage" class="link-detail">HOMEへ</nuxt-link>
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
  </div>
</template>
<script>
import Header from '~/components/header.vue'
import {ipfs} from '~/plugins/ipfs'
import { db,firebase } from '~/plugins/firebase'

export default {
  components: {
    Header
  },
  data() {
    return {
      setBuffer: [],
      ipfsHash: '',
      user:[],
      active: 0,
      visible: false,
      ruleForm: {
        university: '',
        grade: [],
        semester: [],
        subject: '',
        detail: '',
        isDisplay: false,
      },
      rules: {
        university: [
          {required: true, message: '大学名を記入してください', trigger: 'blur'},
        ],
        grade: [
          {type: 'array', required: true, message: '最低でも一つの学年を選択してください', trigger: 'change'}
        ],
        semester: [
          {type: 'array', required: true, message: '最低でも一つのセメスター情報を選択してください', trigger: 'change'}
        ],
        subject: [
          {required: true, message: '科目名を記入してください', trigger: 'blur'},
        ],
        detail: [
          {required: true, message: 'レポートの詳細を記入してください', trigger: 'blur'}
        ],
      },

    };
  },
  async mounted(){
    let accounts = await this.$web3.eth.getAccounts()
    this.userAddress = accounts[0]
    const userRef = db.collection('users').doc(this.userAddress)
        userRef.get().then((doc)=>{
          this.user = doc.data()
        })
  },

  methods: {
    captureFile(event) {
      const files = this.$refs.file;
      const fileImg = files.files[0];

      event.preventDefault()
      const file = event.target.files[0]
      const reader = new window.FileReader()
      //ファイルを読み取ってバッファに変えることでIPFSに送信できる
      reader.readAsArrayBuffer(file)

      reader.onloadend = () => {
        this.setBuffer = Buffer(reader.result)
      }

    },
    async reportUpload() {
      //   IPFSにアップロード
      await ipfs.add(this.setBuffer).then((value) => {
        this.ipfsHash = value.path
      })
      let ret = await this.$reportInfoContract.methods.setReport(this.ipfsHash).send({from: this.userAddress})
      console.log(ret)
      //   firestoreにレポートの情報を追加する
      await db.collection('users').doc(this.userAddress).update({
          //シェアしたレポートの数をインクリメントする。これがレポートのインデックスになる
          shares: firebase.firestore.FieldValue.increment(1),
      })
        this.user.shares++
      await db.collection('reports').add({
          university: this.ruleForm.university,
          grade: this.ruleForm.grade,
          semester: this.ruleForm.semester,
          subject: this.ruleForm.subject,
          detail: this.ruleForm.detail,
          index: this.user.shares,
          shareUser: this.user.address,
          downloads: 0
      })
      if (this.active++ > 2) this.active = 0;
      this.$notify({
        title: '成功',
        message: 'レポートの共有に成功しました！',
        type: 'success'
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
          console.log('error submit!!');
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
          console.log('error submit!!');
          return false;
        }
      });
    },
    resetForm(formName) {
      //   フォームのリセット
      this.$refs[formName].resetFields();
    },
    handleClose(done) {
      this.$confirm('本当に閉じてもよろしいですか？')
        .then(_ => {
          done();
        })
        .catch(_ => {
        });
    }
  }
}
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

.next-step_btn {
  text-align: center;
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
