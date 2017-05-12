<script>
  // import oiView from 'components/project/view.vue'
  // import oiModal from 'components/modal_.vue'
  import webApiPath from 'src/http/webApiPath'
  import oiReport from 'components/project/showReport.vue'
  // import Toastr from 'toastr'

  import services from '../services'

  // import getDensityTotal from 'src/libs/getDensityTotal'
  // import getAverangeTimeTotal from 'src/libs/getAverangeTimeTotal'
  // import getReopenedTotal from 'src/libs/getReopenedTotal'
  // import getDetectableInDevTotal from 'src/libs/getDetectableInDevTotal'

  import getStatusTrans from 'src/libs/getStatusTrans'

  export default {
    name: 'ProjectReport',

    components: { oiReport },

    data () {
      return {
        project: {},

        state: '',

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

        iterations: [],
        iterationsSelected: [],

        email: {
          from: 'sgq@oi.net.br',
          to: '',
          subject: '',
          url: ''
        }
      }
    },

    created () {
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

    computed: {
      emailValid () {
        var re = /\S+@\S+\.\S+/
        return re.test(this.email.to)
      }
    },

    beforeDestroy () {
      window.status = 'FIM'
    },

    methods: {
      delay (ms) {
        var curD = new Date()
        var curTicks = curD.getTime()
        var msPassed = 0
        while (msPassed < ms) {
          var d = new Date() // Possible memory leak?
          var ticks = d.getTime()
          msPassed = ticks - curTicks
          // d = null;  // Prevent memory leak?
        }
      },

      loadProject () {
        services.getProjectBySubEnt(this.project.subproject, this.project.delivery).then(resp => {
          this.project = resp.data
          this.iterationsSelected = this.project.iterations.split("','")

          this.loadData()

          /*
          if (this.iterationsSelected.length > 0) {
            this.loadDataIterations()
          } else {
            this.loadData()
          }
          */

          window.status = 'FIM'

          let subprojectDelivery = this.project.subprojectDelivery.split(' ')
          this.email.subject = '[Status TI] SubPrj: ' + subprojectDelivery[0] + ', Ent: ' + subprojectDelivery[1] + ', Nome: ' + this.project.name

          /*
          services.ClearIterations({ projectId: this.project.id })
            .then(
              r => { console.log('Exclusão ok') },
              e => { console.log(e) }
          )
          */
        })
      },

      loadData () {
        /*
        services.getStatusLastDays(this.project).then(resp => {
          this.statusByProjectGroupDayTop5 = getStatusTrans(resp.data.last05Days)
          this.statusByProjectGroupDayTop30 = getStatusTrans(resp.data.last30Days)
        })
        */
        let _this = this
        _this.$http.get(webApiPath.default + '/statusGroupDay/' + _this.project.subproject + '/' + _this.project.delivery)
          .then(
            r => {
              _this.statusByProjectGroupDayTop30 = getStatusTrans(r.data.slice(0, 29).sort((a, b) => a.dateOrder > b.dateOrder ? 1 : (a.dateOrder < b.dateOrder ? -1 : 0)))
              _this.statusByProjectGroupDayTop5 = getStatusTrans(r.data.slice(0, 4))
            },
            e => { console.log(e) }
          )

        services.getDensity(this.project).then(resp => {
          this.densityTotal = resp.data
        })

        services.getAverangeTimeBySeverity(this.project, '3-HIGH').then(resp => {
          this.averangeTimeTotal = resp.data
        })

        services.getReopened(this.project).then(resp => {
          this.reopenedTotal = resp.data
        })

        services.getDetectableInDev(this.project).then(resp => {
          this.detectableInDevTotal = resp.data
        })

        services.getStatusGroupMonth(this.project).then(resp => {
          this.statusByProjectGroupMonth = getStatusTrans(resp.data)
        })

        services.getDefectsStatus(this.project).then(resp => {
          this.defectStatus = resp.data
        })

        services.getDefectsGroupOrigin(this.project).then(resp => {
          this.defectGroupOrigin = resp.data
        })

        services.getCTsImpactedXDefects(this.project).then(resp => {
          this.ctsImpactedXDefects = resp.data
        })

        services.getDefectsOpenInDevManuf(this.project).then(resp => {
          this.defectsOpenInDevManuf = resp.data
        })

        services.getDefectsOpenInTestManuf(this.project).then(resp => {
          this.defectsOpenInTestManuf = resp.data
        })

        services.getProductivityXDefects(this.project).then(resp => {
          this.productivityXDefects = resp.data
        })

        services.getProductivityXDefectsGroupWeekly(this.project).then(resp => {
          this.productivityXDefectsGroupWeekly = resp.data
        })

        services.getIterations(this.project).then(resp => {
          this.iterations = resp.data
        })
      },

      loadDataIterations () {
        services.getDensityByIterations(this.project, this.iterationsSelected).then(resp => {
          this.densityTotal = resp.data
        })

        services.getAverangeTimeBySeverityIterations(this.project, '3-HIGH', this.iterationsSelected).then(resp => {
          this.averangeTimeTotal = resp.data
        })

        services.getReopenedIterations(this.project, this.iterationsSelected).then(resp => {
          this.reopenedTotal = resp.data
        })

        services.getDetectableInDevIterations(this.project, this.iterationsSelected).then(resp => {
          this.detectableInDevTotal = resp.data
        })

        services.getStatusLastDaysIterations(this.project, this.iterationsSelected).then(resp => {
          this.statusByProjectGroupDayTop5 = getStatusTrans(resp.data.last05Days)
          this.statusByProjectGroupDayTop30 = getStatusTrans(resp.data.last30Days)
        })

        services.getStatusGroupMonthIterations(this.project, this.iterationsSelected).then(resp => {
          this.statusByProjectGroupMonth = getStatusTrans(resp.data)
        })

        services.getDefectsStatusIterations(this.project, this.iterationsSelected).then(resp => {
          this.defectStatus = resp.data
        })

        services.getDefectsGroupOriginIterations(this.project, this.iterationsSelected).then(resp => {
          this.defectGroupOrigin = resp.data
        })

        services.getCTsImpactedXDefectsIterations(this.project, this.iterationsSelected).then(resp => {
          this.ctsImpactedXDefects = resp.data
        })

        services.getDefectsOpenInDevManufIterations(this.project, this.iterationsSelected).then(resp => {
          this.defectsOpenInDevManuf = resp.data
        })

        services.getDefectsOpenInTestManufIterations(this.project, this.iterationsSelected).then(resp => {
          this.defectsOpenInTestManuf = resp.data
        })

        services.getProductivityXDefectsIterations(this.project, this.iterationsSelected).then(resp => {
          this.productivityXDefects = resp.data
        })

        services.getProductivityXDefectsGroupWeeklyIterations(this.project, this.iterationsSelected).then(resp => {
          this.productivityXDefectsGroupWeekly = resp.data
        })
      },

      showReport () {
        this.state = 'showReport'
      },

      searchItem () {
        this.$router.push('/project')
      },

      closeModalShowReport () {
        this.state = 'show'
      }
    }
  }
</script>

<template>
    <div class="container-fluid well well-sm">

      <oiReport
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


<style scoped>
  .oi-icon {
    font-size: medium;
  }
</style>