import vueResource from 'src/http/vueResource'
import serverPaths from 'src/http/serverPaths'

const resource = vueResource.resource(serverPaths.defaultServer + '/projects_{/id}')

// const currentProfile = JSON.parse(window.localStorage.getItem('current-profile'))

export default {
  getAll () {
    return resource.get({})
  },
  getOne (id) {
    return resource.get({id: id})
  }
}
