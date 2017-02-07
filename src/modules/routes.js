import { routes as home } from './home'
import { routes as releases } from './releases'
import { routes as projects } from './projects'
import { routes as trg } from './trg'
import { routes as dashboard } from './dashboard'
import { routes as defectMonitor } from './defectMonitor'
import { routes as indicatorsOfDevelopment } from './indicatorsOfDevelopment'
import { routes as indicatorsOfTest } from './indicatorsOfTest'
import { routes as bptEspValidacaoPlano } from './bptEspValidacaoPlano'
import { routes as bptEspExecucaoTestes } from './bptEspExecucaoTestes'
import { routes as cadGroupersSpecialProject } from './cadGroupersSpecialProject'
import { routes as cadProjects } from './cadProjects'
import { routes as cadAssociationOfSpecialProjectsToGroupers } from './cadAssociationOfSpecialProjectsToGroupers'
import { routes as auth } from './auth'

export default [
  ...home,
  ...releases,
  ...projects,
  ...trg,
  ...dashboard,
  ...defectMonitor,
  ...indicatorsOfDevelopment,
  ...indicatorsOfTest,
  ...bptEspValidacaoPlano,
  ...bptEspExecucaoTestes,
  ...cadGroupersSpecialProject,
  ...cadProjects,
  ...cadAssociationOfSpecialProjectsToGroupers,
  ...auth
]
