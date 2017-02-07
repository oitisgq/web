import axios from 'src/http/axios'

export const getUser = (networkLogin, password) => {
  return axios.get('https://uinames.com/api/?ext')
  .then(resp => resp.data)
}
