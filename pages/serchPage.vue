<template>
  <div class="app-layout">
    <Header />
    <div class="main-contents">
      <div class="main-content">
        <div class="serch-content">
          <el-input
            placeholder="レポート名で検索"
            v-model="input"
            class="serch-input"
          >
            <el-button slot="append" icon="el-icon-search"></el-button>
          </el-input>
        </div>
      </div>
    </div>
    <Upload />
    <Footer />
  </div>
</template>
<script>
import Header from "~/components/header.vue";

export default {
  components: {
    Header,
  },
  data() {
    return {
      value1: [],
      value2: [],
      value3: [],
      input: "",
    };
  },
  methods: {},
};
</script>
<style scoped>
.serch-content {
  text-align: center;
}
.serch-input {
  padding: 10px;
  padding-top: 10px;
  width: 400px;
}
</style>
