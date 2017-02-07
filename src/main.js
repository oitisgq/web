import Vue from 'vue'

import router from './router'
import store from './vuex'

import app from 'components/app.vue'

/* eslint-disable no-new */

new Vue({
  el: '#app',
  router,
  store,
  render: h => h(app)
})

// outer.start(App, '#app')
