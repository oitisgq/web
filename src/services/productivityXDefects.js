import vueResource from 'src/http/vueResource'
import serverPaths from 'src/http/serverPaths'

const resource = vueResource.resource(serverPaths.default + '/productivityXDefects{/subproject}{/delivery}')

export default {
  getByProject (project) {
    return resource.get({ subproject: project.subproject, delivery: project.delivery }, project)
  }
}
