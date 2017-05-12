import vueResource from 'src/http/vueResource'
import webApiPath from 'src/http/webApiPath'

const resource = vueResource.resource(webApiPath.defaultServer + '/projects_{/id}')

// const currentProfile = JSON.parse(window.localStorage.getItem('current-profile'))

export default {
  getAll () {
    return resource.get({})
  },
  getOne (id) {
    return resource.get({id: id})
  }
}
