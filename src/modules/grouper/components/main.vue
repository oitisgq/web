<script>
  import ServicesProject from 'src/modules/project/services'
  import ServicesCadgroupers from 'src/modules/cadgroupers/services'
  import ServicesProjectXgrouper from 'src/modules/projectXgrouper/services'
  import oiGrid from 'components/grouper/gridShow.vue'
  import oiView from 'components/grouper/view.vue'

  export default {
    name: 'groupersMain',

    components: { oiGrid, oiView },

    data () {
      return {
        state: 'search',

        filterProperties: [
            {name: 'name'},
            {name: 'description'}
        ],

        item: {},
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

      showItem () {
        this.state = 'show'
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