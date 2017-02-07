<script>
  import { mapActions } from 'vuex'

  export default {
    name: 'authLogin',
    data () {
      return {
        user: {
          networkLogin: '',
          password: ''
        }
      }
    },
    methods: {
      ...mapActions(['attemptLogin']),
      doLogin () {
        // this.$store.dispatch('attemptLogin', { ...this.user })
        this.attemptLogin({ ...this.user })
          .then(() => {
            this.$router.push('/')
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

        var authenticate=function(username,password,callback){
          if(!user_config.isCheckUser){
            getSuccessResult(username,password,null,callback);
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
                //check password with bind function
                if(user_config.isCheckPassword){
                  client.bind(entry.dn, password, function(err) {//bind successfully
                    if (err){
                      callback(helper.getMessageObject(false,"Your password is not correct."));
                    }else{
                      getSuccessResult(username,password,entry,callback);
                    }
                  });
                }else{
                  getSuccessResult(username,password,entry,callback);
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
        return this.user.networkLogin === 'admin' && this.user.password === 'frade'
      }
    }
  }
</script>

<template>
  <div id="authLogin" class="container">
      <div class="col-md-6">
          <div class="form-group">
              <label>Login de Rede</label>
              <input type="text" class="form-control" v-model="user.networkLogin">
          </div>
          <div class="form-group">
              <label>Senha</label>
              <input type="password" class="form-control" v-model="user.password">
          </div>
          <div class="col-xs-12 text-center">
              <button 
                class="btn btn-default btn-sm" 
                :disabled="!isUserValid" 
                @click="doLogin">Autenticar
              </button>
          </div>
      </div>
  </div>
</template>