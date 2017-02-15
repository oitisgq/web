import vueResource from 'src/http/vueResource'
import serverPaths from 'src/http/serverPaths'

const resource = vueResource.resource(serverPaths.defaultServer + '/defectDetail{/subproject}{/delivery}{/defect}')

export default {
  getByDefect (defect) {
    return resource.get({ subproject: defect.subproject, delivery: defect.delivery, id: defect.id }, defect)
  }
}
