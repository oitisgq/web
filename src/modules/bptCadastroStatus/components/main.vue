<script>
  /* eslint-disable */
  import oiSelection from 'components/selections/selections.vue'
  import oiSelectionBpts from './selectionBpts.vue'
  import serverPaths from 'src/http/serverPaths'

  export default {
    name: 'bptCadastroStatus',

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

        bptCadastroStatus: [],
        bptCadastroStatusFiltered: []
      }
    },
    
    computed: {
      isShowFiltersbptProjects () { return this.selectbptReleasesConfirmed === true && this.bptReleasesSelected.length > 0 },      
      
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
      this.loadbptCadastroStatus()
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
      
      loadbptCadastroStatus () {
        let _this = this
        _this.$http.get(serverPaths.defaultServer + '/bptCadastroStatus')
          .then(
              r => { 
                _this.bptCadastroStatus = r.data 
                _this.bptCadastroStatusFiltered = r.data
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
        this.bptCadastroStatusFiltered = this.filteredData(this.bptCadastroStatus)
        console.log(this.bptCadastroStatusFiltered.lenght)
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
        <th class="title">CADASTRO STATUS DO PROJETO<br /><br /></th>
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
    <br /><br /><br />
    <div class="row" v-show="bptProjectsConfirmed">
        <table class="table table-condensed table-striped table-hover" style="margin-bottom:0;padding-bottom:0;width:100%;">              
              <tbody v-for="item in bptCadastroStatusFiltered">
                <tr>
                    <td colspan="3">
                    <table style="width: 100%">
                        <tr>
                            <td style="padding:5px;width:20%;vertical-align:top;">
                            <p class="titleheader">FAROL:</p>
                            <p>
                            <select class="select">
                                <option value="VERDE">VERDE</option>
                                <option value="AMARELO">AMARELO</option>
                                <option value="VERMELHO">VERMELHO</option>
                            </select>
                            </p>
                            </td>
                            <td style="padding:5px;width:40%;">
                            <p class="titleheader">CAUSA RAIZ:</p>
                            <p>
                            <textarea class="textarea">{{item.causaraiz}}</textarea>
                            </p>
                            </td>
                            <td style="padding:5px;width:40%;">
                            <p class="titleheader">PLANO DE AÇÃO:</p>
                            <p>
                            <textarea class="textarea">{{item.planoacao}}</textarea>
                            </p>
                            </td>
                        </tr>
                    </table>
                    </td>
                </tr>
                <tr>
                    <td>
                    <p class="titleheader">INFORMATIVO:</p>
                    <p><textarea class="textarea">{{item.informativo}}</textarea></p>                
                    </td>
                    <td colspan="2" rowspan="3" style="border-left: lightgrey solid thin;vertical-align: middle">
                    <table style="width: 100%">
                    <tr>
                        <th class="titlecharts" style="vertical-align: top;">1 - DENSIDADE</th>
                        <th class="titlecharts" style="vertical-align: top;">2 - TEMPO MEDIO (HIGH)</th>
                        <th class="titlecharts" style="vertical-align: top;">3 - TAXA DE REINCIDÊNCIA</th>
                        <th class="titlecharts" style="vertical-align: top;">4 - DETECTÁVEIS EM DESENVOLVIMENTO</th>
                    </tr>
                    <tr>
                        <td colspan="4" style="vertical-align:middle;height:300px;padding:5px;" class="namecharts">
                         <img alt="Brand" src="../../../assets/images/img_cadastro1.png" height="vh" width="vh" class="displayed">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" class="textcharts">
                        <p>1 - DENSIDADE: defeitos fechados de construção, divididos pelos componentes fechados diferentes de massa multiplicados por 100.<br />Os valores de referência: Aceitável, Modereada e Alta, são respectivamente 10%, 20% e 30%.</p>
                        <p>2 - TEMPO MÉDIO (HIGH): tempo útil em horas (entre as 9 e 18 horas, exceto fim-de-semana) de defeitos fechados, dividido pela quantidade de defeitos fechados.<br />Os valores de referência para resolução dos defeitos, são: Low 16h; Medium 8h; High 4h.  </p>
                        <p>3 - TAXA DE REINCIDÊNCIA: quantidade de vezes em que os defeitos fechados passaram pelo status "REOPEN", divididos pelo total de defeitos fechados multiplicados por 100.<br />O valor da referência é 5% do valor total dos defeitos fechados.</p>
                        <p>4 - DETECTÁVEIS EM DESENVOLVIMENTO: quantidade de defitos fechados, o campo "ERRO DETECTÁVEL EM DESENVOLVIMENTO" igual a "Sim". Esse campo é imputado manualmeente no ALM.<br />O valor da referência é 5% do valor total dos defeitos fechados.</p>
                        </td>
                    </tr>
                    </table>                    
                    </td>
                </tr>
                <tr>
                    <td>
                    <p class="titleheader">PONTOS DE ATENÇÃO:</p>
                    <p><textarea class="textarea">{{item.pontoatencao}}</textarea></p>                    
                    </td>
                </tr>
                <tr>
                    <td>
                    <p class="titleheader">PONTOS DE ATENÇÃO - INDICADORES:</p>
                    <p><textarea class="textarea">{{item.pontosatencaoindicadores}}</textarea></p>
                    </td>
                </tr>
            </tbody> 
        </table> 
    </div>
    <br /><br /><br />
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
  .textarea {
      width: 100%;
      height: 100px;
      border: grey solid thin;
      border-radius: 8px;
      background: rgba(255,255,255, .5);
      color: darkgrey;
      padding: 5px;
  }
  .select {
      width: 100%;
      border: grey solid thin;
      border-radius: 8px;
      background: rgba(255,255,255, .5);
      color: darkgrey;
      padding: 5px;
  }
  .titleheader {
    font-family: Verdana, Geneva, Tahoma, sans-serif;
    font-size: 18px;
    font-weight: 800;    
    color: darkslategrey;
  }
  .namecharts {
    font-family: Verdana, Geneva, Tahoma, sans-serif;
    font-size: 18px;
    font-weight: 800;    
    color:blueviolet;
    text-align: center;
  }
  .titlecharts {
    font-family: Verdana, Geneva, Tahoma, sans-serif;
    font-size: 12px;    
    color:black;
    text-align: center;
    padding: 5px;
  }
  .textcharts {
    font-family: Verdana, Geneva, Tahoma, sans-serif;
    font-size: 10px;    
    color:black;
    text-align: justify;
  }
</style>