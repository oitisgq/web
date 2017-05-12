import appMain from './components/main.vue'
import oiShow from './components/show.vue'
import oiReport from './components/report.vue'

export default [
  { path: '/grouper', name: 'grouper', component: appMain },
  { path: '/grouper/show/:grouper', name: 'grouperShow', component: oiShow },
  { path: '/grouper/report/:grouper', name: 'grouperReport', component: oiReport }
]
