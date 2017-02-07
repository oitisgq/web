export default function (data) {
  let qtyDefects = 0
  let qtyCTs = 0

  if (data.length > 0) {
    data.forEach(i => {
      qtyDefects = qtyDefects + i.qtyDefects
      qtyCTs = qtyCTs + i.qtyCTs
    })
  }

  return {
    qtyDefects: qtyDefects,
    qtyCTs: qtyCTs,
    density: parseFloat(parseFloat(qtyDefects / ((qtyCTs !== 0) ? qtyCTs : 1) * 100).toFixed(2))
  }
}
