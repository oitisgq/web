import Vue from 'vue'

import router from './router'
import store from './vuex'

import app from 'components/app.vue'

import 'babel-polyfill'

/* eslint-disable no-new */

new Vue({
  el: '#app',
  router,
  store,
  render: h => h(app)
})

// router.start(App, '#app')
