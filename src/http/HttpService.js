export default class HttpService {
  get (url) {
    return new Promise((resolve, reject) => {
      let xhr = new XMLHttpRequest()
      xhr.open('GET', url)
      xhr.onreadystatechange = () => {
        if (xhr.readyState === 4) {
          if (xhr.status === 200) {
            resolve(JSON.parse(xhr.responseText))
          } else {
            reject(xhr.responseText)
          }
        }
      }
      xhr.send()
    })
  }
  post (url, dado) {
    return new Promise((resolve, reject) => {
      let xhr = new XMLHttpRequest()
      xhr.open('POST', url, true)
      xhr.setRequestHeader('Content-type', 'application/json')
      xhr.onreadystatechange = () => {
        if (xhr.readyState === 4) {
          if (xhr.status === 200) {
            resolve(JSON.parse(xhr.responseText))
          } else {
            reject(xhr.responseText)
          }
        }
      }
      xhr.send(JSON.stringify(dado)) // usando JSON.stringifly para converter objeto em uma string no formato JSON.
    })
  }
  postEmail (url, dado) {
    return new Promise((resolve, reject) => {
      let xhr = new XMLHttpRequest()
      console.log('aaaaaaaaaaaaaaa')
      xhr.open('POST', url)
      // xhr.setRequestHeader('Content-type', 'application/text')
      xhr.onreadystatechange = () => {
        if (xhr.readyState === 4) {
          if (xhr.status === 200) {
            resolve(xhr.responseText)
          } else {
            reject(xhr.responseText)
          }
        }
      }
      xhr.send(dado)
    })
  }
}
