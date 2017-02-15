<script>
  export default {
    name: 'projectShow',

    components: {

    },

    // ctsImpactedByDefects: { type: Object },

    props: {
      defect: { type: Object }
    },
  }
</script>

<template>
  <div id="defect">
    <div id="cabecalho" class="row well well-sm oi-well" >
      <div class="col-xs-12 col-md-6" style="margin:0; border:0; padding:0; padding-left:5px">
        <div>
          <label class="fd-label">Número:</label>
          <label class="fd-content">{{defect.subprojectDelivery}}</label>
        </div>
      </div>
      <div class="col-xs-12 col-md-6" style="margin:0; border:0; padding:0; padding-left:5px">
        <div>
          <label class="fd-label">Nome:</label>
          <label class="fd-content">{{defect.name}}</label>
        </div>
      </div>
      <div class="col-xs-12 col-md-6" style="margin:0; border:0; padding:0; padding-left:5px">
        <div>
          <label class="fd-label">GP:</label>
          <label class="fd-content">{{defect.GP}}</label>
        </div>
      </div>

      <div class="col-xs-12 col-md-6" style="margin:0; border:0; padding:0; padding-left:5px">
        <div>
          <label class="fd-label">N3:</label>
          <label class="fd-content">{{defect.N3}}</label>
        </div>
      </div>

      <div class="col-xs-12" style="margin:0; border:0; padding:0; padding-left:5px">
        <div>
          <label class="fd-label">Objetivos (Clarity):</label>
          <label class="fd-content">{{defect.objective}}</label>
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
                          <img alt="Farol Verde" src="../../assets/images/verde.png"  v-show="defect.trafficLight === 'VERDE'">
                          <img alt="Farol Amarelo" src="../../assets/images/amarelo.png" v-show="defect.trafficLight === 'AMARELO'">
                          <img alt="Farol Vermelho" src="../../assets/images/vermelho.png" v-show="defect.trafficLight === 'VERMELHO'">
                        </div>
                    </div>

                    <div class="col-xs-12 col-md-5">
                      <div>
                        <label class="fd-label">Causa Raíz</label>
                      </div>
                      <div>
                        <label class="fd-content">{{defect.rootCause ? defect.rootCause : 'Sem dados!'}}</label>
                      </div>
                    </div>

                    <div class="col-xs-12 col-md-6">
                      <div>
                        <label class="fd-label">Plano de Ação</label>
                      </div>
                      <div>
                        <label class="fd-content">{{defect.actionPlan ? defect.actionPlan : 'Sem dados!'}}</label>
                      </div>
                    </div>
                  </div>

                  <div id="Informative_AttentionPoints" class="row">
                      <div class="col-xs-12 col-md-6">
                        <div id="Informative">
                          <label class="fd-label">Informativo</label>
                        </div>
                        <div>
                          <label class="fd-content">{{defect.informative ? defect.informative : 'Sem dados!'}}</label>
                        </div>
                      </div>

                      <div class="col-xs-12 col-md-6">
                        <div id="AttentionPoints">
                          <label class="fd-label">Pontos de Atenção</label>
                        </div>
                        <div>
                          <label class="fd-content">{{defect.attentionPoints ? defect.attentionPoints : 'Sem dados!'}}</label>
                        </div>
                      </div>
                  </div>

                  <div id="AttentionPointsInd" class="row">
                      <div>
                        <label class="fd-label">Pontos de Atenção dos Indicadores</label>
                      </div>
                      <div class="row">
                        <label class="fd-content">{{defect.attentionPointsOfIndicators  ? defect.attentionPointsOfIndicators : 'Sem dados!'}}</label>
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
                      <oiOpenedXClosedXCancelled 
                        title = "Abertos X Fechados X Cancelados" 
                        :defectStatus="defectStatus" 
                      />
                  </div>
                  <div class="col-xs-12 col-lg-6 text-center" style="padding-top:10px">
                      <oiGroupOrigin 
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
                    <oiGridDefectsOpen :data="defectsOpenInTestManuf"/>
                  </div>

                  <div class="col-xs-12 col-lg-6 text-center" style="padding-top:10px" v-show="defectsOpenInDevManuf.length > 0">
                    <label class="fd-label">Aberto na Fáb. Desenv.</label>
                    <oiGridDefectsOpen :data="defectsOpenInDevManuf"/>
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