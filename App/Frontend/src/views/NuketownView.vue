<template>
 <RegInscripcion />
  <RegEstudiante />
  <div class="d-flex justify-center"></div>
  <RegRepresentante />
</template>

<script>
import RegEstudiante from "@/components/Forms/RegEstudiante.vue";
import RegRepresentante from "@/components/Forms/RegRepresentante.vue";
import RegInscripcion from "@/components/Forms/RegInscripcion.vue";
export default {
  components: {
    RegEstudiante,
    RegRepresentante,
    RegInscripcion,
  },
  data: () => ({}),
};
</script>
