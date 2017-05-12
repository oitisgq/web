<script>
  import ServicesProject from 'src/modules/project/services'
  import ServicesCadgroupers from 'src/modules/cadgroupers/services'
  import ServicesProjectXgrouper from 'src/modules/projectXgrouper/services'
  import oiGrid from 'components/grouper/gridShow.vue'
  import oiShow from 'components/grouper/show.vue'
  import oiModal from 'components/modal_.vue'
  import Toastr from 'toastr'
  import webApiPath from 'src/http/webApiPath'
  import webAppPath from 'src/http/webAppPath'

  export default {
    name: 'groupersMain',

    components: { oiGrid, oiShow, oiModal },

    data () {
      return {
        state: 'search',

        filterProperties: [
            {name: 'name'}
        ],

        item: {},
        itemFull: {},
        items: [],
        itemsFilteredByText: [],
        itemFilterTerm: '',

        email: {
          from: 'sgq@oi.net.br',
          to: '',
          subject: '',
          url: ''
        }
      }
    },

    created () {
      this.loadData()
    },

    methods: {
      loadData () {
        ServicesCadgroupers.getAll().then(resp => {
          this.items = resp.data
          this.itemsFilteredByText = resp.data
        })
      },

      filterItems (evento) {
        let _this = this
        if (this.itemFilterTerm !== '') {
          let words = this.itemFilterTerm.split('+')

          this.itemsFilteredByText = this.items.filter(item => {
            return words.every(word => {
              return _this.filterProperties.some(filterProperty => {
                return item[filterProperty.name].toLowerCase().indexOf(word.toLowerCase()) > -1
              })
            })
          })
        } else {
          this.itemsFilteredByText = this.items
        }
      },

      searchItem () {
        this.state = 'search'
      },

      selectItem (item, state) {
        this.item = item
        this.state = state
        ServicesProjectXgrouper.getByGrouper(item.id).then(pg => {
          if (pg.data.length !== 0) {
            let ids = pg.data.map(i => (i.project)).join()
            ServicesProject.getProjectsByIds(ids)
              .then(r => {
                this.itemFull = {
                  grouper: item,
                  projects: r.data
                }
              }
            )
          } else {
            this.itemFull = {
              grouper: item,
              projects: []
            }
          }

          this.email.subject = '[Agrupador] ' + this.item.name
        })
      },

      showItem () {
        this.state = 'show'
      },

      showReport () {
        this.state = 'showReport'
      },

      closeModalShowReport () {
        this.state = 'show'
      },

      sendReportByEmail () {
        this.email.url = webAppPath.default + '/grouper/report/' + this.item.id
        // Toastr.info('Aguarde o envio...', '', {timeOut: 0, extendedTimeOut: 0})
        Toastr.info('E-mail solicitado! Pode continuar a usar a aplicação...', '', { timeOut: 20000 })
        this.$http.post(webApiPath.default + '/SendEmailGrouper', this.email).then(r => {
          // Toastr.success('E-mail enviado!', '', {timeOut: 0, extendedTimeOut: 0})
          Toastr.success('E-mail enviado!', '', { timeOut: 15000 })
        }, e => {
          // Toastr.error('Não foi possível enviar o e-mail. Tente novamente!', '', {timeOut: 0, extendedTimeOut: 0})
          Toastr.error('Não foi possível enviar o e-mail. Tente novamente!', '', { timeOut: 15000 })
        })
      }
    }
  }
</script>

<template>
  <div id="caditemsMain" class="container">
    <div class="row well well-sm">
      <div class="row">
        <div class="col-xs-6">
          <label>Agrupadores</label>
        </div>
        <div class="col-xs-6 text-right">
          <a class="btn btn-xs my-tool-tip oi-icon"
            v-show="state !== 'search'" 
            @click="showReport"
            data-toggle="modal"
            data-target="#showReport"
            title="Report Por Email">
            <span class="glyphicon glyphicon-envelope"></span>
          </a>

          <a class="btn btn-xs my-tool-tip oi-icon"
            v-show="this.state !== 'search'" 
            @click="searchItem"
            data-toggle="tooltip" 
            title="Pesquisar">
            <span class="glyphicon glyphicon-search"></span>
          </a>

          <a class="btn btn-xs my-tool-tip oi-icon"
            v-show="this.state !== 'show' && this.state !== 'search' && this.state !== 'new'"
            @click="showItem"
            data-toggle="tooltip" 
            title="Exibir">
            <span class='glyphicon glyphicon-list-alt'></span>
          </a>
         
        </div>
      </div>

      <div class="row well well-sm oi-well" v-show="this.state=='search'">
        <input type="text"
            placeholder="Informe o filtro!"
            v-model="itemFilterTerm"
            @keyup="filterItems"/>
      </div>
      <oiGrid
        v-show="this.state === 'search'"
        :items="itemsFilteredByText"
        @onSelectItem="selectItem"
      />

      <oiShow
        v-show="this.state=='show'"
        :item="itemFull"
      />  

      <!-- SEND REPORT -->
      <oiModal id="showReport" v-show="this.state=='showReport'">
        <div class="text-center">
          <div class="form-group">
              <input type="email" class="form-control" id="email" placeholder="email de destino" v-model="email.to"></textarea>
          </div>

          <div class="form-group">
              <textarea class="form-control" rows="3" id="subject" placeholder="título da menssagem" v-model="email.subject"></textarea>
          </div>

          <a class="btn btn-primary btn-xs" id="alert-target"
            role="button"
            v-show="email.to != '' && email.subject != ''"
            @click="sendReportByEmail">
            Enviar
          </a>            

          <a class="btn btn-primary btn-xs" 
            role="button"
            data-dismiss="modal"
            @click="closeModalShowReport">
            Fechar
          </a>
        </div>
      </oiModal>
    </div>
  </div>
</template>

<style scoped>
  input {
     min-width: 100%
  }
  .container {
    margin-top: 15px;
  }
  .oi-well {
    margin: 0;
    border: 0;
    padding: 0;
  }
  .oi-icon {
    font-size: medium;
  }
</style>