<template>
  <div class="filecards">
    <!-- TODO -->
    <div
      class="filecard"
      v-for="report in reports"
      :key="report.shareUser + report.index"
    >
      <nuxt-link
        :to="{
          name: 'folders-id',
          params: { id: report.shareUser + report.index },
        }"
      >
        <Filecard :report="report" />
      </nuxt-link>
      <!-- <h3></h3> -->
    </div>
    <!-- <Filecard /> -->
  </div>
</template>
<script>
export default {
  props: ["reports"],
  data() {
    return {
      report: null,
    };
  },
};
</script>

<style scoped>
.filecards {
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
}
</style>
