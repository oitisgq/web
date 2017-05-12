import Resource from 'src/http/vueResource'
import webApiPath from 'src/http/webApiPath'

// const currentProfile = JSON.parse(window.localStorage.getItem('current-profile'))

export default {
  getDensityByDate (dateBegin, dateEnd) {
    let resource = Resource.resource(webApiPath.default + '/defectsDensity/{dateBegin}/{dateEnd}')
    return resource.get({ dateBegin: dateBegin, dateEnd: dateEnd })
  },
  getAgingMedioByDate (dateBegin, dateEnd) {
    let resource = Resource.resource(webApiPath.default + '/defectsMiddleAges/{dateBegin}/{dateEnd}')
    return resource.get({ dateBegin: dateBegin, dateEnd: dateEnd })
  },
  getWrongClassificationDefectRateByDate (dateBegin, dateEnd) {
    let resource = Resource.resource(webApiPath.default + '/defectsWrongClassif/{dateBegin}/{dateEnd}')
    return resource.get({ dateBegin: dateBegin, dateEnd: dateEnd })
  },
  getDetectableInDevByDate (dateBegin, dateEnd) {
    let resource = Resource.resource(webApiPath.default + '/defectsDetectableInDev/{dateBegin}/{dateEnd}')
    return resource.get({ dateBegin: dateBegin, dateEnd: dateEnd })
  },
  getReopenedByDate (dateBegin, dateEnd) {
    let resource = Resource.resource(webApiPath.default + '/defectsReopened/{dateBegin}/{dateEnd}')
    return resource.get({ dateBegin: dateBegin, dateEnd: dateEnd })
  },
  getnoPredictionDefectsByDate (dateBegin, dateEnd) {
    let resource = Resource.resource(webApiPath.default + '/defectsNoPrediction/{dateBegin}/{dateEnd}')
    return resource.get({ dateBegin: dateBegin, dateEnd: dateEnd })
  }
}
