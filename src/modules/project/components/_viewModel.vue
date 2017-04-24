<script>
  import oiView from 'components/project/view.vue'
  // import oiR from './r.vue'

  import services from '../services'

  import getDensityTotal from 'src/libs/getDensityTotal'
  import getAverangeTimeTotal from 'src/libs/getAverangeTimeTotal'
  import getReopenedTotal from 'src/libs/getReopenedTotal'
  import getDetectableInDevTotal from 'src/libs/getDetectableInDevTotal'

  import getStatusTrans from 'src/libs/getStatusTrans'

  export default {
    name: 'ProjectShow',

    components: { oiView },

    data () {
      return {
        project: {},

        density: [],
        densityTotal: {},

        averangeTime: [],
        averangeTimeTotal: {},

        reopenedByProject: [],
        reopenedTotal: {},

        detectableInDevByProject: [],
        detectableInDevTotal: {},

        statusByProjectGroupDayTop5: {},
        statusByProjectGroupDayTop30: {},
        statusByProjectGroupMonth: {},

        defectStatus: [],
        defectGroupOrigin: [],
        defectsOpenInTestManuf: [],
        defectsOpenInDevManuf: [],
        ctsImpactedXDefects: [],
        productivityXDefects: [],
        productivityXDefectsGroupWeekly: [],
        iterations: []
      }
    },

    mounted () {
      console.log('updated')
      this.project.subproject = this.$route.params.subproject
      this.project.delivery = this.$route.params.delivery
      this.loadProject()
    },

    watch: {
      '$route' (to, from) {
        this.project.subproject = this.$route.params.subproject
        this.project.delivery = this.$route.params.delivery
        this.loadProject()
      }
    },

    methods: {
      loadProject () {
        console.log('loadProject')
        console.log(this.subproject)
        console.log(this.delivery)
        services.getProjectBySubEnt(this.subproject, this.delivery).then(resp => {
          this.project = resp.data

          this.loadDensity(this.project)
          this.loadAverangeTime(this.project)
          this.loadReopened(this.project)
          this.loadDetectableInDev(this.project)

          this.loadStatusGroupDay(this.project)
          this.loadStatusGroupMonth(this.project)
          this.loadDefectStatus(this.project)
          this.loadDefectsGroupOrigin(this.project)
          this.loadCTsImpactedXDefects(this.project)
          this.loadDefectsOpenInDevManuf(this.project)
          this.loadDefectsOpenInTestManuf(this.project)
          this.loadProductivityXDefects(this.project)
          this.loadProductivityXDefectsGroupWeekly(this.project)
          this.loadIterations(this.project)
        })
      },

      loadDensity (project) {
        services.getDensityGroupMonthYear(project).then(resp => {
          this.density = resp.data
          this.densityTotal = getDensityTotal(resp.data)
        })
      },

      loadAverangeTime (project) {
        services.getAverangeTime(project).then(resp => {
          this.averangeTime = resp.data
          this.averangeTimeTotal = getAverangeTimeTotal(resp.data, 'HIGH')
        })
      },

      loadReopened (project) {
        services.getReopened(project).then(resp => {
          this.reopenedByProject = resp.data
          this.reopenedTotal = getReopenedTotal(resp.data, 5)
        })
      },

      loadDetectableInDev (project) {
        services.getDetectableInDev(project).then(resp => {
          this.detectableInDevByProject = resp.data
          this.detectableInDevTotal = getDetectableInDevTotal(resp.data, 5)
        })
      },

      loadStatusGroupDay (project) {
        services.getStatusGroupDay(project).then(resp => {
          this.statusByProjectGroupDayTop30 = getStatusTrans(resp.data.slice(0, 29).sort((a, b) => a.dateOrder > b.dateOrder ? 1 : (a.dateOrder < b.dateOrder ? -1 : 0)))
          this.statusByProjectGroupDayTop5 = getStatusTrans(resp.data.slice(0, 4))
        })
      },

      loadStatusGroupMonth (project) {
        services.getStatusGroupMonth(project).then(resp => {
          this.statusByProjectGroupMonth = getStatusTrans(resp.data)
        })
      },

      loadDefectStatus (project) {
        services.getDefectStatus(project).then(resp => {
          this.defectStatus = resp.data
        })
      },

      loadDefectsGroupOrigin (project) {
        services.getDefectsGroupOrigin(project).then(resp => {
          this.defectGroupOrigin = resp.data
        })
      },

      loadDefectsOpenInDevManuf (project) {
        services.getDefectsOpenInDevManuf(project).then(resp => {
          this.defectsOpenInDevManuf = resp.data
        })
      },

      loadDefectsOpenInTestManuf (project) {
        services.getDefectsOpenInTestManuf(project).then(resp => {
          this.defectsOpenInTestManuf = resp.data
        })
      },

      loadCTsImpactedXDefects (project) {
        services.getCTsImpactedXDefects(project).then(resp => {
          this.ctsImpactedXDefects = resp.data
        })
      },

      loadProductivityXDefects (project) {
        services.getProductivityXDefects(project).then(resp => {
          this.productivityXDefects = resp.data
        })
      },

      loadProductivityXDefectsGroupWeekly (project) {
        services.getProductivityXDefectsGroupWeekly(project).then(resp => {
          this.productivityXDefectsGroupWeekly = resp.data
        })
      },

      loadIterations (project) {
        services.getIterations(project).then(resp => {
          this.iterations = resp.data
        })
      },

      searchItem () {
        this.$router.push({ name: 'projectMain' })
      },

      showReport () {
        this.$router.push({ name: 'projectReport' })
      }
    }
  }
</script>

<template>
    <div class="container-fluid well well-sm">
      <oiView
        :project="project"
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
        :iterations="iterations"
      />

      <router-view/>
      
    </div>
</template>
