<template>
  <v-footer class="d-flex flex-column">
    <div class="bg-cyan-darken-1 w-100 px-5">
      <strong>Transforma tu futuro. Dile sí al idioma más hablado en el mundo.
        Haz del Aprender Inglés tu Nueva Meta</strong>

      <v-spacer></v-spacer>

    </div>

    <div class="px-4 py-2 bg-cyan-lighten-4 text-center w-100">
      {{ new Date().getFullYear() }} — <strong>New Goal ©</strong>
    </div>
  </v-footer>
</template>
<script>
export default {
  data: () => ({
 }),
};
</script>

<style scoped>
.v-footer {
  width: 100%;
  margin: 0; /* Elimina margen */
  padding: 0; /* Elimina padding */
  box-sizing: border-box; /* Asegura que el padding no afecte el ancho */
  position: relative; /* Asegura que ocupe el espacio completo */
  left: 0; /* Alinea al inicio */
  right: 0; /* Alinea al final */
}
</style>
