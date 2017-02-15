<script>
  import oiShow from './selectionBptsShow.vue'
  import oiEdit from './selectionBptsEdit.vue'

  export default {
    name: 'selectionBpts',

    components: { oiEdit, oiShow },

    props: {
      dataSource: { type: Array },
      selected: { type: Array },
      confirmed: { type: Boolean }
    },

    data () {
      return {
        // selected: this.selected,
        // confirmed: this.confirmed,
        inEdit: false
      }
    },

    computed: {
      // selected () { return this.selected },
      // confirmed () { return this.confirmed },
      isEdit () { return !this.confirmed || this.inEdit }
    },

    methods: {
      enterInEdit () {
        this.inEdit = true
        this.$emit('onEnterInEdit')
      },
      confirmData (selected) {
        this.confirmed = true
        this.selected = selected
        this.inEdit = false
        this.$emit('onConfirmData', selected)
      }
    }

  }
</script>

<template>
    <span>
        <oiShow
            v-show="!isEdit"
            :dataSource="selected"
            :numberOfBpts="dataSource.length"
            @onEnterInEdit="enterInEdit"
        />

        <oiEdit
            v-show="isEdit"
            :dataSource="dataSource"
            :filteredByTerm="dataSource"
            :selected="selected"
            @onConfirmData="confirmData"
        />
    </span>            
</template>

<style scoped>

</style>