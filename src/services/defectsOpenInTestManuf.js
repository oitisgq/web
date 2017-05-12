import vueResource from 'src/http/vueResource'
import webApiPath from 'src/http/webApiPath'

const resource = vueResource.resource(webApiPath.default + '/defectsOpenInTestManuf{/subproject}{/delivery}')

export default {
  getByProject (project) {
    return resource.get({ subproject: project.subproject, delivery: project.delivery }, project)
  }
}
