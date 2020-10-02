<template>
    <div class="side-contents">
            <h3>マイフォルダーリポジトリ</h3>
        <div class="folder-content">
            <div class="" v-for="shareReport in shareReports" :key="shareReport">
                <nuxt-link :to="{name: 'folders-id',params:{id:shareReport.subject}}">
                    <el-badge :value="6" class="item folder-repository" type="primary">
                        <el-button size="small">{{shareReport.subject}}</el-button>
                    </el-badge>
                </nuxt-link>
            </div>
            <!-- <div class="">
                <nuxt-link :to="{name: 'folders-id',params:{id:'線形代数小レポート_0802'}}">
                <el-badge :value="4" class="item folder-repository" type="primary">
                    <el-button size="small">線形代数小レポート_0802</el-button>
                </el-badge>
                </nuxt-link>
            </div>
            <div class="">
                <nuxt-link :to="{name: 'folders-id',params:{id:'情報倫理期末レポート'}}">
                <el-badge :value="4" class="item folder-repository" type="primary">
                    <el-button size="small">情報倫理期末レポート</el-button>
                </el-badge>
                </nuxt-link>
            </div>
            <div class="">
                <el-badge :value="2" class="item folder-repository" type="primary">
                    <el-button size="small">解析Ⅰ演習問題レポート</el-button>
                </el-badge>
            </div>
            <div class="">
                <el-badge :value="1" class="item folder-repository" type="primary">
                    <el-button size="small">化学最終レポート</el-button>
                </el-badge>
            </div>
            <div class="">
                <el-badge :value="0" class="item folder-repository" type="primary">
                    <el-button size="small">情報工学通信実験2</el-button>
                </el-badge>
            </div>
            <div class="">
                <el-badge :value="0" class="item folder-repository" type="primary">
                    <el-button size="small">線形代数小レポート_0807</el-button>
                </el-badge>
            </div>
            <div class="">
                <el-badge :value="0" class="item folder-repository" type="primary">
                    <el-button size="small">情報倫理中間レポート</el-button>
                </el-badge>
            </div>
            <div class="">
                <el-badge :value="0" class="item folder-repository" type="primary">
                    <el-button size="small">解析Ⅱ</el-button>
                </el-badge>
            </div>
            <div class="">
                <el-badge :value="0" class="item folder-repository" type="primary">
                    <el-button size="small">化学中間レポート</el-button>
                </el-badge>
            </div> -->
        </div>

    </div>
</template>
<script>
import { db,firebase } from '~/plugins/firebase'
export default {
    data(){
        return{
            shareReports:[]
        }
    },
     mounted () {
        db.collection('reports').get()
            .then((querySnapshot) => {
            querySnapshot.forEach((doc) => {
                //TODO: web3で現在のメタマスクアカウントを取得する
                const shareUser = '0x5A2B93AB2bAe9D319b49d1AeB54840f1C8D0918c'
                   if(doc.data().shareUser == shareUser){
                    //    console.log(doc.data())
                    //    console.log("this shareUser is ",doc.data().shareUser)
                       this.shareReports.push(doc.data())
                       console.log(this.shareReport)

                   }
            })
            })
     }
}
</script>

<style scoped>
h3{
    text-align: center;
}
.folder-content{
    overflow: scroll;
}

.folder-repository{
    padding-left: 20px;
    margin: 10px;
}
.side-contents{
    background:#fff;
    height: 100%;
}

.upload-demo{
    width:auto;
    margin: 10px;
}
</style>