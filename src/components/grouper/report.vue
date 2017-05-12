<script>
  // import ServicesProjectXgrouper from 'src/modules/ProjectXgrouper/services'

  import oiProjectGridReport from 'src/components/project/gridReport.vue'

  export default {
    name: 'grouperView',

    components: { oiProjectGridReport },

    props: {
      item: { type: Object }
    },

    data () {
      return {
        showModal: true
      }
    }
  }
</script>

<template>
    <div id="grouper" class="row well well-sm oi-well">
      <div class="col-xs-12 col-md-1" style="margin:0; border:0; padding:0" v-show="item.grouper.type === 'STATUS'">
          <label class="fd-label">Farol:</label>
          <div class="text-left" style="padding-bottom:5px">
            <img alt="Farol Verde" src="../../assets/images/verde.png"  v-show="item.grouper.trafficLight === 'VERDE'">
            <img alt="Farol Amarelo" src="../../assets/images/amarelo.png" v-show="item.grouper.trafficLight === 'AMARELO'">
            <img alt="Farol Vermelho" src="../../assets/images/vermelho.png" v-show="item.grouper.trafficLight === 'VERMELHO'">
          </div>
      </div>
    

      <div class="col-xs-12 col-md-5" style="margin:0; border:0; padding:0">
        <div>
          <label class="fd-label">Nome:</label>
        </div>
        <div>
          <label 
            class="fd-content" 
            v-html="item.grouper.name"
          />
        </div>
      </div>

      <div class="col-xs-12 col-md-6" style="margin:0; border:0; padding:0" v-show="item.grouper.type === 'STATUS'">
        <div>
          <label class="fd-label">Resumo Executivo Agrupador:</label>
        </div>
        <div>
          <label 
            class="fd-content" 
            v-html="item.grouper.executiveSummary ? item.grouper.executiveSummary : 'Sem dados!'"
          />
        </div>
      </div>

      <div class="col-xs-12" style="margin:0; border:0; padding:0">
        <label class="fd-label">Projetos:</label>
        <oiProjectGridReport
          :items="item.projects"
        />
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
    font-size: large;
  }

  .fd-content {
    margin: 0; 
    border: 0; 
    padding: 3px; 
    text-align: left;
    font-weight: normal;
    font-size: large;
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
