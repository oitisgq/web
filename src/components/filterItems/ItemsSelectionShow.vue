<script>
  export default {
    name: 'ItemsSelectionShow',
    props: {
      title: {type: String},
      dataSource: {type: Array}
    },
    methods: {
    }
  }
</script>

<template>
  <span>
    <label>{{title}}:</label>
    <slot></slot>
    <div class="row well-sm" style="margin-bottom:3px">
        <template v-for="item in dataSource" track-by="$index">
            <label :for=item style="margin-left:10px; font-size:10px; line-height:0px">{{item}}</label>
        </template>
    </div>

    <label v-show="this.dataSource.length < 1">Clique em 'Seleção' para escolher os itens desejados. </label>
  </span>
</template>

<!-- v-show="showButtonSelect" -->