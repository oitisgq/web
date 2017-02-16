<script>
  import oiChartDensityTotal from 'components/charts/defects/densityTotal'
  import oiChartReopenedTotal from 'components/charts/defects/reopenedTotal'
  import oiChartAverangeTimeTotal from 'components/charts/defects/averangeTimeTotal'
  import oiChartDetectableInDev from 'components/charts/defects/detectableInDev'
  import oiChartExecutionProject from 'components/charts/execution/project'
  import oiChartOpenedXClosedXCancelled from 'components/charts/defects/openedXClosedXCancelled'
  import oiChartGroupOrigin from 'components/charts/defects/groupOrigin'
  import oiChartCtsImpactedXDefects from 'components/charts/ctsImpactedXDefects'

  import oiGridMonitAcum from './gridMonitAcum'
  import oiGridMonitDay from './gridMonitDay'
  import oiGridDefectsOpen from './gridDefectsOpen'

  export default {
    name: 'projectShow',

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
      oiChartCtsImpactedXDefects
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
      ctsImpactedXDefects: { type: Array }
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

      selectDefect (defect) {
      },

      close () {
        this.showModal = false
      }

    }
  }
</script>

<template>
  <div id="projects">

    <button @click="showModal = true">New Post</button>

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

    <div id="abas" class="row well well-sm oi-well" >

      <div class="row well-sm oi-well">

          <ul class="nav nav-tabs" style="margin-top:3px">
            <li class="active"><a data-toggle="tab" href="#overview" style="padding: 4px">Visão Geral</a></li>
            <li><a data-toggle="tab" href="#monitoring" style="padding: 4px">Acompanhamento</a></li>
            <li><a data-toggle="tab" href="#defects" style="padding: 4px">Defeitos</a></li>
            <li><a data-toggle="tab" href="#attentionPointsOfIndicators" style="padding: 4px">Aprovações</a></li>
          </ul>

          <div class="tab-content">
              <div id="overview" class="tab-pane fade in active" style="padding:5px; margin:0; text-align: center">

                  <div id="trafficLight" class="row">
                    <div class="col-xs-12 col-md-1">
                        <label class="fd-label">Farol &nbsp</label>
                        <div class="text-center">
                          <img alt="Farol Verde" src="../../assets/images/verde.png"  v-show="project.trafficLight === 'VERDE'">
                          <img alt="Farol Amarelo" src="../../assets/images/amarelo.png" v-show="project.trafficLight === 'AMARELO'">
                          <img alt="Farol Vermelho" src="../../assets/images/vermelho.png" v-show="project.trafficLight === 'VERMELHO'">
                        </div>
                    </div>

                    <div class="col-xs-12 col-md-5">
                      <div>
                        <label class="fd-label">Causa Raíz</label>
                      </div>
                      <div>
                        <label class="fd-content">{{project.rootCause ? project.rootCause : 'Sem dados!'}}</label>
                      </div>
                    </div>

                    <div class="col-xs-12 col-md-6">
                      <div>
                        <label class="fd-label">Plano de Ação</label>
                      </div>
                      <div>
                        <label class="fd-content">{{project.actionPlan ? project.actionPlan : 'Sem dados!'}}</label>
                      </div>
                    </div>
                  </div>

                  <div id="Informative_AttentionPoints" class="row">
                      <div class="col-xs-12 col-md-6">
                        <div id="Informative">
                          <label class="fd-label">Informativo</label>
                        </div>
                        <div>
                          <label class="fd-content">{{project.informative ? project.informative : 'Sem dados!'}}</label>
                        </div>
                      </div>

                      <div class="col-xs-12 col-md-6">
                        <div id="AttentionPoints">
                          <label class="fd-label">Pontos de Atenção</label>
                        </div>
                        <div>
                          <label class="fd-content">{{project.attentionPoints ? project.attentionPoints : 'Sem dados!'}}</label>
                        </div>
                      </div>
                  </div>

                  <div id="AttentionPointsInd" class="row">
                      <div>
                        <label class="fd-label">Pontos de Atenção dos Indicadores</label>
                      </div>
                      <div class="row">
                        <label class="fd-content">{{project.attentionPointsOfIndicators  ? project.attentionPointsOfIndicators : 'Sem dados!'}}</label>
                      </div>                      

                      <div class="row">
                          <div class="col-xs-12">
                              <div class="row">
                                <br>
                                <label class="fd-label">Indicadores</label>
                              </div>

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

              <div id="monitoring" class="tab-pane fade">
                  <div class="col-xs-12 col-lg-6 text-center" style="padding-top:10px">
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
              </div>  

              <div id="defects" class="tab-pane fade">
                  <div class="col-xs-12 col-lg-6 text-center" style="padding-top:10px">
                      <oiChartOpenedXClosedXCancelled 
                        title = "Abertos X Fechados X Cancelados" 
                        :defectStatus="defectStatus" 
                      />
                  </div>
                  <div class="col-xs-12 col-lg-6 text-center" style="padding-top:10px">
                      <oiChartGroupOrigin 
                        title = "Fechados Por Origem"
                        :data = "defectGroupOrigin"
                      />
                  </div>

                  <!--
                  <div class="col-xs-12 text-center" style="padding-top:10px">
                      <oiChartExecutionProject :dataSource="ctsImpactedByDefects" title="CTs Impactados X Defeitos"/>
                  </div>
                  -->

                  <div class="col-xs-12 col-lg-6 text-center" style="padding-top:10px" v-show="defectsOpenInTestManuf.length > 0">
                    <label class="fd-label">Aberto na Fáb. Teste</label>
                    <oiGridDefectsOpen 
                      :defects="defectsOpenInTestManuf"
                      @onSelectDefect="selectDefect"
                    />
                  </div>

                  <div class="col-xs-12 col-lg-6 text-center" style="padding-top:10px" v-show="defectsOpenInDevManuf.length > 0">
                    <label class="fd-label">Aberto na Fáb. Desenv.</label>
                    <oiGridDefectsOpen 
                      :defects="defectsOpenInDevManuf"
                      @onSelectDefect="selectDefect"
                    />
                  </div>

                  <div class="row">
                    <div class="col-xs-12 text-center" style="padding-top:10px" v-show="defectsOpenInDevManuf.length > 0">
                        <oiChartCtsImpactedXDefects 
                          title = "CTs Impactados X Defeitos Abertos" 
                          :dataSource="ctsImpactedXDefects" 
                        />
                    </div>
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
    margin-top: 5px;
    height: 40px;
    width: 40px;
  }
</style>