export default function () {
  return {
    chart: {
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

    xAxis: {
      type: '',
      title: { text: '' },
      categories: [],
      crosshair: true
    },

    yAxis: [
      { // Primary yAxis
        title: {
          text: 'Temperature'
        }
      }, { // Secondary yAxis
        title: {
          text: 'Rainfall'
        },
        opposite: true
      }
    ],

    tooltip: {
      pointFormat: '',
      shared: true
    },

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
