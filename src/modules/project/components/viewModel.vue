<script>
  import oiView from 'components/project/view.vue'
  import oiModal from 'components/modal_.vue'
  // import oiShowReport from 'components/project/showReport.vue'
  import oiReport from 'components/project/showReport.vue'
  import serverPaths from 'src/http/serverPaths'
  import Toastr from 'toastr'
  import 'babel-polyfill'

  import services from '../services'

  // import getDensityTotal from 'src/libs/getDensityTotal'
  // import getAverangeTimeTotal from 'src/libs/getAverangeTimeTotal'
  // import getReopenedTotal from 'src/libs/getReopenedTotal'
  // import getDetectableInDevTotal from 'src/libs/getDetectableInDevTotal'

  import getStatusTrans from 'src/libs/getStatusTrans'

  export default {
    name: 'ProjectReport',

    components: { oiView, oiModal, oiReport },

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
        iterationsActive: [],
        iterationsActiveFull: [],
        iterationsSelected: [],
        iterationsFiltered: [],

        email: {
          from: 'sgq@oi.net.br',
          to: '',
          subject: '',
          url: ''
        }
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

    computed: {
      /*
      iterationsActiveFull () {
        return this.iterations.filter(i => this.iterationsActive.indexOf(i.name) !== -1)
      },
      */
      emailValid () {
        var re = /\S+@\S+\.\S+/
        return re.test(this.email.to)
      }
    },

    methods: {
      loadProject () {
        services.getProjectBySubEnt(this.project.subproject, this.project.delivery).then(resp => {
          this.project = resp.data

          let subprojectDelivery = this.project.subprojectDelivery.split(' ')
          this.email.subject = '[Status TI] SubPrj: ' + subprojectDelivery[0] + ', Ent: ' + subprojectDelivery[1] + ', Nome: ' + this.project.name

          if (this.project.IterationsActive !== null) {
            this.iterationsActive = this.project.IterationsActive.split("','")
            if (this.iterationsActive.length === 1) {
              if (this.iterationsActive[0] === '') {
                this.iterationsActive = []
              }
            }
            this.iterationsActiveFull = this.iterationsActive.map(i => ({ id: i, name: i }))
          }

          if (this.project.IterationsSelected !== null) {
            this.iterationsSelected = this.project.IterationsSelected.split("','")
            if (this.iterationsSelected.length === 1) {
              if (this.iterationsSelected[0] === '') {
                this.iterationsSelected = []
              }
            }
            this.iterationsFiltered = this.iterationsSelected
          } else {
            if (this.iterationsActive.length) {
              this.iterationsFiltered = this.iterationsActive
            }
          }

          if (this.iterationsFiltered.length === 1) {
            if (this.iterationsFiltered[0] === '') {
              this.iterationsFiltered = []
            }
          }

          if (this.iterationsFiltered.length) {
            this.loadDataIterations()
          } else {
            this.loadData()
          }
        })
      },

      loadData () {
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

        services.getStatusLastDays(this.project).then(resp => {
          this.statusByProjectGroupDayTop5 = getStatusTrans(resp.data.last05Days)
          this.statusByProjectGroupDayTop30 = getStatusTrans(resp.data.last30Days)
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
      },

      loadDataIterations () {
        services.getDensityByIterations(this.project)
          .then(resp => {
            this.densityTotal = resp.data
          }
        )

        services.getAverangeTimeBySeverityIterations(this.project, '3-HIGH')
          .then(resp => {
            this.averangeTimeTotal = resp.data
          }
        )

        services.getReopenedIterations(this.project, this.iterationsFiltered).then(resp => {
          this.reopenedTotal = resp.data
        })

        services.getDetectableInDevIterations(this.project, this.iterationsFiltered).then(resp => {
          this.detectableInDevTotal = resp.data
        })

        services.getStatusLastDaysIterations(this.project, this.iterationsFiltered).then(resp => {
          this.statusByProjectGroupDayTop5 = getStatusTrans(resp.data.last05Days)
          this.statusByProjectGroupDayTop30 = getStatusTrans(resp.data.last30Days)
        })

        services.getStatusGroupMonthIterations(this.project, this.iterationsFiltered).then(resp => {
          this.statusByProjectGroupMonth = getStatusTrans(resp.data)
        })

        services.getDefectsStatusIterations(this.project, this.iterationsFiltered).then(resp => {
          this.defectStatus = resp.data
        })

        services.getDefectsGroupOriginIterations(this.project, this.iterationsFiltered).then(resp => {
          this.defectGroupOrigin = resp.data
        })

        services.getCTsImpactedXDefectsIterations(this.project, this.iterationsFiltered).then(resp => {
          this.ctsImpactedXDefects = resp.data
        })

        services.getDefectsOpenInDevManufIterations(this.project, this.iterationsFiltered).then(resp => {
          this.defectsOpenInDevManuf = resp.data
        })

        services.getDefectsOpenInTestManufIterations(this.project, this.iterationsFiltered).then(resp => {
          this.defectsOpenInTestManuf = resp.data
        })

        services.getProductivityXDefectsIterations(this.project, this.iterationsFiltered).then(resp => {
          this.productivityXDefects = resp.data
        })

        services.getProductivityXDefectsGroupWeeklyIterations(this.project, this.iterationsFiltered).then(resp => {
          this.productivityXDefectsGroupWeekly = resp.data
        })
      },

      ConfirmIterations (iterationsSelected) {
        if (this.iterationsSelected !== iterationsSelected) {
          if (iterationsSelected.length > 0) {
            this.iterationsSelected = iterationsSelected
            this.iterationsFiltered = iterationsSelected
          } else {
            this.iterationsSelected = this.iterationsActive
            this.iterationsFiltered = this.iterationsActive
          }

          services.updateIterationsSelected({ projectId: this.project.id, iterations: this.iterationsSelected })
            .then(resp => {
              if (this.iterationsFiltered.length > 0) {
                this.loadDataIterations()
              } else {
                this.loadData()
              }
            }
          )
        }
      },

      showReport () {
        this.state = 'showReport'
      },

      searchItem () {
        this.$router.push('/project')
      },

      sendReportByEmail () {
        // this.email.url = 'http://localhost:8080/#/project/report/' + this.project.subproject + '/' + this.project.delivery
        // this.email.url = 'http://sgq.intranet/dist/index.html#/project/report/' + this.project.subproject + '/' + this.project.delivery
        this.email.url = 'http://sgqhml.intranet/dist/index.html#/project/report/' + this.project.subproject + '/' + this.project.delivery
        this.$http.post(serverPaths.default + '/SendEmail', this.email)
        Toastr.success('E-mail enviado!')
      },

      closeModalShowReport () {
        this.state = 'show'
      }
    }
  }
</script>

<template>
    <div class="container-fluid well well-sm">
      <div class="row">
        <div class="col-xs-12 text-left">
          <a class="btn btn-xs my-tool-tip oi-icon"
            v-show="state !== 'search'" 
            @click="showReport"
            data-toggle="modal"
            data-target="#showReport"
            title="Report Por Email">
            <span class="glyphicon glyphicon-envelope"></span>
          </a>
          <a class="btn btn-xs my-tool-tip oi-icon"
            v-show="this.state !== 'search'" 
            @click="searchItem"
            data-toggle="tooltip"
            title="Pesquisa">
            <span class="glyphicon glyphicon-search"></span>
          </a>
        </div>
      </div>    

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
        :iterationsActive="iterationsActive"
        :iterationsActiveFull="iterationsActiveFull"
        :iterationsSelected="iterationsSelected"
        :iterationsFiltered="iterationsFiltered"
        @onConfirmIterations="ConfirmIterations"
      />

      <!-- SEND REPORT -->
      <oiModal id="showReport" >
        <div class="text-center">
          <div class="form-group">
              <input type="email" class="form-control" id="email" placeholder="email de destino" v-model="email.to"></textarea>
          </div>

          <div class="form-group">
              <textarea class="form-control" rows="3" id="subject" placeholder="título da menssagem" v-model="email.subject"></textarea>
          </div>

          <a class="btn btn-primary btn-xs" id="alert-target"
            role="button"
            v-show="email.to != '' && email.subject != ''"
            @click="sendReportByEmail">
            Enviar
          </a>            

          <a class="btn btn-primary btn-xs" 
            role="button"
            data-dismiss="modal"
            @click="closeModalShowReport">
            Fechar
          </a>
        </div>

        <div class="text-left">
          <a class="btn btn-primary btn-xs" 
            role="button" 
            data-toggle="collapse" 
            href="#xpto52" 
            aria-expanded="false" 
            aria-controls="collapseExample">
            Exibir Report
          </a>            

          <div id="xpto52" class="collapse" >
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
        </div>
      </oiModal>  
    </div>
</template>


<style scoped>
  .oi-icon {
    font-size: medium;
  }
</style>