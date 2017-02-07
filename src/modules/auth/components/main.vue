<script>
  import { mapGetters } from 'vuex'
  import login from './login.vue'

  export default {
    name: 'authMain',
    components: { login },
    computed: {
      ...mapGetters(['isLogged'])
    }
  }
</script>

<template>
  <div id="authMain" class="container">
    <h3>Autenticação</h3><br>
    <login/>
  </div>
</template>