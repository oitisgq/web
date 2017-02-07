export default function () {
  return {
    chart: {
      type: 'bar',
      backgroundColor: 'transparent',
      events: {}
    },
    title: { text: '', y: 0, style: { fontSize: 14, fontWeight: 'bold' } },
    credits: { enabled: false },
    exporting: { enabled: false },
    lang: { noData: 'Sem dados para mostrar' },
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
