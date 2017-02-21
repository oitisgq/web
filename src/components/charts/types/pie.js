export default function () {
  return {
    chart: {
      type: 'pie',
      zoomType: 'xy',
      backgroundColor: 'transparent'
    },
    title: {
      text: 'title',
      margin: 0,
      style: { fontSize: 13, fontWeight: 'bold', color: '#6b6b47' }
    },

    tooltip: {
      pointFormat: '<b>{point.percentage:.1f}%</b> <br>{point.y:.2f}%'
    },

    credits: { enabled: false },
    exporting: { enabled: false },
    lang: { noData: 'Sem dados!' },

    navigation: {
      buttonOptions: {
        enabled: false
      }
    },

    plotOptions: {
      pie: {
        allowPointSelect: true,
        cursor: 'pointer',
        depth: 50,
        dataLabels: {
          enabled: true,
          format: '{point.name}',
          style: { fontFamily: 'arial', fontSize: '11px', fontWeight: 'normal' }
        }
      }
    },

    series: []
  }
}
