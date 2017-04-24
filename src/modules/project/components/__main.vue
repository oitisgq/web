<script>
  import oiSelection from './selection.vue'
  import oiShow from 'components/project/show.vue'
  import oiReport from 'components/project/showReport.vue'

  export default {
    name: 'ProjectsMain',

    components: { oiSelection, oiShow, oiReport },

    data () {
      return {
        project: {},
        state: 'search'
      }
    }
  }
</script>

<template>
    <div class="container-fluid well well-sm">

      <!-- CABEÇALHO -->
      <div class="row">
        <div class="col-xs-6">
          <label>Projetos</label>
        </div>
      </div>

      <router-view/>
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