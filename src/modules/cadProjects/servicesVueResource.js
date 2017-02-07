import vueResource from 'src/http/vueResource'
import serverPaths from 'src/http/serverPaths'

const resource = vueResource.resource(serverPaths.defaultServer + '/projects_{/id}')

export default {
  // Create
  createOne (item) {
    // item['student_id'] = currentProfile.student.id
    return resource.save({}, item)
  },

  // Read
  getAll () {
    return resource.get({})
  },
  getOne (id) {
    return resource.get({id: id})
  },

  // Update
  updateOne (item) {
    return resource.update({id: item.id}, item)
  },

  // Delete
  deleteOne (id) {
    return resource.delete({id: id})
  }
}
