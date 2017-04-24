export default function (data, percentReference) {
  let qtyTotal = 0
  let qtyDetectable = 0

  data.forEach(i => {
    qtyTotal = qtyTotal + i.qtyTotal
    qtyDetectable = qtyDetectable + i.qtyDetectable
  })

  return {
    qtyTotal: qtyTotal,
    qtyDetectableInDev: qtyDetectable,
    percentDetectableInDev: parseFloat(parseFloat(qtyDetectable / ((qtyTotal !== 0) ? qtyTotal : 1) * 100).toFixed(2)),
    percentReference: percentReference,
    qtyReference: parseFloat(parseFloat(qtyTotal * (percentReference / 100)).toFixed(2))
  }
}
