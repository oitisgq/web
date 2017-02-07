import * as mT from './mutations-types'
import { getUser } from '../services'

export const attemptLogin = (context, payload) => {
  return getUser(payload.networkLogin, payload.password)
    .then(data => {
      context.commit(mT.setToken, data.email)
      context.commit(mT.setUser, data)
    })
}
