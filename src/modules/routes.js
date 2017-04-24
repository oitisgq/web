import { routes as home } from './home'
import { routes as releases } from './releases'
import { routes as project } from './project'
import { routes as grouper } from './grouper'
import { routes as trg } from './trg'
import { routes as dashboard } from './dashboard'
import { routes as defectMonitor } from './defectMonitor'
import { routes as indicatorsOfDevelopment } from './indicatorsOfDevelopment'
import { routes as indicatorsOfTest } from './indicatorsOfTest'
import { routes as bptCadastroStatus } from './bptCadastroStatus'
import { routes as bptValidacaoPlano } from './bptValidacaoPlano'
import { routes as bptAcompanhamentoExecucao } from './bptAcompanhamentoExecucao'
import { routes as cadGroupers } from './cadGroupers'
import { routes as cadProjects } from './cadProjects'
import { routes as auth } from './auth'

export default [
  ...home,
  ...releases,
  ...project,
  ...grouper,
  ...trg,
  ...dashboard,
  ...defectMonitor,
  ...indicatorsOfDevelopment,
  ...indicatorsOfTest,
  ...bptCadastroStatus,
  ...bptValidacaoPlano,
  ...bptAcompanhamentoExecucao,
  ...cadGroupers,
  ...cadProjects,
  ...auth
]
