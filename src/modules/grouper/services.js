import Resource from 'src/http/vueResource'
import webApiPath from 'src/http/webApiPath'

export default {
  // Create
  create (item) {
    let resource = Resource.resource(webApiPath.default + '/grouper/create')
    // item['student_id'] = currentProfile.student.id
    return resource.update(item)
  },

  // Read
  getAll () {
    let resource = Resource.resource(webApiPath.default + '/groupers')
    return resource.get()
  },

  get (id) {
    let resource = Resource.resource(webApiPath.default + '/grouper/{id}')
    return resource.get({id: id})
  },

  // Update
  update (item) {
    let resource = Resource.resource(webApiPath.default + '/grouper/update/{id}')
    return resource.update({id: item.id}, item)
  },

  // Delete
  delete (id) {
    let resource = Resource.resource(webApiPath.default + '/grouper/{id}')
    return resource.delete({id: id})
  }
}
