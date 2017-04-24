<script>
  const Highcharts = require('highcharts')

  const highchartsMore = require('highcharts-more')
  highchartsMore(Highcharts)

  const highcharts3d = require('highcharts-3d')
  highcharts3d(Highcharts)

  const highchartsExporting = require('highcharts-exporting')
  highchartsExporting(Highcharts)

  const highchartsDrilldown = require('highcharts-drilldown')
  highchartsDrilldown(Highcharts)

  const highchartsNoData = require('highcharts-no-data-to-display')
  highchartsNoData(Highcharts)

  import chartParametersTimeline from 'components/charts/types/timeline'

  export default {
    name: 'chartExecutionProject',

    props: {
      dataSource: { type: Object },
      title: { type: String }
    },

    data () {
      return {
        parameters: chartParametersTimeline(),
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
        this.parameters.yAxis.title.text = 'Qt.CTs'
        /*
        this.parameters.tooltip.pointFormat = 'Formula: Reabertos / Total * 100<br>' +
          'Qt.Total: ' + this.dataSource.qtyTotal + ' def.<br>' +
          'Qt.Reaberto: ' + this.dataSource.qtyReopened + ' def. (' + this.dataSource.percentReopened + '%)<br>' +
          'Qt.Referência: ' + this.dataSource.qtyReference + ' def. (' + this.dataSource.percentReference + '%)'
        */

        // this.parameters.plotOptions.bar.dataLabels.format = '{point.y:.0f}'

        this.parameters.xAxis.categories = this.dataSource.columns

        this.parameters.series = [
          {
            name: 'Planejado',
            tooltip: { pointFormat: 'Qt. CTs: {point.y:.0f}<br> Percentual: {point.percent:.2f}%' },
            data: this.dataSource.rows[1].valuesAcum.map(i => ({
              name: i.date,
              y: i.value,
              percent: i.percent
            }))
          },
          {
            name: 'Realizado',
            color: '#00e600',
            tooltip: { pointFormat: 'Qt. CTs: {point.y:.0f}<br> Percentual: {point.percent:.2f}%' },
            data: this.dataSource.rows[2].valuesAcum.map(i => ({
              name: i.date,
              y: i.value,
              percent: i.percent
            }))
          },
          {
            name: 'GAP',
            color: '#ff3333',
            tooltip: { pointFormat: 'Qt. CTs: {point.y:.0f}<br> Percentual: {point.percent:.2f}%' },
            data: this.dataSource.rows[4].valuesAcum.map(i => ({
              name: i.date,
              y: i.value,
              percent: i.percent
            }))
          }
        ]
      }
    }
  }
</script>

<template>
  <div style="width:450px; height:250px; margin:0 auto">
    {{dataSource}}
  </div>
</template>

<style>
</style>