import axios from 'src/http/axios'

// serverPathLocal: 'http://localhost:55286',
// serverPathNode: 'http://localhost:3000',
// serverPathHml: 'http://sgqhml.intranet/SGQJson',
// serverPathPrd: 'http://sgq.intranet/SGQJson',
const serverPath = 'http://sgqhml.intranet/SGQJson'

export const getProjects = () => {
  return axios.get(serverPath + '/projects/all')
  .then(resp => resp.data)
}

export const updateProject = (project) => {
  return axios.put(serverPath + '/project/' + project.id, project)
  .then(resp => console.log(resp))
}
