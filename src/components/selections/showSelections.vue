<script>
  export default {
    name: 'showSelections',

    props: {
      dataSource: {type: Array}
    }
  }
</script>

<template>
  <span>
    <div class="row well-sm" style="margin-bottom:3px">
        <template v-for="item in dataSource" track-by="$index">
            <label :for=item style="margin-left:10px; font-size:10px; line-height:0px">{{item}}</label>
        </template>
    </div>
  </span>
</template>
