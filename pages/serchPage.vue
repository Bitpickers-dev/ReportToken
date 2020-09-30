<template>
  　
  <div class="app-layout">
    <Header/>
    <div class="main-contents">
      <div class="side-content">
        <Folder/>
      </div>
      <div class="main-content">
        <h1>検索</h1>
        <div class="home-btn">
          <el-button type="primary">
            <nuxt-link to="/homePage" class="link-detail">HOMEへ</nuxt-link>
          </el-button>
        </div>
        <h3>絞って検索</h3>
        <div class="serch-content">

          <div class="block">
            <span class="demonstration">大学</span>
            <el-cascader
              style="width:300px"
              v-model="value1"
              :options="options"
              :props="{ expandTrigger: 'hover' }"
              @change="handleChange"></el-cascader>
          </div>
          <div class="block">
            <span class="demonstration">学年</span>
            <el-cascader
              style="width:300px"
              v-model="value2"
              :options="options2"
              :props="{ expandTrigger: 'hover' }"
              @change="handleChange"></el-cascader>
          </div>
          <div class="block">
            <span class="demonstration">科目</span>
            <el-cascader
              style="width:300px"
              v-model="value3"
              :options="options3"
              :props="{ expandTrigger: 'hover' }"
              @change="handleChange"></el-cascader>
          </div>
          <el-input placeholder="レポート名で検索" v-model="input" class="serch-input">
            <el-button slot="append" icon="el-icon-search"></el-button>
          </el-input>
        </div>
        <Upload/>
      </div>
    </div>
  </div>
</template>
<script>
import Header from '~/components/header.vue'

export default {
  components: {
    Header
  },
  data() {
    return {
      value1: [],
      value2: [],
      value3: [],
      options: [{
        value: '九州',
        label: '九州',
        children: [{
          value: '福岡県',
          label: '福岡県',
          children: [{
            value: '九州大学',
            label: '九州大学'
          }, {
            value: '九州工業大学',
            label: '九州工業大学'
          }, {
            value: '近畿大学',
            label: '近畿大学'
          }, {
            value: '福岡大学',
            label: '福岡大学'
          }],
        },]
      }],
      options2: [{
        value: '修士',
        label: '修士',
        children: [{
          value: '4',
          label: 'M1(修士1年)'
        }, {
          value: '5',
          label: 'M2(修士2年)'
        }]
      }],
      options3: [{
        value: '情報工学部',
        label: '情報工学部',
        children: [{
          value: '1',
          label: '情報工学通信実験'
        }, {
          value: '2',
          label: '解析Ⅱ'
        }]
      }]
    }
  },
  methods: {
    handleChange(value) {
      console.log(value);
    }
  }

}
</script>
<style scoped>

.home-btn {
  text-align: center;
  padding: 10px;
}

.serch-content {
  text-align: center;
}
</style>
