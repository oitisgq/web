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
  <div style="width:100%">
    <table class="table table-condensed table-striped table-hover table-bordered" style="width:100%">
        <thead style="width:100%">
            <tr>
                <th class="text-center" style="padding:0; width:11px;">
                    Farol
                </th>                                

                <th class="text-center" style="padding:0; font-size:11px">
                    Proj.
                </th>

                <th class="text-center" style="padding:0; font-size:11px">
                    Nome
                </th>

                <th class="text-center" style="padding:0; font-size:11px">
                    UN
                </th>

                <th class="text-center" style="padding:0; font-size:11px">
                    N4
                </th>

                <th class="text-center" style="padding:0; font-size:11px">
                    GP
                </th>

                <th class="text-center" style="padding:0; font-size:11px">
                    GAP
                </th>

                <th class="text-center" style="padding:0; white-space: nowrap; font-size:11px">
                    Resumo Executivo
                </th>
            </tr>
        </thead>
        <tbody v-for="item in items" style="width:100%">
            <tr>
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
  img {
    margin-top: 8px; 
    border: 0; 
    padding: 0;
    height: 11px;
    width: 11px;
  }  
</style>
