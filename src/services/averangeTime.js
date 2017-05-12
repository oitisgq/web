import vueResource from 'src/http/vueResource'
import webApiPath from 'src/http/webApiPath'

const resource = vueResource.resource(webApiPath.default + '/DefectsAverangeTime{/subproject}{/delivery}')

export default {
  getByProject (project) {
    return resource.get({ subproject: project.subproject, delivery: project.delivery }, project)
  }
}
