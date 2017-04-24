import Resource from 'src/http/vueResource'
import ServerPaths from 'src/http/serverPaths'

export default {
  // Create
  create (groupId, projectId, subproject, delivery) {
    let resource = Resource.resource(ServerPaths.default + '/ProjectXGrouper/create/{groupId}/{projectId}/{subproject}/{delivery}')
    // item['student_id'] = currentProfile.student.id
    return resource.get({groupId: groupId, projectId: projectId, subproject: subproject, delivery: delivery})
  },

  // Read
  getAll () {
    let resource = Resource.resource(ServerPaths.default + '/ProjectXGrouper/All')
    return resource.get()
  },

  get (id) {
    let resource = Resource.resource(ServerPaths.default + '/ProjectXGrouper/{/id}')
    return resource.get({id: id})
  },

  // Update
  update (item) {
    let resource = Resource.resource(ServerPaths.default + '/ProjectXGrouper{/id}')
    return resource.update({id: item.id}, item)
  },

  // Delete
  delete (groupId, projectId) {
    let resource = Resource.resource(ServerPaths.default + '/ProjectXGrouper/Delete/{groupId}/{projectId}')
    return resource.get({groupId: groupId, projectId: projectId})
  }
}
