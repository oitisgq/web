<script>
  export default {
    name: 'ProjectGridShow',

    props: {
      items: {type: Array}
    }

  }
</script>

<template>
  <div>
    <table class="table table-condensed table-striped table-hover table-bordered" >
        <thead>
            <tr>
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
                <td class="text-center" style="padding:0;">
                    <div class="text-center" style="padding:0;">
                        <img alt="Farol Verde" src="../../assets/images/verde.png" v-show="item.trafficLight === 'VERDE'" style="padding:0; margin:0; border:0">
                        <img alt="Farol Amarelo" src="../../assets/images/amarelo.png" v-show="item.trafficLight === 'AMARELO'" style="padding:0; margin:0; border:0">
                        <img alt="Farol Vermelho" src="../../assets/images/vermelho.png" v-show="item.trafficLight === 'VERMELHO'" style="padding:0; margin:0; border:0">
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
    margin-top: 8px; 
    border: 0; 
    padding: 0;
    height: 18px;
    width: 18px;
  }  
</style>
