let options = {
  chart: {
    type: 'bar',
    backgroundColor: 'transparent',
    events: {
      drillup: null
    }
  },
  title: { text: '' },
  xAxis: { type: 'category', categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'] },
  yAxis: { title: {text: ''}, plotLines: [{value: 0, width: 1, color: '#FF8080'}] },
  tooltip: { pointFormat: '' },
  legend: {enabled: false},
  series: [{
    name: 'Defeitos',
    colorByPoint: true,
    data: null
  }]
}

export default options
