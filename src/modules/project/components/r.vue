<script>
  import oiProjectHeader from 'components/project/header'

  export default {
    name: 'ProjectsR',

    components: { oiProjectHeader },

    data () {
      return {
        email: {
          from: 'sgq@oi.net.br',
          to: '',
          subject: '',
          url: ''
        }
      }
    },

    methods: {
      searchItem () {
        this.$router.push({ name: 'projectMain' })
      },

      showProject () {
        this.$router.push({ name: 'projectReport' })
      },

      sendReportByEmail () {

      }
    }
  }
</script>

<template>
    <div class="container-fluid well well-sm">

        <!--<oiProjectHeader :project="project"/>-->

        <a class="btn btn-xs my-tool-tip oi-icon"
          @click="showProject"
          title="Exibir Projecto">
          <span class="glyphicon glyphicon-list-alt"></span>
        </a>

        <a class="btn btn-xs my-tool-tip oi-icon"
          @click="searchItem"
          data-toggle="tooltip"
          title="Pesquisa">
          <span class="glyphicon glyphicon-search"></span>
        </a>   
      
        <div class="text-center">
          <div class="form-group">
              <input type="email" class="form-control" id="email" placeholder="email de destino" v-model="email.to"></textarea>
          </div>

          <div class="form-group">
              <textarea class="form-control" rows="3" id="subject" placeholder="título da menssagem" v-model="email.subject"></textarea>
          </div>

          <a class="btn btn-primary btn-xs" id="alert-target"
            role="button"
            @click="sendReportByEmail">
            Enviar
          </a>            
        </div>

        <div class="text-left">
          <a class="btn btn-primary btn-xs" 
            role="button" 
            data-toggle="collapse" 
            href="#xpto52" 
            aria-expanded="false" 
            aria-controls="collapseExample">
            Exibir Report
          </a>            

          <div id="xpto52" class="collapse" >
              <oiReport
                :project="project"
                :densityTotal="densityTotal"
                :averangeTimeTotal="averangeTimeTotal"
                :reopenedTotal="reopenedTotal"
                :detectableInDevTotal="detectableInDevTotal"
                :statusByProjectGroupDayTop5="statusByProjectGroupDayTop5"
                :statusByProjectGroupDayTop30="statusByProjectGroupDayTop30"
                :statusByProjectGroupMonth="statusByProjectGroupMonth"
                :defectStatus="defectStatus"
                :defectGroupOrigin="defectGroupOrigin"
                :defectsOpenInTestManuf="defectsOpenInTestManuf"
                :defectsOpenInDevManuf="defectsOpenInDevManuf"
                :ctsImpactedXDefects="ctsImpactedXDefects"
                :productivityXDefects="productivityXDefects"
                :productivityXDefectsGroupWeekly="productivityXDefectsGroupWeekly"
              />
          </div>
        </div>
      </div>
</template>

<style scoped>
  input {
     min-width: 100%
  }
  .container {
    margin-top: 15px;
  }
  .oi-well {
    margin: 0;
    border: 0;
    padding: 0;
  }
  .oi-icon {
    font-size: medium;
  }
</style>