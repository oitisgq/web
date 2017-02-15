<script>
  const Highcharts = require('highcharts')

  const highchartsExporting = require('highcharts-exporting')
  highchartsExporting(Highcharts)

  const highchartsMore = require('highcharts-more')
  highchartsMore(Highcharts)

  import chartParametersTotal from 'components/charts/types/Total'

  export default {
    name: 'chartDensityTotal',

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
        this.parameters.title.text = 'Densidade'
        this.parameters.yAxis.title.text = '%'
        this.parameters.plotOptions.gauge.dataLabels.format = '{point.y:.0f}%'
        this.parameters.yAxis.max = (this.value.density <= 100) ? 100 : this.value.density

        this.parameters.yAxis.plotBands = [
          {from: 0, to: 10, color: '#00CC00'},
          {from: 10, to: 20, color: '#FFFF0D'},
          {from: 20, to: 30, color: '#FF9E0D'},
          {from: 30, to: this.parameters.yAxis.max, color: '#FF3300'}
        ]

        this.parameters.tooltip.pointFormat = 'Formula: Defeitos / CTs * 100 <br>' +
          'Qt.Defeitos: ' + this.value.qtyDefects + '<br>' +
          'Qt.CTs: ' + this.value.qtyCTs + '<br>' +
          'Densidade: ' + this.value.density + '%'

        this.parameters.series = [ { name: 'densidade', colorByPoint: true, data: [ this.value.density ] } ]
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