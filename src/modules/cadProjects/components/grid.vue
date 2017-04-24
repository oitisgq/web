<script>
  export default {
    name: 'cadProjectsGrid',

    props: {
      dataSource: {type: Array}
    },

    data () {
      return {
        project: {},

        colors: [
          { portugues: 'VERMELHO', ingles: 'red' },
          { portugues: 'VERDE', ingles: 'green' },
          { portugues: 'AZUL', ingles: 'blue' }
        ]
      }
    },

    methods: {
      onSelectItem (project, state) {
        this.$emit('onSelectItem', project, state)
      },

      color (item) {
        // return this.colors.filter(function (obj) {
        //   return obj.portugues === item
        // })[0].ingles
        return ''
      }
    }
  }
</script>

<template>
  <div id="cadProjectsGrid">
    <table class="table table-condensed table-striped table-hover" style="margin-bottom:0;padding-bottom:0">
        <thead>
            <tr>
                <th class="text-center" style="padding:0; width:26px;">
                </th>                                
           
                <th class="text-center" style="padding:0; width:26px;">
                    <font size="2px">Farol</font>
                </th>                                

                <th class="text-center" style="padding:0">
                    <font size="2px">Clas.</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2px">Rel.</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2px">Proj.</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2px">Nome</font>
                </th>


                <th class="text-center" style="padding:0; width:130px;">
                    <font size="2px">Estado</font>
                </th>              
            </tr>
        </thead>
        <tbody v-for="item in dataSource">
            <tr>
                <td class="text-right" style="padding:0; padding-top:5px; margin:0; border:0; white-space: nowrap">
                  <a class='btn btn-xs my-tool-tip' 
                    data-toggle="tooltip" 
                    title="Editar" 
                    style="padding:0;margin:0; text-right"
                    @click="onSelectItem(item, 'edit')">
                    <span class="glyphicon glyphicon glyphicon-pencil"></span>
                  </a>                  
                  <a class='btn btn-xs my-tool-tip' 
                    data-toggle="tooltip" 
                    title="Exibir" 
                    style="padding:0;margin:0; text-right"
                    @click="onSelectItem(item, 'show')">
                    <i class='glyphicon glyphicon-list-alt'></i>
                  </a>
                </td>

                <td class="text-center" :style="'color:' + color(item.trafficLight)" style="padding:0;padding-top:4px;">
                    <div class="text-center" style="padding:0;">
                        <img alt="Farol Verde" src="../../../assets/images/verde.png" v-show="item.trafficLight === 'VERDE'" style="padding:0; margin:0; border:0">
                        <img alt="Farol Amarelo" src="../../../assets/images/amarelo.png" v-show="item.trafficLight === 'AMARELO'" style="padding:0; margin:0; border:0">
                        <img alt="Farol Vermelho" src="../../../assets/images/vermelho.png" v-show="item.trafficLight === 'VERMELHO'" style="padding:0; margin:0; border:0">
                    </div>
                </td>

                <td class="text-center" style="padding:1px">
                    <font size="2px">{{item.classification ? item.classification.substring(0,3) : ''}}</font>
                </td>

                <td class="text-center" style="padding:1px">
                    <font size="2px">{{item.release}}</font>
                </td>

                <td class="text-center" style="padding:1px">
                    <font size="2px">{{item.subprojectDelivery}}</font>
                </td>

                <td class="text-left" style="padding:1px">
                    <font size="1.5px">{{item.name}}</font>
                </td>

                <td class="text-center" style="padding:1px">
                    <font size="1.5px">{{item.state}}</font>
                </td>


            </tr>
        </tbody> 
    </table>
  </div>
</template>

<style scoped>
  .oi-icon {
    font-size: medium;
  }
  img {
    border: 0; 
    padding-top: 15px; 
    height: 15px;
    width: 15px;
  }  
</style>
