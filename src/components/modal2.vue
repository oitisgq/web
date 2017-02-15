<script>
  export default {
    props: ['show', 'onClose'],

    methods: {
      close () {
        this.onClose()
      }
    },

    ready () {
      document.addEventListener('keydown', (e) => {
        if (this.show && e.keyCode === 27) {
          this.onClose()
        }
      })
    }
  }
</script>

<template>
    <div id="modal2" 
        class="modal" 
        @click="close" 
        aria-labelledby="myModalLabel">

        <div class="modal-dialog">

            <div class="modal-content" @click.stop>

                <div class="modal-body">

                    <slot></slot>

                    <div class="row text-center">
                        <button 
                            type="button" 
                            class="btn btn-xs"
                            @click="close">

                            Fechar
                        </button>        
                        <!--data-dismiss="modal"-->
                    </div>                              
                </div>

            </div>

        </div>

    </div>      
</template>