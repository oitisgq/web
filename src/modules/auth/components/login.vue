<script>
  import { mapActions, mapGetters } from 'vuex'

  export default {
    name: 'authLogin',
    data () {
      return {
        user: {
          login: '',
          cpf: ''
        },
        to: ''
      }
    },
    mounted () {
      this.to = this.$route.query.to
    },
    methods: {
      ...mapActions(['attemptLogin']),
      ...mapGetters(['isLogged']),

      doLogin () {
        // this.$store.dispatch('attemptLogin', { ...this.user })
        this.attemptLogin({ ...this.user })
          .then(() => {
            this.$router.push('/' + this.to)
          })

        /*
        var ldap = require('ldapjs')
        var client = ldap.createClient({
          url: 'ldap://ldap.oi.corp.net:3268'
        })

        var opts = {
          filter: '(&(l=Seattle)(email=*@oi.net.br))',
          scope: 'sub',
          attributes: ['dn', 'sn', 'cn']
        }

        client.search('o=example', opts, function (err, res) {
          console.log(err)

          res.on('searchEntry', function (entry) {
            console.log('entry: ' + JSON.stringify(entry.object))
          })
          res.on('searchReference', function (referral) {
            console.log('referral: ' + referral.uris.join())
          })
          res.on('error', function (err) {
            console.error('error: ' + err.message)
          })
          res.on('end', function (result) {
            console.log('status: ' + result.status)
          })
        })

        var authenticate=function(username,cpf,callback){
          if(!user_config.isCheckUser){
            getSuccessResult(username,cpf,null,callback);
          }else{
            var opts = {
                filter: '(mail=' + username + ')',
                scope: 'sub'
              };
            var client = ldap.createClient({
              url: ldap_config.scheme + '://' + ldap_config.ldapHost + ':' + ldap_config.ldapPort
            });
            var isFoundEntry = false;
            client.search(ldap_config.base, opts, function(err, res) {
              res.on('searchEntry', function(entry) {//found the user entry
                isFoundEntry = true;
                //check cpf with bind function
                if(user_config.isCheckcpf){
                  client.bind(entry.dn, cpf, function(err) {//bind successfully
                    if (err){
                      callback(helper.getMessageObject(false,"Your cpf is not correct."));
                    }else{
                      getSuccessResult(username,cpf,entry,callback);
                    }
                  });
                }else{
                  getSuccessResult(username,cpf,entry,callback);
                }
              });
              //do action if err happened when search run
              res.on('error', function(err) {
                callback(helper.getErrorObject(err.toString()));
              });
              //do action if end such as release client
              res.on('end', function(result) {
                client.unbind(function(err) {
                  if (err!==null){
                    callback(helper.getErrorObject(err.toString()));
                  }
                });
                if (!isFoundEntry){
                  callback(helper.getMessageObject(false,"Your intranet id is not correct."));
                }
              });
            });
          }
        };
        */
      }
    },
    computed: {
      isUserValid () {
        // return this.user.login === 'admin' && this.user.cpf === 'frade'
        return this.user.login !== ''
      }
    }
  }
</script>

<template>
  <div id="authLogin" class="container">
    <div class="row">
      <div class="col-xs-5">

        <div class="form-group">
            <label>Login de Rede</label>
            <input type="text" class="form-control" v-model="user.login">
        </div>

        <div class="form-group">
            <label>CPF</label>
            <input type="text" class="form-control" v-model="user.cpf">
        </div>

        <div class="col-xs-12 text-center">
            <button 
              class="btn btn-default btn-sm" 
              @click="doLogin">Autenticar
            </button>
        </div>

      </div>
    </div>
  </div>
</template>