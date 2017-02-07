import * as mT from './mutations-types'

export default {
  [mT.setUser] (state, user) {
    state.user = user
  },
  [mT.setToken] (state, token) {
    state.token = token
  }
}
