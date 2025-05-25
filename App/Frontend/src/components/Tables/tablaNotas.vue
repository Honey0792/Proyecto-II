<template>
  <v-data-table
    :loading="loadingConfig"
    :search="search"
    :items="notas"
    :headers
  >
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
    <template v-slot:item.id_nota="{ item }"> </template>
    <template v-slot:item.actions="{ item }">
      <div class="d-flex ga-2 justify-center">
        <v-icon
          color="medium-emphasis"
          icon="mdi-pencil"
          size="small"
          @click="edita(item.id_nota)"
        ></v-icon>
        <v-icon
          color="medium-emphasis"
          icon="mdi-eye"
          size="small"
          @click="ver(item.id_nota)"
        ></v-icon>
        <v-icon
          color="medium-emphasis"
          icon="mdi-delete"
          size="small"
          @click="eliminar(item.id_nota)"
        ></v-icon>
      </div>
    </template>
    <template v-slot:footer.prepend>
      <div class="mx-3">
        <v-btn @click="reporteNotas">Generar Listado</v-btn>
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
    <CartaEditNota @actualizar_tabla="obtenerNotas" :id="id_nota" />
  </v-dialog>
  <v-dialog v-model="this.dialog_2">
    <v-icon
      icon="mdi-close"
      class="position-absolute right-0"
      color="white"
      @click="this.dialog_2 = false"
    ></v-icon>
    <CartaVerNota :id="id_nota" />
  </v-dialog>
  <v-dialog v-model="this.dialog_3" width="auto">
    <v-card
      max-width="400"
      prepend-icon="mdi-delete-alert"
      text="¿Estas Seguro/a de querer eliminar a esta nota?"
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
        <v-btn class="ms-auto" text="Ok" @click="eliminarNota"></v-btn>
      </template>
    </v-card>
  </v-dialog>
</template>

<script>
import newGoalService from "@/services/newGoalService";
import CartaEditNota from "../Cards/CartaEditNota.vue";
import CartaVerNota from "../Cards/CartaVerNota.vue";

export default {
  components: {
    CartaEditNota,
    CartaVerNota,
  },
  data: () => ({
    loadingConfig: true,
    search: null,
    dialog_1: false,
    dialog_2: false,
    dialog_3: false,
    id_nota: null,
    notas: [],
    headers: [
      { title: "Orden", align: "center", key: "id_nota" },
      { title: "Nombres", align: "center", key: "nombre_etd" },
      { title: "Apellidos", align: "center", key: "apellido_etd" },
      { title: "Cedula", align: "center", key: "cedula_etd" },
      { title: "Nivel", align: "center", key: "nombre_nivel" },
      // { title: "Grupo", align: "center", key: "nombre_nivel" },
      { title: "Periodo", align: "center", key: "nombre_periodo" },
      { title: "Notas", align: "center", key: "valor_nota" },
      { title: "Acciones", align: "center", key: "actions" },
    ],
  }),
  methods: {
    async obtenerNotas() {
      try {
        const res = await newGoalService.getNotas();
        this.notas = res.data;
        console.log(this.notas);
        this.loadingConfig = false
      } catch (error) {
        console.log(error);
      }
    },

    async eliminarNota() {
      try {
        const id = { id_nota: this.id_nota };
        const res = await newGoalService.deleteNota(id);
        console.log(res);
        this.obtenerNotas();
        this.dialog_3 = false;
      } catch (error) {
        console.log(error);
      }
    },

    async reporteNotas() {
      try {
        const response = await newGoalService.getReporteNotas();
        const url = window.URL.createObjectURL(new Blob([response.data]));
        const link = document.createElement("a");
        link.href = url;

        // Obtener el nombre del archivo desde las cabeceras (si el servidor lo envía)
        const contentDisposition = response.headers["content-disposition"];
        const fileName = contentDisposition
          ? contentDisposition.split("filename=")[1].replace(/"/g, "")
          : `Reporte_Notas_${new Date().toISOString()}.xlsx`; // Nombre por defecto si no hay header

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
      this.id_nota = id;
      console.log("hola");
      this.dialog_1 = true;
    },

    ver(id) {
      this.id_nota = id;
      console.log(id);
      this.dialog_2 = true;
    },
    eliminar(id) {
      this.id_nota = id;
      console.log("hola");
      this.dialog_3 = true;
      console.log(id);
    },
  },
  mounted() {
    this.obtenerNotas();
  },
};
</script>
