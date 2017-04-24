import vue from 'vue'
import vuex from 'vuex'

import actions from './actions'
import getters from './getters'
import mutations from './mutations'
import state from './state'

vue.use(vuex)

export default new vuex.Store({ actions, getters, mutations, state })
