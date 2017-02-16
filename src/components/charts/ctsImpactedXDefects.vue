<script>
  const Highcharts = require('highcharts')

  const highchartsMore = require('highcharts-more')
  highchartsMore(Highcharts)

  const highchartsNoData = require('highcharts-no-data-to-display')
  highchartsNoData(Highcharts)

  import chartParameters from 'components/charts/types/timelineMultipleAxis'

  export default {
    name: 'ctsImpactedXDefects',

    props: {
      dataSource: { type: Array },
      title: { type: String }
    },

    data () {
      return {
        parameters: chartParameters(),
        chart: undefined
      }
    },

    updated () {
      console.log('updated')
      this.loadParameters()
      this.chart = Highcharts.chart(this.$el, this.parameters)
    },

    methods: {
      loadParameters () {
        this.parameters.title.text = this.title
        this.parameters.yAxis[0].title.text = 'CTs Impactados'
        this.parameters.yAxis[1].title.text = 'Defeitos'

        this.parameters.xAxis.categories =
          this.dataSource.map(i => i.date)

        this.parameters.series = [
          {
            name: 'CTs Impactados',
            type: 'column',
            tooltip: { pointFormat: 'CTs Impactados: {point.y:.0f}<br>' },
            data: this.dataSource.map(i => i.qtyCtsImpactedAcum)
          }, {
            name: 'Total',
            type: 'spline',
            yAxis: 1,
            tooltip: { pointFormat: 'Total Defeitos: {point.y:.0f}<br>' },
            data: this.dataSource.map(i => i.qtyDefectsTotAcum)
          }, {
            name: 'Ambiente',
            type: 'spline',
            yAxis: 1,
            tooltip: { pointFormat: 'Defeitos Ambiente: {point.y:.0f}<br>' },
            data: this.dataSource.map(i => i.qtyDefectsAmbAcum)
          }, {
            name: 'Construção',
            yAxis: 1,
            type: 'spline',
            tooltip: { pointFormat: 'Defeitos Construção: {point.y:.0f}' },
            data: this.dataSource.map(i => i.qtyDefectsConsAcum)
          }
        ]
      }
    }
  }
</script>

<template>
  <div style="width:900px; height:500px; margin:0 auto">
    {{dataSource}}
  </div>
</template>

<style>
</style>