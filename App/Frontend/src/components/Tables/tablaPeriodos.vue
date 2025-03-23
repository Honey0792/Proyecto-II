<template>
  <v-data-table :headers="headers" :items="periodos">
    <template v-slot:item.fecha_ini_periodo="{ item }">
      {{ item.fecha_ini_periodo.split("T")[0] }}
    </template>
    <template v-slot:item.fecha_fin_periodo="{ item }">
      {{ item.fecha_fin_periodo.split("T")[0] }}
    </template>
    <template v-slot:item.actions="{ item }">
      <div class="d-flex ga-2 justify-end">
        <v-icon
          color="medium-emphasis"
          icon="mdi-pencil"
          size="small"
          @click="edita(item.id_periodo)"
        ></v-icon>
        <v-icon
          color="medium-emphasis"
          icon="mdi-eye"
          size="small"
          @click="ver(item.id_periodo)"
        ></v-icon>
        <v-icon
          color="medium-emphasis"
          icon="mdi-delete"
          size="small"
          @click="eliminar(item.id_periodo)"
        ></v-icon>
      </div>
    </template>
  </v-data-table>
  <v-dialog v-model="this.dialog_1">
    <v-icon
      icon="mdi-close"
      class="position-absolute right-0"
      color="white"
      @click="this.dialog_1 = false"
    ></v-icon>
    <div class="d-flex justify-center">
      <CartaEditPeriodo :id="id_periodo" />
    </div>
  </v-dialog>
  <v-dialog v-model="this.dialog_2">
    <v-icon
      icon="mdi-close"
      class="position-absolute right-0"
      color="white"
      @click="this.dialog_2 = false"
    ></v-icon>
    <div class="d-flex justify-center">
      <CartaVerPeriodo :id="id_periodo" />
    </div>
  </v-dialog>
  <v-dialog v-model="this.dialog_3" width="auto">
    <v-card
      max-width="400"
      prepend-icon="mdi-delete-alert"
      text="¿Estas Seguro/a de querer eliminar a este estdiante?"
      title="Oprimiste eliminar"
      color="warning"
    >
      <template v-slot:actions>
        <v-spacer></v-spacer>
        <v-btn
          class="ms-auto"
          text="Cancelar"
          @click="this.dialog_3 = false"
        ></v-btn>
        <v-btn class="ms-auto" text="Ok" @click=""></v-btn>
      </template>
    </v-card>
  </v-dialog>
</template>

<script>
import newGoalService from "@/services/newGoalService";
import CartaEditPeriodo from "../Cards/CartaEditPeriodo.vue";
import CartaVerPeriodo from "../Cards/CartaVerPeriodo.vue";

export default {
  components: {
    CartaEditPeriodo,
    CartaVerPeriodo,
  },
  data: () => ({
    dialog_1: false,
    dialog_2: false,
    dialog_3: false,
    id_periodo: null,
    periodos: [],
    headers: [
      { title: "ID", align: "start", key: "id_periodo" },
      { title: "Nombre", align: "start", key: "nombre_periodo" },
      { title: "Fecha Inicio", align: "end", key: "fecha_ini_periodo" },
      { title: "Fecha de Culminacion", align: "end", key: "fecha_fin_periodo" },
      { title: "Año", align: "end", key: "year_academico" },
      { title: "Estado", align: "end", key: "nombre_estado" },
      { title: "Acciones", align: "end", key: "actions" },
    ],
  }),

  methods: {
    async obtenerEstados() {
      try {
        const res = await newGoalService.getPeriodos();
        this.periodos = res.data;
        console.log(res);
      } catch (error) {
        console.log(error);
      }
    },
    edita(id) {
      this.id_periodo = id;
      console.log("hola");
      this.dialog_1 = true;
    },

    ver(id) {
      this.id_periodo = id;
      console.log("hola");
      this.dialog_2 = true;
    },
    eliminar(id) {
      this.id_periodo = id;
      console.log("hola");
      this.dialog_3 = true;
      console.log(id);
    },
  },
  mounted() {
    this.obtenerEstados();
  },
};
</script>
