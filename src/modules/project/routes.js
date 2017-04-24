import oiMain from './components/main.vue'
import oiViewModel from './components/viewModel.vue'
import oiReport from './components/report.vue'
// import oiViewModel2 from './components/viewModel2.vue'

export default [
    { path: '/project', name: 'project', component: oiMain },
    { path: '/project/show/:subproject/:delivery', name: 'projectShow', component: oiViewModel },
    { path: '/project/report/:subproject/:delivery', name: 'projectReport', component: oiReport }
    // { path: '/project/report/:subproject/:delivery', name: 'projectReport', component: oiReport }
]
