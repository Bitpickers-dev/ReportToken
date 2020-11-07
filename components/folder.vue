<template>
    <div class="side-contents">
            <h4>共有したレポート</h4>
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
export default {
    props:['shareReports'],
    data(){
        return{
            // shareReports:[],
            // userAddress:null
        }
    },
}
</script>

<style scoped>
h4{
    text-align: center;
    padding: 15px;
}
.folder-content{
    overflow: scroll;
}

.folder-repository{
    padding-left: 20px;
    margin: 10px;
}
.side-contents{
    /* background:#fff; */
    position: fixed;
    max-height: 450px;
    min-width: 200px;
    overflow: hidden;
    margin: 10px;
    margin-top: 30px;
    /* margin-right: 50px; */
    right: 20px;
    padding-bottom: 50px;
    border-radius: 10px;
    background: #f4f4f4;
    box-shadow:  8px 8px 25px #8b8b8b, 
                -8px -8px 25px #ffffff;
}

</style>