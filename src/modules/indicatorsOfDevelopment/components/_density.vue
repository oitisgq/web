<script>
/* eslint-disable */
  export default {
    name: 'oiDensity',

    props: {
      devManufacturersSelected: {type: Array},
      systemsSelected: {type: Array},
      projectsSelected: {type: Array},
      density: {type: Array},
      densityFab:{type: Array},
      densityDate:{type: Array},
      densityTotal:{type: Array}
    },

    components: {},

    data () {
      return {
     /*   densityFiltered: [],
        densityDate: [],
        densityFab: [],
        densityTotal: 0,
        densityDevManufSelected: '',
        densitySystemSelected: '',
        dataTarget: [] */
      }
    },

    methods: {
     
      // Gráficos //
      
    /*  chartDensityByDate () {
        let Categories = this.densityDate.map(i => i.date)
        let Series = [
          {
            name: 'Real',
            data: this.densityDate.map(i => i.density)
          },
          {
            name: 'Aceitável',
            color: '#00CC00',
            data: this.densityDate.map(i => 10)
          },
          {
            name: 'Moderada',
            color: '#FFFF0D',
            data: this.densityDate.map(i => 20)
          },
          {
            name: 'Alta',
            color: '#FF9E0D',
            data: this.densityDate.map(i => 30)
          }
        ] 
        document.getElementById('#chartdensityTemporal').highcharts({
          chart: {type: 'spline', backgroundColor: 'transparent'},
          title: {text: 'Visão Temporal'},
          xAxis: {categories: Categories},
          yAxis: {title: {text: '% Densidade'},
            plotLines: [{value: 0, width: 1, color: '#FF8080'}]
          },
          tooltip: {
            pointFormat: '{point.y:.2f}%'
          },
          legend: {layout: 'horizontal', itemDistance: 1, align: 'center', verticalAlign: 'bottom', borderWidth: 0, x: 0, y: 0},
          align: 'center',
          series: Series
        })
      }, 
      chartDensityTotal () {
        document.getElementById('#chartdensityTotal').highcharts({
            chart: {type: 'gauge', backgroundColor: 'transparent'},
            title: {text: 'Total'},
            yAxis: {min: 0,
                max: 100,
                tickPixelInterval: 30,
                tickColor: '#666',
                title: {text: '% Dens'},
                plotBands: [
                    {from: 0, to: 10, color: '#00CC00'},
                    {from: 10, to: 20, color: '#FFFF0D'},
                    {from: 20, to: 30, color: '#FF9E0D'},
                    {from: 30, to: 100, color: '#FF3300'}
                ]
            },
            plotOptions: {
                gauge: {
                    dataLabels: {
                        enabled: true,
                        format: '{point.y:.0f}%'
                    }
                }
            },
            tooltip: {
                pointFormat: '{point.y:.2f}%'
            },
            pane: {
                        startAngle: -170,
                        endAngle: 170
                    },
            series: [
                {name: 'Densidade',
                    data: [this.densityTotal]}]
        })
      }, */
    },

    // this.processDensity()

    beforeCreate () {
      console.log('density - beforeCreate')
    },

    created () {
      console.log('density - created')
    },

    beforeMount () {
      console.log('density - beforeMount')
    },

    mounted () {
      console.log('density - mounted')
    },

    beforeUpdate () {
      console.log('density - beforeUpdate')
    },

    updated () {
      console.log('density - updated')
    },

    beforeDestroy () {
      console.log('density - beforeDestroy')
    },

    destroyed () {
      console.log('density - beforeUpdate')
    }

  }
  
</script>

<template>
 <span>
    <center>
        <h4 v-show="densityDevManufSelected != ''" style="margin:3px"><b>{{densityDevManufSelected}}</b></h4>
        <hr style="margin:0; height: 7px; border: 0; box-shadow: 0 7px 7px -7px #d9d9d9 inset">

        <div class="col-xs-12 col-md-6 col-lg-4">
            <div id="chartdensityFab" style="width:300px; height:500px; margin:0 auto"></div>
        </div>
        <div class="col-xs-12 col-md-6 col-lg-4">
            <div id="chartdensityTemporal" style="width:300px; height:300px; margin:0"></div>
        </div>
        <div class="col-xs-12 col-md-6 col-lg-4">  
            <div id="chartdensityTotal" style="width:300px; height:300px; margin:0 auto"></div>
        </div>

     <!--   <div class="row">
            <div class="col-sm-12">
                <button 
                    type="button" 
                    style="margin-top:3px"
                    class="btn btn-xs"
                    data-toggle="modal" 
                    data-target="#oiDensityModalRules">Regras
                </button>
                <oiDensityModalRules></oidensitymodalrules>

                <button 
                    type="button" 
                    style="margin-top:3px"
                    class="btn btn-xs"
                    data-toggle="modal" 
                    data-target="#densityAnalyticalModal">Analítico
                </button>
                <oi-show-analytical-density
                    title="Analítico de 'Densidade'" 
                    :data-source="densityFiltered"
                ></oi-show-analytical-density>
            </div>           
        </div>  -->
    </center>  
 </span>    
                
</template>