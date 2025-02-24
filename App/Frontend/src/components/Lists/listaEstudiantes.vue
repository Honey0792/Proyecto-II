<template>
  <v-card class="mx-auto" max-width="300">
    <v-list :items="estudiante" item-title="apellido_etd" item-value="id_etd">
    </v-list>
  </v-card>
</template>

<script>
import newGoalService from "@/services/newGoalService";

export default {
  data: () => ({
    estudiante: [],
  }),

  methods: {

    async obtenerEstudiante() {
      try {
        console.log('hola')
        const res = await newGoalService.getEstudiante();
        this.estudiante = res.data.datos;
        console.log(this.estudiante)
      } catch (error) {
        console.log(error);
      }
    },
  },

  mounted(){
    this.obtenerEstudiante()
  }
};

</script>
