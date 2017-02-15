<script>
  export default {
    name: 'ProjectsGrid',

    props: {
      dataSource: {type: Array}
    },

    data () {
      return {
        selected_: [],

        project: {},

        colors: [
          { portugues: 'VERMELHO', ingles: 'red' },
          { portugues: 'VERDE', ingles: 'green' },
          { portugues: 'AMARELO', ingles: 'gold' }
        ]
      }
    },

    methods: {
      onSelectItem (item, state) {
        this.$emit('onSelectItem', item, state)
      },

      color (item) {
        let index = this.colors.findIndex(i => i.portugues === item)
        return (index > -1) ? this.colors[index].ingles : ''
      }
    }
  }
</script>

<template>
  <div id="projectsGrid">
    <table class="table table-condensed table-striped table-hover table-bordered" style="margin-bottom:0; border:0; padding-bottom:0">
        <thead>
            <tr>
                <th class="text-center" style="padding:0">
                    <font size="2px">Proj.</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2px">Nome</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2px">Clas.</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2px">Rel.</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2px">Estado</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2px">Farol</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2px">Ações</font>
                </th>                                
            </tr>
        </thead>
        <tbody v-for="item in dataSource">
            <tr>
                <td class="text-center" style="padding:0">
                    <font size="2px">{{item.subprojectDelivery}}</font>
                </td>

                <td class="text-left" style="padding:0">
                    <font size="1.5px">{{item.name}}</font>
                </td>

                <td class="text-center" style="padding:0">
                    <font size="2px">{{item.classification ? item.classification.substring(0,3) : ''}}</font>
                </td>

                <td class="text-center" style="padding:0">
                    <font size="2px">{{item.release}}</font>
                </td>

                <td class="text-center" style="padding:0">
                    <font size="2px">{{item.state}}</font>
                </td>

                <td class="text-center" :style="'color:' + color(item.trafficLight)">
                    <font size="2px">{{item.trafficLight.substring(0,4)}}</font>
                </td>

                <td class="text-center" style="padding:0; white-space: nowrap">
                  <a class='btn btn-xs my-tool-tip' 
                    data-toggle="tooltip" 
                    title="Exibir" 
                    style="padding:0;margin:0; text-right"
                    @click="onSelectItem(item, 'show')">
                    <i class='glyphicon glyphicon-list-alt'></i>
                  </a>
                </td>
            </tr>
        </tbody> 
    </table>
  </div>
</template>

<style>

</style>
