<script>
  import oiModal from 'components/modal'
  import oiDefectShow from 'components/defect/show'
  import serviceDefectDetail from 'src/services/defectDetail'

  export default {
    name: 'gridDefectsOpen',

    components: { oiModal, oiDefectShow },

    props: {
      project: { type: Object },
      defects: { type: Array },
      id: { type: String }
    },

    data () {
      return {
        selectedDefect: {},
        selectedDefectDetail: {}
      }
    },

    methods: {
      onSelectDefect (defectSelected) {
        this.selectedDefect = defectSelected
        serviceDefectDetail.getByDefect(this.project, this.selectedDefect).then(resp => {
          this.selectedDefectDetail = resp.data
        })

        // this.$emit('onSelectDefect', defect)
      }
    }
  }
</script>

<template>
  <div id="projectsGrid">
    <table class="table table-condensed table-striped table-hover table-bordered">
        <thead>
            <tr>
                <td class="text-center" style="padding:0">
                    <font size="2px"></font>
                </td>                                

                <td class="text-center" style="padding:0">
                    <font size="2px">Nº</font>
                </td>

                <td class="text-center" style="padding:0">
                    <font size="2px">Status</font>
                </td>

                <td class="text-center" style="padding:0">
                    <font size="2px">Encam.Para</font>
                </td>

                <td class="text-center" style="padding:0">
                    <font size="2px">Sistema Def.</font>
                </td>

                <td class="text-center" style="padding:0">
                    <font size="2px">Aging</font>
                </td>

                <td class="text-center" style="padding:0">
                    <font size="2px">Ping Pong</font>
                </td>

            </tr>
        </thead>
        <tbody v-for="defect in defects">
            <tr>
                <td class="text-center" style="padding:0; white-space: nowrap">
                  <a class='btn btn-xs my-tool-tip' 
                    title="Exibir"
                    style="padding:0;margin:0; text-right"
                    data-toggle="modal"
                    :data-target="'#' + id"                    
                    @click="onSelectDefect(defect)">
                    <i class='glyphicon glyphicon-list-alt'></i>
                  </a>
                </td>

                <td class="text-center" style="padding:0">
                    <font size="2px">{{defect.defect}}</font>
                </td>

                <td class="text-center" style="padding:0">
                    <font size="1.5px">{{defect.status}}</font>
                </td>

                <td class="text-center" style="padding:0">
                    <font size="1.5px">{{defect.forwardedTo}}</font>
                </td>

                <td class="text-center" style="padding:0">
                    <font size="1.5px">{{defect.defectSystem}}</font>
                </td>

                <td class="text-center" style="padding:0">
                    <font size="1.5px">{{defect.agingDisplay}}</font>
                </td>

                <td class="text-center" style="padding:0">
                    <font size="1.5px">{{defect.pingPong}}</font>
                </td>
            </tr>
        </tbody> 
    </table>


    <oiModal :id="id">
        <oiDefectShow
            :defect="selectedDefectDetail"
        />
    </oiModal>

  </div>
</template>

<style>

</style>
