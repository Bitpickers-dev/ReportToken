<template>
    <div class="filecards">
        <!-- TODO -->
        <div class="filecard" v-for="report in reports" :key="report.shareUser + report.index">
            <nuxt-link :to="{name: 'folders-id',params:{id:report.shareUser + report.index}}">
            <Filecard :report="report"/>
            </nuxt-link>
            <!-- <h3></h3> -->
        </div>
        <!-- <Filecard /> -->
    </div>
</template>
<script>
import { db,firebase } from '~/plugins/firebase'
export default {
    data(){
        return{
            reports:[],
            report:null
        }
    },
    mounted(){
        db.collection('reports').get().then((querySnapshot) => {
            querySnapshot.forEach((doc) => {
                console.log(doc.id, "=>" ,doc.data())
                this.reports.push(doc.data())
                console.log(this.reports)
                this.report = this.reports[0]

            })
        })
    }
}
</script>

<style scoped>

</style>