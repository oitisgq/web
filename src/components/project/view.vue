<script>
  import oiProjectHeader from './header'
  import oiSelection from 'components/selections/selections.vue'
  import serverPaths from 'src/http/serverPaths'

  import oiChartDensityTotal from 'components/charts/defects/densityTotal'
  import oiChartReopenedTotal from 'components/charts/defects/reopenedTotal'
  import oiChartAverangeTimeTotal from 'components/charts/defects/averangeTimeTotal'
  import oiChartDetectableInDev from 'components/charts/defects/detectableInDev'
  import oiChartExecutionProject from 'components/charts/execution/project'
  import oiChartOpenedXClosedXCancelled from 'components/charts/defects/openedXClosedXCancelled'
  import oiChartGroupOrigin from 'components/charts/defects/groupOrigin'
  import oiChartCtsImpactedXDefects from 'components/charts/ctsImpactedXDefects'
  import oiChartProductivityXDefects from 'components/charts/productivityXDefects'
  import oiChartProductivityXDefectsGroupWeekly from 'components/charts/productivityXDefectsGroupWeekly'

  import oiGridMonitAcum from './gridMonitAcum'
  import oiGridMonitDay from './gridMonitDay'
  import oiGridDefectsOpen from './gridDefectsOpen'
  
  // import html2canvas from 'html2canvas'
  // import domtoimage from 'dom-to-image'
  // import HttpService from 'src/http/HttpService'
  // import vueResource from 'src/http/vueResource'
  // import serverPaths from 'src/http/serverPaths'

  export default {
    name: 'projectShow',

    components: {
      oiProjectHeader,
      oiSelection,
      oiChartDensityTotal,
      oiChartReopenedTotal,
      oiChartAverangeTimeTotal,
      oiChartDetectableInDev,
      oiChartExecutionProject,
      oiGridMonitAcum,
      oiGridMonitDay,
      oiChartOpenedXClosedXCancelled,
      oiChartGroupOrigin,
      oiGridDefectsOpen,
      oiChartCtsImpactedXDefects,
      oiChartProductivityXDefects,
      oiChartProductivityXDefectsGroupWeekly
    },

    // ctsImpactedByDefects: { type: Object },

    props: {
      project: { type: Object },
      densityTotal: { type: Object },
      averangeTimeTotal: { type: Object },
      reopenedTotal: { type: Object },
      detectableInDevTotal: { type: Object },
      statusByProjectGroupDayTop5: { type: Object },
      statusByProjectGroupDayTop30: { type: Object },
      statusByProjectGroupMonth: { type: Object },
      defectStatus: { type: Array },
      defectGroupOrigin: { type: Array },
      defectsOpenInTestManuf: { type: Array },
      defectsOpenInDevManuf: { type: Array },
      ctsImpactedXDefects: { type: Array },
      productivityXDefects: { type: Array },
      productivityXDefectsGroupWeekly: { type: Array },
      iterations: { type: Array },
      iterationsActive: { type: Array },
      iterationsActiveFull: { type: Array },
      iterationsSelected: { type: Array },
      iterationsFiltered: { type: Array }
    },

    data () {
      return {
        colors: [
          { portugues: 'VERMELHO', ingles: 'color:red' },
          { portugues: 'VERDE', ingles: 'color:green' },
          { portugues: 'AMARELO', ingles: 'color:gold ' }
        ],

        showModal: true
      }
    },

    methods: {
      color (item) {
        let index = this.colors.findIndex(i => i.portugues === item)
        return (index > -1) ? this.colors[index].ingles : ''
      },

      sendCurrentPageByEmail () {
        let myPage = `
          <!DOCTYPE html>
          <html lang="en">
          <head>
              <meta charset="UTF-8">
              <meta http-equiv=Content-Type content="text/html">
              <title>Document</title>
          </head>
          <body>
            <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
            ${document.querySelector('#defectsOpenInTestManuf').innerHTML}
            <script src='https://code.jquery.com/jquery-3.1.1.min.js'/>
          </body>
          </html>`

        let email = {
          from: 'sgq@oi.net.br',
          to: 'joao.frade@oi.net.br',
          subject: 'subject',
          body: myPage
        }

        this.$http.post(serverPaths.default + '/SaveImageByHtml', email)
      },

      selectDefect (defect) {
      },

      close () {
        this.showModal = false
      },

      changeSelectedIteration () {
      },

      confirmIterations (itemsSelected) {
        this.iterationsSelected = itemsSelected
        this.$emit('onConfirmIterations', this.iterationsSelected)
      }

        /*
        const _this = this
        this.systemsFiltered = this.systems.filter(e => _this.devManufacturersSelected.indexOf(e.devManufacturing) > -1)
        this.systemsSelected = []

        this.projectsFiltered = []
        this.projectsSelected = []

        this.selectDevManufConfirmed = true
        */
    }
  }
</script>

<template>
  <div id="projects" class="projects">
    <!--
    <div id="cabecalho" class="row well well-sm oi-well" >
      <div class="col-xs-12 col-md-6" style="margin:0; border:0; padding:0; padding-left:5px">
        <div>
          <label class="fd-label">Projeto:</label>
          <label class="fd-content">{{project.subprojectDelivery}}</label>
        </div>
      </div>
      <div class="col-xs-12 col-md-6" style="margin:0; border:0; padding:0; padding-left:5px">
        <div>
          <label class="fd-label">Nome:</label>
          <label class="fd-content">{{project.name}}</label>
        </div>
      </div>
      <div class="col-xs-12 col-md-6" style="margin:0; border:0; padding:0; padding-left:5px">
        <div>
          <label class="fd-label">GP:</label>
          <label class="fd-content">{{project.GP}}</label>
        </div>
      </div>

      <div class="col-xs-12 col-md-6" style="margin:0; border:0; padding:0; padding-left:5px">
        <div>
          <label class="fd-label">N3:</label>
          <label class="fd-content">{{project.N3}}</label>
        </div>
      </div>

      <div class="col-xs-12" style="margin:0; border:0; padding:0; padding-left:5px">
        <div>
          <label class="fd-label">Objetivos (Clarity):</label>
          <label class="fd-content">{{project.objective}}</label>
        </div>
      </div>

    </div>    
    -->

    <oiProjectHeader :project="project"/>

    <div id="abas" class="row well well-sm oi-well">

          <ul class="nav nav-tabs" style="margin-top:3px">
            <li class="active"><a data-toggle="tab" href="#Iteration" style="padding: 4px">Fitros</a></li>
            <li><a data-toggle="tab" href="#overview" style="padding: 4px">Visão Geral</a></li>
            <li><a data-toggle="tab" href="#monitoring" style="padding: 4px">Acompanhamento</a></li>
            <li><a data-toggle="tab" href="#defects" style="padding: 4px">Defeitos</a></li>
          </ul>

          <div class="tab-content">
              <div id="Iteration" class="tab-pane fade in active">
                  <div class="col-xs-12 text-left" style="margin:5px; border:0; padding:0; padding-top:10px">
                      <oiSelection
                        idChild="iterationsFiltered"
                        title="Iterations"
                        :dataSource="iterationsActiveFull"
                        :itemsSelected="iterationsFiltered"
                        :isShowButtonSelected="false"
                        @onChangeSelected="confirmIterations"
                      />                      
                  </div>              
              </div>
          
              <div id="overview" class="tab-pane fade" style="padding:5px; margin:0; text-align: center">

                  <div id="trafficLight" class="row well well-sm oi-well">
                    <div class="col-12 col-sm-1 text-left">
                        <label class="fd-label">Farol &nbsp</label>
                        <div class="text-left" style="padding-bottom:5px">
                          <img alt="Farol Verde" src="../../assets/images/verde.png"  v-show="project.trafficLight === 'VERDE'">
                          <img alt="Farol Amarelo" src="../../assets/images/amarelo.png" v-show="project.trafficLight === 'AMARELO'">
                          <img alt="Farol Vermelho" src="../../assets/images/vermelho.png" v-show="project.trafficLight === 'VERMELHO'">
                        </div>
                    </div>

                    <div class="col-12 col-sm-5 text-left">
                      <div>
                        <label class="fd-label">Causa Raíz</label>
                      </div>
                      <div>
                        <label class="fd-content" v-html="project.rootCause ? project.rootCause : 'Sem dados!'"></label>
                      </div>
                    </div>

                    <div class="col-12 col-sm-6 text-left">
                      <div>
                        <label class="fd-label">Plano de Ação</label>
                      </div>
                      <div>
                        <label class="fd-content" v-html="project.actionPlan ? project.actionPlan : 'Sem dados!'"></label>
                      </div>
                    </div>
                  </div>

                  <div id="Informative_AttentionPoints" class="row well well-sm oi-well">
                      <div class="col-12 col-sm-6 text-left">
                        <div id="Informative">
                          <label class="fd-label">Resumo Executivo</label>
                        </div>
                        <div>
                          <label class="fd-content" v-html="project.informative ? project.informative : 'Sem dados!'"></label>
                        </div>
                      </div>

                      <div class="col-12 col-sm-6 text-left">
                        <div id="AttentionPoints">
                          <label class="fd-label">Pontos de Atenção</label>
                        </div>
                        <div>
                          <label class="fd-content" v-html="project.attentionPoints ? project.attentionPoints : 'Sem dados!'"></label>
                        </div>
                      </div>
                  </div>

                  <div id="AttentionPointsInd" class="row well well-sm oi-well">
                  
                      <!--
                      <div>
                        <label class="fd-label">Pontos de Atenção dos Indicadores</label>
                      </div>
                      <div class="row">
                        <label class="fd-content" v-html="project.attentionPointsOfIndicators  ? project.attentionPointsOfIndicators : 'Sem dados!'"></label>
                      </div>                      
                      -->
                      
                      <label class="fd-label">Indicadores de Defeito</label><br>
                      <div class="row">
                          <div class="col-xs-12">
                              <div class="col-12 col-sm-6 col-md-3 oi-col">
                                <oiChartDensityTotal :value="densityTotal"/>
                              </div>

                              <div class="col-12 col-sm-6 col-md-3 oi-col">
                                <oiChartAverangeTimeTotal :value="averangeTimeTotal"/>
                              </div>

                              <div class="col-12 col-sm-6 col-md-3 oi-col">
                                <oiChartReopenedTotal :value="reopenedTotal"/>
                              </div>

                              <div class="col-12 col-sm-6 col-md-3 oi-col">
                                <oiChartDetectableInDev :value="detectableInDevTotal"/>
                              </div>
                          </div>
                      </div>
                  </div>
              </div>

              <div id="monitoring" class="tab-pane fade">
                  <div id="Acumulado" class="col-xs-12 col-lg-6 text-center" style="padding-top:10px">
                      <label class="fd-label">Acumulado</label>
                      <oiGridMonitAcum :dataSource="statusByProjectGroupDayTop5"/>
                  </div>

                  <div class="col-xs-12 col-lg-6 text-center" style="padding-top:10px">
                      <label class="fd-label">Diário</label>
                      <oiGridMonitDay :dataSource="statusByProjectGroupDayTop5"/>
                  </div>

                  <div class="col-xs-12 col-md-6 text-center" style="padding-top:10px">
                      <oiChartExecutionProject :dataSource="statusByProjectGroupMonth" title="Curva S"/>
                  </div>

                  <div class="col-xs-12 col-md-6 text-center" style="padding-top:10px">
                      <oiChartExecutionProject :dataSource="statusByProjectGroupDayTop30" title="Curva S dos últimos dias"/>
                  </div>

                  <div class="col-xs-12 col-md-6 text-center" style="padding-top:10px">
                      <oiChartProductivityXDefects
                        title = "Produtividade X Defeitos Abertos" 
                        :dataSource="productivityXDefects" 
                      />
                  </div>
                  
                  <div class="col-xs-12 col-md-6 text-center" style="padding-top:10px">
                      <oiChartProductivityXDefectsGroupWeekly
                        title = "Produtividade X Defeitos Abertos, Semanal" 
                        :dataSource="productivityXDefectsGroupWeekly" 
                      />
                  </div>
              </div>  

              <div id="defects" class="tab-pane fade">
                  <div class="col-xs-12 col-md-6 col-lg-4 text-center" style="margin:0; border:0; padding:0; padding-top:10px">
                      <oiChartOpenedXClosedXCancelled 
                        title = "Abertos X Fechados X Cancelados" 
                        :defectStatus="defectStatus" 
                      />
                  </div>
                  <div class="col-xs-12 col-md-6 col-lg-4 text-center" style="margin:0; border:0; padding:0; padding-top:15px">
                      <oiChartGroupOrigin 
                        title = "Fechados Por Origem"
                        :data = "defectGroupOrigin"
                      />
                  </div>

                  <div class="col-xs-12 col-lg-4 text-center" style="margin:0; border:0; padding:0; padding-top:15px">
                      <oiChartCtsImpactedXDefects 
                        title = "CTs Impactados X Defeitos Abertos" 
                        :dataSource="ctsImpactedXDefects" 
                      />
                  </div>

                  <!--
                  <div class="col-xs-12 text-center" style="padding-top:10px">
                      <oiChartExecutionProject :dataSource="ctsImpactedByDefects" title="CTs Impactados X Defeitos"/>
                  </div>
                  -->

                  <div id="defectsOpenInTestManuf" class="col-xs-12 col-lg-6 text-center" style="padding-top:10px" v-show="defectsOpenInTestManuf.length > 0">
                    <label class="fd-label">Aberto na Fáb. Teste</label>
                    <oiGridDefectsOpen 
                      :project="project"
                      :defects="defectsOpenInTestManuf"
                      id="xpto1"
                      @onSelectDefect="selectDefect"
                    />
                  </div>

                  <div class="col-xs-12 col-lg-6 text-center" style="padding-top:10px" v-show="defectsOpenInDevManuf.length > 0">
                    <label class="fd-label">Aberto na Fáb. Desenv.</label>
                    <oiGridDefectsOpen 
                      :project="project"
                      :defects="defectsOpenInDevManuf"
                      id="xpto2"
                      @onSelectDefect="selectDefect"
                    />
                  </div>
                
              </div>

          </div>
    </div>
  </div>
</template>

<style scoped>
  .oi-well {
    margin: 2px; 
    padding: 0;
  }

  .oi-col {
    padding: 5px; 
    margin: 0; 
    border: 0;
  }

  .fd-label {
    margin: 0; 
    border: 0; 
    padding: 0; 
    color: gray;
  }

  .fd-content {
    margin: 0; 
    border: 0; 
    padding: 3px; 
    text-align: left;
    font-weight: normal;
  }

  img {
    margin: 0; 
    border: 0; 
    padding: 0;
    vertical-align: top;
    height: 35px;
    width: 35px;
  }
</style>
