<script>
  import oiModal from 'components/modal.vue'

  export default {
    name: 'filtersProjects',

    props: {
      dataSource: {type: Array},
      itemsSelected: {type: Array}
    },

    components: { oiModal },

    data () {
      return {
        dataSourceAux: [],
        FilterSelected: '',
        projectFilterTerm: '',
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

    methods: {
      setExibirProjetos () {
        this.FilterSelected = 'projects'
      },
      selectAllProjects () {
        this.projectFilterTerm = ''
        this.itemsSelected = this.dataSource.map(e => e.id)
       // this.changeProjectsFiltered()
      },
      unSelectAllProjects () {
        this.projectFilterTerm = ''
        this.itemsSelected = []
      //  this.changeProjectsFiltered()
      },
      confirmProjects () {
        this.projectFilterTerm = ''
      //  this.changeProjectsFiltered()
        this.indicatorsShown = true
       // this.processDensity();
       // this.processWrongClassif();
       // this.processDetectableInDev();
       // this.processaverageTime();
       // this.processReopened();
       // this.processNoPrediction();
      },
      filterProjects () {
        let _this = this
        if (this.projectFilterTerm !== '') {
          let words = this.projectFilterTerm.split('+')
          this.dataSource = this.dataSource.filter(item => {
            return words.every(word => {
              return _this.filterProperties.some(filterProperty => {
                return item[filterProperty.name].toLowerCase().indexOf(word.toLowerCase()) > -1
              })
            })
          })
        } else {
          this.changeProjectsFiltered()
        }
      },
      selectAllProjectsFilteredByText () {
        this.dataSource.forEach(i => {
          if (this.itemsSelected.indexOf(i.id) === -1) {
            this.itemsSelected.push(i.id)
          }
        })
      },
      unSelectAllProjectsFilteredByText () {
        this.dataSource.forEach(i => {
          let index = this.itemsSelected.indexOf(i.id)
          if (index > -1) {
            this.itemsSelected.splice(index, 1)
          }
        })
      },
      confirm () {
        this.$emit('onChangeSelected', this.itemsSelected)
        this.isUpdate = false
      }
    }
  }

</script>

<template>
  <span>
      <div class="col-xs-12">
    <div v-show="FilterSelected != 'projects'" >
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
            <div class="row well-sm" style="margin-bottom:3px">
                <h4 style="margin-top:0; text-align:center"><strong>Projetos Selecionados</strong></h4>
                <template v-for="item in itemsSelected" track-by="$index">
                    <label :for=item style="margin-left:10px; font-size:10px; line-height:0">{{item}}</label>
                </template>
            </div>
        </oiModal> 
    </div>  

    <div v-show="FilterSelected === 'projects'">
        <label>Projetos:</label>&nbsp;

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

        <button 
            type="button" 
            id="confirmProjects" 
            v-show="itemsSelected.length > 0"
            class="btn btn-xs" 
            @click="confirm()">Confirmar
        </button>        

        <div class="row well well-sm" style="margin-bottom:3px">
          <div class="col-xs-12">
              <input type="text"
                  placeholder="Inf. o filtro. Ex: jul+espec"
                  v-show="dataSource.length > 0"
                  v-model="projectFilterTerm"
                  @keyup="filterProjects"/>

              <button 
                  type="button" 
                  id="selectAllProjects" 
                  class="btn btn-xs" 
                  v-show="projectFilterTerm != '' && dataSource.length > 0"
                  @click="selectAllProjectsFilteredByText()">Todos os Filtrados
              </button>

              <button 
                  type="button" 
                  id="unSelectAllProjects" 
                  class="btn btn-xs" 
                  v-show="projectFilterTerm != '' && itemsSelected.length > 0"
                  @click="unSelectAllProjectsFilteredByText()">Nenhum dos Filtrados
              </button>     
          </div>
        </div>        

        <table class="table table-condensed table-striped table-hover" sv-show="dataSource.length > 0">
          <thead>
              <tr>
                  <th style="padding:0">
                      <font size="2" class="text-nowrap">Release
                          <a href="#" @click.prevent="setOrder('release')">
                          </a>
                      </font>
                  </th>

                  <th style="padding:0">
                      <font size="2" class="text-nowrap">Class
                          <a href="#" @click.prevent="setOrder('classification')">
                          </a>
                      </font>
                  </th style="padding:0">

                  <th style="padding:0">
                      <font size="2" class="text-nowrap">Projeto
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

          <tbody v-for="item in dataSource">
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
  </div>
 </span>            
</template>