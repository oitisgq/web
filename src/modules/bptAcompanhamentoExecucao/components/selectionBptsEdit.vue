<script>
  import oiModal from 'components/modal.vue'

  export default {
    name: 'selectionBptsEdit',

    components: { oiModal },

    props: {
      dataSource: {type: Array},
      filteredByTerm: {type: Array},
      selected: {type: Array}
    },

    data () {
      return {
        // filteredByTerm: this.filteredByTerm,
        // selected: this.selected,
        state: 'searching',
        filterSelected: '',
        filterTerm: '',
        orderProperty: 'classification+name+system+status',
        directionOrder: 1,
        indicatorsShown: false,
        filterProperties: [
            {name: 'id'},
            {name: 'classification'},
            {name: 'name'},
            {name: 'system'},
            {name: 'status'}
        ]
      }
    },

    computed: {
      message () {
        let numberOfBpts = this.dataSource.length ? 'Encontrados: <b>' + this.dataSource.length + '</b>' : ''
        let selected = this.selected.length ? 'selecionados: <b>' + this.selected.length + '</b>' : ''
        let filteredByTerm = (this.filteredByTerm.length !== this.dataSource.length) ? 'filtrados: <b>' + this.filteredByTerm.length + '</b>' : ''
        if (numberOfBpts !== '' && (selected !== '' || filteredByTerm !== '')) {
          numberOfBpts = numberOfBpts + ', '
        }
        if (selected !== '' && filteredByTerm !== '') {
          selected = selected + ', '
        }
        return numberOfBpts + selected + filteredByTerm
      }
      // filteredByTerm () { return this.filteredByTerm }
      // selected () { return this.selected }
    },

    methods: {
      setExibirBpts () {
        this.filterSelected = 'bpts'
        this.state = 'searching'
        this.$emit('onNewSelected')
      },
      selectAllBpts () {
        this.filterTerm = ''
        this.filteredByTerm = this.dataSource
        this.selected = this.dataSource.map(e => e.id)
      },
      unSelectAllBpts () {
        this.filteredByTerm = this.dataSource
        this.selected = []
        this.filterTerm = ''
      },

      filterBpts () {
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

      selectAllBptsFilteredByText () {
        this.filteredByTerm.forEach(i => {
          if (this.selected.indexOf(i.id) === -1) {
            this.selected.push(i.id)
          }
        })

        this.filteredByTerm = this.dataSource
        this.filterTerm = ''
      },

      unSelectAllBptsFilteredByText () {
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
    <!-- SELEÇÃO DE BPTs  -->
    <div class="col-xs-12" style="margin:0; border:0; padding:0">
        <label>BPTs:</label>
        <span style="white-space:nowrap; padding:0">
            <button 
                type="button" 
                id="selectAllBpts" 
                class="btn btn-xs" 
                v-show="dataSource.length > 0"
                @click="selectAllBpts()">Tudo
            </button>

            <button 
                type="button" 
                id="unSelectAllBpts" 
                class="btn btn-xs" 
                v-show="selected.length > 0"
                @click="unSelectAllBpts()">Nada
            </button>
        </span>

        <!-- BOTÃO CONFIRMAR -->
        <button 
            type="button" 
            id="confirmBpts" 
            v-show="selected.length > 0"
            class="btn btn-xs" 
            @click="confirm()">Confirmar
        </button>        

        <label class="oi-message" v-html="message"/>
        
        <!-- CAMPO PESQUISA  -->
        <div class="row well well-sm oi-well">
          <div class="col-xs-12 oi-col">
              <input type="text"
                  placeholder="Inf. o filtro. Ex: JUL+SIEBEL"
                  v-show="dataSource.length > 0"
                  v-model="filterTerm"
                  @keyup="filterBpts"/>

              <button 
                  type="button" 
                  id="selectAllBpts" 
                  class="btn btn-xs" 
                  v-show="filterTerm != '' && dataSource.length > 0"
                  @click="selectAllBptsFilteredByText()">Todos os Filtrados
              </button>

              <button 
                  type="button" 
                  id="unSelectAllBpts" 
                  class="btn btn-xs" 
                  v-show="filterTerm != '' && selected.length > 0"
                  @click="unSelectAllBptsFilteredByText()">Nenhum dos Filtrados
              </button>     
          </div>
        </div>        


        <!-- TABELA RESULTADO  -->
        <table class="table table-condensed table-striped table-hover" style="margin-bottom:0;padding-bottom:0">
          <thead>
              <tr>
                  <th style="padding:0">
                      <font size="2" class="text-nowrap">Release
                          <a href="#" @click.prevent="setOrder('release')">
                          </a>
                      </font>
                  </th>

                  <th style="padding:0">
                      <font size="2" class="text-nowrap">Classificação
                          <a href="#" @click.prevent="setOrder('classification')">
                          </a>
                      </font>
                  </th style="padding:0">

                  <th style="padding:0">
                      <font size="2" class="text-nowrap">Projeto
                          <a href="#" @click.prevent="setOrder('project')">
                          </a>
                      </font>
                  </th style="padding:0">                                  

                  <th style="padding:0">
                      <font size="2" class="text-nowrap">BPT
                          <a href="#" @click.prevent="setOrder('name')">
                          </a>
                      </font>
                  </th>
                  <th style="padding:0">
                      <font size="2" class="text-nowrap">Sistema
                          <a href="#" @click.prevent="setOrder('system')">
                          </a>
                      </font>
                  </th>                  
                  <th style="padding:0">
                      <font size="2" class="text-nowrap">Status
                          <a href="#" @click.prevent="setOrder('status')">
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
                      <font size="2">{{item.project}}</font>
                  </td style="padding:0">                  
                  <td style="padding:0">
                      <font size="2">{{item.name}}</font>
                  </td style="padding:0">
                  <td style="padding:0">
                      <font size="2">{{item.system}}</font>
                  </td style="padding:0">                  
                  <td style="padding:0">
                      <font size="2">{{item.status}}</font>
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