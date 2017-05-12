import Resource from 'src/http/vueResource'
import webApiPath from 'src/http/webApiPath'

export default {
  // Create
  createOne (item) {
    let resource = Resource.resource(webApiPath.default + '/ProjectXGrouper{/id}')
    // item['student_id'] = currentProfile.student.id
    return resource.save({}, item)
  },

  // Read
  getAll () {
    let resource = Resource.resource(webApiPath.default + '/ProjectXGrouper/All')
    return resource.get()
  },

  getByProjectId (id) {
    let resource = Resource.resource(webApiPath.default + '/ProjectXGrouper/ByProject/{id}')
    return resource.get()
  },

  getByProject (subproject, delivery) {
    let resource = Resource.resource(webApiPath.default + '/ProjectXGrouper/ByProject/{subproject}/{delivery}')
    return resource.get()
  },

  getByGrouper (id) {
    let resource = Resource.resource(webApiPath.default + '/ProjectXGrouper/ByGrouper/{id}')
    return resource.get({id: id})
  },

  getOne (id) {
    let resource = Resource.resource(webApiPath.default + '/ProjectXGrouper/{id}')
    return resource.get({id: id})
  },

  // Update
  updateOne (item) {
    let resource = Resource.resource(webApiPath.default + '/ProjectXGrouper/{id}')
    return resource.update({id: item.id}, item)
  },

  // Delete
  deleteOne (id) {
    let resource = Resource.resource(webApiPath.default + '/ProjectXGrouper/{id}')
    return resource.delete({id: id})
  }
}
