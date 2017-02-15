<script>
  import oiGrid from './grid.vue'
  import oiEdit from './edit.vue'
  import oiShow from 'components/project/show.vue'
  import services from '../servicesVueResource'

  import servicesDensity from 'src/services/density'
  import getDensityTotal from 'src/libs/getDensityTotal'

  import servicesAverangeTime from 'src/services/averangeTime'
  import getAverangeTimeTotal from 'src/libs/getAverangeTimeTotal'

  import servicesReopened from 'src/services/reopened'
  import getReopenedTotal from 'src/libs/getReopenedTotal'

  import servicesDetectableInDev from 'src/services/detectableInDev'
  import getDetectableInDevTotal from 'src/libs/getDetectableInDevTotal'

  import servicesStatusGroupDay from 'src/services/statusGroupDay'
  import servicesStatusGroupMonth from 'src/services/statusGroupMonth'
  import getStatusTrans from 'src/libs/getStatusTrans'

  export default {
    name: 'cadProjectsMain',

    components: { oiGrid, oiEdit, oiShow },

    data () {
      return {
        project: { },

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
        projectsFilteredByText: [],

        densityByProject: [],
        densityTotal: {},

        averangeTimeByProject: [],
        averangeTimeTotal: {},

        reopenedByProject: [],
        reopenedTotal: {},

        detectableInDevByProject: [],
        detectableInDevTotal: {},

        statusByProjectGroupDayTop5: {},
        statusByProjectGroupDayTop30: {},
        statusByProjectGroupMonth: {}
      }
    },

    created () {
      this.loadData()
    },

    methods: {
      loadData () {
        /* getProjects().then(data => {
          this.projects = data
          this.projectsFilteredByText = data
        }) */
        services.getAll({}).then(resp => {
          this.projects = resp.data
          this.projectsFilteredByText = resp.data
        })
      },

      saveItem (project) {
        /* updateProject(project)
          .then(data => {
            console.log(data)
          }) */
        services.updateOne(this.project)
        this.state = 'search'
      },

      filterProjects (evento) {
        let _this = this
        if (this.projectFilterTerm !== '') {
          let words = this.projectFilterTerm.split('+')

          this.projectsFilteredByText = this.projects.filter(item => {
            return words.every(word => {
              return _this.filterProperties.some(filterProperty => {
                return item[filterProperty.name].toLowerCase().indexOf(word.toLowerCase()) > -1
              })
            })
          })
        } else {
          this.projectsFilteredByText = this.projects
        }
      },

      searchItem () {
        this.state = 'search'
      },

      selectItem (project, state) {
        this.project = project
        this.state = state
        this.loadDensityData(this.project)
        this.loadAverangeTimeData(this.project)
        this.loadReopenedData(this.project)
        this.loadDetectableInDevData(this.project)
        this.loadStatus(this.project)
      },

      showItem () {
        this.state = 'show'
      },

      editItem () {
        this.state = 'edit'
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

      loadStatus (project) {
        servicesStatusGroupDay.getByProject(project).then(resp => {
          this.statusByProjectGroupDayTop30 = getStatusTrans(resp.data.slice(0, 29).sort((a, b) => a.dateOrder > b.dateOrder ? 1 : (a.dateOrder < b.dateOrder ? -1 : 0)))
          this.statusByProjectGroupDayTop5 = getStatusTrans(resp.data.slice(0, 4))
        })
        servicesStatusGroupMonth.getByProject(project).then(resp => {
          this.statusByProjectGroupMonth = getStatusTrans(resp.data)
        })
      }
    }
  }
</script>

<template>
  <div id="cadProjectsMain" class="container">
    <div class="row well well-sm">

    <div class="row">
      <div class="col-xs-6">
        <label>Cadastro de Status de Projetos</label>
      </div>
      
      <div class="col-xs-6 text-right">
        <a class="btn btn-xs my-tool-tip oi-icon"
          v-show="this.state !== 'search'" 
          @click="searchItem"
          data-toggle="tooltip" 
          title="Pesquisar">
          <span class="glyphicon glyphicon-search"></span>
        </a>

        <a class="btn btn-xs my-tool-tip oi-icon"
          v-show="this.state === 'show'" 
          @click="editItem"
          data-toggle="tooltip" 
          title="Editar">
          <span class="glyphicon glyphicon-pencil"></span>
        </a>                  

        <a class="btn btn-xs my-tool-tip oi-icon" 
          v-show="this.state === 'edit'" 
          @click="saveItem"
          data-toggle="tooltip" 
          title="Gravar">
          <span class='glyphicon glyphicon-save'></span>
        </a>

        <a class="btn btn-xs my-tool-tip oi-icon"
          v-show="this.state === 'edit'" 
          @click="showItem"
          data-toggle="tooltip" 
          title="Exibir">
          <span class='glyphicon glyphicon-list-alt'></span>
        </a>
      </div>
    </div>

    <div class="row well well-sm oi-well" v-show="this.state=='search'">
      <input type="text"
          placeholder="Informe o filtro! Ex: multip+verde"
          v-model="projectFilterTerm"
          @keyup="filterProjects"/>
    </div>

    <oiGrid
      v-show="this.state === 'search'"
      :dataSource="projectsFilteredByText"
      @onSelectItem="selectItem"
    />

    <oiEdit 
      v-show="this.state=='edit'"
      :project="project"
      :densityTotal="densityTotal"
      :averangeTimeTotal="averangeTimeTotal"
      :reopenedTotal="reopenedTotal"
      :detectableInDevTotal="detectableInDevTotal"
    />

    <oiShow
      v-show="this.state=='show'"
      :project="project"
      :densityTotal="densityTotal"
      :averangeTimeTotal="averangeTimeTotal"
      :reopenedTotal="reopenedTotal"
      :detectableInDevTotal="detectableInDevTotal"
      :statusByProjectGroupDayTop5="statusByProjectGroupDayTop5"
      :statusByProjectGroupDayTop30="statusByProjectGroupDayTop30"
      :statusByProjectGroupMonth="statusByProjectGroupMonth"
    />    
    
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