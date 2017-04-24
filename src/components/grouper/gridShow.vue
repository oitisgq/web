<script>
  export default {
    name: 'grouperGrid',

    props: {
      items: {type: Array}
    },

    methods: {
      selectItem (item, state) {
        this.$emit('onSelectItem', item, state)
      }
    }
  }
</script>

<template>
  <div>
    <table class="table table-condensed table-striped table-hover" style="margin-bottom:0;padding-bottom:0">
        <thead>
            <tr>
                <th class="text-center" style="padding:0; width:26px;">
                </th>                                
           
                <!--
                <th class="text-center">
                    <font size="2px">Farol</font>
                </th>                                
                -->

                <th class="text-left">
                    <font size="2px">Nome</font>
                </th>                                
            </tr>
        </thead>
        <tbody v-for="item in items">
            <tr>
                <td class="text-right" style="padding:0; padding-top:5px; margin:0; border:0; width:26px; white-space: nowrap">
                  <a class='btn' 
                    data-toggle="tooltip" 
                    title="Exibir" 
                    style="padding:0;margin:0; text-right"
                    @click="selectItem(item, 'show')">
                    <i class='glyphicon glyphicon-list-alt'></i>
                  </a>
                </td>

                <!--
                <td class="text-center" style="padding:0;">
                    <div class="text-center" style="padding:0;">
                        <img alt="Farol Verde" src="../../assets/images/verde.png" v-show="item.trafficLight === 'VERDE'" class="img">
                        <img alt="Farol Amarelo" src="../../assets/images/amarelo.png" v-show="item.trafficLight === 'AMARELO'" class="img">
                        <img alt="Farol Vermelho" src="../../assets/images/vermelho.png" v-show="item.trafficLight === 'VERMELHO'"class="img">
                    </div>
                </td>
                -->

                <td class="text-left" >
                    <font size="2px" v-text="item.name"></font>
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
    margin-top: 8px; 
    border: 0; 
    padding: 0;
    height: 18px;
    width: 18px;
  }  
</style>
