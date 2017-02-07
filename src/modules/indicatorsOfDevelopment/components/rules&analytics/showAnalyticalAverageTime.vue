<script>
export default {
  name: 'showAnalyticalAverageTime',

  props: {

    title: {type: String},
    dataSource: {type: Array}
  }
}
</script>

<template>
  <span>
            <h4 style="margin-top:0px"><strong>{{title}}</strong></h4>
        <table class="table table-condensed table-striped table-hover" style="font-size=6px" >
            <thead>
                <tr>
                    <th style="padding:0px">
                        <font size="2" class="text-nowrap">Execução
                        </font>
                    </th>
                    <th style="padding:0px">
                        <font size="2" class="text-nowrap">Projeto
                        </font>
                    </th>
                    <th style="padding:0px">
                        <font size="2" class="text-nowrap">Fáb. Desenv
                        </font>
                    </th>
                    <th style="padding:0px">
                        <font size="2" class="text-nowrap">Sistema
                        </font>
                    </th>
                    <th style="padding:0px">
                        <font size="2" class="text-nowrap">Qte Defeitos
                        </font>
                    </th>
                    <th style="padding:0px">
                        <font size="2" class="text-nowrap">Qte Horas
                        </font>
                    </th>    
                    <th style="padding:0px">
                        <font size="2" class="text-nowrap">T.Médio
                        </font>
                    </th>                                                       
                </tr>
            </thead>

            <tbody v-for="item in dataSource">
                <tr>
                    <td style="padding:0px">
                        <font size="1">{{item.date}}</font>
                    </td>
                    <td style="padding:0px">
                        <font size="1">{{item.project}}</font>
                    </td>
                    <td style="padding:0px">
                        <font size="1">{{item.devManufacturing}}</font>
                    </td>
                    <td style="padding:0px">
                        <font size="1">{{item.system}}</font>
                    </td>
                    <td style="padding:0px">
                        <font size="1">{{item.qtyDefects}}</font>
                    </td>
                    <td style="padding:0px">
                        <font size="1">{{item.qtyHours}}</font>
                    </td>
                    <td style="padding:0px">
                        <font size="1">{{item.Media}}</font>
                    </td>
                </tr>
            </tbody>
        </table>  
  </span>
</template>