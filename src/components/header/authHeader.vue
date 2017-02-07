<script>
  import { mapGetters } from 'vuex'

  export default {
    name: 'authHeader',
    data () {
      return {
        menuUserIsOpen: false
      }
    },
    methods: {
      toggleMenuUser () {
        this.menuUserIsOpen = !this.menuUserIsOpen
      },
      closeMenuUser () {
        this.menuUserIsOpen = false
      }
    },
    computed: {
      ...mapGetters(['isLogged', 'currentUser'])
    }
  }
</script>

<template>
    <ul id="authHeader" class="nav navbar-nav navbar-right" >
        <router-link :to="{ name: 'auth' }" tag="li" style="margin-left:10px" v-if="!isLogged" >
            <a class="oi-menu">Login</a>
        </router-link>

        <li class="dropdown" v-if="isLogged" :class="{ open: menuUserIsOpen }">
            <a href="#" 
              class="dropdown-toggle oi-menu" 
              data-toggle="dropdown"
              style="margin-left:10px">
                <span class="glyphicon glyphicon-user"/>&nbsp;admin
                <span class="caret"></span>
            </a>
            
            <!--
              console.log('action')
              @click="toggleMenuUser"
            -->

            <ul class="dropdown-menu">
                <router-link :to="{ name: 'auth' }" tag="li" style="margin-left:10px" >
                    <a class="oi-menu">Login com outro usuário</a>
                </router-link>
            </ul>
        </li>
    </ul>
</template>

<style scoped>
    .oi-menu {
        height: 25px;
        margin: 0;
        padding: 0 7px 25px 7px;
    }
</style>