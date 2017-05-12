<script>
  import ServicesProjectXgrouper from 'src/modules/projectXgrouper/services'
  import ServicesProject from 'src/modules/project/services'
  import ServicesGrouper from 'src/modules/grouper/services'
  import oiReport from 'components/grouper/report.vue'

  export default {
    name: 'GrouperReport',

    components: { oiReport },

    data () {
      return {
        groupParameter: '',
        grouper: {},
        itemFull: {}
      }
    },

    created () {
      this.groupParameter = this.$route.params.grouper
      this.loadData()
    },

    watch: {
      '$route' (to, from) {
        this.groupParameter = this.$route.params.grouper
        this.loadData()
      }
    },

    methods: {
      loadData () {
        ServicesGrouper.get(this.groupParameter).then(r => {
          this.grouper = r.data

          ServicesProjectXgrouper.getByGrouper(this.groupParameter).then(pg => {
            if (pg.data.length !== 0) {
              let ids = pg.data.map(i => (i.project)).join()
              ServicesProject.getProjectsByIds(ids).then(r => {
                this.itemFull = {
                  grouper: this.grouper,
                  projects: r.data
                }
              })
            } else {
              this.itemFull = {
                grouper: this.grouper,
                projects: []
              }
            }
          })
        })
      }
    }
  }
</script>

<template>
    <div class="container-fluid well well-sm">
      <oiReport
        :item="itemFull"
      />  
    </div>
</template>


<style scoped>
  .oi-icon {
    font-size: medium;
  }
</style>