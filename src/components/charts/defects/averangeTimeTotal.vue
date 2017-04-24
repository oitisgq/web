<script>
  const Highcharts = require('highcharts')

  const highchartsExporting = require('highcharts-exporting')
  highchartsExporting(Highcharts)

  const highchartsMore = require('highcharts-more')
  highchartsMore(Highcharts)

  import chartParametersTotal from 'components/charts/types/Total'

  export default {
    name: 'chartAverangeTimeTotal',

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
        let limitSupGreen = 4
        let limitSupRed = (this.value.averageHours > 30 ? this.value.averageHours : 30)

        this.parameters.title.text = 'Tempo Médio - High'
        this.parameters.yAxis.title.text = 'Horas'
        this.parameters.plotOptions.gauge.dataLabels.format = '{point.y:.0f} h'
        this.parameters.yAxis.max = limitSupRed
        this.parameters.yAxis.plotBands = [
          {from: 0, to: limitSupGreen, color: '#00CC00'},
          {from: limitSupGreen, to: limitSupRed, color: '#FF3300'}
        ]
        this.parameters.tooltip.pointFormat = 'Formula: Horas / Defeitos<br>' +
          'Qt.Horas: ' + this.value.qtyHours + '<br>' +
          'Qt.Defeitos: ' + this.value.qtyDefects + '<br>' +
          'Tempo Médio: ' + this.value.averageHours + '(h)<br>' +
          'Tempo Limite: ' + limitSupGreen + '(h)'
  
        this.parameters.series = [ { name: 'Horas', colorByPoint: true, data: [ this.value.averageHours ] } ]
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