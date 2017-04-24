<script>
  import oiShowReport from 'components/project/showReport.vue'

  export default {
    name: 'ProjectsReport,

    components: { oiShowReport }
  }
</script>

<template>
    <div class="container-fluid well well-sm">

      <oiReport
        :project="projectSelected"
        :densityTotal="densityTotal"
        :averangeTimeTotal="averangeTimeTotal"
        :reopenedTotal="reopenedTotal"
        :detectableInDevTotal="detectableInDevTotal"
        :statusByProjectGroupDayTop5="statusByProjectGroupDayTop5"
        :statusByProjectGroupDayTop30="statusByProjectGroupDayTop30"
        :statusByProjectGroupMonth="statusByProjectGroupMonth"
        :defectStatus="defectStatus"
        :defectGroupOrigin="defectGroupOrigin"
        :defectsOpenInTestManuf="defectsOpenInTestManuf"
        :defectsOpenInDevManuf="defectsOpenInDevManuf"
        :ctsImpactedXDefects="ctsImpactedXDefects"
        :productivityXDefects="productivityXDefects"
        :productivityXDefectsGroupWeekly="productivityXDefectsGroupWeekly"
      />
      
</template>

<style scoped>
  input {
     min-width: 100%
  }
  .container {
    margin-top: 15px;
  }
  .oi-well {
    margin: 0;
    border: 0;
    padding: 0;
  }
  .oi-icon {
    font-size: medium;
  }
</style>