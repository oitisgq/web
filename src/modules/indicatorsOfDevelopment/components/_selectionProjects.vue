<script>
  import oiModal from 'components/modal.vue'

  export default {
    name: 'selectionProjects',

    props: {
      dataSource: {type: Array},
      itemsFilteredByTerm: {type: Array}
    },

    components: { oiModal },

    data () {
      return {
        itemsSelected: [],
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

    created () {
      console.log('created: ' + this.state)
    },

    methods: {
      setExibirProjetos () {
        this.filterSelected = 'projects'
        this.state = 'searching'
        this.$emit('onNewSelected')
      },
      selectAllProjects () {
        this.filterTerm = ''
        this.itemsFilteredByTerm = this.dataSource
        this.itemsSelected = this.itemsFilteredByTerm.map(e => e.id)
      },
      unSelectAllProjects () {
        this.filterTerm = ''
        this.itemsSelected = []
        this.itemsFilteredByTerm = this.dataSource
      },

      filterProjects () {
        let _this = this
        if (this.filterTerm !== '') {
          let words = this.filterTerm.split('+')
          this.itemsFilteredByTerm = this.dataSource.filter(item => {
            return words.every(word => {
              return _this.filterProperties.some(filterProperty => {
                return item[filterProperty.name].toLowerCase().indexOf(word.toLowerCase()) > -1
              })
            })
          })
        } else {
          this.itemsFilteredByTerm = this.dataSource
        }
      },

      selectAllProjectsFilteredByText () {
        this.itemsFilteredByTerm.forEach(i => {
          if (this.itemsSelected.indexOf(i.id) === -1) {
            this.itemsSelected.push(i.id)
          }
        })
      },

      unSelectAllProjectsFilteredByText () {
        this.itemsFilteredByTerm.forEach(i => {
          let index = this.itemsSelected.indexOf(i.id)
          if (index > -1) {
            this.itemsSelected.splice(index, 1)
          }
        })
      },

      confirm () {
        this.state = 'confirmed'
        this.isUpdate = false
        this.$emit('onChangeSelected', this.itemsSelected)
      }

    }
  }

</script>

<template>
  <span>
    <!-- SELEÇÃO DE PROJETOS  -->
    <div class="col-xs-12" style="margin:0; border:0; padding:0" v-show="state === 'searching'">
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
                v-show="itemsSelected.length > 0"
                @click="unSelectAllProjects()">Nada
            </button>
        </span>   

        <!-- BOTÃO CONFIRMAR -->
        <button 
            type="button" 
            id="confirmProjects" 
            v-show="itemsSelected.length > 0"
            class="btn btn-xs" 
            @click="confirm()">Confirmar
        </button>        

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
                  v-show="filterTerm != '' && itemsSelected.length > 0"
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

          <tbody v-for="item in itemsFilteredByTerm">
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
                          v-model="itemsSelected"
                      />
                  </td>
              </tr>
          </tbody> 
        </table>
      
        <label v-show="dataSource.length <= 0">Não encontrado</label>
    </div>


    <!-- BOTÔES SELEÇÃO E SELECIONADOS  -->
    <div class="col-xs-12 oi-col" style="margin:0; border:0; padding:0">
        <div v-show="state === 'confirmed'">
            <label>Projetos:</label>

            <button 
                type="button" 
                class="btn btn-xs"
                @click="setExibirProjetos()">Seleção
            </button>    

            <button 
                type="button" 
                class="btn btn-xs"
                data-toggle="modal" 
                data-target="#showModalProjectsSelected">Selecionados
            </button>

            <oiModal id="showModalProjectsSelected">
                <div class="row well well-sm oi-well">
                    <h4 style="margin-top:0; text-align:center"><strong>Projetos Selecionados</strong></h4>
                    <template v-for="item in itemsSelected" track-by="$index">
                        <label :for=item style="margin-left:10px; font-size:10px; line-height:0">{{item}}</label>
                    </template>
                </div>
            </oiModal> 
        </div>  
    </div>  


  </div>
 </span>            
</template>

<style scoped>
  /*
  input {
    min-width: 100% 
  }
  */
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
</style>