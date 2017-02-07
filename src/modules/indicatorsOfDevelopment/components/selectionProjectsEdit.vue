<script>
  import oiModal from 'components/modal.vue'

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
        let selected = this.selected.length ? 'selecionados: <b>' + this.selected.length + '</b>' : ''
        let filteredByTerm = (this.filteredByTerm.length !== this.dataSource.length) ? 'filtrados: <b>' + this.filteredByTerm.length + '</b>' : ''
        if (numberOfProjects !== '' && (selected !== '' || filteredByTerm !== '')) {
          numberOfProjects = numberOfProjects + ', '
        }
        if (selected !== '' && filteredByTerm !== '') {
          selected = selected + ', '
        }
        return numberOfProjects + selected + filteredByTerm
      }
      // filteredByTerm () { return this.filteredByTerm }
      // selected () { return this.selected }
    },

    methods: {
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
      }

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
            @click="confirm()">Confirmar
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