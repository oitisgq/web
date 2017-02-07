<script>
  import oiGrid from './grid.vue'
  import oiShow from 'components/project/show.vue'
  
  import services from '../servicesVueResource'

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
        projectsFilteredByTerm: []
      }
    },

    created () {
      this.loadData()
    },

    methods: {
      loadData () {
        services.getAll({}).then(resp => {
          this.projects = resp.data
          this.projectsFilteredByTerm = resp.data
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
      },

      selectItem (item, state) {
        this.project = item

        console.log(this.project.subproject)
        this.state = state
      },

      searchItem () {
        this.state = 'search'
      },

      showItem () {
        this.state = 'show'
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
            title="Pesquisar">
            <span class="glyphicon glyphicon-search"></span>
          </a>
        </div>
      </div>

      <!-- CAMPO PESQUISA  -->
      <div class="row well well-sm oi-well" v-show="this.state=='search'">
        <input type="text"
            placeholder="Informe o filtro! Ex: multip+verde"
            v-model="projectFilterTerm"
            @keyup="filterProjects"/>
      </div>

      <!-- TABELA RESULTADO  -->
      <oiGrid
        v-show="this.state === 'search'"
        :dataSource="projectsFilteredByTerm"
        @onSelectItem="selectItem"
      />

      <!-- EXIBIÇÃO ITEM SELECIONADO  -->
      <oiShow
        v-show="this.state=='show'"
        :project="project"
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