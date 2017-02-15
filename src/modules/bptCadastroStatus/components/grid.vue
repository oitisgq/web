<script>
  export default {
    name: 'BptsGrid',

    props: {
      dataSource: {type: Array}
    },

    data () {
      return {
        selected_: [],

        project: {},

        colors: [
          { portugues: 'VERMELHO', ingles: 'red' },
          { portugues: 'VERDE', ingles: 'green' },
          { portugues: 'AZUL', ingles: 'blue' }
        ]
      }
    },

    methods: {
      onSelectItem (item, state) {
        this.$emit('onSelectItem', item, state)
      },
      color (item) {
        return this.colors.filter(function (obj) {
          return obj.portugues === item
        })[0].ingles
      }
    }
  }
</script>

<template>
  <div id="BptsGrid">
    <table class="table table-condensed table-striped table-hover" style="margin-bottom:0;padding-bottom:0">
        <thead>
            <tr>
                <th style="padding:0">
                    <font size="2" class="text-nowrap">Relase
                        <a href="#" @click.prevent="setOrder('release')">
                        </a>
                    </font>
                </th>

                <th style="padding:0">
                    <font size="2" class="text-nowrap">Classificação
                        <a href="#" @click.prevent="setOrder('classification')">
                        </a>
                    </font>
                </th style="padding:0">

                <th style="padding:0">
                    <font size="2" class="text-nowrap">Projeto
                        <a href="#" @click.prevent="setOrder('project')">
                        </a>
                    </font>
                </th style="padding:0">                

                <th style="padding:0">
                    <font size="2" class="text-nowrap">BPT
                        <a href="#" @click.prevent="setOrder('name')">
                        </a>
                    </font>
                </th>
                <th style="padding:0">
                    <font size="2" class="text-nowrap">Sistema
                        <a href="#" @click.prevent="setOrder('system')">
                        </a>
                    </font>
                </th>
                <th style="padding:0">
                    <font size="2" class="text-nowrap">Status
                        <a href="#" @click.prevent="setOrder('status')">
                        </a>
                    </font>
                </th>                
                <th width="1%" style="padding:0">
                </th>                 
            </tr>
        </thead>
        <tbody v-for="item in dataSource">
            <tr style="padding:0">
                <td style="padding:0">
                    <font size="2">{{item.release}}</font>
                </td style="padding:0">
                <td style="padding:0">
                    <font size="2">{{item.classification}}</font>
                </td style="padding:0">
                <td style="padding:0">
                    <font size="2">{{item.project}}</font>
                </td style="padding:0">                
                <td style="padding:0">
                    <font size="2">{{item.name}}</font>
                </td style="padding:0">
                <td style="padding:0">
                    <font size="2">{{item.system}}</font>
                </td style="padding:0">
                <td style="padding:0">
                    <font size="2">{{item.status}}</font>
                </td style="padding:0">                

                <td style="padding:0">
                    <input 
                        type="checkbox" 
                        :id="item.id" 
                        :value="item.id" 
                        v-model="itemsSelected"
                    />
                </td>
            </tr>
        </tbody> 
    </table>
  </div>
</template>

<style>
</style>