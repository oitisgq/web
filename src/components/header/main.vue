<script>
  import oiBrand from './brand.vue'
  import oiButtonMobile from './ButtonMobile.vue'
  import oiMenu from './menu.vue'
  import oiAuthHeader from './authHeader.vue'

  export default {
    name: 'header',
    components: { oiBrand, oiButtonMobile, oiMenu, oiAuthHeader },
    data () {
      return {
        menuIsOpen: false
      }
    },
    methods: {
      onToggleMenu () {
        this.menuIsOpen = !this.menuIsOpen
      }
    }
  }
</script>

<template>
    <nav id="header" class="navbar navbar-default" style="margin:0">
      <div class="navbar-header">
          <oiBrand/>
          <oiButtonMobile @toggleMenu="onToggleMenu"/>
      </div>
      
      <div id="menu-collapse" class="collapse navbar-collapse"> 
        <!-- :class="{ in: menuIsOpen }" -->
        <oiAuthHeader />
        <oiMenu/>
      </div>
    </nav> 
</template>