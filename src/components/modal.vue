<script>
  export default {
    props: ['id']
  }
</script>

<template>
    <div class="modal" :id="id" aria-labelledby="myModalLabel">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <slot></slot>
                    <div class="row text-center">
                        <button 
                            type="button" 
                            class="btn btn-xs"
                            data-dismiss="modal">Fechar
                        </button>        
                    </div>                              
                </div>
            </div>
        </div>
    </div>      
</template>