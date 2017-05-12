import vueResource from 'src/http/vueResource'
import webApiPath from 'src/http/webApiPath'

export default {
  getByDefect (project, defect) {
    const resource = vueResource.resource(webApiPath.default + '/defectDetail{/subproject}{/delivery}{/defect}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery, defect: defect.defect })
  }
}
