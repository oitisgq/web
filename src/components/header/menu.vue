<script>
  export default {
    name: 'menu'
  }
</script>

<template>
    <ul id="menu" class="nav navbar-nav navbar-right" style="margin-bottom:0; border-bottom:0; padding-bottom:0">
        <router-link :to="{ name: 'releases' }" tag="li">
            <a class="oi-menu">Releases</a>
        </router-link>

        <router-link :to="{ name: 'projects' }" tag="li">
            <a class="oi-menu">Projetos</a>
        </router-link>
 
        <router-link :to="{ name: 'trg' }" tag="li">
            <a class="oi-menu">TRG</a>
        </router-link>

        <router-link :to="{ name: 'dashboard' }" tag="li">
            <a class="oi-menu">Painel</a>
        </router-link>

        <router-link :to="{ name: 'defectMonitor' }" tag="li">
            <a class="oi-menu">Monit.Def.</a>
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
                role="button" aria-haspopup="true" aria-expanded="false">BPTs Especiais<span class="caret"/>&nbsp;
            </a>
            <ul class="dropdown-menu">
                <router-link :to="{ name: 'bptEspValidacaoPlano' }" tag="li">
                    <a class="oi-menu">Validação do Plano</a>
                </router-link>
                <router-link :to="{ name: 'bptEspExecucaoTestes' }" tag="li">
                    <a class="oi-menu">Execução dos Testes</a>
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
                    <a class="oi-menu">Projetos</a>
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