<template>
  <v-btn
    append-icon="mdi-plus"
    variant="elevated"
    class="mx-7"
    color="#B2EBF2"
    to="/registrar/cliente"
    >Añadir</v-btn
  >
  <v-card class="d-flex mx-10 ma-7">
    <v-data-table height="460" :headers="headers" :items="estudiantes">
      <template v-slot:item.nombre_etd="{ item }">
        {{ item.nombre_etd }}
      </template>
      <template v-slot:item.estado="{ value }">
        <div class="">
          <v-icon :color="getcolor(value)" icon="mdi-circle-medium"></v-icon>
        </div>
      </template>

      <template v-slot:item.actions="{ item }">
        <div class="d-flex ga-2 justify-end">
          <v-icon
            color="medium-emphasis"
            icon="mdi-pencil"
            size="small"
            @click="edita(item.id_etd)"
          ></v-icon>
          <v-icon color="medium-emphasis" icon="mdi-eye" size="small"></v-icon>
          <v-icon
            color="medium-emphasis"
            icon="mdi-delete"
            size="small"
            @click="remove(item.id)"
          ></v-icon>
        </div>
      </template>
    </v-data-table>
  </v-card>

  <v-dialog  v-model="this.dialog">
    <v-icon
              icon="mdi-close"
              class="position-absolute right-0"
              color="white"
            ></v-icon>
    <CartaEditEstudiante :id="id_etd" />
  </v-dialog>
</template>

<script>
import newGoalService from "@/services/newGoalService";
import { getCurrentInstance } from "vue";
import CartaEditEstudiante from "../Cards/CartaEditEstudiante.vue";

export default {
  components: {
    CartaEditEstudiante,
  },
  data: () => ({
    id_etd : null,
    dialog: false,
    estudiantes: [], // Lista de estudiantes
    headers: [
    { title: "ID", key: "id_etd" }, // Columna para el estado
      { title: "Estado", key: "estado" }, // Columna para el estado
      { title: "Nombre", key: "nombre_etd" }, // Columna para el nombre
      { title: "Apellido", key: "apellido_etd" }, // Columna para el apellido
      { title: "Correo", key: "correo_etd" }, // Columna para el correo
      { title: "Actions", key: "actions", align: "end", sortable: false }, //columna para las acciones
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
    edita(id){
      this.id_etd = id
    console.log('hola')
    this.dialog=true
  },

    getcolor(estado) {
      if (estado == "Activo") {
        return "success";
      } else {
        return "error";
      }
    },
  },


  mounted() {
    this.obtenerEstudiantes();
  },
};
</script>
