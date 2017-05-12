<script>
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

  import services from 'src/modules/project/services'
  
  // import html2canvas from 'html2canvas'
  // import domtoimage from 'dom-to-image'

  // import HttpService from 'src/http/HttpService'
  // import vueResource from 'src/http/vueResource'
  // import webApiPath from 'src/http/webApiPath'

  export default {
    name: 'projectShowReport',

    components: {
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
      productivityXDefectsGroupWeekly: { type: Array }
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

      searchItem () {
        this.$router.push({ name: 'project' })
      },

      sendEmail () {
        let email = {
          from: 'sgq@oi.net.br',
          to: 'joao.frade@oi.net.br',
          subject: 'subject - client',
          url: 'http://sgq.intranet/dist/index.html#/project/report/PRJ00000744/ENTREGA00000179'
        }
        //  url: 'http://sgq.intranet/dist/index.html#/project/report/PRJ00000744/ENTREGA00000179'

        services.sendEmail(email)
      },

      selectDefect (defect) {
      },

      close () {
        this.showModal = false
      }

    }
  }
</script>

<template>
  <div id="projects" class="projects">
      <!-- CABEÇALHO -->
      <div class="row">
        <div class="col-xs-6">
          <label>Projetos</label>
        </div>
        
        <div class="col-xs-6 text-right">
          <a class="btn btn-xs my-tool-tip oi-icon"
            v-show="this.state !== 'search'" 
            @click="searchItem"
            data-toggle="tooltip"
            title="Pesquisa">
            <span class="glyphicon glyphicon-search"></span>
          </a>
        </div>
      </div>
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
            <br>
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
            <br>
            <div>
              <label class="fd-label">Objetivos (Clarity):</label>
              <label class="fd-content">{{project.objective}}</label>
            </div>
          </div>
      </div>

      <div id="trafficLight" class="row well well-sm oi-well">
        <br>
        <div class="col-xs-1">
            <label class="fd-label">Farol &nbsp</label>
            <div class="text-center" style="padding-bottom:5px">
              <img alt="Farol Verde" src="../../assets/images/verde.png"  v-show="project.trafficLight === 'VERDE'">
              <img alt="Farol Amarelo" src="../../assets/images/amarelo.png" v-show="project.trafficLight === 'AMARELO'">
              <img alt="Farol Vermelho" src="../../assets/images/vermelho.png" v-show="project.trafficLight === 'VERMELHO'">
            </div>
        </div>

        <div id="rootCause" class="col-xs-5">
          <div>
            <label class="fd-label">Causa Raíz</label>
          </div>
          <div>
            <label class="fd-content">{{project.rootCause ? project.rootCause : 'Sem dados!'}}</label>
          </div>
        </div>

        <div id="actionPlan"class="col-xs-6">
          <div>
            <label class="fd-label">Plano de Ação</label>
          </div>
          <div>
            <label class="fd-content">{{project.actionPlan ? project.actionPlan : 'Sem dados!'}}</label>
          </div>
        </div>
      </div>

      <div id="Informative_AttentionPoints" class="row well well-sm oi-well">
          <br>
          <div class="col-xs-6">
            <div id="Informative">
              <label class="fd-label">Informativo</label>
            </div>
            <div>
              <label class="fd-content">{{project.informative ? project.informative : 'Sem dados!'}}</label>
            </div>
          </div>

          <div class="col-xs-6">
            <div id="AttentionPoints">
              <label class="fd-label">Pontos de Atenção</label>
            </div>
            <div>
              <label class="fd-content">{{project.attentionPoints ? project.attentionPoints : 'Sem dados!'}}</label>
            </div>
          </div>
      </div>

      <div id="monitoring" class="row well well-sm oi-well">
          <div id="Acumulado" class="col-xs-12 col-lg-6 text-center" style="padding-top:10px">
              <label class="fd-label">Acumulado</label><br><br>
              <oiGridMonitAcum :dataSource="statusByProjectGroupDayTop5"/>
          </div>

          <div class="col-xs-12 col-lg-6 text-center" style="padding-top:10px">
              <label class="fd-label">Diário</label><br><br>
              <oiGridMonitDay :dataSource="statusByProjectGroupDayTop5"/>
          </div>
          
          <div class="col-xs-12 col-md-6 text-center" style="padding-top:10px">
              <br>
              <oiChartExecutionProject :dataSource="statusByProjectGroupMonth" title="Curva S"/>
          </div>

          <div class="col-xs-12 col-md-6 text-center" style="padding-top:10px">
              <br>
              <oiChartExecutionProject :dataSource="statusByProjectGroupDayTop30" title="Curva S dos últimos dias"/>
          </div>

          <div class="col-xs-12 text-center" style="padding-top:10px">
              <oiChartProductivityXDefects
                title = "Produtividade X Defeitos Abertos" 
                :dataSource="productivityXDefects" 
              />
          </div>
          
          <div class="col-xs-12 text-center" style="padding-top:10px">
              <oiChartProductivityXDefectsGroupWeekly
                title = "Produtividade X Defeitos Abertos, Semanal" 
                :dataSource="productivityXDefectsGroupWeekly" 
              />
          </div>
      </div>  

      <div id="defects">
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

          <div id="defectsOpenInTestManuf" class="col-xs-12 col-lg-6 text-center" style="padding-top:10px" v-show="defectsOpenInTestManuf.length > 0">
            <label class="fd-label">Aberto na Fáb. Teste</label>
            <oiGridDefectsOpen 
              :defects="defectsOpenInTestManuf"
              id="xpto1"
              @onSelectDefect="selectDefect"
            />
          </div>

          <div class="col-xs-12 col-lg-6 text-center" style="padding-top:10px" v-show="defectsOpenInDevManuf.length > 0">
            <label class="fd-label">Aberto na Fáb. Desenv.</label>
            <oiGridDefectsOpen 
              :defects="defectsOpenInDevManuf"
              id="xpto2"
              @onSelectDefect="selectDefect"
            />
          </div>
        
      </div>

      <div id="Indicadores" class="row well well-sm oi-well text-center">
          <div id="AttentionPointsInd" style="padding-top:10px">
              <!--
              <div>
                <label class="fd-label">Pontos de Atenção dos Indicadores</label>
              </div>
              <div class="row">
                <label class="fd-content">{{project.attentionPointsOfIndicators  ? project.attentionPointsOfIndicators : 'Sem dados!'}}</label>
              </div>                      
              -->
              
              <label class="fd-label">Indicadores de Defeito</label><br>
              <div class="row">
                  <div class="col-xs-12">
                      <div class="col-xs-6 col-md-3 oi-col">
                        <oiChartDensityTotal :value="densityTotal"/>
                      </div>

                      <div class="col-xs-6 col-md-3 oi-col">
                        <oiChartAverangeTimeTotal :value="averangeTimeTotal"/>
                      </div>

                      <div class="col-xs-6 col-md-3 oi-col">
                        <oiChartReopenedTotal :value="reopenedTotal"/>
                      </div>

                      <div class="col-xs-6 col-md-3 oi-col">
                        <oiChartDetectableInDev :value="detectableInDevTotal"/>
                      </div>
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
  .oi-icon {
    font-size: medium;
  }
</style>