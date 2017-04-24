<script>
  import oiGrid from './grid.vue'
  import oiShow from 'components/project/show.vue'

  import services from 'src/modules/project/services'
  
  export default {
    name: 'ProjectsMain',

    components: { oiGrid, oiShow },

    data () {
      return {
        selectedProject: {},

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

        email: {
          from: 'sgq@oi.net.br',
          to: '',
          subject: '',
          url: ''
        }
      }
    },

    created () {
      this.loadInitialData()
    },

    methods: {
      loadInitialData () {
        services.getProjects({}).then(resp => {
          this.projects = resp.data
          this.projectsFilteredByTerm = resp.data
        })
      },

      selectItem (item) {
        this.selectedProject = item

        let subprojectDelivery = this.selectedProject.subprojectDelivery.split(' ')

        this.email.subject = '[Status TI] SubPrj: ' + subprojectDelivery[0] + ', Ent: ' + subprojectDelivery[1] + ', Nome: ' + this.selectedProject.name

        this.$router.push({
          path: 'project/show/' + this.selectedProject.subproject + '/' + this.selectedProject.delivery,
          payload: this.email
        })

        /*
        this.$router.push({
          path: 'project/show/' + this.selectedProject.subproject + '/' + this.selectedProject.delivery
        })
        */
        /*
        this.$router.push({
          path: ('project/show/' + this.selectedProject.subproject + '/' + this.selectedProject.delivery),
          props: route => ({
            rootComponent: oiShow,
            rootParams: {
              x1: 'this.selectedProject.subproject'
            },
            x2: 'this.selectedProject.delivery'
          })
        })
        */
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

      <!-- CAMPO PESQUISA  -->
      <div class="row well well-sm oi-well">
        <input type="text"
            placeholder="Informe os filtros! Ex: multip+verd+2017"
            v-model="projectFilterTerm"
            @keyup="filterProjects"/>
      </div>

      <!-- TABELA RESULTADO  -->
      <oiGrid
        :dataSource="projectsFilteredByTerm"
        @onSelectItem="selectItem"
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