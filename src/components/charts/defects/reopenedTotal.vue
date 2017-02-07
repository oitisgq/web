<script>
  const Highcharts = require('highcharts')

  const highchartsExporting = require('highcharts-exporting')
  highchartsExporting(Highcharts)

  const highchartsMore = require('highcharts-more')
  highchartsMore(Highcharts)

  import chartParametersTotal from 'components/charts/types/Total'

  export default {
    name: 'chartReopenedTotal',

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
        let limitSupGreen = this.value.percentReference
        let limitSupRed = this.value.percentReopened > 100 ? this.value.percentReopened : 100

        this.parameters.title.text = 'Reabertos'
        this.parameters.yAxis.title.text = '%'
        this.parameters.yAxis.max = (this.value.percentReopened <= 100) ? 100 : this.value.percentReopened
        this.parameters.yAxis.plotBands = [
            {from: 0, to: limitSupGreen, color: '#00CC00'},
            {from: limitSupGreen, to: limitSupRed, color: '#FF3300'}
        ]
        this.parameters.tooltip.pointFormat = 'Formula: Reabertos / Total * 100<br>' +
          'Qt.Total: ' + this.value.qtyTotal + ' def.<br>' +
          'Qt.Reaberto: ' + this.value.qtyReopened + ' def. (' + this.value.percentReopened + '%)<br>' +
          'Qt.Referência: ' + this.value.qtyReference + ' def. (' + this.value.percentReference + '%)'

        this.parameters.series = [ { name: '% Def', colorByPoint: true, data: [ this.value.percentReopened ] } ]
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