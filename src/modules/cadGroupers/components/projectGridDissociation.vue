<script>
  export default {
    name: 'projectGridDissociation',

    props: {
      items: {type: Array}
    },
    methods: {
      dissociation (item) {
        this.$emit('onDissociation', item)
      }
    }
  }
</script>

<template>
  <div>
    <table class="table table-condensed table-striped table-hover table-bordered" >
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
        <tbody v-for="item in items">
            <tr>
                <td class="text-center" style="padding:0; margin:0; border:0">
                  <a class='btn oi-icon' 
                    title="Desassociar" 
                    style="padding:0;margin:0; text-right"
                    @click="dissociation(item)">
                    <span class="glyphicon glyphicon-minus-sign"></span>
                  </a>                  
                </td>
            
                <td class="text-center" style="padding:0;">
                    <div class="text-center" style="padding:0;">
                        <img alt="Farol Verde" src="../../../assets/images/verde.png" v-show="item.trafficLight === 'VERDE'" class="img">
                        <img alt="Farol Amarelo" src="../../../assets/images/amarelo.png" v-show="item.trafficLight === 'AMARELO'" class="img">
                        <img alt="Farol Vermelho" src="../../../assets/images/vermelho.png" v-show="item.trafficLight === 'VERMELHO'" class="img">
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
    margin: 0; 
    border: 0; 
    padding: 0;
    height: 18px;
    width: 18px;
  }  
</style>
