<template>
  <RegEstudiante />
  <div class="d-flex justify-center">
    <v-switch
      v-model="actRegPadres"
      title="Active aqui si necesita registrar un representante"
    ></v-switch>
  </div>
  <RegRepresentante v-show="actRegPadres" />
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
    actRegPadres: false,
  }),
};
</script>
