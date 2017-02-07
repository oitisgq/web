<script>
  export default {
    name: 'cadProjectsEdit',

    props: {
      project: {}
    }

  }
</script>

<template>
  <div id="cadProjectsEdit">
    <div id="cabecalho" class="row well well-sm oi-well">
      <div class="col-xs-12 col-md-6 oi-col">
        <label class="fd-label">Projeto:</label>
        <label class="fd-content">{{project.subprojectDelivery}}</label>
      </div>
      <div class="col-xs-12 col-md-6 oi-col">
        <label class="fd-label">Nome:</label>
        <label class="fd-content">{{project.name}}</label>
      </div>
    </div>    

    <div id="farol" class="row well well-sm oi-well">
      <div class="col-xs-12 oi-col">
        <label class="fd-label">Farol: &nbsp</label>

        <input type="radio" id="green" value="VERDE" v-model="project.trafficLight">
        <label for="green">Verde</label>

        <input type="radio" id="yellow" value="AMARELO" v-model="project.trafficLight">
        <label for="yellow">Amarelo</label>

        <input type="radio" id="red" value="VERMELHO" v-model="project.trafficLight">
        <label for="red">Vermelho</label>
      </div>

      <div class="col-xs-12 col-md-6 oi-col">
        <label class="fd-label">Causa Raíz:</label>
        <textarea id="opiniao"
          rows="2" name="opiniao" 
          v-model="project.rootCause"
          wrap="hard">
        </textarea>
      </div>

      <div class="col-xs-12 col-md-6 oi-col">
        <label class="fd-label">Plano de Ação: </label>
        <textarea id="opiniao"
          rows="2" name="opiniao" 
          v-model="project.actionPlan"
          wrap="hard"> 
        </textarea>
      </div>
    </div>

    <div id="demais" class="row well well-sm oi-well">
      <div class="col-xs-12 col-md-6 oi-col">
        <label class="fd-label">Informativo: </label>
        <textarea id="opiniao" 
          rows="3" name="opiniao" 
          v-model="project.informative"
          wrap="hard">
        </textarea>
      </div>

      <div class="col-xs-12 col-md-6 oi-col">
        <label class="fd-label">Pontos de Atenção: </label>
        <textarea id="opiniao"
          rows="3" name="opiniao" 
          v-model="project.attentionPoints"
          wrap="hard">
        </textarea>
      </div>

      <div class="col-xs-12 oi-col">
        <label class="fd-label">Pontos de Atenção dos Indicadores: </label>
        <textarea id="opiniao"
          rows="3" name="opiniao" 
          v-model="project.attentionPointsOfIndicators"
          wrap="hard">
        </textarea>
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
    font-weight: normal;
  }

  label[for="green"] {
    color: green;
  }

  label[for="yellow"] {
    color: yellow;
  }

  label[for="red"] {
    color: red;
  }

  textarea {
    min-width: 100%
  }
</style>