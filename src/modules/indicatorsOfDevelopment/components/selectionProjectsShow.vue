<script>
  import oiModal from 'components/modal.vue'

  export default {
    name: 'selectionProjectsShow',

    props: {
      dataSource: { type: Array },
      numberOfProjects: { type: Number }
    },

    components: { oiModal },

    computed: {
      message () {
        let projects = this.numberOfProjects ? 'Encontrados: <b>' + this.numberOfProjects + '</b>' : ''
        let selected = this.dataSource.length ? 'selecionados: <b>' + this.dataSource.length + '</b>' : ''
        if (selected !== '') {
          projects = projects + ', '
        }
        return projects + selected
      }
    },

    methods: {
      EnterInEdit () {
        this.$emit('onEnterInEdit')
      }

    }
  }

</script>

<template>
  <span>
    <!-- BOTÔES SELEÇÃO E SELECIONADOS  -->
    <div class="col-xs-12 oi-col" style="margin:0; border:0; padding:0">
        <div>
            <label>Projetos:</label>

            <button 
                type="button" 
                class="btn btn-xs"
                @click="EnterInEdit()">Seleção
            </button>    

            <button 
                type="button" 
                class="btn btn-xs"
                data-toggle="modal" 
                data-target="#showModalProjectsSelected">Selecionados
            </button>

            <label class="message" v-html="message"/>

            <oiModal id="showModalProjectsSelected">
                <h4 style="margin-top:0; text-align:center"><b>Projetos Selecionados</b></h4>
                <div class="row well well-sm oi-well">
                    <template v-for="item in dataSource" track-by="$index">
                        <label :for=item style="margin-left:10px; font-size:10px; line-height:0">{{item}}</label>
                    </template>
                </div>
            </oiModal> 
        </div>  
    </div>  


  </div>
 </span>            
</template>

<style scoped>
  .oi-well {
    margin: 0;
    border: 0;
    padding: 0px;
  }
  .oi-col {
    padding: 3px; 
    margin: 0; 
    border: 0;
  }
  .message {
    margin: 0; 
    margin-left: 10px; 
    vertical-align: middle;
    font-size: 12px;
    font-weight: normal;
  }  
</style>