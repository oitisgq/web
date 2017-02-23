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
          { portugues: 'VERMELHO', ingles: 'white' },
          { portugues: 'VERDE', ingles: 'white' },
          { portugues: 'AMARELO', ingles: 'white' }
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
  <div id="projectsGrid" class="myClass" >
    <table id="tabela" class="table table-condensed table-striped table-hover table-bordered" style="margin-bottom:0; border:0; padding-bottom:0">
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

                <td class="text-center">
                     <img alt="Farol Verde" src="../../../assets/images/verde.png" height="20" width="20" align="middle" v-show="item.trafficLight === 'VERDE'">
                     <img alt="Farol Amarelo" src="../../../assets/images/amarelo.png" height="20" width="20" v-show="item.trafficLight === 'AMARELO'">
                     <img alt="Farol Vermelho" src="../../../assets/images/vermelho.png" height="20" width="20"  v-show="item.trafficLight === 'VERMELHO'">
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

<style scoped>
    

    
</style>
