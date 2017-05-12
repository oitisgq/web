import axios from 'src/http/axios'

const serverPath = 'http://localhost:55286'

export const getProjects = () => {
  return axios.get(serverPath + '/projects/all')
  .then(resp => resp.data)
}

export const updateProject = (project) => {
  return axios.put(serverPath + '/project/' + project.id, project)
  .then(resp => console.log(resp))
}
