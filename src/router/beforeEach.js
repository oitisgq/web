import store from '../vuex'

const isCadProjectsRoute = route => route.path.indexOf('cadProjects') !== -1
// const isAuthRoute = route => route.path.indexOf('/auth') !== -1
const isLogged = () => store.getters.isLogged

export default (to, from, next) => {
  if (isCadProjectsRoute(to) && !isLogged()) {
    next('/auth')
  } else {
    next()
  }
}
