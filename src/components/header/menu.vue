<script>
  export default {
    name: 'menu'
  }
</script>

<template>
    <ul id="menu" class="nav navbar-nav navbar-right" style="margin-bottom:0; border-bottom:0; padding-bottom:0">
        <router-link :to="{ name: 'releases' }" tag="li">
            <a class="oi-menu" style="height:20px;margin:0;padding-top:0px;" 
                href="#"
                onclick="window.open('http://sgq.intranet/Mobile_Status_Release_Menu.aspx', 
                    'newwindow', 
                    'fullscreen=yes, titlebar=no, toolbar=no, location=no, channelmode=0no, status=no, menubar=no, scrollbars=yes, resizable=yes'
                );
                return false">Releases
            </a>
        </router-link>

        <router-link :to="{ name: 'projects' }" tag="li">
            <a class="oi-menu">Projetos</a>
        </router-link>
 
        <router-link :to="{ name: 'trg' }" tag="li">
            <a class="oi-menu"
                href="#"
                onclick="window.open('http://sgq.intranet/Mobile_Status_TRG_Menu.aspx', 
                    'newwindow', 
                    'fullscreen=yes, titlebar=no, toolbar=no, location=no, channelmode=0no, status=no, menubar=no, scrollbars=yes, resizable=yes'
                ); 
                return false;">TRGs
            </a>
        </router-link>

        <router-link :to="{ name: 'dashboard' }" tag="li">
            <a class="oi-menu"
                href="#"
                onclick="window.open('http://sgq.intranet/Mobile_Painel_Menu.aspx', 
                    'newwindow', 
                    'fullscreen=yes, titlebar=no, toolbar=no, location=no, channelmode=0no, status=no, menubar=no, scrollbars=yes, resizable=yes'
                ); 
                return false;">Painel
            </a>            
        </router-link>

        <router-link :to="{ name: 'defectMonitor' }" tag="li">
            <a class="oi-menu" 
                href="#"
                onclick="window.open('http://sgq.intranet/Mobile_Monitor_Defeitos_Menu.aspx', 
                    'newwindow', 
                    'fullscreen=yes, titlebar=no, toolbar=no, location=no, channelmode=0no, status=no, menubar=no, scrollbars=yes, resizable=yes'
                ); 
                return false;">Monit.Def.
            </a>            
        </router-link>

        <li class="dropdown">
            <a href="#" 
                class="dropdown-toggle oi-menu" data-toggle="dropdown" 
                role="button" aria-haspopup="true" aria-expanded="false">Indicadores<span class="caret"/>&nbsp;
            </a>
            <ul class="dropdown-menu">
                <router-link :to="{ name: 'indicatorsOfDevelopment' }" tag="li">
                    <a class="oi-menu">Desenvolvimento</a>
                </router-link>
                <router-link :to="{ name: 'indicatorsOfTest' }" tag="li">
                    <a class="oi-menu">Teste</a>
                </router-link>
            </ul>
        </li>

        <li class="dropdown">
            <a href="#" 
                class="dropdown-toggle oi-menu" data-toggle="dropdown" 
                role="button" aria-haspopup="true" aria-expanded="false">BPTs<span class="caret"/>&nbsp;
            </a>
            <ul class="dropdown-menu">
                <router-link :to="{ name: 'bptCadastroStatus' }" tag="li">
                    <a class="oi-menu">Cadastro de Status do Projeto</a>
                </router-link>
                <router-link :to="{ name: 'bptValidacaoPlano' }" tag="li">
                    <a class="oi-menu">Validação do Plano/Evidência</a>
                </router-link>
                <router-link :to="{ name: 'bptAcompanhamentoExecucao' }" tag="li">
                    <a class="oi-menu">Acompanhamento da Execução</a>
                </router-link>
            </ul>
        </li>

        <li class="dropdown">
            <a href="#" 
                class="dropdown-toggle oi-menu" data-toggle="dropdown" 
                role="button" aria-haspopup="true" aria-expanded="false">Cadastros<span class="caret"/>&nbsp;
            </a>
            <ul class="dropdown-menu">
                <router-link :to="{ name: 'cadGroupersSpecialProject' }" tag="li">
                    <a class="oi-menu">Agrupadores de projetos especiais</a>
                </router-link>
                <router-link :to="{ name: 'cadProjects' }" tag="li">
                    <a class="oi-menu">Status de Projetos</a>
                </router-link>
                <router-link :to="{ name: 'cadAssociationOfSpecialProjectsToGroupers' }" tag="li">
                    <a class="oi-menu">Associação de projetos especiais aos agrupadores</a>
                </router-link>
            </ul>
        </li>
    </ul>
</template>

<style scoped>
    .oi-menu {
        height: 25px;
        margin: 0;
        padding: 0 7px 25px 7px;
    }
</style>