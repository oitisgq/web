<script>
  import oiGrid from './grid.vue'
  import oiShow from 'components/project/show.vue'

  import servicesProject from 'src/services/project'
  
  import servicesDensity from 'src/services/density'
  import getDensityTotal from 'src/libs/getDensityTotal'

  import servicesAverangeTime from 'src/services/averangeTime'
  import getAverangeTimeTotal from 'src/libs/getAverangeTimeTotal'

  import servicesReopened from 'src/services/reopened'
  import getReopenedTotal from 'src/libs/getReopenedTotal'

  import servicesDetectableInDev from 'src/services/detectableInDev'
  import getDetectableInDevTotal from 'src/libs/getDetectableInDevTotal'

  export default {
    name: 'ProjectsMain',

    components: { oiGrid, oiShow },

    data () {
      return {
        project: {},
        state: 'search',
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
        densityTotal: {},

        averangeTimeByProject: [],
        averangeTimeTotal: {},

        reopenedByProject: [],
        reopenedTotal: {},

        detectableInDevByProject: [],
        detectableInDevTotal: {}
      }
    },

    created () {
      this.loadInitialData()
    },

    methods: {
      loadInitialData () {
        servicesProject.getAll({}).then(resp => {
          this.projects = resp.data
          this.projectsFilteredByTerm = resp.data
        })
      },

      selectItem (item, state) {
        this.project = item
        this.state = state
        this.loadDensityData(this.project)
        this.loadAverangeTimeData(this.project)
        this.loadReopenedData(this.project)
        this.loadDetectableInDevData(this.project)
      },

      searchItem () {
        this.state = 'search'
      },

      showItem () {
        this.state = 'show'
      },

      loadDensityData (project) {
        servicesDensity.getByProject(project).then(resp => {
          this.densityByProject = resp.data
          this.densityTotal = getDensityTotal(resp.data)
        })
      },

      loadAverangeTimeData (project) {
        servicesAverangeTime.getByProject(project).then(resp => {
          this.averangeTimeByProject = resp.data
          this.averangeTimeTotal = getAverangeTimeTotal(resp.data, 'HIGH')
        })
      },

      loadReopenedData (project) {
        servicesReopened.getByProject(project).then(resp => {
          this.reopenedByProject = resp.data
          this.reopenedTotal = getReopenedTotal(resp.data, 5)
        })
      },

      loadDetectableInDevData (project) {
        servicesDetectableInDev.getByProject(project).then(resp => {
          this.detectableInDevByProject = resp.data
          this.detectableInDevTotal = getDetectableInDevTotal(resp.data, 5)
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
  <div id="projects" class="container">
    <div class="row well well-sm">

      <!-- CABEÇALHO -->
      <div class="row">
        <div class="col-xs-6">
          <label>Projetos</label>
        </div>
        
        <div class="col-xs-6 text-right">
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
      <oiShow
        v-show="this.state=='show'"
        :project="project"
        :densityTotal="densityTotal"
        :averangeTimeTotal="averangeTimeTotal"
        :reopenedTotal="reopenedTotal"
        :detectableInDevTotal="detectableInDevTotal"
      />

    </div>
  </div>
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