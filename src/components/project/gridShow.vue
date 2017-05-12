<script>
  export default {
    name: 'ProjectGridShow',

    props: {
      items: {type: Array}
    },

    methods: {
      selectItem (item) {
        this.$router.push('/project/show/' + item.subproject + '/' + item.delivery)
      }
    }
  }
</script>

<template>
  <div>
    <table class="table table-condensed table-striped table-hover table-bordered">
        <thead>
            <tr>
                <th class="text-center" style="padding:0; width:26px">
                </th>                                
            
                <th class="text-center" style="padding:0; width:26px;">
                    <font size="2px">Farol</font>
                </th>                                

                <!--
                <th class="text-center" style="padding:0">
                    <font size="2px">Clas.</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2px">Rel.</font>
                </th>
                -->

                <th class="text-center" style="padding:0">
                    <font size="2px">Proj.</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2px">Nome</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2px">UN</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2px">N4</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2px">GP</font>
                </th>

                <th class="text-center" style="padding:0">
                    <font size="2px">GAP</font>
                </th>

                <th class="text-center" style="padding:0; white-space: nowrap">
                    <font size="2px">Resumo Executivo</font>
                </th>

                <!--
                <th class="text-center" style="padding:0; white-space: nowrap">
                    <font size="2px">Causa Raiz</font>
                </th>

                <th class="text-center" style="padding:0; white-space: nowrap">
                    <font size="2px">Plano Ação</font>
                </th>

                <th class="text-center" style="padding:0; width:130px;">
                    <font size="2px">Estado</font>
                </th>
                -->
            </tr>
        </thead>
        <tbody v-for="item in items">
            <tr>
                <td class="text-center" style="padding:0; margin:0; border:0; width:26px; white-space: nowrap">
                  <!--
                  <a class='btn' 
                    data-toggle="tooltip" 
                    title="Exibir" 
                    style="padding:0;margin:0; text-right"
                    @click="selectItem(item)">
                    <i class='glyphicon glyphicon-list-alt'></i>
                  </a>

                  :onclick="'window.open(\'http://sgq.intranet/dist/index.html#/project/show/' + item.subproject + '/' + item.delivery + '\', \'newwindow\', \'fullscreen=yes, titlebar=no, toolbar=no, location=no, channelmode=0no, status=no, menubar=no, scrollbars=yes, resizable=yes\'); return false;'">
                 -->
                  <a 
                     href="#"
                     :onclick="'window.open(\'http://sgq.intranet/dist/index.html#/project/show/' + item.subproject + '/' + item.delivery + '\', \'newwindow\', \'fullscreen=yes, titlebar=no, toolbar=no, location=no, channelmode=0no, status=no, menubar=no, scrollbars=yes, resizable=yes\'); return false;'">
                     <i class='glyphicon glyphicon-list-alt' style="padding-top:4px"></i>
                  </a>

                </td>
            
                <td class="text-center" style="padding:0;">
                    <div class="text-center" style="padding:0;">
                        <img alt="Farol Verde" src="../../assets/images/verde.png" v-show="item.trafficLight === 'VERDE'" style="padding:0; margin:0; border:0">
                        <img alt="Farol Amarelo" src="../../assets/images/amarelo.png" v-show="item.trafficLight === 'AMARELO'" style="padding:0; margin:0; border:0">
                        <img alt="Farol Vermelho" src="../../assets/images/vermelho.png" v-show="item.trafficLight === 'VERMELHO'" style="padding:0; margin:0; border:0">
                    </div>
                </td>

                <td class="text-center" style="padding:1px; font-size:11px">
                    {{item.subprojectDelivery}}
                </td>

                <td class="text-left" style="padding:1px; font-size:11px">
                    {{item.name}}
                </td>

                <td class="text-left" style="padding:1px; font-size:11px">
                    {{item.UN}}
                </td>

                <td class="text-left" style="padding:1px; font-size:11px">
                    {{item.N3}}
                </td>

                <td class="text-left" style="padding:1px; font-size:11px">
                    {{item.GP}}
                </td>

                <td class="text-center" style="padding:1px; font-size:11px">
                    {{item.gap}}
                </td>
                <td class="text-left" style="padding:1px; font-size:11px">
                    <span v-html="item.informative"/>
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
