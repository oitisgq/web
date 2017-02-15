export default class Project {
  constructor (id, subproject, delivery, name, gp, n3, dateEnd) {
    this._id = id
    this._subproject = subproject
    this._delivery = delivery
    this._name = name
    this._gp = gp
    this._n3 = n3
    this._objective = ''
    this._dateStart = new Date()

    // this._dateEnd = dateEnd
    this._dateEnd = new Date(dateEnd.getTime()) // evita que alguem passe um objeto como parametro e chame _date.setDate(x), para alterar a data (programação defensiva)
    
    Object.freeze(this)
  }

  get id () { return this._id }
  get subproject () { return this._subproject }
  get delivery () { return this._delivery }
  get name () { return this._name }
  get gp () { return this._gp }
  get n3 () { return this._n3 }
  get objective () { return this._objective }

  // get date () { return this._date }
  get date () { return new Date(this._date.getTime()) } // evita que alguem chame _date.setDate(x), para alterar a data (programação defensiva)

  get densidade () { return this._id * 2 }

  /*
    defectsDensidades: [
      {
        date: '',
        devManuf: '',
        system: '',

        qtyDefects: 0,
        qtyCTs: 0,
        density: 0
      }
    ],

    defectsDensidadesTotal: {
      qtyDefects: 0,
      qtyCTs: 0,
      density: 0
    },

    defectsAverangeTime: [
      {
        date: '',
        devManuf: '',
        system: '',
        qtyDefects: 0,
        qtyHours: 0,
        averageTime: 0
      }
    ],

    defectsAverangeTimeTotal: {
      qtyHours: 0,
      averageTime: 0
    },

    defectsDetectableInDev: [
      {
        date: '',
        devManuf: '',
        system: '',
        qtyCTs: 0,
        qtyCTsDetectableInDev: 0,
        percentReference: 0,
        qtyReference: 0
      }
    ],

    defectsReopened: [
      {
        date: '',
        devManuf: '',
        system: '',
        qtyCTs: 0,
        qtyCTsReopened: 0,
        percent: 0,
        percentReference: 0,
        qtyReference: 0
      }
    ]
  }
  */
}
