export default function (data, percentReference) {
  let qtyTotal = 0
  let qtyReopened = 0

  data.forEach(i => {
    qtyTotal = qtyTotal + i.qtyTotal
    qtyReopened = qtyReopened + i.qtyReopened
  })

  return {
    qtyTotal: qtyTotal,
    qtyReopened: qtyReopened,
    percentReopened: parseFloat(parseFloat(qtyReopened / ((qtyTotal !== 0) ? qtyTotal : 1) * 100).toFixed(2)),
    percentReference: percentReference,
    qtyReference: parseFloat(parseFloat(qtyTotal * (percentReference / 100)).toFixed(2))
  }
}
