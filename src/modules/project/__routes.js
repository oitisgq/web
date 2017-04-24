import oiProjectMain from './components/main.vue'
import oiProjectSelection from './components/selection.vue'
import oiProjectShow from './components/show.vue'
import oiProjectReport from './components/r.vue'

export default [
  { name: 'projectMain',
    component: oiProjectMain,
    path: '/project',
    children:
    [
      { name: 'projectSelection', component: oiProjectSelection, path: '' },
      { name: 'projectShow', component: oiProjectShow, path: 'show/:subproject/:delivery' },
      { name: 'projectReport', component: oiProjectReport, path: 'report/:subproject/:delivery' }
    ]
  }
]
