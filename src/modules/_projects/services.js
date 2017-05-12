import Resource from 'src/http/vueResource'
import webApiPath from 'src/http/webApiPath'

// const currentProfile = JSON.parse(window.localStorage.getItem('current-profile'))

export default {
  getProjects () {
    let resource = Resource.resource(webApiPath.defaultServer + '/Project/Projects')
    return resource.get()
  },

  getProject (project) {
    let resource = Resource.resource(webApiPath.defaultServer + '/Project/Project{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery })
  },

  getProjectFull (project) {
    let resource = Resource.resource(webApiPath.defaultServer + '/Project/ProjectFull{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery })
  },

  getDensity (project) {
    let resource = Resource.resource(webApiPath.defaultServer + '/defectsDensity{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery }, project)
  },

  getAverangeTime (project) {
    let resource = Resource.resource(webApiPath.defaultServer + '/DefectsAverangeTime{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery }, project)
  },

  getAll () {
    let resource = Resource.resource(webApiPath.defaultServer + '/projects{/id}')
    return resource.get({})
  },

  getOne (id) {
    let resource = Resource.resource(webApiPath.defaultServer + '/projects{/id}')
    return resource.get({id: id})
  }
}
