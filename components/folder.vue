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
            shareReports:[],
            userAddress:null
        }
    },
     async mounted () {
        let accounts = await this.$web3.eth.getAccounts()
        this.userAddress = accounts[0]
        if(this.userAddress != null){
            db.collection('reports').onSnapshot((snapshot)=>{
                snapshot.docChanges().forEach((change)=>{
                const doc = change.doc
              if(change.type === 'added' && doc.data().shareUser == this.userAddress){
                this.shareReports.push({id: doc.id, ...doc.data()})
              }
            })
          })    
        }
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