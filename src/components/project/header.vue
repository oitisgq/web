<script>
  export default {
    name: 'projectHeader',
    props: {
      project: { type: Object }
    }
  }
</script>

<template>
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