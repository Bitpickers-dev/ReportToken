<template>
    <div class="side-contents">
            <h3>マイフォルダーリポジトリ</h3>
        <div class="folder-content">
            <div class="">
                <el-badge :value="20" class="item folder-repository" type="primary">
                    <el-button size="small">情報工学通信実験</el-button>
                </el-badge>
            </div>
            <div class="">
                <el-badge :value="13" class="item folder-repository" type="primary">
                    <el-button size="small">線形代数小レポート_0802</el-button>
                </el-badge>
            </div>
            <div class="">
                <el-badge :value="4" class="item folder-repository" type="primary">
                    <el-button size="small">情報倫理期末レポート</el-button>
                </el-badge>
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
            </div>
        </div>

    </div>
</template>


<style scoped>
h3{
    text-align: center;
}
.folder-content{
    height: 80vh;
    overflow: scroll;
}

.folder-repository{
    padding-left: 20px;
    margin: 10px;
}

.upload-demo{
    width:auto;
    margin: 10px;
}
</style>