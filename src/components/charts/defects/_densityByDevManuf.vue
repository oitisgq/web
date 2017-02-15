<script>
  import Vue from 'vue'

  import VueHighcharts from 'vue-highcharts'
  import Highcharts from 'highcharts/highstock'

  Vue.use(VueHighcharts, { Highcharts })
  
  import chartNormal from 'components/charts/types/normal'

  export default {
    name: 'densityByDevManuf',

    props: {
      densityFiltered: { type: Array }
    },

    data () {
      return {
        options: chartNormal
      }
    },

    computed: {
      densityByFab () {
        let dataTarget = []
        let dataSource = this.densityFiltered
        dataSource.forEach(source => {
          let index = dataTarget.findIndex(target => target.devManufacturing === source.devManufacturing)
          if (index > -1) {
            dataTarget[index].qtyDefects = dataTarget[index].qtyDefects + source.qtyDefects
            dataTarget[index].qtyCTs = dataTarget[index].qtyCTs + source.qtyCTs
          } else {
            dataTarget.push({
              devManufacturing: source.devManufacturing,
              qtyDefects: source.qtyDefects,
              qtyCTs: source.qtyCTs,
              density: 0.0
            })
          }
        })
        dataTarget.forEach(target => {
          target.density = parseFloat((target.qtyDefects / (target.qtyCTs ? target.qtyCTs : 1)) * 100)
        })
        dataTarget = dataTarget.filter(i => i.density > 0)
        dataTarget = dataTarget.sort((a, b) => a.density > b.density ? 1 : (a.density < b.density ? -1 : 0))

        return dataTarget
      },
      seriesData: function () {
        return this.densityByFab.map(i => ({ name: i.devManufacturing, y: i.density }))
      }
    },

    mounted () {
      this.options.title.text = 'Por Fáb.Desenvolvimento.'
      this.options.yAxis.title.text = '% Densidade'
      this.options.tooltip.pointFormat = '{point.y:.2f}%'
      this.options.series.name = 'Densidade'
      this.options.plotOptions.bar.dataLabels.format = '{point.y:.0f}'

      // this.options.xAxis.categories = this.categories
    },

    updated () {
      this.options.series = [ { name: 'densidade', colorByPoint: true, data: this.seriesData } ]

      console.log('densityByDevManuf updated')
    },

    methods: {
      updateCredits: function () {
        var chart = this.$refs.densityByDevManuf.chart
        this.options.title.text = 'updateCredits'
        chart.credits.update({
          style: {
            color: '#' + (Math.random() * 0xffffff | 0).toString(16)
          }
        })
      },

      redraw: function () {
        var chart = this.$refs.densityByDevManuf.chart
        this.options.title.text = 'redraw'
        chart.redraw()
      },

      getDensityBySystems (devManufacturing) {
        let dataTarget = []
        let dataSourceLocal = []

        if (devManufacturing !== '') {
          dataSourceLocal = this.densityFiltered.filter(i => i.devManufacturing === devManufacturing)
        }
        dataSourceLocal.forEach(i => {
          let index = dataTarget.findIndex(target => target.system === i.system)
          if (index > -1) {
            dataTarget[index].qtyDefects = dataTarget[index].qtyDefects + i.qtyDefects
            dataTarget[index].qtyCTs = dataTarget[index].qtyCTs + i.qtyCTs
          } else {
            dataTarget.push({
              system: i.system,
              qtyDefects: i.qtyDefects,
              qtyCTs: i.qtyCTs,
              density: 0
            })
          }
        })

        dataTarget.forEach(target => {
          target.density = parseFloat(parseFloat(target.qtyDefects / (target.qtyCTs ? target.qtyCTs : 1) * 100).toFixed(2))
        })

        dataTarget = dataTarget.filter(i => i.density > 0)
        dataTarget = dataTarget.sort((a, b) => a.density > b.density ? 1 : (a.density < b.density ? -1 : 0))
        return dataTarget
      }
    }

  }
</script>

<template>
  <div>
    <button @click="updateCredits">update credits</button>
    <button @click="redraw">redraw</button>
    <highcharts :options="options" ref="densityByDevManuf"></highcharts>
  </div>    
</template>

<style>

</style>