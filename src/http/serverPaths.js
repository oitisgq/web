const local = 'http://localhost:55286'
const localExpress = 'http://localhost:3000'
const homologation = 'http://sgqhml.intranet/SGQJson'
const production = 'http://sgq.intranet/SGQJson'

const serverPaths = {
  local,
  localExpress,
  homologation,
  production,
  default: homologation
}

export default serverPaths
