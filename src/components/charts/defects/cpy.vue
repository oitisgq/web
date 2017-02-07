<script>
  import Vue from 'vue'

  import VueHighcharts from 'vue-highcharts'
  // import VueHighchartsMore from 'highcharts-more'
  // import VueHighchartsDrilldown from 'highcharts-drilldown'
  // import VueHighcharts3d from 'highcharts-3d'
  // import VueHighchartsExporting from 'highcharts-exporting'
  
  Vue.use(VueHighcharts)
  // Vue.use(VueHighchartsMore)
  // Vue.use(VueHighchartsDrilldown)
  // Vue.use(VueHighcharts3d)
  // Vue.use(VueHighchartsExporting)
  
  import chartDrillDown from 'components/charts/types/drillDown'

  export default {
    name: 'densityByDevManuf',

    props: {
      densityFiltered: { type: Array }
    },

    data () {
      return {
        options: chartDrillDown
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
      DensityBySystems: function () {
        let _this = this
        let drillDown = []

        this.densityByFab.forEach(fab => {
          let densityBySystems = _this.getDensityBySystems(fab.devManufacturing)
          drillDown.push({
            name: fab.devManufacturing,
            id: fab.devManufacturing,
            data: densityBySystems.map(i => [i.system, i.density])
          })
        })

        return drillDown
      },
      seriesData: function () {
        return this.densityByFab.map(i => ({ name: i.devManufacturing, y: i.density, drilldown: i.devManufacturing }))
      }

    },

    mounted () {
      this.options.title.text = 'Visão Por Fáb/Sistema'
      this.options.yAxis.title.text = '% Densidade'
      this.options.tooltip.pointFormat = '{point.y:.2f}%'
      this.options.series.name = 'Densidade'
      this.options.plotOptions.bar.dataLabels.format = '{point.y:.0f}'
      console.log('densityByDevManuf mounted')
    },

    updated () {
      // this.options.xAxis.categories = this.categories

      this.options.series = [ { name: 'densidade', colorByPoint: true, data: this.seriesData } ]
      this.options.drilldown.series = this.DensityBySystems

      console.log('densityByDevManuf updated')
    },

    methods: {
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
    {{seriesData}}
    <highcharts :options="options" ref="densityByDevManuf"/>
  </div>    
</template>

<style>

</style>