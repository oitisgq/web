<script>
  import oiHeader from 'components/header/main.vue'
  // import oiDensityByDevManuf from 'components/charts/defects/densityByDevManuf.vue'

  // import vueResource from 'src/http/vueResource'

  export default {
    name: 'app',
    components: { oiHeader } /*,
    data () {
      return {
        myData: []
      }
    },
    created () {
      let _this = this
      vueResource.http.get('http://localhost:3000/projects')
        .then(r => {
          _this.myData = r.data
        })
        .catch(r => {
          console.log(r)
        })
    } */
  }
</script>

<template>
  <div id="app">
    <oiHeader/>
    <!-- <pre> {{myData | json}}</pre> -->
    <router-view/>
  </div>
</template>

<style src="assets/sass/app.scss" lang="sass">

</style>
