import store from '../vuex'

const isCadProjectsRoute = route => route.path.indexOf('cadProjects') !== -1
const isCadGroupers = route => route.path.indexOf('cadGroupers') !== -1
// const isAuthRoute = route => route.path.indexOf('/auth') !== -1
const isLogged = () => store.getters.isLogged

export default (to, from, next) => {
  if ((isCadProjectsRoute(to) || isCadGroupers(to)) && !isLogged()) {
    next('/auth?to=' + to.name)
  } else {
    next()
  }
}
