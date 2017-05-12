const local = 'http://localhost:55286'
const homologation = 'http://sgqhml.intranet/SGQJson'
const production = 'http://sgq.intranet/SGQJson'

const webApiPath = {
  local,
  homologation,
  production,
  default: homologation
}

export default webApiPath

// "c:\Program Files\wkhtmltopdf\bin\wkhtmltoimage.exe" --crop-y 53 --javascript-delay 10000 --encoding utf-8 "http://sgq.intranet/dist/index.html#/project/report/PRJ00006615/ENTREGA00002484" "c:\tmp\PRJ00006615.jpg"
// "c:\Program Files\wkhtmltopdf\bin\wkhtmltoimage.exe" --crop-y 53 --javascript-delay 5000 --encoding utf-8 "http://sgqhml.intranet/dist/index.html#/grouper/show/34" "d:\tmp\Alcino - Release Junho.jpg"
