<script>
  import oiModal from 'components/modal.vue'
  import oiItemsSelectionShow from 'components/filterItems/ItemsSelectionShow.vue'
  import oiItemsSelectionEdit from 'components/filterItems/ItemsSelectionEdit.vue'

  export default {
    name: 'ItemsSelection',
    data () {
      return {
      }
    },
    props: {
      idChild: {type: String},
      title: {type: String},
      dataSource: {type: Array},
      itemsSelected: {type: Array},
      isShowButtonSelected: {type: Boolean}
    },
    components: { oiModal, oiItemsSelectionShow, oiItemsSelectionEdit },
    methods: {
      changeSelected (itemsSelected) {
        this.itemsSelected = itemsSelected
        this.$emit('onChangeSelected', this.itemsSelected)
      }
    }
  }
</script>

<template>
  <span>
    <oiItemsSelectionShow
      :title="title"               
      :dataSource="itemsSelected">

      <button 
          type="button"     
          class="btn btn-xs"
          data-toggle="modal" 
          :data-target="'#modalEdit' + idChild">
          Seleção
      </button>    
         
      <button 
          type="button"     
          class="btn btn-xs"
          v-show="isShowButtonSelected===true"
          data-toggle="modal" 
          :data-target="'#modalShow' + idChild">
          Selecionados
      </button>       
    </oiItemsSelectionShow>

    <oiModal :id="'modalEdit' + idChild">
       <oiItemsSelectionEdit
          :id="idChild"
          :title="title"
          :dataSource="dataSource"
          @onChangeSelected="changeSelected"
      ></oiItemsSelectionEdit> 
    </oiModal>

    <oiModal :id="'modalShow' + idChild">
      <oiItemsSelectionShow
          :title="title"
          :dataSource="itemsSelected"
          @onChangeSelected="changeSelected"
      ></oiItemsSelectionShow> 
    </oiModal>
  </span>
</template>

<!-- v-show="showButtonSelect" -->