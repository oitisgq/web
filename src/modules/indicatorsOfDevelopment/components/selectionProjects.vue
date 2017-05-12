<script>
  import oiShow from './selectionProjectsShow.vue'
  import oiEdit from './selectionProjectsEdit.vue'

  export default {
    name: 'selectionProjects',

    components: { oiEdit, oiShow },

    props: {
      dataSource: { type: Array },
      selected: { type: Array },
      confirmed: { type: Boolean },
      messageTimeline: { type: Boolean }
    },

    data () {
      return {
        // selected: this.selected,
        inEdit: false,
        date1: '',
        date2: ''
      }
    },

    computed: {
      // selected () { return this.selected },
      // confirmed () { return this.confirmed },
      isEdit () { return !this.confirmed || this.inEdit }
    },

    methods: {
      message (date1, date2) {
        this.date1 = date1
        this.date2 = date2
      },
      enterInEdit () {
        this.inEdit = true
        this.$emit('onEnterInEdit')
      },
      confirmData (selected) {
        this.confirmed = true
        this.selected = selected
        this.inEdit = false
        this.$emit('onConfirmData', selected)
      },
      /*
      confirmDataDay (selected) {
        this.confirmed = true
        this.selected = selected
        this.inEdit = false
        this.$emit('onConfirmDataDay', selected)
      },
      confirmDataLastDay (selected) {
        this.confirmed = true
        this.selected = selected
        this.inEdit = false
        this.$emit('onConfirmDataLastDay', selected)
      },
      */
      confirmDataTimeline (selected, dataDens, dataAg, dataWr, dataDet, dataReop, dataPred) {
        this.confirmed = true
        this.selected = selected
        this.dataDens = dataDens
        this.dataAg = dataAg
        this.dataWr = dataWr
        this.dataDet = dataDet
        this.dataReop = dataReop
        this.dataPred = dataPred
        this.inEdit = false
        this.$emit('onConfirmDataTimeline', selected, dataDens, dataAg, dataWr, dataDet, dataReop, dataPred)
      }
    }

  }
</script>

<template>
    <span>
        <oiShow
            v-show="!isEdit"
            :dataSource="selected"
            :numberOfProjects="dataSource.length"
            :date1="date1"
            :date2="date2"
            :messageTimeline="messageTimeline"
            @onEnterInEdit="enterInEdit"
        />

        <oiEdit
            v-show="isEdit"
            :dataSource="dataSource"
            :filteredByTerm="dataSource"
            :selected="selected"
            @onConfirmData="confirmData"
            @onConfirmDataTimeline="confirmDataTimeline"
            @onMessage="message"
        />
    </span>            
</template>

<style scoped>

</style>