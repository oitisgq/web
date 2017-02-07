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
          { portugues: 'AZUL', ingles: 'blue' }
        ]
      }
    },

    methods: {
      onSelectItem (item, state) {
        this.$emit('onSelectItem', item, state)
      },
      color (item) {
        return this.colors.filter(function (obj) {
          return obj.portugues === item
        })[0].ingles
      }
    }
  }
</script>

<template>
  <div id="projectsGrid">
    <table class="table table-condensed table-striped table-hover" style="margin-bottom:0;padding-bottom:0">
        <thead>
            <tr>
                <th class="text-center" style="padding:0">
                    <font size="2">Proj.</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2">Nome</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2">Clas.</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2">Rel.</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2">Estado</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2">Farol</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2">Ações</font>
                </th>                                
            </tr>
        </thead>
        <tbody v-for="item in dataSource">
            <tr style="padding:0">
                <td class="text-left" style="padding:0">
                    <font size="2">{{item.subprojectDelivery}}</font>
                </td>

                <td class="text-left" style="padding:0">
                    <font size="2">{{item.name}}</font>
                </td>

                <td class="text-center" style="padding:0">
                    <font size="2">{{item.classification}}</font>
                </td>

                <td class="text-center" style="padding:0">
                    <font size="2">{{item.release}}</font>
                </td>

                <td class="text-center" style="padding:0">
                    <font size="2">{{item.state}}</font>
                </td>

                <td class="text-center" :style="'color:' + color(item.trafficLight)">
                    <font size="2">{{item.trafficLight}}</font>
                </td>

                <td class="text-right" style="padding:0; white-space: nowrap">
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