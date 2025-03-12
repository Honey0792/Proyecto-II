<template>
  <v-card class="mx-auto" max-width="800">
    <v-data-table
      :headers="headers"
      :items="estudiantes"
    >
  <template v-slot:item.nombre_etd="{ item }">
    {{ item.nombre_etd }} {{ item.apellido_etd }}
  </template>
  </v-data-table>
  </v-card>
</template>

<script>
import newGoalService from "@/services/newGoalService";

export default {
  data: () => ({
    estudiantes: [], // Lista de estudiantes
    headers: [
      { title: "ID", key: "id_etd" }, // Columna para el ID del estudiante
      { title: "Apellido", key: "apellido_etd" }, // Columna para el apellido
      { title: "Nombre", key: "nombre_etd" }, // Columna para el nombre
      { title: "Correo", key: "correo_etd" }, // Columna para el correo
      // Agrega más columnas según los datos que tengas
    ],
  }),

  methods: {
    async obtenerEstudiantes() {
      try {
        const res = await newGoalService.getEstudiante();
        this.estudiantes = res.data;
        console.log(this.estudiantes);
      } catch (error) {
        console.log(error);
      }
    },
  },

  mounted() {
    this.obtenerEstudiantes();
  },
};
</script>