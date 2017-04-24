<script>
  import oiModal from 'components/modal'

  export default {
    name: 'dashboard',
    components: { oiModal }
  }
</script>

<template>
  <div id="dashboard" class="container">
    <h3>Painel</h3>

    <button 
        type="button" 
        style="margin-top:3px"
        class="btn btn-xs"
        data-toggle="modal" 
        data-target="#xx">teste
    </button>

  </div>
</template>
