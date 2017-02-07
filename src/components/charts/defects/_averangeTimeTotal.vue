<script>
  const Highcharts = require('highcharts')

  const highchartsExporting = require('highcharts-exporting')
  highchartsExporting(Highcharts)

  const highchartsMore = require('highcharts-more')
  highchartsMore(Highcharts)

  import parametersTotal from 'components/charts/types/Total'

  export default {
    name: 'chartAverangeTimeTotal',

    props: {
      _value: { type: Number },
      _severity: { type: String }
    },

    data () {
      return {
        parameters: parametersTotal(),
        chart: {}
      }
    },

    mounted () {
      console.log(this._value)
      console.log(this._severity)
      // this.loadParameters()
    },

    // beforeDestroy () {
    //   this.target.destroy()
    // },

    methods: {
      loadParameters () {
        let plotBands = []
        let limitSupRed = 0

        if (this.value > 0) {
          if (this.severity === 'LOW') {
            limitSupRed = (this.value > 80 ? this.value : 80)
            plotBands.push(
              { from: 0, to: 16, color: '#00CC00' },
              { from: 16, to: limitSupRed, color: '#FF3300' }
            )
          } else if (this.severity === 'MEDIUM') {
            limitSupRed = (this.value > 50 ? this.value : 50)
            plotBands.push(
              { from: 0, to: 8, color: '#00CC00' },
              { from: 8, to: limitSupRed, color: '#FF3300' }
            )
          } else if (this.severity === 'HIGH') {
            limitSupRed = (this.value > 30 ? this.value : 30)
            plotBands.push(
              { from: 0, to: 4, color: '#00CC00' },
              { from: 4, to: limitSupRed, color: '#FF3300' }
            )
          }
        } else {
          plotBands.push({ from: 0, to: 0, color: '#00CC00' })
        }

        this.parameters.title.text = 'Tempo Médio'
        this.parameters.yAxis.title.text = '% Dens'
        this.parameters.yAxis.max = (this.value <= 100) ? 100 : this.value
        this.parameters.yAxis.plotBands = plotBands
        this.yAxis.title.text = 'Horas'
        this.parameters.series.name = 'Densidade'
        this.parameters.series = [ { name: 'densidade', colorByPoint: true, data: [ this.value ] } ]

        this.chart = Highcharts.chart(this.$el, this.parameters)
        // this.target = Highcharts.chart('#chartId', this.parameters)

        // this.$el = '#chartId'
        // this.target = Highcharts.chart(this.$el, this.parameters)
        // this.target = Highcharts.chart('#chartId', this.parameters)
        /* eslint-disable */
        // this.parameters.chart.renderTo = 'chartdensityTotal'
        // let chartdensityTotal = new Highcharts.Chart(this.parameters)
        /* eslint-enable */
      }
    }
  }
</script>

<template>
  <div style="width:250px; height:250px; margin:0 auto"/>
</template>

<style>
</style>