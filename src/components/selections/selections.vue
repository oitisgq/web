<script>
  import oiModal from 'components/modal.vue'
  import showSelections from 'components/selections/showSelections.vue'
  import editSelections from 'components/selections/editSelections.vue'

  export default {
    name: 'selections',

    components: { oiModal, showSelections, editSelections },

    props: {
      idChild: {type: String},
      title: {type: String},
      dataSource: {type: Array},
      itemsSelected: {type: Array},
      isShowButtonSelected: {type: Boolean}
    },

    data () {
      return {
        itemsSelectedCpy: []
      }
    },

    mounted () {
      this.itemsSelectedCpy = this.itemsSelected
    },

    methods: {
      changeSelected (itemsSelected) {
        this.itemsSelectedCpy = itemsSelected
        this.$emit('onChangeSelected', itemsSelected)
      }
    }

  }
</script>

<template>
  <span>

    <label>{{title}}:</label>

    <button 
        type="button"     
        class="btn btn-xs"
        data-toggle="modal" 
        :data-target="'#modalEdit' + idChild">Seleção
    </button>    
    
    <oiModal :id="'modalEdit' + idChild">
      <editSelections
          :id="idChild"
          :title="title"
          :dataSource="dataSource"
          :itemsSelected="itemsSelectedCpy"
          @onChangeSelected="changeSelected"
      ></editSelections> 
    </oiModal>

    <showSelections
        v-show="itemsSelected.length > 0 && !isShowButtonSelected"
        :dataSource="itemsSelected">
    </showSelections> 

    <button 
        type="button"
        v-show="itemsSelected.length > 0 && isShowButtonSelected"
        class="btn btn-xs"
        data-toggle="modal" 
        :data-target="'#modalShow' + idChild">Selecionados
    </button>       

    <oiModal :id="'modalShow' + idChild">
      <showSelections
          :title="title"
          :dataSource="itemsSelected"
      ></showSelections> 
    </oiModal>

  </span>
</template>

<style scoped>
</style>