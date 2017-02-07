<script>
  export default {
    name: 'buttonMobile',
    methods: {
      toggle () {
        this.$emit('toggleMenu')
      }
    }
  }
</script>

<template>
    <button id="buttonMobile" @click="toggle"
        type="button" 
        class="navbar-toggle collapsed"
        data-toggle="collapse" 
        data-target="#menu-collapse" 
        aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"/>
        <span class="icon-bar"/>
        <span class="icon-bar"/>
    </button>
</template>