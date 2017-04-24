import Services from 'src/modules/cadGroups/services'

export default class Group {
  constructor (data) {
    this._data = data
    Object.freeze(this)
  }

  get data () { return this._data }
  get projects () { return this._projects }

  get loadProjects () {
    Services.getAll().then(resp => {
      this.items = resp.data
      this.itemsFilteredByText = resp.data
    })


    return [
      {id: 1, name: 'proj aaa'},
      {id: 2, name: 'proj bbb'}
    ]
  }
}
