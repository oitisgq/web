<script>
  /* eslint-disable */
  import oiSelection from 'components/selections/selections.vue'
  import oiSelectionBpts from './selectionBpts.vue'
  import webApiPath from 'src/http/webApiPath'

  export default {
    name: 'bptValidacaoPlano',

    components: { oiSelection },

    data () {
      return {
        pingCounter: 0,

        bptReleases: [],
        bptReleasesSelected: [],
        selectbptReleasesConfirmed: false,
        
        bptProjects: [],
        bptProjectsFiltered: [],
        bptProjectsSelected: [],
        bptProjectsConfirmed: false,

        bptValidPlanoEvid: [],
        bptValidPlanoEvidFiltered: []
      }
    },
    
    computed: {
      isShowFiltersbptProjects () { return this.selectbptReleasesConfirmed === true && this.bptReleasesSelected.length > 0 },
      // isShowFiltersbptBpts () { return this.bptProjectsConfirmed === true && this.bptProjectsSelected.length > 0 },
      
      filteredData () {
          console.log('filteredData')
        let _this = this
        return function (dataSource) {
          let out = []
          dataSource.forEach(i => {
            if (_this.bptReleasesSelected.indexOf(i.release) > -1 && _this.bptProjectsSelected.indexOf(i.name) > -1) {
              out.push(i)
            }
          })
          return out
        }
      },

 
    },
    
    mounted () {
      this.loadbptReleases()      
      this.loadbptProjects()
      this.loadbptValidPlanoEvid()
    },

    methods: {
      loadbptReleases () {
        let _this = this
        _this.$http.get(webApiPath.default + '/bptReleases')
          .then(
              r => { _this.bptReleases = r.data },
              e => { console.log(e) }
          )
      },
      
      loadbptProjects () {
        let _this = this
        _this.$http.get(webApiPath.default + '/bptProjects')
          .then(
              r => { _this.bptProjects = r.data },
              e => { console.log(e) }
          )
      },
      
      loadbptValidPlanoEvid () {
        let _this = this
        _this.$http.get(webApiPath.default + '/bptValidPlanoEvid')
          .then(
              r => { 
                _this.bptValidPlanoEvid = r.data 
                _this.bptValidPlanoEvidFiltered = r.data
              },
              e => { console.log(e) }
          )
      },
      
      // ===============

      confirmbptReleases (itemsSelected) {
        this.bptReleasesSelected = itemsSelected

        const _this = this
        this.bptProjectsFiltered = this.bptProjects.filter(e => _this.bptReleasesSelected.indexOf(e.release) > -1)
        this.bptProjectsSelected = []

        this.bptBptsFiltered = []
        this.bptBptsSelected = []
       
        this.selectbptReleasesConfirmed = true
      },
      
      confirmbptProjects (itemsSelected) {
        console.log('confirmbptProjects')
        this.bptProjectsSelected = itemsSelected
        this.bptProjectsConfirmed = true
        this.bptValidPlanoEvidFiltered = this.filteredData(this.bptValidPlanoEvid)
        console.log(this.bptValidPlanoEvidFiltered.lenght)
      },      
      
      enterInEdit () {
        this.inEdit = true
      },   

    }
  }
</script>

<template>
  <div class="container">

    <div>
        <th class="title">VALIDAÇÃO DO PLANO / EVIDÊNCIA<br /><br /></th>
    </div>

    <!-- {{bptProjectsFiltered}} -->
    <!-- FILTRO DE RELEASES -->
    <div id="bptReleases" 
      class="row well well-sm oi-well" 
      style="margin-bottom:3px">
      
      <oiSelection
        idChild="bptReleases"
        title="Releases"               
        :dataSource="bptReleases"
        :itemsSelected="bptReleasesSelected"
        :isShowButtonSelected="false"
        @onChangeSelected="confirmbptReleases"
      />
    </div>

    <!-- FILTRO DE PROJETOS -->
    <div id="bptProjects" 
      class="row well well-sm oi-well" 
      style="margin-bottom:3px" 
      v-show="isShowFiltersbptProjects">
      
      <oiSelection
        idChild="bptProjects"
        title="Projetos"               
        :dataSource="bptProjectsFiltered"
        :itemsSelected="bptProjectsSelected"
        :isShowButtonSelected="false"
        @onChangeSelected="confirmbptProjects"
      />
    </div>

    <div class="row" v-show="bptProjectsConfirmed">
        <table class="table table-condensed table-striped table-hover" style="margin-bottom:0;padding-bottom:0">
            <thead>
                <tr>
                    <th style="width: 10%"></th>
                    <th style="width: 10%"></th>
                    <th style="width: 10%"></th>
                    <th style="width: 15%"></th>
                    <th style="width: 15%"></th>
                    <th colspan="2" style="width:20%;border-right:black solid thin;border-left:black solid thin;text-align:center">Plano</th>
                    <th colspan="2" style="width:20%;text-align:center;border-right:black solid thin;">Evidência</th>
                </tr>
                <tr>
                    <th style="padding:5px;width:10%;background-color:grey;border-right:darkgrey solid thin;">
                        <font size="1" class="text-nowrap">Release
                            <a href="#" @click.prevent="setOrder('release')">
                            </a>
                        </font>
                    </th>

                    <th style="padding:5px;width:10%;background-color:grey;border-right:darkgrey solid thin;">
                        <font size="1" class="text-nowrap">Clas.
                            <a href="#" @click.prevent="setOrder('classification')">
                            </a>
                        </font>
                    </th>

                    <th style="padding:5px;width:10%;background-color:grey;border-right:darkgrey solid thin;">
                        <font size="1" class="text-nowrap">Projeto
                            <a href="#" @click.prevent="setOrder('project')">
                            </a>
                        </font>
                    </th>                                  

                    <th style="padding:5px;width:15%;background-color:grey;border-right:darkgrey solid thin;">
                        <font size="1" class="text-nowrap">BPT
                            <a href="#" @click.prevent="setOrder('name')">
                            </a>
                        </font>
                    </th>

                    <th style="padding:5px;width:15%;background-color:grey;">
                        <font size="1" class="text-nowrap">Componentes
                            <a href="#" @click.prevent="setOrder('name')">
                            </a>
                        </font>
                    </th>

                    <th style="padding:5px;width:10%;background-color:grey;text-align:center;border-left:black solid thin;">
                        <font size="1" class="text-nowrap">Val. Tecnica
                            <a href="#" @click.prevent="setOrder('system')">
                            </a>
                        </font>
                    </th> 
                                    
                    <th style="padding:5px;width:10%;background-color:grey;text-align:center;border-left:darkgrey solid thin;border-right:black solid thin;">
                        <font size="1" class="text-nowrap">Val. Cliente
                            <a href="#" @click.prevent="setOrder('status')">
                            </a>
                        </font>
                    </th>
                    <th style="padding:5px;width:10%;background-color:grey;text-align:center;border-right:darkgrey solid thin;">
                        <font size="1" class="text-nowrap">Val. Tecnica
                            <a href="#" @click.prevent="setOrder('system')">
                            </a>
                        </font>
                    </th>
                                    
                    <th style="padding:5px;width:10%;background-color:grey;text-align:center;border-right:black solid thin;">
                        <font size="1" class="text-nowrap">Val. Cliente
                            <a href="#" @click.prevent="setOrder('status')">
                            </a>
                        </font>
                    </th>                                           
                </tr>
            </thead>

            <tbody v-for="item in bptValidPlanoEvidFiltered">
                <tr>
                    <td style="padding:5px;width:10%;border-right:darkgrey solid thin;">
                        <font size="1">{{item.release}}</font>
                    </td>
                    <td style="padding:5px;width:10%;border-right:darkgrey solid thin;">
                        <font size="1">{{item.classification}}</font>
                    </td>
                    <td style="padding:5px;width:10%;border-right:darkgrey solid thin;">
                        <font size="1">{{item.name}}</font>
                    </td>                  
                    <td style="padding:5px;width:15%;border-right:darkgrey solid thin;">
                        <font size="1">{{item.bpt}}</font>
                    </td>
                    <td style="padding:5px;width:15%;">
                        <font size="1">{{item.components}}</font>
                    </td>                  
                    <td style="padding:;width:10%;border-left:black solid thin;border-right:darkgrey solid thin;">
                        <font size="1">{{item.plano_val_tecnica}}</font>
                    </td>
                    <td style="padding:5px;width:10%;border-right:black solid thin;">
                        <font size="1">{{item.plano_val_cliente}}</font>
                    </td>
                    <td style="padding:5px;width:10%;border-right:darkgrey solid thin;">
                        <font size="1">{{item.evidencia_val_tecnica}}</font>
                    </td>
                    <td style="padding:5px;width:10%;border-right:black solid thin;">
                        <font size="1">{{item.evidencia_val_cliente}}</font>
                    </td>                                    

                </tr>
            </tbody> 
        </table> 
    </div>

  </div> 
</template>

<style scoped>
  .container {
    margin-top: 15px;
  }
  .oi-well {
    margin: 0;
    border: 0;
    padding: 3px;
  } 
  .oi-col {
    padding: 3px;
    margin: 0;
    border: 0;
  }
  .blink {
    font-family: Verdana, Geneva, Tahoma, sans-serif;
    font-size: 24px;
    color: blue;
    animation: blink-animation 1s steps(5, start) infinite;
    -webkit-animation: blink-animation 1s steps(5, start) infinite;
  }
  @keyframes blink-animation {
  to {
    visibility: hidden;
    }
  }
  @-webkit-keyframes blink-animation {
    to {
      visibility: hidden;
    }
  }
  .title {
    font-family: Verdana, Geneva, Tahoma, sans-serif;
    font-size: 30px;
    font-weight: 800;
    text-align: center;
  }
</style>