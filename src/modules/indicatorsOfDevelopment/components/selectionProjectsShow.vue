<script>
  import oiModal from 'components/modal.vue'

  export default {
    name: 'selectionProjectsShow',

    props: {
      dataSource: { type: Array },
      numberOfProjects: { type: Number },
      date1: { type: String },
      date2: { type: String },
      messageTimeline: { type: Boolean }
    },

    components: { oiModal },

    computed: {
      message () {
        let projects = this.numberOfProjects ? 'Encontrados: <b>' + this.numberOfProjects + '</b>' : ''
        let selected = this.dataSource.length ? 'Selecionados: <b>' + this.dataSource.length + '</b>' : ''
        let timeScope1 = this.date1.length ? 'Data Início: <b>' + this.convertDate(this.date1) + '</b>' : ''
        let timeScope2 = this.date2.length ? 'Data Fim: <b>' + this.convertDate(this.date2) + '</b>' : ''
        if (selected !== '' || timeScope1 !== '' || timeScope2 !== '') {
          projects = projects + ', '
        }
        if (timeScope1 !== '' || timeScope2 !== '') {
          selected = selected + ', '
        }
        if (timeScope2 !== '') {
          timeScope1 = timeScope1 + ', '
        }
        if (this.messageTimeline === true) {
          return projects + selected + timeScope1 + timeScope2
        } else {
          return projects + selected
        }
      }
    },

    methods: {
      EnterInEdit () {
        this.$emit('onEnterInEdit')
      },
      convertDate (inputFormat) {
        var year = inputFormat.substr(0, 4)
        var month = inputFormat.slice(5, 7) - 1
        var day = inputFormat.slice(8)
        function pad (s) { return (s < 10) ? '0' + s : s }
        var d = new Date(year, month, day)
        return [pad(d.getDate()), pad(d.getMonth() + 1), d.getFullYear()].join('/')
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