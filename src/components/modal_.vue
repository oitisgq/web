<script>
  export default {
    props: ['id'],

    methods: {
      close () {
        this.$emit('onClose')
      }
    }
  }

</script>

<template>
    <div class="modal" :id="id">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <slot></slot>
                    <!--
                    <div class="row text-center">
                        <button 
                            class="btn btn-xs"
                            @click="close"
                            data-dismiss="modal">Fechar
                        </button>        
                    </div>                              
                    -->
                </div>
            </div>
        </div>
    </div>      
</template>

<style scoped>
    body .modal-dialog { /* Width */
        max-width: 95%;
        width: auto !important;
    }
</style>