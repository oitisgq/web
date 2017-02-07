<script>
  import oiModal from 'components/modal.vue'

  export default {
    name: 'rulesDensity',

    components: { oiModal }
  }
</script>

<template>
  <span>
  <oiModal id="rulesDensityModal">
            <h4 style="margin-top:0px; text-align:center"><strong>Regras para cálculo de 'Densidade'</strong></h4>
            
            <p style="text-align:left">
                Defeitos fechados de CONSTRUÇÃO, divididos pelos CTs fechados diferentes de MASSA, multiplicados por 100.
            </p>
            <p style="text-align:left">
                Devido a este painel exibir os dados em uma régua de tempo, totalizamos os defeitos relacionados aos CTs, no mês de execução destes CTs.
            </p>
            <p style="text-align:left">
                Em outros locais onde os dados não são exibidos em uma régua de tempo, não consideramos o relacionamento entre Defeitos e CTs. Isto é, contemplamos também defeitos avulsos (sem relacionamento com CTs).
            </p>
            <p style="text-align:left">
                Os valores de referência: Aceitável, Moderada e Alta, são respectivamente: 10%, 20% e 30%.
            </p>
        </oiModal>  
  </span>   
</template>