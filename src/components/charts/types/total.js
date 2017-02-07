export default function () {
  return {
    chart: {
      type: 'gauge',
      backgroundColor: 'transparent'
    },
    credits: { enabled: false },
    exporting: { buttons: { contextButton: { text: 'Exportar', symbol: 'circle', symbolStrokeWidth: 1, symbolFill: '#a4edba', symbolStroke: '#330033', menuItems: null, onclick: function () { this.exportChart() } } } },
    lang: { noData: 'Sem dados para mostrar' },
    title: { text: '', y: 0, style: { fontSize: 14, fontWeight: 'bold' } },
    yAxis: {
      min: 0,
      max: 0,
      tickPixelInterval: 0,
      minorTickInterval: 'auto',
      tickColor: '#666',
      title: { text: '' },
      plotBands: [],
      labels: {step: 2}
    },
    tooltip: { pointFormat: '' },
    pane: { startAngle: -170, endAngle: 170 },
    plotOptions: {
      gauge: {
        dataLabels: {
          enabled: true,
          format: ''
        }
      }
    },
    series: []
  }
}
