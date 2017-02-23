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
  import oiModal from 'components/modal.vue'

  import oiGridMonitAcum from './gridMonitAcum'
  import oiGridMonitDay from './gridMonitDay'
  import oiGridDefectsOpen from './gridDefectsOpen'

  // import HttpService from 'src/http/HttpService'

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
      oiChartCtsImpactedXDefects,
      oiChartProductivityXDefects,
      oiChartProductivityXDefectsGroupWeekly,
      oiModal
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

      emailCurrentPage () {
        // let y1 = document.querySelector('#projects').innerHTML
        let y2 = `
          <!DOCTYPE html>
          <html lang="en">
          <head>
              <meta charset="UTF-8">
              <title>Document</title>
          </head>
          <body>
            <h1>sffdfdsffd</h1>
          </body>
          </html>`
        window.location.href = 'mailto:joao.frade@oi.net.br?subject=' + document.title + '&body=' + encodeURIComponent(y2)
        console.log('11111')
        console.log(y2)
        /*
        let xpto = new HttpService()
        console.log('22222')
        xpto
          .postEmail('http://localhost:55286/email', y2)
          .then(item => {
            console.log(item)
          })
          .catch(erro => {
            console.log(erro)
          })
        console.log('33333')
        */
        // console.log('-----------------------')
        // console.log(x)
        // window.print()
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

    <a href="#" @click="emailCurrentPage">Mail this page!</a>   <br>

    <a href='mailto:email@email.com?subject=Software&body=see attachment&attachment="d:/Cargas.txt"'>sdfds</a>

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

    <div id="abas" class="row well well-sm oi-well">

          <ul class="nav nav-tabs" style="margin-top:3px">
            <li class="active"><a data-toggle="tab" href="#overview" style="padding: 4px">Visão Geral</a></li>
            <li><a data-toggle="tab" href="#monitoring" style="padding: 4px">Acompanhamento</a></li>
            <li><a data-toggle="tab" href="#defects" style="padding: 4px">Defeitos</a></li>
          </ul>

          <div class="tab-content">
              <div id="overview" class="tab-pane fade in active" style="padding:5px; margin:0; text-align: center">

                  <div id="trafficLight" class="row well well-sm oi-well">
                    <div class="col-xs-1">
                        <label class="fd-label">Farol &nbsp</label>
                        <div class="text-center" style="padding-bottom:5px">
                          <img alt="Farol Verde" src="../../assets/images/verde.png"  v-show="project.trafficLight === 'VERDE'">
                          <img alt="Farol Amarelo" src="../../assets/images/amarelo.png" v-show="project.trafficLight === 'AMARELO'">
                          <img alt="Farol Vermelho" src="../../assets/images/vermelho.png" v-show="project.trafficLight === 'VERMELHO'">
                        </div>
                    </div>

                    <div class="col-xs-5">
                      <div>
                        <label class="fd-label">Causa Raíz</label>
                      </div>
                      <div>
                        <label class="fd-content">{{project.rootCause ? project.rootCause : 'Sem dados!'}}</label>
                      </div>
                    </div>

                    <div class="col-xs-6">
                      <div>
                        <label class="fd-label">Plano de Ação</label>
                      </div>
                      <div>
                        <label class="fd-content">{{project.actionPlan ? project.actionPlan : 'Sem dados!'}}</label>
                      </div>
                    </div>
                  </div>

                  <div id="Informative_AttentionPoints" class="row well well-sm oi-well">
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

                  <div id="AttentionPointsInd" class="row well well-sm oi-well">
                      <div>
                        <label class="fd-label">Pontos de Atenção dos Indicadores</label>
                      </div>
                      <div class="row">
                        <label class="fd-content">{{project.attentionPointsOfIndicators  ? project.attentionPointsOfIndicators : 'Sem dados!'}}</label>
                      </div>                      

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
                      <button 
                          type="button" 
                          style="margin-top:3px"
                          class="btn btn-xs"
                          data-toggle="modal" 
                          data-target="#definitionScurveModal">Definição
                      </button>
                      <oiModal id="definitionScurveModal">
                          <h4 style="margin-top:0; text-align:center"><strong>Gráfico de acompanhamento de Execução (Curva S).</strong></h4>
                          <p style="text-align:left">
                             <b> Planejados </b> = Qtd de CTs com campo 'Planned Exec Date' preenchido para aquele dia.
                          </p>
                          <p style="text-align:left">
                             <b> Realizado </b>= Qtd de CTs com campo 'Status = 'Passed' + 'Exec Date' = Dia relacionado.
                          </p>
                          <p style="text-align:left">
                             <b> GAP </b> = (CTs <> Passed) - (CTs = 'Passed') com planejamento para aquele dia.
                          </p>
                          <p style="text-align:left">
                             A escala temporal é baseada na SEQUÊNCIA de meses no ano (01-xx = JANEIRO; 02-XX = FEVEREIRO; etc).
                          </p>
                      </oiModal>   
                  </div>

                  <div class="col-xs-12 col-md-6 text-center" style="padding-top:10px">
                      <oiChartExecutionProject :dataSource="statusByProjectGroupDayTop30" title="Curva S dos últimos dias"/>
                      <button 
                          type="button" 
                          style="margin-top:3px"
                          class="btn btn-xs"
                          data-toggle="modal" 
                          data-target="#definitionScurveDaysModal">Definição
                      </button>
                      <oiModal id="definitionScurveDaysModal">
                          <h4 style="margin-top:0; text-align:center"><strong>Gráfico de acompanhamento de Execução (Curva S Últimos Dias).</strong></h4>
                          <p style="text-align:left">
                             <b> Planejados </b> = Qtd de CTs com campo 'Planned Exec Date' preenchido para aquele dia.
                          </p>
                          <p style="text-align:left">
                             <b> Realizado </b>= Qtd de CTs com campo 'Status = 'Passed' + 'Exec Date' = Dia relacionado.
                          </p>
                          <p style="text-align:left">
                             <b> GAP </b> = (CTs <> Passed) - (CTs = 'Passed') com planejamento para aquele dia.
                          </p>
                          <p style="text-align:left">
                             A escala temporal é baseada em dias recentes do projeto nos quais ocorreram mudanças quanto aos indicadores acima.
                          </p>
                      </oiModal>   
                  </div>

                  <div class="col-xs-12 text-center" style="padding-top:10px">
                      <oiChartProductivityXDefects
                        title = "Produtividade X Defeitos Abertos" 
                        :dataSource="productivityXDefects" 
                      />
                      <button 
                          type="button" 
                          style="margin-top:3px"
                          class="btn btn-xs"
                          data-toggle="modal" 
                          data-target="#definitionProductivityxDefects">Definição
                      </button>
                      <oiModal id="definitionProductivityxDefects">
                          <h4 style="margin-top:0; text-align:center"><strong>Gráfico de acompanhamento de Execução (Produtividade X Defeitos Abertos).</strong></h4>
                          <p style="text-align:left">
                             <b> Produtividade </b> = Qtd diária de CTs executados + reexecutados ('Passed'' e 'Failed') na tabela 'RUNS'.
                          </p>
                          <p style="text-align:left">
                             <b> Realizado </b>= Qtd de 'Passed' NOVO, ou seja, o primeiro status 'Passed' na tabela 'RUNS'.
                          </p>
                          <p style="text-align:left">
                             <b> Tot.Def. </b> = Total de defeitos abertos naquele período com 'ORIGEM = AMBIENTE and CONSTRUÇÃO'.
                          </p>
                          <p style="text-align:left">
                             <b> Def.Amb. </b> = Total de defeitos abertos com 'ORIGEM = AMBIENTE'.
                          </p>
                          <p style="text-align:left">
                             <b> Def.Const. </b> = Total de defeitos abertos com 'ORIGEM = CONSTRUÇÃO'.
                          </p>
                      </oiModal>   
                  </div>
                  
                  <div class="col-xs-12 text-center" style="padding-top:10px">
                      <oiChartProductivityXDefectsGroupWeekly
                        title = "Produtividade X Defeitos Abertos, Semanal" 
                        :dataSource="productivityXDefectsGroupWeekly" 
                      />
                      <button 
                          type="button" 
                          style="margin-top:3px"
                          class="btn btn-xs"
                          data-toggle="modal" 
                          data-target="#definitionproductivityXDefectsGroupWeekly">Definição
                      </button>
                      <oiModal id="definitionproductivityXDefectsGroupWeekly">
                          <h4 style="margin-top:0; text-align:center"><strong>Gráfico de acompanhamento de Execução (Produtividade X Defeitos Abertos, Semanal).</strong></h4>
                          <p style="text-align:left">
                             <b> Produtividade </b> = Qtd diária de CTs executados + reexecutados ('Passed'' e 'Failed') na tabela 'RUNS'.
                          </p>
                          <p style="text-align:left">
                             <b> Realizado </b>= Qtd de 'Passed' NOVO, ou seja, o primeiro status 'Passed' na tabela 'RUNS'.
                          </p>
                          <p style="text-align:left">
                             <b> Tot.Def. </b> = Total de defeitos abertos naquele período com 'ORIGEM = AMBIENTE and CONSTRUÇÃO'.
                          </p>
                          <p style="text-align:left">
                             <b> Def.Amb. </b> = Total de defeitos abertos com 'ORIGEM = AMBIENTE'.
                          </p>
                          <p style="text-align:left">
                             <b> Def.Const. </b> = Total de defeitos abertos com 'ORIGEM = CONSTRUÇÃO'.
                          </p>
                            <p style="text-align:left">
                             <b> Média CTs dia </b> = CTs Realizados / dias corridos na semana.
                          </p>
                      </oiModal>   
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
                      <button 
                          type="button" 
                          style="margin-top:3px"
                          class="btn btn-xs"
                          data-toggle="modal" 
                          data-target="#definitionctsImpactedXDefects">Definição
                      </button>
                      <oiModal id="definitionctsImpactedXDefects">
                          <h4 style="margin-top:0; text-align:center"><strong>Gráfico de acompanhamento de Execução (CTs Impactados X Defeitos Abertos").</strong></h4>
                          <p style="text-align:left">
                             <b> CTs Impact. </b> = Soma dos valores preenchidos no campo 'Qtd CTs Impactados' naquele período.
                          </p>
                          <p style="text-align:left">
                             <b> Tot.Def. </b> = Total de defeitos abertos naquele período com 'ORIGEM = AMBIENTE and CONSTRUÇÃO'.
                          </p>
                          <p style="text-align:left">
                             <b> Def.Amb. </b> = Total de defeitos abertos com 'ORIGEM = AMBIENTE'.
                          </p>
                          <p style="text-align:left">
                             <b> Def.Const. </b> = Total de defeitos abertos com 'ORIGEM = CONSTRUÇÃO'.
                          </p>
                      </oiModal>   
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