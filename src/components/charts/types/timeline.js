export default function () {
  return {
    chart: {
      type: 'spline',
      zoomType: 'xy',
      backgroundColor: 'transparent'
    },

    title: {
      text: 'title',
      margin: 0,
      style: { fontSize: 12, fontWeight: 'bold', color: '#6b6b47' }
    },

    credits: { enabled: false },
    exporting: { enabled: false },
    lang: { noData: 'Sem dados!' },
    xAxis: { type: '' },

    yAxis: {
      title: {
        text: ''
      },
      plotLines: [
        {
          value: 0,
          width: 1,
          color: '#FF8080'
        }
      ]
    },
    tooltip: { pointFormat: '' },
    plotOptions: {
      bar: {
        allowPointSelect: true,
        cursor: 'pointer',
        depth: 35,
        dataLabels: { allowOverlap: false, enabled: true, format: '' }
      }
    },
    legend: {
      layout: 'horizontal',
      itemDistance: 1,
      align: 'center',
      verticalAlign: 'bottom',
      borderWidth: 0,
      x: 0,
      y: 0,
      margin: 0,
      itemStyle: {
        color: '#6b6b47',
        fontWeight: 'normal',
        fontSize: '12px'
      }
    },
    series: []
  }
}
