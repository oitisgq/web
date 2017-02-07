import vueResource from 'src/http/vueResource'
import serverPaths from 'src/http/serverPaths'

const resource = vueResource.resource(serverPaths.defaultServer + '/DefectsAverangeTime{/subproject}{/delivery}')

export default {
  // Read
  getAll () {
    return resource.get({})
  },
  getByProject (project) {
    return resource.get({ subproject: project.subproject, delivery: project.delivery }, project)
  }
}
