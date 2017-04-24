<script>
  import ServicesProject from 'src/modules/project/services'
  import ServicesCadgroupers from 'src/modules/cadgroupers/services'
  import ServicesProjectXgrouper from 'src/modules/projectXgrouper/services'
  
  // import grouper from 'src/models/grouper'
  import Toastr from 'toastr'

  import oiGrid from 'components/grouper/grid.vue'
  import oiView from 'components/grouper/view.vue'
  import oiEdit from './edit.vue'
  import oiNew from './new.vue'

  export default {
    name: 'cadgroupersMain',

    components: { oiGrid, oiView, oiEdit, oiNew },

    data () {
      return {
        state: 'search',

        filterProperties: [
            {name: 'name'},
            {name: 'executiveSummary'}
        ],

        item: {
          id: 0,
          name: '',
          type: 'STATUS',
          executiveSummary: ' ',
          trafficLight: 'VERDE'
        },

        itemFull: {},
        items: [],
        itemsFilteredByText: [],
        itemFilterTerm: ''
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
        })
      },

      deleteItem (item) {
        ServicesCadgroupers.delete(item.id)
          .then(r => {
            this.loadData()
            this.state = 'search'
            Toastr.success('Dados apagados!')
          })
      },

      newItem () {
        if (this.state !== 'new') {
          this.state = 'new'
          this.item = {
            id: 0,
            name: '',
            type: 'STATUS',
            executiveSummary: ' ',
            trafficLight: 'VERDE'
          }
        } else {
          if (this.item.name === '') {
            Toastr.success('Informe o nome!')
          } else {
            ServicesCadgroupers.create(this.item)
              .then(r => {
                this.items.push(r.data)
                this.loadData()
                this.state = 'search'
                Toastr.success('Dados gravados!')
              })
          }
        }
      },

      showItem () {
        this.state = 'show'
      },

      editItem () {
        this.state = 'edit'
      },

      saveItem () {
        ServicesCadgroupers.update(this.item)
        Toastr.success('Dados gravados!')
        this.loadData()
        this.state = 'search'
      }
    }
  }
</script>

<template>
  <div id="caditemsMain" class="container">
    <div class="row well well-sm">
      <div class="row">
        <div class="col-xs-6">
          <label>Cadastro de Agrupadores</label>
        </div>
        <div class="col-xs-6 text-right">
          <a class="btn btn-xs my-tool-tip oi-icon"
            v-show="this.state !== 'search'" 
            @click="searchItem"
            data-toggle="tooltip" 
            title="Pesquisar">
            <span class="glyphicon glyphicon-search"></span>
          </a>

          <a class="btn btn-xs my-tool-tip oi-icon"
            v-show="this.state === 'show'" 
            @click="editItem"
            data-toggle="tooltip" 
            title="Editar">
            <span class="glyphicon glyphicon-pencil"></span>
          </a>                  

          <a class="btn btn-xs my-tool-tip oi-icon" 
            v-show="this.state === 'edit'" 
            @click="saveItem"
            data-toggle="tooltip" 
            title="Gravar">
            <span class='glyphicon glyphicon-save'></span>
          </a>

          <a class="btn btn-xs my-tool-tip oi-icon" 
            v-show="this.state === 'new'" 
            @click="newItem"
            data-toggle="tooltip" 
            title="Gravar">
            <span class='glyphicon glyphicon-save'></span>
          </a>

          <a class="btn btn-xs my-tool-tip oi-icon"
            v-show="this.state !== 'show' && this.state !== 'search' && this.state !== 'new'"
            @click="showItem"
            data-toggle="tooltip" 
            title="Exibir">
            <span class='glyphicon glyphicon-list-alt'></span>
          </a>

          <a class="btn btn-xs my-tool-tip oi-icon"
            v-show="this.state === 'search'"
            @click="newItem"
            data-toggle="tooltip" 
            :title="this.state !== 'new' ? 'Novo' : 'Gravar'">
            <span class='glyphicon glyphicon-save-file'></span>
          </a>

          <a class="btn btn-xs my-tool-tip oi-icon"
            v-show="this.state === 'edit'"
            data-toggle="tooltip" 
            title="Apagar" 
            style="padding:0;margin:0; text-right"
            @click="deleteItem(item)">
            <i class='glyphicon glyphicon-trash'></i>
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
        @onDeleteItem="deleteItem"
      />

      <oiEdit 
        v-show="this.state=='edit'"
        :item="itemFull"
      />

      <oiNew
        v-show="this.state=='new'"
        :item="item"
      />

      <oiView
        v-show="this.state=='show'"
        :item="itemFull"
      />  
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