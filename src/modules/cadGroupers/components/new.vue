<script>
  // import servicesCadgroupers from 'src/modules/cadgroupers/services'

  export default {
    name: 'cadProjectsNew',

    props: {
      item: { type: Object }
    },

    data () {
      return {
        config: {
          language: 'pt_br',
          events: {
            'froalaEditor.initialized': function () {
            }
          }
        },
        lastItem: undefined,
        subprojectDelivery: '',
        projects: []
      }
    },

    /*
    updated () {
      if (this.lastItem !== this.item.grouper.id) {
        this.lastItem = this.item.grouper.id
        servicesCadgroupers.getProjects()
          .then(resp => {
            this.projects = resp.data.filter(i =>
              this.item.projects.findIndex(o => o.id === i.id) === -1
            )
          }
        )
      }
    },
    */

    /*
    updated () {
      if (this.subprojectDelivery !== this.item.subprojectDelivery) {
        this.subprojectDelivery = this.item.subprojectDelivery
        this.loadIterations()
        this.loadIterationsActive()
        this.loadIterationsSelected()
      }
    },
    */
    methods: {
    }

  }
</script>

<template>
  <div>
    <div id="cabecalho" class="row well well-sm oi-well">
      <div class="col-xs-12 oi-col">
        <div class="input-grouper input-grouper-sm" style="width:100%">
          <label class="fd-label">Nome:&nbsp;&nbsp;</label>
          <input type="text" v-model="item.name" style="width:100%" maxlength="150">
        </div>
      </div>

      <div class="col-xs-12 oi-col">
        <label class="fd-label">Tipo:&nbsp;&nbsp;</label>
        <input type="radio" id="STATUS" value="STATUS" v-model="item.type">
        <label class="fd-label" for="STATUS">Status</label>

        <input type="radio" id="CONSULTA" value="CONSULTA" v-model="item.type">
        <label class="fd-label" for="CONSULTA">Consulta</label>    
      </div> 
    </div> 

    <div id="abas" class="row well well-sm oi-well" >
      <div class="row well-sm oi-well" v-show="item.type === 'STATUS'">
          <label class="fd-label">Resumo Executivo:&nbsp;&nbsp;</label>
          <div id="executiveSummary" class="tab-pane fade in" style="padding:0; margin:0; text-align: center">
            <div class="col-xs-12 oi-col">
                <froala :tag="'textarea'" :config="config" v-model="item.executiveSummary"></froala>
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

  img {
    margin-top: 4px;
    vertical-align: top;
    height: 12px;
    width: 12px;
  }  
</style>