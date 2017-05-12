<script>
  import oiShowReport from 'components/project/showReport.vue'
  import webApiPath from 'src/http/webApiPath'

  // import services from '../services'

  import getDensityTotal from 'src/libs/getDensityTotal'
  // import getAverangeTimeTotal from 'src/libs/getAverangeTimeTotal'
  import getReopenedTotal from 'src/libs/getReopenedTotal'
  import getDetectableInDevTotal from 'src/libs/getDetectableInDevTotal'

  // import webApiPath from 'src/http/webApiPath'

  import getStatusTrans from 'src/libs/getStatusTrans'

  export default {
    name: 'ProjectReport',

    components: { oiShowReport },

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
        productivityXDefectsGroupWeekly: []
      }
    },

    mounted () {
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
        let _this = this
        _this.$http.get(webApiPath.default + '/Project/Project/' + _this.project.subproject + '/' + _this.project.delivery)
          .then(
            r => {
              _this.project = r.data
              _this.loadDensity(this.project)
              _this.loadAverangeTime(this.project)
              _this.loadReopened(this.project)
              _this.loadDetectableInDev(this.project)

              _this.loadStatusGroupDay(this.project)
              _this.loadStatusGroupMonth(this.project)
              _this.loadDefectStatus(this.project)
              _this.loadDefectsGroupOrigin(this.project)
              _this.loadCTsImpactedXDefects(this.project)
              _this.loadDefectsOpenInDevManuf(this.project)
              _this.loadDefectsOpenInTestManuf(this.project)
              _this.loadProductivityXDefects(this.project)
              _this.loadProductivityXDefectsGroupWeekly(this.project)
            },
            e => { console.log(e) }
          )
        /*
        services.getProjectBySubEnt(this.project.subproject, this.project.delivery).then(resp => {
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
        })
        */
      },

      loadDensity (project) {
        let _this = this
        _this.$http.get(webApiPath.default + '/defectsDensity/' + _this.project.subproject + '/' + _this.project.delivery)
          .then(
            r => {
              _this.density = r.data
              _this.densityTotal = getDensityTotal(r.data)
            },
            e => { console.log(e) }
          )
        /*
        services.getDensity(project).then(resp => {
          this.density = resp.data
          this.densityTotal = getDensityTotal(resp.data)
        })
        */
      },

      loadAverangeTime (project) {
        /*
        let _this = this
        _this.$http.get(webApiPath.default + '/defectsAverangeTime/' + _this.project.subproject + '/' + _this.project.delivery)
          .then(
            r => {
              _this.averangeTime = r.data
              _this.averangeTimeTotal = getAverangeTimeTotal(r.data)
            },
            e => { console.log(e) }
          )
        /*
        services.getAverangeTime(project).then(resp => {
          this.averangeTime = resp.data
          this.averangeTimeTotal = getAverangeTimeTotal(resp.data, 'HIGH')
        })
        */
      },

      loadReopened (project) {
        let _this = this
        _this.$http.get(webApiPath.default + '/defectsReopened/' + _this.project.subproject + '/' + _this.project.delivery)
          .then(
            r => {
              _this.reopenedByProject = r.data
              _this.reopenedTotal = getReopenedTotal(r.data)
            },
            e => { console.log(e) }
          )
        /*
        services.getReopened(project).then(resp => {
          this.reopenedByProject = resp.data
          this.reopenedTotal = getReopenedTotal(resp.data, 5)
        })
        */
      },

      loadDetectableInDev (project) {
        let _this = this
        _this.$http.get(webApiPath.default + '/defectsDetectableInDev/' + _this.project.subproject + '/' + _this.project.delivery)
          .then(
            r => {
              _this.detectableInDevByProject = r.data
              _this.detectableInDevTotal = getDetectableInDevTotal(r.data)
            },
            e => { console.log(e) }
          )
        /*
        services.getDetectableInDev(project).then(resp => {
          this.detectableInDevByProject = resp.data
          this.detectableInDevTotal = getDetectableInDevTotal(resp.data, 5)
        })
        */
      },

      loadStatusGroupDay (project) {
        let _this = this
        _this.$http.get(webApiPath.default + '/statusGroupDay/' + _this.project.subproject + '/' + _this.project.delivery)
          .then(
            r => {
              _this.statusByProjectGroupDayTop30 = getStatusTrans(r.data.slice(0, 29).sort((a, b) => a.dateOrder > b.dateOrder ? 1 : (a.dateOrder < b.dateOrder ? -1 : 0)))
              _this.statusByProjectGroupDayTop5 = getStatusTrans(r.data.slice(0, 4))
            },
            e => { console.log(e) }
          )
        /*
        services.getStatusGroupDay(project).then(resp => {
          this.statusByProjectGroupDayTop30 = getStatusTrans(resp.data.slice(0, 29).sort((a, b) => a.dateOrder > b.dateOrder ? 1 : (a.dateOrder < b.dateOrder ? -1 : 0)))
          this.statusByProjectGroupDayTop5 = getStatusTrans(resp.data.slice(0, 4))
        })
        */
      },

      loadStatusGroupMonth (project) {
        let _this = this
        _this.$http.get(webApiPath.default + '/statusGroupMonth/' + _this.project.subproject + '/' + _this.project.delivery)
          .then(
            r => {
              _this.statusByProjectGroupMonth = getStatusTrans(r.data)
            },
            e => { console.log(e) }
          )
        /*
        services.getStatusGroupMonth(project).then(resp => {
          this.statusByProjectGroupMonth = getStatusTrans(resp.data)
        })
        */
      },

      loadDefectStatus (project) {
        let _this = this
        _this.$http.get(webApiPath.default + '/defectsStatus/' + _this.project.subproject + '/' + _this.project.delivery)
          .then(
            r => {
              _this.defectStatus = r.data
            },
            e => { console.log(e) }
          )
        /*
        services.getDefectStatus(project).then(resp => {
          this.defectStatus = resp.data
        })
        */
      },

      loadDefectsGroupOrigin (project) {
        let _this = this
        _this.$http.get(webApiPath.default + '/defectsGroupOrigin/' + _this.project.subproject + '/' + _this.project.delivery)
          .then(
            r => {
              _this.defectGroupOrigin = r.data
            },
            e => { console.log(e) }
          )
        /*
        services.getDefectsGroupOrigin(project).then(resp => {
          this.defectGroupOrigin = resp.data
        })
        */
      },

      loadDefectsOpenInDevManuf (project) {
        let _this = this
        _this.$http.get(webApiPath.default + '/defectsOpenInDevManuf/' + _this.project.subproject + '/' + _this.project.delivery)
          .then(
            r => {
              _this.defectsOpenInDevManuf = r.data
            },
            e => { console.log(e) }
          )
        /*
        services.getDefectsOpenInDevManuf(project).then(resp => {
          this.defectsOpenInDevManuf = resp.data
        })
        */
      },

      loadDefectsOpenInTestManuf (project) {
        let _this = this
        _this.$http.get(webApiPath.default + '/defectsOpenInTestManuf/' + _this.project.subproject + '/' + _this.project.delivery)
          .then(
            r => {
              _this.defectsOpenInTestManuf = r.data
            },
            e => { console.log(e) }
          )
        /*
        services.getDefectsOpenInTestManuf(project).then(resp => {
          this.defectsOpenInTestManuf = resp.data
        })
        */
      },

      loadCTsImpactedXDefects (project) {
        let _this = this
        _this.$http.get(webApiPath.default + '/ctsImpactedXDefects/' + _this.project.subproject + '/' + _this.project.delivery)
          .then(
            r => {
              _this.ctsImpactedXDefects = r.data
            },
            e => { console.log(e) }
          )
        /*
        services.getCTsImpactedXDefects(project).then(resp => {
          this.ctsImpactedXDefects = resp.data
        })
        */
      },

      loadProductivityXDefects (project) {
        let _this = this
        _this.$http.get(webApiPath.default + '/productivityXDefects/' + _this.project.subproject + '/' + _this.project.delivery)
          .then(
            r => {
              _this.productivityXDefects = r.data
            },
            e => { console.log(e) }
          )
        /*
        services.getProductivityXDefects(project).then(resp => {
          this.productivityXDefects = resp.data
        })
        */
      },

      loadProductivityXDefectsGroupWeekly (project) {
        let _this = this
        _this.$http.get(webApiPath.default + '/productivityXDefectsGroupWeekly/' + _this.project.subproject + '/' + _this.project.delivery)
          .then(
            r => {
              _this.productivityXDefectsGroupWeekly = r.data
            },
            e => { console.log(e) }
          )
        /*
        services.getProductivityXDefectsGroupWeekly(project).then(resp => {
          this.productivityXDefectsGroupWeekly = resp.data
        })
        */
      }
    }
  }
</script>

<template>
    <div class="container-fluid well well-sm">
      <oiShowReport
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
      />
    </div>
</template>
