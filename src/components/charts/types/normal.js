export default function () {
  return {
    chart: {
      type: 'bar',
      backgroundColor: 'transparent'
    },
    title: { text: '', style: { fontSize: 14, fontWeight: 'bold' } },
    xAxis: { type: 'category' },
    yAxis: { title: {text: ''}, plotLines: [{value: 0, width: 1, color: '#FF8080'}] },
    tooltip: { pointFormat: '' },
    plotOptions: {
      bar: {
        allowPointSelect: true,
        cursor: 'pointer',
        depth: 35,
        dataLabels: { allowOverlap: false, enabled: true, format: '' },
        events: {
          /*
          click: function(event) {
            if(_this.densityDevManufSelected === '') {
              _this.densityDevManufSelected = event.point.name
              _this.densityDate = _this.getDensityByDateOfDevManuf(_this.densityDevManufSelected)
              _this.densityTotal = _this.getDensityTotalOfDevManuf(_this.densityDevManufSelected)
            } else {
              _this.densitySystemSelected = event.point.name
              _this.densityDate = _this.getDensityByDateOfSystems(_this.densityDevManufSelected, _this.densitySystemSelected)
              _this.densityTotal = _this.getDensityTotalOfSystems(_this.densityDevManufSelected, _this.densitySystemSelected)
            }
            _this.chartDensityByDate()
            _this.chartDensityTotal()
          }
          */
        }
      }
    },
    legend: { enabled: false },
    series: []
  }
}
