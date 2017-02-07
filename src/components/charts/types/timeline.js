export default function () {
  return {
    chart: {
      type: 'spline',
      backgroundColor: 'transparent'
    },
    title: { text: '', y: 0, style: { fontSize: 14, fontWeight: 'bold' } },
    credits: { enabled: false },
    exporting: { enabled: false },
    lang: { noData: 'Sem dados para mostrar' },
    xAxis: { type: '' },
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
