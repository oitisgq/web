import vueResource from 'src/http/vueResource'
import serverPaths from 'src/http/serverPaths'

export default {
  getByDefect (project, defect) {
    const resource = vueResource.resource(serverPaths.default + '/defectDetail{/subproject}{/delivery}{/defect}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery, defect: defect.defect })
  }
}
