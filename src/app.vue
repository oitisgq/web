<script>
    import appHeader from './components/header/main.vue'

    export default {
      components: { appHeader }
    }
</script>

<template>
  <div id="app">
    <appHeader/>
    <div class="container">
      <router-view></router-view>
    </div>    
  </div>
</template>

<style src="assets/sass/app.scss" lang="sass">

</style>
