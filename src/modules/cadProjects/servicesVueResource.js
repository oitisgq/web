import vueResource from 'src/http/vueResource'
import serverPaths from 'src/http/serverPaths'

export default {
  // Create
  createOne (item) {
    let resource = vueResource.resource(serverPaths.default + '/projects_{/id}')
    // item['student_id'] = currentProfile.student.id
    return resource.save({}, item)
  },

  // Read
  getAll () {
    // let resource = vueResource.resource(serverPaths.default + '/projects_{/id}')
    let resource = vueResource.resource(serverPaths.default + '/Project/Projects')
    return resource.get({})
  },
  getOne (id) {
    let resource = vueResource.resource(serverPaths.default + '/projects_{/id}')
    return resource.get({id: id})
  },

  // Update
  updateOne (item) {
    let resource = vueResource.resource(serverPaths.default + '/projects_{/id}')
    return resource.update({id: item.id}, item)
  },

  // Delete
  deleteOne (id) {
    let resource = vueResource.resource(serverPaths.default + '/projects_{/id}')
    return resource.delete({id: id})
  }
}
