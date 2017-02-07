export default function () {
  return {
    chart: {
      type: 'spline',
      backgroundColor: 'transparent'
    },
    credits: { enabled: false },
    exporting: { buttons: { contextButton: { text: 'Exportar', symbol: 'circle', symbolStrokeWidth: 1, symbolFill: '#a4edba', symbolStroke: '#330033', menuItems: null, onclick: function () { this.exportChart() } } } },
    lang: { noData: 'Sem dados para mostrar' },
    title: { text: '', y: 0, style: { fontSize: 14, fontWeight: 'bold' } },
    xAxis: { categories: [] },
    yAxis: { title: {text: ''}, plotLines: [{value: 0, width: 1, color: '#FF8080'}] },
    tooltip: { pointFormat: '' },
    plotOptions: {
      bar: {
        allowPointSelect: true,
        cursor: 'pointer',
        depth: 35,
        dataLabels: { allowOverlap: false, enabled: true, format: '' }
      }
    },
    legend: { layout: 'horizontal', itemDistance: 1, align: 'center', verticalAlign: 'bottom', borderWidth: 0, x: 0, y: 0 },
    series: []
  }
}
