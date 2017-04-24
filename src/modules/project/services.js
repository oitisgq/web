import Resource from 'src/http/vueResource'
import ServerPaths from 'src/http/serverPaths'

// const currentProfile = JSON.parse(window.localStorage.getItem('current-profile'))

export default {
  getProjects () {
    let resource = Resource.resource(ServerPaths.default + '/Project/Projects')
    return resource.get()
  },

  getProjectsByIds (ids) {
    let resource = Resource.resource(ServerPaths.default + '/Project/ProjectsByIds/{ids}')
    return resource.get({ids: ids})
  },

  getProjectBySubEnt (subproject, delivery) {
    let resource = Resource.resource(ServerPaths.default + '/Project/Project{/subproject}{/delivery}')
    return resource.get({ subproject: subproject, delivery: delivery })
  },

  getProject (project) {
    let resource = Resource.resource(ServerPaths.default + '/Project/Project{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery })
  },

  getProjectFull (project) {
    let resource = Resource.resource(ServerPaths.default + '/Project/ProjectFull{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery })
  },

  getDensityGroupMonthYear (project) {
    let resource = Resource.resource(ServerPaths.default + '/defectsDensity{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery })
  },

  getDensity (project) {
    let resource = Resource.resource(ServerPaths.default + '/Project/DefectsDensity{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery })
  },

  getAverangeTime (project) {
    let resource = Resource.resource(ServerPaths.default + '/Project/DefectsAverangeTime{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery })
  },

  getAverangeTimeBySeverity (project, severity) {
    let resource = Resource.resource(ServerPaths.default + '/Project/DefectsAverangeTime{/subproject}{/delivery}{/severity}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery, severity: severity })
  },

  getReopened (project) {
    let resource = Resource.resource(ServerPaths.default + '/Project/DefectsReopened{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery })
  },

  getDetectableInDev (project) {
    let resource = Resource.resource(ServerPaths.default + '/Project/DefectsDetectableInDev{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery })
  },

  getStatusLastDays (project) {
    let resource = Resource.resource(ServerPaths.default + '/Project/StatusLastDays{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery })
  },

  getStatusGroupMonth (project) {
    let resource = Resource.resource(ServerPaths.default + '/Project/StatusGroupMonth{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery })
  },

  getDefectsStatus (project) {
    let resource = Resource.resource(ServerPaths.default + '/Project/DefectsStatus{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery })
  },

  getDefectsGroupOrigin (project) {
    let resource = Resource.resource(ServerPaths.default + '/Project/DefectsGroupOrigin{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery })
  },

  getCTsImpactedXDefects (project) {
    let resource = Resource.resource(ServerPaths.default + '/Project/CtsImpactedXDefects{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery })
  },

  getDefectsOpenInDevManuf (project) {
    let resource = Resource.resource(ServerPaths.default + '/Project/DefectsOpenInDevManuf{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery })
  },

  getDefectsOpenInTestManuf (project) {
    let resource = Resource.resource(ServerPaths.default + '/Project/DefectsOpenInTestManuf{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery })
  },

  getProductivityXDefects (project) {
    let resource = Resource.resource(ServerPaths.default + '/Project/ProductivityXDefects{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery })
  },

  getProductivityXDefectsGroupWeekly (project) {
    let resource = Resource.resource(ServerPaths.default + '/Project/ProductivityXDefectsGroupWeekly{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery })
  },

  getAll () {
    let resource = Resource.resource(ServerPaths.default + '/Projects{/id}')
    return resource.get({})
  },

  getOne (id) {
    let resource = Resource.resource(ServerPaths.default + '/Projects{/id}')
    return resource.get({id: id})
  },

  // ITERATIONS

  getIterations (project) {
    let resource = Resource.resource(ServerPaths.default + '/Project/Iterations{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery })
  },

  getIterationsActive (project) {
    let resource = Resource.resource(ServerPaths.default + '/Project/IterationsActive{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery })
  },

  getIterationsSelected (project) {
    let resource = Resource.resource(ServerPaths.default + '/Project/IterationsSelected{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery })
  },

  updateIterationsActive (item) {
    let resource = Resource.resource(ServerPaths.default + '/Project/UpdateIterationsActive{/id}')
    return resource.update({ id: item.projectId }, item.iterations)
  },

  updateIterationsSelected (item) {
    let resource = Resource.resource(ServerPaths.default + '/Project/UpdateIterationsSelected{/id}')
    return resource.update({ id: item.projectId }, item.iterations)
  },

  ClearIterations (projectId) {
    let resource = Resource.resource(ServerPaths.default + '/Project/ClearIterations{/id}')
    return resource.get({id: projectId})
  },

  // --------

  getDensityByIterations (project) {
    let resource = Resource.resource(ServerPaths.default + '/Project/DefectsDensityByProjectIterations{/subproject}{/delivery}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery })
  },

  getAverangeTimeBySeverityIterations (project, severity) {
    let resource = Resource.resource(ServerPaths.default + '/Project/DefectsAverangeTimeIterations{/subproject}{/delivery}{/severity}')
    return resource.get({ subproject: project.subproject, delivery: project.delivery, severity: severity })
  },

  getReopenedIterations (project, iterations) {
    let resource = Resource.resource(ServerPaths.default + '/Project/DefectsReopenedIterations{/subproject}{/delivery}')
    return resource.update({ subproject: project.subproject, delivery: project.delivery }, iterations)
  },

  getDetectableInDevIterations (project, iterations) {
    let resource = Resource.resource(ServerPaths.default + '/Project/DefectsDetectableInDevIterations{/subproject}{/delivery}')
    return resource.update({ subproject: project.subproject, delivery: project.delivery }, iterations)
  },

  getStatusLastDaysIterations (project, iterations) {
    let resource = Resource.resource(ServerPaths.default + '/Project/StatusLastDaysIterations{/subproject}{/delivery}')
    return resource.update({ subproject: project.subproject, delivery: project.delivery }, iterations)
  },

  getStatusGroupMonthIterations (project, iterations) {
    let resource = Resource.resource(ServerPaths.default + '/Project/StatusGroupMonthIterations{/subproject}{/delivery}')
    return resource.update({ subproject: project.subproject, delivery: project.delivery }, iterations)
  },

  getDefectsStatusIterations (project, iterations) {
    let resource = Resource.resource(ServerPaths.default + '/Project/DefectsStatusIterations{/subproject}{/delivery}')
    return resource.update({ subproject: project.subproject, delivery: project.delivery }, iterations)
  },

  getDefectsGroupOriginIterations (project, iterations) {
    let resource = Resource.resource(ServerPaths.default + '/Project/DefectsGroupOriginIterations{/subproject}{/delivery}')
    return resource.update({ subproject: project.subproject, delivery: project.delivery }, iterations)
  },

  getCTsImpactedXDefectsIterations (project, iterations) {
    let resource = Resource.resource(ServerPaths.default + '/Project/CtsImpactedXDefectsIterations{/subproject}{/delivery}')
    return resource.update({ subproject: project.subproject, delivery: project.delivery }, iterations)
  },

  getDefectsOpenInDevManufIterations (project, iterations) {
    let resource = Resource.resource(ServerPaths.default + '/Project/DefectsOpenInDevManufIterations{/subproject}{/delivery}')
    return resource.update({ subproject: project.subproject, delivery: project.delivery }, iterations)
  },

  getDefectsOpenInTestManufIterations (project, iterations) {
    let resource = Resource.resource(ServerPaths.default + '/Project/DefectsOpenInTestManufIterations{/subproject}{/delivery}')
    return resource.update({ subproject: project.subproject, delivery: project.delivery }, iterations)
  },

  getProductivityXDefectsIterations (project, iterations) {
    let resource = Resource.resource(ServerPaths.default + '/Project/ProductivityXDefectsIterations{/subproject}{/delivery}')
    return resource.update({ subproject: project.subproject, delivery: project.delivery }, iterations)
  },

  getProductivityXDefectsGroupWeeklyIterations (project, iterations) {
    let resource = Resource.resource(ServerPaths.default + '/Project/ProductivityXDefectsGroupWeeklyIterations{/subproject}{/delivery}')
    return resource.update({ subproject: project.subproject, delivery: project.delivery }, iterations)
  }
}
