<script>
    export default {
      name: 'editSelections',
      props: {
        id: {type: String},
        title: {type: String},
        dataSource: {type: Array},
        itemsSelected: {type: Array},
        onStart: {type: Function}
       // onConfirm: {type: Function}
      },
      data () {
        return {
          isUpdate: false
        }
      },

      /*
      computed: {
        itemsSelectedAux: {
          get () { return this.itemsSelected },
          set (value) {
            this.itemsSelected = value
          }
        }
      },
      */

      methods: {
        selectAll: function () {
          this.itemsSelected = this.dataSource.map(e => e.id)
          this.isUpdate = true
        },

        unSelectAll: function () {
          this.itemsSelected = []
          this.isUpdate = true
        },

        update: function () {
          this.isUpdate = true
        },

        confirm () {
          this.$emit('onChangeSelected', this.itemsSelected)
          this.isUpdate = false
        }
      }
    }
</script>

<template>
    <span>
        <label class="fd-label" v-text="title">:</label>
        <button 
            type="button" 
            id="selectAll" 
            class="btn btn-xs"
            @click="selectAll()">Tudo
        </button>
        
        <button 
            type="button" 
            id="unSelectAll" 
            class="btn btn-xs" 
            @click="unSelectAll()">Nada
        </button>
        
        <button 
            type="button" 
            id="Confirmar" 
            class="btn btn-xs" 
            data-dismiss="modal"
            v-show="isUpdate"
            v-on:click="confirm()">Confirmar
        </button>

        <div class="row well-sm oi-well"><br>
                <div class="col-xs-12 col-sm-6 col-lg-4" v-for="item in dataSource" track-by="$index" style="padding:0">
                      <div class="col-xs-1">
                          <input style="margin-top:4px"
                              type="checkbox" 
                              :id=item.id
                              :value=item.id
                              v-model="itemsSelected"
                              @click="update" 
                          />
                      </div>       

                      <div class="col-xs-11">
                          <label style="font-size:small; font-weight:normal; margin-left:-15px" v-text="item.id"></label>
                      </div>                
              </div>                
        </div>
    </span>
</template>

<style scoped>
  .oi-well {
    margin: 0;
    border: 0;
    padding: 0;
  }  
  .fd-label {
    margin: 0; 
    border: 0; 
    padding: 0; 
    color: gray;
  }  
</style>