<script>
  export default {
    name: 'projectShow',

    props: {
      project: {}
    }
  }
</script>

<template>
  <div id="projects">
    <div id="cabecalho" class="row well well-sm oi-well">
      <div class="col-xs-12 col-md-6 oi-col">
        <div>
          <label class="fd-label">Projeto:</label>
          <label class="fd-content">{{project.subprojectDelivery}}</label>
        </div>
      </div>
      <div class="col-xs-12 col-md-6 oi-col">
        <div>
          <label class="fd-label">Nome:</label>
          <label class="fd-content">{{project.name}}</label>
        </div>
      </div>
      <div class="col-xs-12 col-md-6 oi-col">
        <div>
          <label class="fd-label">GP:</label>
          <label class="fd-content">{{project.GP}}</label>
        </div>
      </div>
      <div class="col-xs-12 col-md-6 oi-col">
        <div>
          <label class="fd-label">N3:</label>
          <label class="fd-content">{{project.N3}}</label>
        </div>
      </div>
    </div>    

    <div id="farol" class="row well well-sm oi-well">
      <div class="col-xs-12 oi-col">
        <div>
          <label class="fd-label">Farol: &nbsp</label>
          <label class="fd-content">{{project.trafficLight}}</label>
        </div>
      </div>

      <div class="col-xs-12 col-md-6 oi-col">
        <div>
          <label class="fd-label">Causa Raíz:</label>
          <label class="fd-content">{{project.rootCause}}</label>
        </div>
      </div>

      <div class="col-xs-12 col-md-6 oi-col">
        <div>
          <label class="fd-label">Plano de Ação: </label>
          <label class="fd-content">{{project.actionPlan}}</label>
        </div>
      </div>
    </div>

    <div id="demais" class="row well well-sm oi-well">
      <div class="col-xs-12 col-md-6 oi-col">
        <div>
          <label class="fd-label">Informativo: </label>
          <label class="fd-content">{{project.informative}}</label>
        </div>
      </div>

      <div class="col-xs-12 col-md-6 oi-col">
        <div>
          <label class="fd-label">Pontos de Atenção: </label>
          <label class="fd-content">{{project.attentionPoints}}</label>
        </div>
      </div>

      <div class="col-xs-12 oi-col">
        <div>
          <label class="fd-label">Pontos de Atenção dos Indicadores: </label>
          <label class="fd-content">{{project.attentionPointsOfIndicators}}</label>
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
    padding: 3px; 
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
    padding: 0; 
    font-weight:normal;
  }
  
</style>