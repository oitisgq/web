export default function (dataSource) {
  return {
    columns: dataSource.map(i => i.date),
    rows: [
      {
        name: 'Ativo',
        valuesAcum: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.activeAcum, percent: 0 } }),
        valuesDay: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.active, percent: 0 } })
      },
      {
        name: 'Planejado',
        valuesAcum: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.plannedAcum, percent: parseFloat(el.percPlanned).toFixed(2) } }),
        valuesDay: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.planned, percent: 0 } })
      },
      {
        name: 'Realizado',
        valuesAcum: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.realizedAcum, percent: parseFloat(el.percRealized).toFixed(2) } }),
        valuesDay: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.realized, percent: 0 } })
      },
      {
        name: 'Produtividade',
        valuesAcum: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.productivityAcum, percent: 0 } }),
        valuesDay: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.productivity, percent: 0 } })
      },
      {
        name: 'GAP',
        valuesAcum: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.GAPAcum, percent: parseFloat(el.percGAP).toFixed(2) } }),
        valuesDay: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.GAP, percent: 0 } })
      },
      {
        name: 'Valid. Evid. TI',
        valuesAcum: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.approvedTIAcum, percent: parseFloat(el.percApprovedTI).toFixed(2) } }),
        valuesDay: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.approvedTI, percent: 0 } })
      },
      {
        name: 'Valid. Evid. UAT',
        valuesAcum: dataSource.map((el, i) => { return { date: dataSource[i].date, value: el.approvedUATAcum, percent: parseFloat(el.percApprovedUAT).toFixed(2) } }),
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
