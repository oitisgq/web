import vueResource from 'src/http/vueResource'
import webApiPath from 'src/http/webApiPath'

export default {
  // Create
  createOne (item) {
    let resource = vueResource.resource(webApiPath.default + '/projects_{/id}')
    // item['student_id'] = currentProfile.student.id
    return resource.save({}, item)
  },

  // Read
  getAll () {
    // let resource = vueResource.resource(webApiPath.default + '/projects_{/id}')
    let resource = vueResource.resource(webApiPath.default + '/Project/Projects')
    return resource.get({})
  },
  getOne (id) {
    let resource = vueResource.resource(webApiPath.default + '/projects_{/id}')
    return resource.get({id: id})
  },

  // Update
  updateOne (item) {
    let resource = vueResource.resource(webApiPath.default + '/projects_{/id}')
    return resource.update({id: item.id}, item)
  },

  // Delete
  deleteOne (id) {
    let resource = vueResource.resource(webApiPath.default + '/projects_{/id}')
    return resource.delete({id: id})
  }
}
