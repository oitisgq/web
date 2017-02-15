<script>
  export default {
    name: 'gridDefectsOpen',

    props: {
      defects: {type: Array}
    },

    data () {
      return {
        defect: {}
      }
    },

    methods: {
      onSelectDefect (defect) {
        this.$emit('onSelectDefect', defect)
      }
    }
  }
</script>

<template>
  <div id="projectsGrid">
    <table class="table table-condensed table-striped table-hover table-bordered">
        <thead>
            <tr>
                <th class="text-center" style="padding:0">
                    <font size="2px"></font>
                </th>                                

                <th class="text-center" style="padding:0">
                    <font size="2px">Nº</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2px">Status</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2px">Encam.Para</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2px">Sistema Def.</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2px">Aging (h)</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2px">Ping Pong</font>
                </th>

            </tr>
        </thead>
        <tbody v-for="defect in defects">
            <tr>
                <td class="text-center" style="padding:0; white-space: nowrap">
                  <a class='btn btn-xs my-tool-tip' 
                    data-toggle="tooltip" 
                    title="Exibir" 
                    style="padding:0;margin:0; text-right"
                    @click="onSelectDefect(defect)">
                    <i class='glyphicon glyphicon-list-alt'></i>
                  </a>
                </td>

                <td class="text-center" style="padding:0">
                    <font size="2px">{{defect.defect}}</font>
                </td>

                <td class="text-left" style="padding:0">
                    <font size="1.5px">{{defect.status}}</font>
                </td>

                <td class="text-left" style="padding:0">
                    <font size="2px">{{defect.forwardedTo}}</font>
                </td>

                <td class="text-left" style="padding:0">
                    <font size="2px">{{defect.defectSystem}}</font>
                </td>

                <td class="text-right" style="padding:0">
                    <font size="2px">{{defect.aging}}</font>
                </td>

                <td class="text-right" style="padding:0">
                    <font size="2px">{{defect.pingPong}}</font>
                </td>
            </tr>
        </tbody> 
    </table>
  </div>
</template>

<style>

</style>
