<script>
  /* eslint-disable */
  import oiSelection from 'components/selections/selections.vue'
  import oiSelectionBpts from './selectionBpts.vue'
  import serverPaths from 'src/http/serverPaths'

  export default {
    name: 'bptAcompanhamentoExecucao',

    components: { oiSelection, oiSelectionBpts },

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

        bptBpts: [],
        bptBptsFiltered: [],
        bptBptsSelected: [],
        bptBptsFilterTerm: '',
        bptBptsConfirmed: false,
        inEdit: false
        
      }
    },
    
    computed: {
      isShowFiltersbptProjects () { return this.selectbptReleasesConfirmed === true && this.bptReleasesSelected.length > 0 },
      isShowFiltersbptBpts () { return this.bptProjectsConfirmed === true && this.bptProjectsSelected.length > 0 },
      isShowIndicators () { return this.bptBptsConfirmed === true && this.bptBptsSelected.length > 0 && !this.inEdit },

      filteredData () {
        let _this = this
        return function (dataSource) {
          let out = []
          dataSource.forEach(i => {
            if (_this.bptReleasesSelected.indexOf(i.release) > -1 && _this.bptProjectsSelected.indexOf(i.system) > -1 && _this.bptBptsSelected.indexOf(i.id) > -1) {
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
      this.loadbptBpts()
    },

    methods: {
      loadbptReleases () {
        let _this = this
        _this.$http.get(serverPaths.defaultServer + '/bptReleases')
          .then(
              r => { _this.bptReleases = r.data },
              e => { console.log(e) }
          )
      },
      
      loadbptProjects () {
        let _this = this
        _this.$http.get(serverPaths.defaultServer + '/bptProjects')
          .then(
              r => { _this.bptProjects = r.data },
              e => { console.log(e) }
          )
      },
      
      loadbptBpts () {
        let _this = this
        _this.$http.get(serverPaths.defaultServer + '/bptBpts')
          .then(
              r => { _this.bptBpts = r.data },
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
        this.bptProjectsSelected = itemsSelected
        this.bptProjectsConfirmed = true
        this.bptBptsConfirmed = false

        let _this = this
        _this.bptBptsFiltered = []
        _this.bptBpts.forEach(proj => {
          if (_this.bptReleasesSelected.indexOf(proj.release) > -1 &&
              _this.bptProjectsSelected.indexOf(proj.project) > -1 &&
              _this.bptBptsFiltered.findIndex(bptBptsFiltered => bptBptsFiltered.id === proj.name) === -1) {
            _this.bptBptsFiltered.push(proj)
          }
        })
        console.log( _this.bptBptsFiltered)
        this.bptBptsSelected = []
        this.bptBptsFilterTerm = ''
        this.inEdit = false
      },

      confirmbptBpts (itemsSelected) {
        this.bptBptsSelected = itemsSelected
        this.bptBptsConfirmed = true
        this.inEdit = false
        
      },

      newSelectedbptBpts () {
        this.bptBptsConfirmed = false
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
        <th class="title">ACOMPANHAMENTO DA EXECUÇÃO<br /><br /></th>
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

    <!-- FILTRO DE BPTs -->
    <div id="bptBpts"
      class="row well well-sm oi-well" 
      style="margin-bottom:3px" 
      v-show="isShowFiltersbptBpts">

      <oiSelectionBpts
        :dataSource="bptBptsFiltered"
        :selected="bptBptsSelected"
        :confirmed="bptBptsConfirmed"
        @onConfirmData="confirmbptBpts"
        @onNewSelected="newSelectedbptBpts"
        @onEnterInEdit="enterInEdit">
      </oiSelectionBpts>
    </div> 
    
    <div id="Indicators" v-show="isShowIndicators"> 
      <div class="row well-sm oi-well">
        <ul class="nav nav-tabs" style="margin-top:3px">
          <li class="active"><a data-toggle="tab" href="#tab1" style="padding: 0 5px 0 5px">Farol</a></li>
          <li><a data-toggle="tab" href="#tab2" style="padding: 0 5px 0 5px">Visão Geral</a></li>
          <li><a data-toggle="tab" href="#tab3" style="padding: 0 5px 0 5px">Produtividade</a></li>
          <li><a data-toggle="tab" href="#tab4" style="padding: 0 5px 0 5px">Defeitos</a></li>
          <li><a data-toggle="tab" href="#tab5" style="padding: 0 5px 0 5px">Indicadores</a></li> 
        </ul>

        <div class="tab-content">
            <div id="tab1" class="tab-pane fade in active" style="padding:50px;margin:0">
            <br /><br />
            <img alt="Brand" src="../../../assets/images/img_exec1.png" height="100%" width="vh" class="displayed">
            </div>

            <div id="tab2" class="tab-pane fade in" style="padding:50px; margin:0">
            <br /><br />
            <img alt="Brand" src="../../../assets/images/img_exec2.png" height="100%" width="vh" class="displayed">
            </div>

            <div id="tab3" class="tab-pane fade in" style="padding:50px; margin:0">
            <br /><br />
            <img alt="Brand" src="../../../assets/images/img_exec3.png" height="100%" width="vh" class="displayed">
            </div>

            <div id="tab4" class="tab-pane fade in" style="padding:50px; margin:0">
            <br /><br />
            <img alt="Brand" src="../../../assets/images/img_exec4.png" height="100%" width="vh" class="displayed">
            </div>

            <div id="tab5" class="tab-pane fade in" style="padding:50px; margin:0">
            <br /><br />
            <img alt="Brand" src="../../../assets/images/img_exec5.png" height="100%" width="vh" class="displayed">
            </div>
        </div> 

      </div>
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
  .displayed {
    display: block;
    margin-left: auto;
    margin-right: auto }
</style>