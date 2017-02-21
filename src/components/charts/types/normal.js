export default function () {
  return {
    chart: {
      type: 'bar',
      backgroundColor: 'transparent'
    },
    title: {
      text: 'title',
      margin: 0,
      style: { fontSize: 12, fontWeight: 'bold', color: '#6b6b47' }
    },
    credits: { enabled: false },
    exporting: { enabled: false },
    lang: { drillUpText: '◁', noData: 'Sem dados!' },
    xAxis: { type: 'category', labels: { style: { fontSize: '9px' } } },
    yAxis: { title: { text: '' }, plotLines: [ { value: 0, width: 1, color: '#FF8080' } ] },
    tooltip: { pointFormat: '' },
    plotOptions: {
      bar: {
        allowPointSelect: true,
        cursor: 'pointer',
        depth: 35,
        dataLabels: { allowOverlap: false, enabled: true, format: '' }
      }
    },
    legend: { enabled: false },
    series: []
  }
}
