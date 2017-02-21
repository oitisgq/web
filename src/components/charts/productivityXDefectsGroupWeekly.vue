<script>
  const Highcharts = require('highcharts')

  const highchartsMore = require('highcharts-more')
  highchartsMore(Highcharts)

  const highchartsNoData = require('highcharts-no-data-to-display')
  highchartsNoData(Highcharts)

  import chartParameters from 'components/charts/types/timelineMultipleAxis'

  export default {
    name: 'productivityXDefects',

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
      this.loadParameters()
      this.chart = Highcharts.chart(this.$el, this.parameters)
    },

    methods: {
      loadParameters () {
        this.parameters.title.text = this.title
        this.parameters.yAxis[0].title.text = 'Produtividade / Realizado / Defeitos'
        this.parameters.yAxis[1].title.text = 'Média CTs Dia'
        this.parameters.xAxis.title.text = 'Semanas'

        this.parameters.xAxis.categories = this.dataSource.map(i => i.fullWeekNumber)

        this.parameters.series = [
          {
            name: 'Produtividade',
            type: 'column',
            tooltip: { pointFormat: 'Produtividade: {point.y:.0f}<br>' },
            data: this.dataSource.map(i => i.productivity)
          }, {
            name: 'Realizado',
            type: 'column',
            tooltip: { pointFormat: 'Realizado: {point.y:.0f}<br>' },
            data: this.dataSource.map(i => i.realized)
          }, {
            name: 'Tot.Def.',
            type: 'column',
            color: '#008000',
            tooltip: { pointFormat: 'Total Defeitos: {point.y:.0f}<br>' },
            data: this.dataSource.map(i => i.qtyDefectsTotAcum)
          }, {
            name: 'Def.Amb.',
            type: 'column',
            color: '#0000FF',
            tooltip: { pointFormat: 'Defeitos Ambiente: {point.y:.0f}<br>' },
            data: this.dataSource.map(i => i.qtyDefectsAmbAcum)
          }, {
            name: 'Def.Const.',
            type: 'column',
            color: '#FF5733',
            tooltip: { pointFormat: 'Defeitos Construção: {point.y:.0f}<br>' },
            data: this.dataSource.map(i => i.qtyDefectsConsAcum)
          }, {
            name: 'Média CTs Dia',
            color: '#FFA500',
            type: 'spline',
            yAxis: 1,
            tooltip: { pointFormat: 'Média CTs Dia: {point.y:.0f}' },
            data: this.dataSource.map(i => i.realizedAverage)
          }
        ]
      }
    }
  }
</script>

<template>
  <div style="width:1000px; height:400px; margin:0 auto">
    {{dataSource}}
  </div>
</template>

<style>
</style>