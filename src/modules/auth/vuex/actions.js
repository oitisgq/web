import * as mT from './mutations-types'
import Services from '../services'

export const attemptLogin = (context, payload) => {
  /*
  return Services.getUserByCpf(payload.login, payload.password)
    .then(data => {
      context.commit(mT.setToken, data.email)
      context.commit(mT.setUser, data)
    })
  */
  return Services.getUserByCpf(payload.login, payload.cpf)
    .then(resp => {
      if (resp.data !== null) {
        context.commit(mT.setToken, resp.data.email)
        context.commit(mT.setUser, resp.data)
      }
    })
}
