<template>
  <v-data-table :search="search" :headers="headers" :items="periodos">
    <template v-slot:top>
      <v-text-field
        v-model="search"
        placeholder="Buscar"
        prepend-inner-icon="mdi-magnify"
        clearable
        density="compact"
        single-line
      ></v-text-field>
    </template>
    <template v-slot:item.id_periodo="{ item }"></template>
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
    <template v-slot:footer.prepend>
      <div class="mx-3">
        <v-btn @click="reportePeriodos">Generar Listado</v-btn>
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
        <v-btn class="ms-auto" text="Ok" @click="eliminarPeriodo"></v-btn>
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
    search: null,
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
    async obtenerPeriodos() {
      try {
        const res = await newGoalService.getPeriodos();
        this.periodos = res.data;
        console.log(res);
      } catch (error) {
        console.log(error);
      }
    },
    async eliminarPeriodo() {
      const id = { id_periodo: this.id_periodo };
      try {
        const res = await newGoalService.deletePeriodo(id);
        this.dialog_3 = false;
        this.obtenerPeriodos();
      } catch (error) {
        console.log(error);
      }
    },

        async reportePeriodos() {
      try {
        const response = await newGoalService.getReportePeriodos();
        const url = window.URL.createObjectURL(new Blob([response.data]));
        const link = document.createElement("a");
        link.href = url;

        // Obtener el nombre del archivo desde las cabeceras (si el servidor lo envía)
        const contentDisposition = response.headers["content-disposition"];
        const fileName = contentDisposition
          ? contentDisposition.split("filename=")[1].replace(/"/g, "")
          : `Reporte_Periodos_${new Date().toISOString()}.xlsx`; // Nombre por defecto si no hay header

        link.setAttribute("download", fileName);
        document.body.appendChild(link);
        link.click();

        // Limpiar recursos
        document.body.removeChild(link);
        window.URL.revokeObjectURL(url);
      } catch (error) {
        console.error("Error:", error.response?.data || error.message);
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
    this.obtenerPeriodos();
  },
};
</script>
