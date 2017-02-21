<script>
    import appHeader from './components/header/main.vue'

    export default {
      components: { appHeader }
    }
</script>

<template>
  <div id="app">
    <appHeader/>
    <router-view></router-view>
  </div>
</template>

<style src="assets/sass/app.scss" lang="sass">

</style>
