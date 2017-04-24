import Resource from 'src/http/vueResource'
import ServerPaths from 'src/http/serverPaths'

// const currentProfile = JSON.parse(window.localStorage.getItem('current-profile'))

export default {
  getProjects () {
    let resource = Resource.resource(ServerPaths.defaultServer + '/Project/Projects')
    return resource.get()
  },

  getProject (project) {
    let resource = Resource.resource(ServerPaths.defaultServer + '/Project/Project{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery })
  },

  getProjectFull (project) {
    let resource = Resource.resource(ServerPaths.defaultServer + '/Project/ProjectFull{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery })
  },

  getDensity (project) {
    let resource = Resource.resource(ServerPaths.defaultServer + '/defectsDensity{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery }, project)
  },

  getAverangeTime (project) {
    let resource = Resource.resource(ServerPaths.defaultServer + '/DefectsAverangeTime{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery }, project)
  },

  getAll () {
    let resource = Resource.resource(ServerPaths.defaultServer + '/projects{/id}')
    return resource.get({})
  },

  getOne (id) {
    let resource = Resource.resource(ServerPaths.defaultServer + '/projects{/id}')
    return resource.get({id: id})
  }
}
