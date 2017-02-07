export default function () {
  return {
    chart: {
      type: 'bar',
      backgroundColor: 'transparent',
      events: {}
    },
    credits: { enabled: false },
    exporting: { buttons: { contextButton: { text: 'Exportar', symbol: 'circle', symbolStrokeWidth: 1, symbolFill: '#a4edba', symbolStroke: '#330033', menuItems: null, onclick: function () { this.exportChart() } } } },
    lang: { drillUpText: '◁ Voltar', noData: 'Sem dados para mostrar' },
    title: { text: '', y: 0, style: { fontSize: 14, fontWeight: 'bold' } },
    xAxis: { type: 'category', labels: { style: { fontSize: '9px' } } },
    yAxis: { title: { text: '' }, plotLines: [ { value: 0, width: 1, color: '#FF8080' } ] },
    tooltip: { pointFormat: '' },
    plotOptions: {
      bar: {
        allowPointSelect: true,
        cursor: 'pointer',
        depth: 35,
        dataLabels: { allowOverlap: false, enabled: true, format: '' },
        events: {}
      }
    },
    legend: { enabled: false },
    series: [],
    drilldown: { series: {} }
  }
}
