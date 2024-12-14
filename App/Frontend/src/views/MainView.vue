<template>
  <v-container class="d-flex">
    <v-card
      v-for="n in 3"
      :key="n"
      class="mx-auto"
      prepend-icon="$vuetify"
      width="400"
      height="300"
    >
    
      <template v-slot:title>
        <span class="font-weight-black">Welcome to Vuetify</span>
      </template>
      <template v-slot class="d-flex justify-center align-center">
        <v-progress-circular model-value="20" size="200"></v-progress-circular>
      </template>
    </v-card>
  </v-container>
</template>

<script>
export default {
  components: {},
  methods: {},
};
</script>
