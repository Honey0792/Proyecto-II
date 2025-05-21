<template>
  <v-tabs v-model="tab">
    <v-tab value="one" @click="refrescarRepresentantes">Estudiante</v-tab>
    <v-tab value="two">Representante</v-tab>
  </v-tabs>

  <v-tabs-window v-model="tab">
    <v-tabs-window-item value="one">
      <RegEstudiante ref="hijo" />
    </v-tabs-window-item>

    <v-tabs-window-item value="two">
      <RegRepresentante />
    </v-tabs-window-item>
  </v-tabs-window>
</template>

<script>
import RegEstudiante from "@/components/Forms/RegEstudiante.vue";
import RegRepresentante from "@/components/Forms/RegRepresentante.vue";
export default {
  components: {
    RegEstudiante,
    RegRepresentante,
  },
  data: () => ({
    tab: null,
  }),
  methods: {
    refrescarRepresentantes() {
      this.$refs.hijo.obtenerRepresentantes();
    },
  },
};
</script>
