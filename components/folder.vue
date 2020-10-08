<template>
    <div class="side-contents">
            <h3>マイフォルダーリポジトリ</h3>
        <div class="folder-content">
            <div class="" v-for="shareReport in shareReports" :key="shareReport.index">
                <nuxt-link :to="{name: 'folders-id',params:{id:shareReport.shareUser + shareReport.index}}">
                    <el-badge :value=shareReport.downloads class="item folder-repository" type="primary">
                        <el-button size="small">{{shareReport.subject}}</el-button>
                    </el-badge>
                </nuxt-link>
            </div>
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
        // db.collection('reports').get()
        //     .then((querySnapshot) => {
        //     querySnapshot.forEach((doc) => {
        //         //TODO: web3で現在のメタマスクアカウントを取得する
        //         const userAddress = '0x5A2B93AB2bAe9D319b49d1AeB54840f1C8D0918c'
        //         // const userAddress = '0xcD3Ab788fC0343C63d393000Ae70Ece96336d4a0'
        //            if(doc.data().shareUser == userAddress){
        //             //    console.log(doc.data())
        //             //    console.log("this shareUser is ",doc.data().shareUser)
        //                this.shareReports.push(doc.data())
        //             //    console.log(this.shareReports)
        //            }
        //     })
        //     })
        db.collection('reports').onSnapshot((snapshot)=>{
            snapshot.docChanges().forEach((change)=>{
            const doc = change.doc
            const userAddress = '0x5A2B93AB2bAe9D319b49d1AeB54840f1C8D0918c'
            // const userAddress = '0xcD3Ab788fC0343C63d393000Ae70Ece96336d4a0'
          if(change.type === 'added' && doc.data().shareUser == userAddress){
            this.shareReports.push({id: doc.id, ...doc.data()})
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