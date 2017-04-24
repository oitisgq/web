<script>
  import Services from 'src/modules/cadGroups/services'
  import Group from 'src/models/Group'
  import Toastr from 'toastr'

  import oiGrid from 'components/groups/grid.vue'
  import oiView from 'components/groups/view.vue'
  // import oiEdit from './edit.vue'

  export default {
    name: 'cadGroupsMain',

    components: { oiGrid, oiView },

    data () {
      return {
        state: 'search',

        filterProperties: [
            {name: 'name'},
            {name: 'description'}
        ],

        item: {},
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
        Services.getAll().then(resp => {
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
        let xx = new Group(item)
        console.log(xx)
        this.item = item
        this.state = state
        // this.loadIterations(this.item)
      },

      showItem () {
        this.state = 'show'
      },

      editItem () {
        this.state = 'edit'
      },

      saveItem (item) {
        /* updateitem(item)
          .then(data => {
            console.log(data)
          }) */
        Services.updateOne(item)
        Toastr.success('Dados gravados!')

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
            @click="saveItem(item)"
            data-toggle="tooltip" 
            title="Gravar">
            <span class='glyphicon glyphicon-save'></span>
          </a>

          <a class="btn btn-xs my-tool-tip oi-icon"
            v-show="this.state === 'edit'" 
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

      <!--
      <oiEdit 
        v-show="this.state=='edit'"
        :item="item"
      />
      -->  

      <oiView
        v-show="this.state=='show'"
        :item="item"
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