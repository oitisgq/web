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
          ItemsSelected: [],
          isUpdate: false
        }
      },
      methods: {
        selectAll: function () {
          this.ItemsSelected = this.dataSource.map(e => e.id)
          this.isUpdate = true
        },

        unSelectAll: function () {
          this.ItemsSelected = []
          this.isUpdate = true
        },

        update: function () {
          this.isUpdate = true
        },

        confirm () {
          this.$emit('onChangeSelected', this.ItemsSelected)
          this.isUpdate = false
        }
      }
    }
</script>

<template>
    <span>
        <label>{{title}}:</label>
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

        <div class="row well-sm oi-well" style="margin-bottom:3px">
            <template v-for="item in dataSource" track-by="$index">
                <input 
                    type="checkbox" 
                    :id=item.id
                    :value=item.id
                    v-model="ItemsSelected"
                    @click="update"
                />
                <label :for=item style="padding-right:10px">{{item.id}}</label>
            </template>
        </div>
    </span>
</template>

<style scoped>
  .oi-well {
    margin: 0;
    border: 0;
    padding: 0;
  }  
</style>