<script>
  const Highcharts = require('highcharts')

  const highchartsExporting = require('highcharts-exporting')
  highchartsExporting(Highcharts)

  const highchartsMore = require('highcharts-more')
  highchartsMore(Highcharts)

  import chartParametersTotal from 'components/charts/types/Total'

  export default {
    name: 'chartDetectableInDev',

    props: {
      value: { type: Object }
    },

    data () {
      return {
        parameters: chartParametersTotal(),
        chart: undefined
      }
    },

    updated () {
      this.loadParameters()
      this.chart = Highcharts.chart(this.$el, this.parameters)
    },

    methods: {
      loadParameters () {
        let limitSupGreen = this.value.qtyReference
        let limitSupRed = limitSupGreen > this.value.qtyTotal ? limitSupGreen : this.value.qtyTotal

        this.parameters.title.text = 'Detectável em Desenv.'
        this.parameters.yAxis.title.text = 'Defeitos'
        this.parameters.plotOptions.gauge.dataLabels.format = '{point.y:.0f} def'
        this.parameters.yAxis.max = limitSupRed
        this.parameters.yAxis.plotBands = [
          {from: 0, to: limitSupGreen, color: '#00CC00'},
          {from: limitSupGreen, to: limitSupRed, color: '#FF3300'}
        ]
        this.parameters.tooltip.pointFormat = 'Formula: Detectáveis / Total * 100<br>' +
          'Qt.Total: ' + this.value.qtyTotal + '<br>' +
          'Qt.Detectável: ' + this.value.qtyDetectableInDev + ' def. (' + this.value.percentDetectableInDev + '%)<br>' +
          'Qt.Referência: ' + this.value.qtyReference + ' def. (' + this.value.percentReference + '%)'
  
        this.parameters.series = [ { name: 'Horas', colorByPoint: true, data: [ this.value.qtyDetectableInDev ] } ]
      }
    }
  }
</script>

<template>
  <div style="width:250px; height:250px; margin:0 auto">
    {{value}}
  </div>
</template>

<style>
</style>