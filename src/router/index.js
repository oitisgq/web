import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

import routes from './routes'
import beforeEach from './beforeEach'

const router = new VueRouter({
  routes: routes,
  linkActiveClass: 'active',
  hashbang: false,
  history: true
})

router.beforeEach(beforeEach)

export default router
