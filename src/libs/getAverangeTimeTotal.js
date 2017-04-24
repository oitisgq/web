export default function (data, severity) {
  let qtyDefects = 0
  let qtyHours = 0

  if (severity !== undefined) {
    data = data.filter(i => i.severity === severity)
  }

  data.forEach(i => {
    qtyDefects = qtyDefects + i.qtyDefects
    qtyHours = qtyHours + i.qtyHours
  })

  return {
    qtyDefects: qtyDefects,
    qtyHours: qtyHours,
    averageHours: parseFloat(parseFloat(qtyHours / ((qtyDefects !== 0) ? qtyDefects : 1)).toFixed(2))
  }
}
