<template>
    　<div class="app-layout">
            <Header />
        <div class="main-contents">
            <div class="side-content">
            <Folder />
            </div>
    <div class="main-content">
       <h1>共有</h1>
             <div class="home-btn">
                <el-button type="primary">
                        <nuxt-link to="/homePage" class="link-detail">HOMEへ</nuxt-link>
                </el-button>
             </div>
             <div class="step-content">
                <el-steps :active="active" finish-status="success" align-center>
                <el-step title="ステップ1"  description="レポート情報の登録"></el-step>
                <el-step title="ステップ2" description="レポートアップロード"></el-step>
                <el-step title="ステップ3" description="最終確認"></el-step>
                </el-steps>
                <!-- <div class="input-form_contents"  v-if="this.active == 0">
                    <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="120px" class="demo-ruleForm">
                    <el-form-item label="大学名" prop="university" style="margin-bottom:5px;">
                        <el-input v-model="ruleForm.university">{{this.ruleForm.university}}</el-input>
                    </el-form-item>
                    <el-form-item label="学年" prop="grade" style="margin-bottom:10px;">
                        <el-checkbox-group v-model="ruleForm.grade">
                        <el-checkbox label="B1(学士1年)" name="grade"></el-checkbox>
                        <el-checkbox label="B2(学士2年)" name="grade"></el-checkbox>
                        <el-checkbox label="B3(学士3年)" name="grade"></el-checkbox>
                        <el-checkbox label="B4(学士4年)" name="grade"></el-checkbox>
                        <el-checkbox label="M1 (修士1年)" name="grade"></el-checkbox>
                        <el-checkbox label="M2(修士2年)" name="grade"></el-checkbox>
                        </el-checkbox-group>
                    </el-form-item>
                    <el-form-item label="セメスター情報" prop="semester" style="margin-bottom:20px;">
                        <el-checkbox-group v-model="ruleForm.semester">
                        <el-checkbox label="1Q(1クォーター)" name="semester"></el-checkbox>
                        <el-checkbox label="2Q(2クォーター)" name="semester"></el-checkbox>
                        <el-checkbox label="3Q(3クォーター)" name="semester"></el-checkbox>
                        <el-checkbox label="4Q(4クォーター)" name="semester"></el-checkbox>
                        <el-checkbox label="前期" name="semester"></el-checkbox>
                        <el-checkbox label="後期" name="semester"></el-checkbox>
                        </el-checkbox-group>
                    </el-form-item>
                    <el-form-item label="科目名" prop="subject">
                        <el-input v-model="ruleForm.subject">{{this.ruleForm.subject}}</el-input>
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
                </div> -->
                <div class="upload-contents" v-if="this.active == 1 || this.active == 0">
                    <!-- <p>科目名:{{this.ruleForm.subject}}</p>
                    <p>レポートの詳細:{{this.ruleForm.detail}}</p> -->
                    <!-- <el-upload
                    class="upload-demo"
                    ref="upload"
                    action="https://jsonplaceholder.typicode.com/posts/"
                    :auto-upload="false">
                    <el-button slot="trigger" size="small" type="primary">レポートを選択</el-button>
                    <div class="el-upload__tip" slot="tip">jpg/pngファイルで500kb未満にしてください</div>
                    </el-upload> -->
                    <form onSubmit="onSubmit">
                      <input type="file" @change="setImage" ref="file">
                      

                      <el-button style="margin-top: 12px;" @click="next">最終確認に進む</el-button>
                      <el-button style="margin-top: 12px;" @click="back">戻る</el-button>
                    </form>
                </div>
                <div class="confirm-contents" v-if="this.active == 2">
                    <!-- <p>大学名:{{this.ruleForm.university}}</p>
                    <p>学年:{{this.ruleForm.grade}}</p>
                    <p>セメスター:{{this.ruleForm.semester}}</p>
                    <p>科目名:{{this.ruleForm.subject}}</p>
                    <p>レポートの詳細:{{this.ruleForm.detail}}</p>
                    <p>ユーザー名の表示:{{this.ruleForm.isDisplay}}</p> -->
                    <el-popconfirm
                    @onConfirm = "reportUpload"
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
                    <h3>{{image}}</h3>
                    <div class="home-btn">
                        <el-button type="primary">
                                <nuxt-link to="/homePage" class="link-detail">HOMEへ</nuxt-link>
                        </el-button>
                    </div>
                </div>
             </div>
      </div>
            </div>
        </div>
</template>
<script>
import Header from '~/components/header.vue'
export default {
    components:{
        Header
    },
    data() {
      return {
        image:"",
        active: 0,
        visible: false,
        ruleForm: {
          university: '',
          grade: [],
          semester: [],
          subject:'',
          detail:'',
          isDisplay:false,
        },
        rules: {
          university: [
            { required: true, message: '大学名を記入してください', trigger: 'blur' },
          ],
          grade: [
              { type: 'array', required: true, message: '最低でも一つの学年を選択してください', trigger: 'change' }
          ],
          semester: [
              { type: 'array', required: true, message: '最低でも一つのセメスター情報を選択してください', trigger: 'change' }
          ],
          subject: [
              { required: true, message: '科目名を記入してください', trigger: 'blur' },
          ],
          detail: [
            {required: true, message: 'レポートの詳細を記入してください', trigger: 'blur' }
          ],
        },

      };
    },

    methods: {
      setImage(e) {
        const files = this.$refs.file;
        const fileImg = files.files[0];
        // if (fileImg.type.startsWith("image/")) {
        //   this.data.image = window.URL.createObjectURL(fileImg);
        //   console.log("data.image="+this.data.image)
        // }
        console.log("filesは"+files)
        console.log("typeは"+fileImg.type)
        console.log("fileimgは"+fileImg)
        this.image = fileImg.type

      },
      next() {
        if (this.active++ > 2) this.active = 0;
      },
      back() {
        if(this.active-- < 1) this.active = 0;
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
      reportUpload() {
        //   IPFSにアップロード
        // this.$refs.upload.submit();
        if (this.active++ > 2) this.active = 0;
        this.$notify({
          title: '成功',
          message: 'レポートの共有に成功しました！',
          type: 'success'
        });
      },
      handleClose(done) {
        this.$confirm('本当に閉じてもよろしいですか？')
          .then(_ => {
            done();
          })
          .catch(_ => {});
      }
    }
}
</script>
<style scoped>
.step-content{
    margin: 0;
    padding: 0;
    margin-left: 10%;
    width: 80%;
}
.input-form_contents{
    margin-top: 5px;
}
.next-step_btn{
    text-align: center;
}
.upload-contents{
    margin-top: 30px;
    text-align: center;
}
.confirm-contents{
    margin-top: 30px;
    margin-bottom: 30px;
    text-align: center;
}
    .home-btn{
      text-align: center;
      padding: 10px;
    }
</style>