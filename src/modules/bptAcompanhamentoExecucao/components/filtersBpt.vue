<script>
  import oiModal from 'components/modal.vue'

  export default {
    name: 'filtersBpt',

    props: {
      dataSource: {type: Array},
      itemsSelected: {type: Array}
    },

    components: { oiModal },

    data () {
      return {
        dataSourceAux: [],
        FilterSelected: '',
        bptFilterTerm: '',
        orderProperty: 'classification+system+status+name',
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

    methods: {
      setExibirBpts () {
        this.FilterSelected = 'Bpts'
      },
      selectAllBpts () {
        this.bptFilterTerm = ''
        this.itemsSelected = this.dataSource.map(e => e.id)
       // this.changeBptsFiltered()
      },
      unSelectAllBpts () {
        this.bptFilterTerm = ''
        this.itemsSelected = []
      //  this.changeBptsFiltered()
      },
      confirmBpts () {
        this.bptFilterTerm = ''
      //  this.changeBptsFiltered()
        this.indicatorsShown = true
       // this.processDensity();
       // this.processWrongClassif();
       // this.processDetectableInDev();
       // this.processMiddleAges();
       // this.processReopened();
       // this.processNoPrediction();
      },
      filterBpts () {
        let _this = this
        if (this.bptFilterTerm !== '') {
          let words = this.bptFilterTerm.split('+')
          this.dataSource = this.dataSource.filter(item => {
            return words.every(word => {
              return _this.filterProperties.some(filterProperty => {
                return item[filterProperty.name].toLowerCase().indexOf(word.toLowerCase()) > -1
              })
            })
          })
        } else {
          this.changeBptsFiltered()
        }
      },
      selectAllBptsFilteredByText () {
        this.dataSource.forEach(i => {
          if (this.itemsSelected.indexOf(i.id) === -1) {
            this.itemsSelected.push(i.id)
          }
        })
      },
      unSelectAllBptsFilteredByText () {
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
    <div v-show="FilterSelected != 'Bpts'" >
        <label>BPTs:</label>
        <button 
            type="button" 
            class="btn btn-xs"
            @click="setExibirProjetos()">Seleção
        </button>    

        <button 
            type="button" 
            class="btn btn-xs"
            data-toggle="modal" 
            data-target="#showModalBptsSelected">Selecionados
        </button>

        <oiModal id="showModalBptsSelected">
            <div class="row well-sm" style="margin-bottom:3px">
                <h4 style="margin-top:0; text-align:center"><strong>BPTs Selecionados</strong></h4>
                <template v-for="item in itemsSelected" track-by="$index">
                    <label :for=item style="margin-left:10px; font-size:10px; line-height:0">{{item}}</label>
                </template>
            </div>
        </oiModal> 
    </div>  

    <div v-show="FilterSelected === 'Bpts'">
        <label>BPTs:</label>&nbsp;

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
                v-show="itemsSelected.length > 0"
                @click="unSelectAllBpts()">Nada
            </button>
        </span>   

        <button 
            type="button" 
            id="confirmBpts" 
            v-show="itemsSelected.length > 0"
            class="btn btn-xs" 
            @click="confirm()">Confirmar
        </button>        

        <div class="row well well-sm" style="margin-bottom:3px">
          <div class="col-xs-12">
              <input type="text"
                  placeholder="Inf. o filtro. Ex: jul+espec"
                  v-show="dataSource.length > 0"
                  v-model="bptFilterTerm"
                  @keyup="filterBpts"/>

              <button 
                  type="button" 
                  id="selectAllBpts" 
                  class="btn btn-xs" 
                  v-show="bptFilterTerm != '' && dataSource.length > 0"
                  @click="selectAllBptsFilteredByText()">Todos os Filtrados
              </button>

              <button 
                  type="button" 
                  id="unSelectAllBpts" 
                  class="btn btn-xs" 
                  v-show="bptFilterTerm != '' && itemsSelected.length > 0"
                  @click="unSelectAllBptsFilteredByText()">Nenhum dos Filtrados
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

          <tbody v-for="item in dataSource">
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