import vueResource from 'src/http/vueResource'
import serverPaths from 'src/http/serverPaths'

const resource = vueResource.resource(serverPaths.default + '/projects_{/id}')

// const currentProfile = JSON.parse(window.localStorage.getItem('current-profile'))

export default {
  // Read
  getAll () {
    return resource.get({})
  },
  getOne (id) {
    return resource.get({id: id})
  }
}
