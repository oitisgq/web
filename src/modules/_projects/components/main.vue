<script>
  import oiGrid from './grid.vue'
  import oiShow from 'components/project/show.vue'
  // import oiShowReport from 'components/project/showReport.vue'
  import oiModal from 'components/modal_.vue'
  import webApiPath from 'src/http/webApiPath'

  import services from '../services'
  // import servicesProject from 'src/services/project'

  // import servicesDensity from 'src/services/density'
  // import getDensityTotal from 'src/libs/getDensityTotal'

  // import servicesAverangeTime from 'src/services/averangeTime'
  // import getAverangeTimeTotal from 'src/libs/getAverangeTimeTotal'

  // import servicesReopened from 'src/services/reopened'
  // import getReopenedTotal from 'src/libs/getReopenedTotal'

  // import servicesDetectableInDev from 'src/services/detectableInDev'
  // import getDetectableInDevTotal from 'src/libs/getDetectableInDevTotal'

  // import servicesStatusGroupDay from 'src/services/statusGroupDay'
  // import servicesStatusGroupMonth from 'src/services/statusGroupMonth'
  // import servicesDefectsStatus from 'src/services/defectsStatus'

  // import servicesDefectsGroupOrigin from 'src/services/defectsGroupOrigin'
  import servicesDefectsOpenInTestManuf from 'src/services/defectsOpenInTestManuf'
  import servicesDefectsOpenInDevManuf from 'src/services/defectsOpenInDevManuf'
  import servicesCtsImpactedXDefects from 'src/services/ctsImpactedXDefects'
  import servicesProductivityXDefects from 'src/services/productivityXDefects'
  import servicesProductivityXDefectsGroupWeekly from 'src/services/productivityXDefectsGroupWeekly'

  import getStatusTrans from 'src/libs/getStatusTrans'

  export default {
    name: 'ProjectsMain',

    components: { oiGrid, oiShow, oiModal },

    data () {
      return {
        projectSelected: {},
        projectFull: {},
        state: 'search',
        statusLast05Days: {},
        statusLast30Days: {},
        statusGroupMonth: {},

        filterProperties: [
            {name: 'subprojectDelivery'},
            {name: 'name'},
            {name: 'classification'},
            {name: 'release'},
            {name: 'state'},
            {name: 'trafficLight'}
        ],
        projectFilterTerm: '',

        projects: [],
        projectsFilteredByTerm: [],

        densityByProject: [],
        // densityTotal: {},

        averangeTimeByProject: [],
        // averangeTimeTotal: {},

        reopenedByProject: [],
        // reopenedTotal: {},

        detectableInDevByProject: [],
        // detectableInDevTotal: {},

        // statusByProjectGroupDayTop5: {},
        // statusByProjectGroupDayTop30: {},
        // statusByProjectGroupMonth: {},

        // defectStatus: [],
        // defectGroupOrigin: [],
        defectsOpenInTestManuf: [],
        defectsOpenInDevManuf: [],
        ctsImpactedXDefects: [],
        productivityXDefects: [],
        productivityXDefectsGroupWeekly: []
      }
    },

    created () {
      this.loadInitialData()
    },

    methods: {
      loadInitialData () {
        // servicesProject.getAll({}).then(resp => {
        services.getProjects().then(resp => {
          this.projects = resp.data
          this.projectsFilteredByTerm = resp.data
        })
      },

      selectItem (item, state) {
        this.projectSelected = item
        this.state = state

        this.loadProjectFull(this.projectSelected)

        this.loadDensityData(this.projectSelected)

        // this.loadAverangeTimeData(this.projectSelected)
        // this.loadReopenedData(this.projectSelected)
        // this.loadDetectableInDevData(this.projectSelected)
        // this.loadStatus(this.projectSelected)
        // this.loadDefectsStatus(this.projectSelected)
        // this.loadDefectsGroupOrigin(this.projectSelected)
        this.loadCtsImpactedXDefects(this.projectSelected)
        this.loadDefectsOpenInTestManuf(this.projectSelected)
        this.loadDefectsOpenInDevManuf(this.projectSelected)
        this.loadCtsImpactedXDefects(this.projectSelected)
        this.loadProductivityXDefects(this.projectSelected)
        this.loadProductivityXDefectsGroupWeekly(this.projectSelected)
      },

      searchItem () {
        this.state = 'search'
      },

      showItem () {
        this.state = 'show'
      },

      showReport () {
        this.state = 'showReport'
      },

      sendReportByEmail () {
        let email = {
          from: 'sgq@oi.net.br',
          to: 'joao.frade@oi.net.br',
          subject: 'Titulo da mensagem',
          url: 'http://sgq.intranet/dist/index.html'
        }
        this.$http.post(webApiPath.default + '/send', email)
      },
      // url: 'http://sgq.intranet/dist/index.html'

      closeModalShowReport () {
        this.state = 'show'
      },

      loadProjectFull (project) {
        services.getProjectFull(project).then(resp => {
          this.projectFull = resp.data
          this.statusLast05Days = getStatusTrans(this.projectFull.statusLastDays.last05Days)
          this.statusLast30Days = getStatusTrans(this.projectFull.statusLastDays.last30Days)
          this.statusGroupMonth = getStatusTrans(this.projectFull.statusGroupMonth)
        })
      },

      loadDensityData (project) {
        services.getDensity(project).then(resp => {
          this.densityByProject = resp.data
          // this.densityTotal = getDensityTotal(resp.data)
        })
      },

      /*
      loadAverangeTimeData (project) {
        servicesAverangeTime.getByProject(project).then(resp => {
          this.averangeTimeByProject = resp.data
          this.averangeTimeTotal = getAverangeTimeTotal(resp.data, 'HIGH')
        })
      },
      */

      /*
      loadReopenedData (project) {
        servicesReopened.getByProject(project).then(resp => {
          this.reopenedByProject = resp.data
          this.reopenedTotal = getReopenedTotal(resp.data, 5)
        })
      },
      */

      /*
      loadDetectableInDevData (project) {
        servicesDetectableInDev.getByProject(project).then(resp => {
          this.detectableInDevByProject = resp.data
          this.detectableInDevTotal = getDetectableInDevTotal(resp.data, 5)
        })
      },
      */

      /*
      loadStatus (project) {
        servicesStatusGroupDay.getByProject(project).then(resp => {
          this.statusByProjectGroupDayTop30 = getStatusTrans(resp.data.slice(0, 29).sort((a, b) => a.dateOrder > b.dateOrder ? 1 : (a.dateOrder < b.dateOrder ? -1 : 0)))
          this.statusByProjectGroupDayTop5 = getStatusTrans(resp.data.slice(0, 4))
        })
        servicesStatusGroupMonth.getByProject(project).then(resp => {
          this.statusByProjectGroupMonth = getStatusTrans(resp.data)
        })
      },
      */

      /*
      loadDefectsStatus (project) {
        servicesDefectsStatus.getByProject(project).then(resp => {
          this.defectStatus = resp.data
        })
      },
      */

      /*
      loadDefectsGroupOrigin (project) {
        servicesDefectsGroupOrigin.getByProject(project).then(resp => {
          this.defectGroupOrigin = resp.data
        })
      },
      */

      loadDefectsOpenInTestManuf (project) {
        servicesDefectsOpenInTestManuf.getByProject(project).then(resp => {
          this.defectsOpenInTestManuf = resp.data
        })
      },

      loadDefectsOpenInDevManuf (project) {
        servicesDefectsOpenInDevManuf.getByProject(project).then(resp => {
          this.defectsOpenInDevManuf = resp.data
        })
      },

      loadCtsImpactedXDefects (project) {
        servicesCtsImpactedXDefects.getByProject(project).then(resp => {
          this.ctsImpactedXDefects = resp.data
        })
      },

      loadProductivityXDefects (project) {
        servicesProductivityXDefects.getByProject(project).then(resp => {
          this.productivityXDefects = resp.data
        })
      },

      loadProductivityXDefectsGroupWeekly (project) {
        servicesProductivityXDefectsGroupWeekly.getByProject(project).then(resp => {
          this.productivityXDefectsGroupWeekly = resp.data
        })
      },

      filterProjects (evento) {
        let _this = this
        if (this.projectFilterTerm !== '') {
          let words = this.projectFilterTerm.split('+')

          this.projectsFilteredByTerm = this.projects.filter(item => {
            return words.every(word => {
              return _this.filterProperties.some(filterProperty => {
                return item[filterProperty.name].toLowerCase().indexOf(word.toLowerCase()) > -1
              })
            })
          })
        } else {
          this.projectsFilteredByTerm = this.projects
        }
      }
    }
  }
</script>

<template>
    <div class="container-fluid well well-sm">
      <!-- CABEÇALHO -->
      <div class="row">
        <div class="col-xs-6">
          <label>Projetos</label>
        </div>
        
        <div class="col-xs-6 text-right">
          <a class="btn btn-xs my-tool-tip oi-icon"
            v-show="this.state !== 'search'" 
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

      <!-- CAMPO PESQUISA  -->
      <div class="row well well-sm oi-well" v-show="this.state=='search'">
        <input type="text"
            placeholder="Informe os filtros! Ex: multip+verd+2017"
            v-model="projectFilterTerm"
            @keyup="filterProjects"/>
      </div>

      <!-- TABELA RESULTADO  -->
      <oiGrid
        v-show="this.state === 'search'"
        :dataSource="projectsFilteredByTerm"
        @onSelectItem="selectItem"
      />

      <!-- EXIBIÇÃO ITENS SELECIONADOS  -->
      <!-- :ctsImpactedXDefects="ctsImpactedXDefects" -->

      <oiShow
        v-show="state=='show' || state=='showReport'"
        :project="projectSelected"
        :projectFull="projectFull"
        :statusLast05Days="statusLast05Days"
        :statusLast30Days="statusLast30Days"
        :statusGroupMonth="statusGroupMonth"
        :defectsOpenInTestManuf="defectsOpenInTestManuf"
        :defectsOpenInDevManuf="defectsOpenInDevManuf"
        :ctsImpactedXDefects="ctsImpactedXDefects"
        :productivityXDefects="productivityXDefects"
        :productivityXDefectsGroupWeekly="productivityXDefectsGroupWeekly"
      />
      <!--
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
      -->

      <!-- SEND REPORT -->
      <oiModal v-show="this.state=='showReport'" id="showReport" >
        <div class="text-center">
          <div class="form-group">
              <textarea class="form-control" rows="1" id="email" placeholder="email de destino"></textarea>
          </div>

          <div class="form-group">
              <textarea class="form-control" rows="1" id="subject" placeholder="título da menssagem"></textarea>
          </div>

          <a class="btn btn-primary btn-xs" 
            role="button"
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

          <!--
          <div id="xpto52" class="collapse" >
                <oiShowReport
                  :project="projectSelected"
                />
          </div>
          -->
        </div>
            
      </oiModal>

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