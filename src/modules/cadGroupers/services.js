import Resource from 'src/http/vueResource'
import ServerPaths from 'src/http/serverPaths'

export default {
  // Create
  create (item) {
    let resource = Resource.resource(ServerPaths.default + '/Grouper/create')
    // item['student_id'] = currentProfile.student.id
    return resource.update(item)
  },

  // Read
  getAll () {
    let resource = Resource.resource(ServerPaths.default + '/Groupers')
    return resource.get()
  },

  get (id) {
    let resource = Resource.resource(ServerPaths.default + '/Grouper/{id}')
    return resource.get({id: id})
  },

  // Update
  update (item) {
    let resource = Resource.resource(ServerPaths.default + '/Grouper/update/{id}')
    return resource.update({id: item.id}, item)
  },

  // Delete
  delete (id) {
    let resource = Resource.resource(ServerPaths.default + '/Grouper/{id}')
    return resource.delete({id: id})
  }
}
