<script>
  import oiModal from 'components/modal.vue'
  import services from '../services'

  export default {
    name: 'selectionProjectsEdit',

    components: { oiModal },

    props: {
      dataSource: {type: Array},
      filteredByTerm: {type: Array},
      selected: {type: Array}
    },

    data () {
      return {
        inputDate: '',
        inputDate2: '',

        densityTimeline: [],
        agingMedioTimeline: [],
        wrongClassifTimeline: [],
        detectableInDevTimeline: [],
        reopenedTimeline: [],
        noPredictionTimeline: [],

        state: 'searching',
        filterSelected: '',
        filterTerm: '',
        orderProperty: 'release+classification+name',
        directionOrder: 1,
        indicatorsShown: false,
        filterProperties: [
            {name: 'id'},
            {name: 'name'},
            {name: 'classification'},
            {name: 'release'}
        ]
      }
    },

    computed: {
      message () {
        let numberOfProjects = this.dataSource.length ? 'Encontrados: <b>' + this.dataSource.length + '</b>' : ''
        let selected = this.selected.length ? 'Selecionados: <b>' + this.selected.length + '</b>' : ''
        let timeScope1 = this.inputDate.length ? 'Data Início: <b>' + this.convertDate(this.inputDate) + '</b>' : ''
        let timeScope2 = this.inputDate2.length ? 'Data Fim: <b>' + this.convertDate(this.inputDate2) + '</b>' : ''
        let filteredByTerm = (this.filteredByTerm.length !== this.dataSource.length) ? 'Filtrados: <b>' + this.filteredByTerm.length + '</b>' : ''
        if (numberOfProjects !== '' && (selected !== '' || filteredByTerm !== '' || timeScope1 !== '' || timeScope2 !== '')) {
          numberOfProjects = numberOfProjects + ', '
        }
        if (selected !== '' && (filteredByTerm !== '' || timeScope1 !== '' || timeScope2 !== '')) {
          selected = selected + ', '
        }
        if (filteredByTerm !== '' && (timeScope1 !== '' || timeScope2 !== '')) {
          filteredByTerm = filteredByTerm + ', '
        }
        if (timeScope2 !== '') {
          timeScope1 = timeScope1 + ', '
        }
        return numberOfProjects + selected + filteredByTerm + timeScope1 + timeScope2
      }
    },

    methods: {
      replaceDateBegin (inputDate) {
        var dateBegin = this.inputDate.replace(/-/g, '').substr(2)
        // console.log(dateBegin)
        return dateBegin
      },
      replaceDateEnd (inputDate2) {
        var dateEnd = this.inputDate2.replace(/-/g, '').substr(2)
        // console.log(dateEnd)
        return dateEnd
      },
      convertDate (inputFormat) {
        var year = inputFormat.substr(0, 4)
        var month = inputFormat.slice(5, 7) - 1
        var day = inputFormat.slice(8)
        function pad (s) { return (s < 10) ? '0' + s : s }
        var d = new Date(year, month, day)
        return [pad(d.getDate()), pad(d.getMonth() + 1), d.getFullYear()].join('/')
      },
      loadJsonDataTimeline () {
        services.getDensityByDate(this.replaceDateBegin(), this.replaceDateEnd()).then(r => {
          this.densityTimeline = r.data
        })
        services.getAgingMedioByDate(this.replaceDateBegin(), this.replaceDateEnd()).then(r => {
          this.agingMedioTimeline = r.data
        })
        services.getWrongClassificationDefectRateByDate(this.replaceDateBegin(), this.replaceDateEnd()).then(r => {
          this.wrongClassifTimeline = r.data
        })
        services.getDetectableInDevByDate(this.replaceDateBegin(), this.replaceDateEnd()).then(r => {
          this.detectableInDevTimeline = r.data
        })
        services.getReopenedByDate(this.replaceDateBegin(), this.replaceDateEnd()).then(r => {
          this.reopenedTimeline = r.data
        })
        services.getnoPredictionDefectsByDate(this.replaceDateBegin(), this.replaceDateEnd()).then(r => {
          this.noPredictionTimeline = r.data
        })
        this.$emit('onMessage', this.inputDate, this.inputDate2)
      },
      setExibirProjetos () {
        this.filterSelected = 'projects'
        this.state = 'searching'
        this.$emit('onNewSelected')
      },
      selectAllProjects () {
        this.filterTerm = ''
        this.filteredByTerm = this.dataSource
        this.selected = this.dataSource.map(e => e.id)
      },
      unSelectAllProjects () {
        this.filteredByTerm = this.dataSource
        this.selected = []
        this.filterTerm = ''
      },

      filterProjects () {
        let _this = this
        if (this.filterTerm !== '') {
          let words = this.filterTerm.split('+')
          this.filteredByTerm = this.dataSource.filter(item => {
            return words.every(word => {
              return _this.filterProperties.some(filterProperty => {
                return item[filterProperty.name].toLowerCase().indexOf(word.toLowerCase()) > -1
              })
            })
          })
        } else {
          this.filteredByTerm = this.dataSource
        }
      },

      selectAllProjectsFilteredByText () {
        this.filteredByTerm.forEach(i => {
          if (this.selected.indexOf(i.id) === -1) {
            this.selected.push(i.id)
          }
        })

        this.filteredByTerm = this.dataSource
        this.filterTerm = ''
      },

      unSelectAllProjectsFilteredByText () {
        this.filteredByTerm.forEach(i => {
          let index = this.selected.indexOf(i.id)
          if (index > -1) {
            this.selected.splice(index, 1)
          }
        })
        this.filteredByTerm = this.dataSource
        this.filterTerm = ''
      },

      confirm () {
        this.filterTerm = ''
        this.$emit('onConfirmData', this.selected)
      },

      confirmTimeline () {
        this.filterTerm = ''
        this.$emit('onConfirmDataTimeline', this.selected, this.densityTimeline, this.agingMedioTimeline, this.wrongClassifTimeline, this.detectableInDevTimeline, this.reopenedTimeline, this.noPredictionTimeline)
      }
      /*
      confirmDay () {
        this.filterTerm = ''
        this.$emit('onConfirmDataDay', this.selected)
      },

      confirmLastDay () {
        this.filterTerm = ''
        this.$emit('onConfirmDataLastDay', this.selected)
      }
      */
    }
  }

</script>

<template>
  <span>
    <!-- SELEÇÃO DE PROJETOS  -->
    <div class="col-xs-12" style="margin:0; border:0; padding:0">
        <label>Projetos:</label>
        <span style="white-space:nowrap; padding:0">
            <button 
                type="button" 
                id="selectAllProjects" 
                class="btn btn-xs" 
                v-show="dataSource.length > 0"
                @click="selectAllProjects()">Tudo
            </button>

            <button 
                type="button" 
                id="unSelectAllProjects" 
                class="btn btn-xs" 
                v-show="selected.length > 0"
                @click="unSelectAllProjects()">Nada
            </button>
        </span>

        <!-- BOTÃO CONFIRMAR -->
        <button 
            type="button" 
            id="confirmProjects" 
            v-show="selected.length > 0"
            class="btn btn-xs" 
            @click="confirm()">Confirmar(Consolidado)
        </button>   

        <button 
            type="button" 
            id="confirmProjectsTimeline" 
            v-show="selected.length > 0"
            class="btn btn-xs" 
            @click="confirmTimeline()">Confirmar Escopo
        </button>      

        <label class="oi-message" v-html="message"/>

        <!-- CAMPO PESQUISA  -->
        <div class="row well well-sm oi-well">
          <div class="col-xs-12 oi-col">
              <input type="text"
                  placeholder="Inf. o filtro. Ex: jul+espec"
                  v-show="dataSource.length > 0"
                  v-model="filterTerm"
                  @keyup="filterProjects"/>

              <button 
                  type="button" 
                  id="selectAllProjects" 
                  class="btn btn-xs" 
                  v-show="filterTerm != '' && dataSource.length > 0"
                  @click="selectAllProjectsFilteredByText()">Todos os Filtrados
              </button>

              <button 
                  type="button" 
                  id="unSelectAllProjects" 
                  class="btn btn-xs" 
                  v-show="filterTerm != '' && selected.length > 0"
                  @click="unSelectAllProjectsFilteredByText()">Nenhum dos Filtrados
              </button>  

              <label for="beginningDate">Data Inicial: </label>
              <input id="beginningDate" type="date" v-model="inputDate"  v-on:change='replaceDateBegin(inputDate)'/>

              <label for="endDate">Data Final: </label>
              <input id="endDate" type="date" v-model="inputDate2"  v-on:change='replaceDateEnd(inputDate2)'/>

              <button 
                  type="button" 
                  id="confirmDates" 
                  class="btn btn-xs" 
                  v-show="inputDate != '' && inputDate2 !=''"
                  @click="loadJsonDataTimeline()">Ok
              </button>  
          </div>
        </div>        

      


        <!-- TABELA RESULTADO  -->
        <table class="table table-condensed table-striped table-hover" style="margin-bottom:0;padding-bottom:0">
          <thead>
              <tr>
                  <th style="padding:0">
                      <font size="2" class="text-nowrap">Rel.
                          <a href="#" @click.prevent="setOrder('release')">
                          </a>
                      </font>
                  </th>

                  <th style="padding:0">
                      <font size="2" class="text-nowrap">Clas.
                          <a href="#" @click.prevent="setOrder('classification')">
                          </a>
                      </font>
                  </th style="padding:0">

                  <th style="padding:0">
                      <font size="2" class="text-nowrap">Proj.
                          <a href="#" @click.prevent="setOrder('project')">
                          </a>
                      </font>
                  </th>
                  <th style="padding:0">
                      <font size="2" class="text-nowrap">Nome
                          <a href="#" @click.prevent="setOrder('name')">
                          </a>
                      </font>
                  </th>
                  <th width="1%" style="padding:0">
                  </th>                                
              </tr>
          </thead>

          <tbody v-for="item in filteredByTerm">
              <tr style="padding:0">
                  <td style="padding:0">
                      <font size="2">{{item.release}}</font>
                  </td style="padding:0">
                  <td style="padding:0">
                      <font size="2">{{item.classification}}</font>
                  </td style="padding:0">
                  <td style="padding:0">
                      <font size="2">{{item.id}}</font>
                  </td style="padding:0">
                  <td style="padding:0">
                      <font size="2">{{item.name}}</font>
                  </td style="padding:0">

                  <td style="padding:0">
                      <input 
                          type="checkbox" 
                          :id="item.id" 
                          :value="item.id" 
                          v-model="selected"
                      />
                  </td>
              </tr>
          </tbody> 
        </table>
      
        <label v-show="dataSource.length <= 0">Não encontrado</label>
    </div>

  </div>
 </span>            
</template>

<style scoped>
  .oi-well {
    margin: 0;
    border: 0;
    padding: 0px;
  }
  .oi-col {
    padding: 3px; 
    margin: 0; 
    border: 0;
  }  
  .oi-message {
    margin: 0; 
    margin-left: 10px; 
    vertical-align: middle;
    font-size: 12px;
    font-weight: normal;
  }
  label { list-style-type: decimal; }  
</style>