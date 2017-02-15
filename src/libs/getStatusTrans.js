export default function (dataSource) {
  return {
    columns: dataSource.map(i => i.date),
    rows: [
      {
        name: 'Planejado',
        valuesAcum: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.plannedAcum, percent: el.percPlanned } }),
        valuesDay: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.planned, percent: 0 } })
      },
      {
        name: 'Realizado',
        valuesAcum: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.realizedAcum, percent: el.percRealized } }),
        valuesDay: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.realized, percent: 0 } })
      },
      {
        name: 'Produtividade',
        valuesAcum: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.productivityAcum, percent: 0 } }),
        valuesDay: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.productivity, percent: 0 } })
      },
      {
        name: 'GAP',
        valuesAcum: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.GAPAcum, percent: el.percGAP } }),
        valuesDay: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.GAP, percent: 0 } })
      },
      {
        name: 'Valid. Evid. TI',
        valuesAcum: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.approvedTIAcum, percent: el.percApprovedTI } }),
        valuesDay: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.approvedTI, percent: 0 } })
      },
      {
        name: 'Valid. Evid. UAT',
        valuesAcum: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.approvedUATAcum, percent: el.percApprovedUAT } }),
        valuesDay: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.approvedUAT, percent: 0 } })
      }
    ]
  }
}

/*
project
delivery
subproject

active
activeUAT
planned
realized
productivity
GAP
approvedTI
approvedUAT

*/
