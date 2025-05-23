<template>
  <v-data-table
    :loading="loadingConfig"
    :search="search"
    :items="gastos"
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
    <template v-slot:item.id_gasto="{ item }"></template>
    <template v-slot:item.fecha_gasto="{ item }">
      {{ item.fecha_gasto.split("T")[0] }}
    </template>
    <template v-slot:item.actions="{ item }">
      <div class="d-flex ga-2 justify-end">
        <v-icon
          color="medium-emphasis"
          icon="mdi-pencil"
          size="small"
          @click="edita(item.id_gasto)"
        ></v-icon>
        <v-icon
          color="medium-emphasis"
          icon="mdi-eye"
          size="small"
          @click="ver(item.id_gasto)"
        ></v-icon>
        <v-icon
          color="medium-emphasis"
          icon="mdi-delete"
          size="small"
          @click="eliminar(item.id_gasto)"
        ></v-icon>
      </div>
    </template>
    <template v-slot:footer.prepend>
      <div class="mx-3">
        <v-btn @click="reporteGastos">Generar Listado</v-btn>
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
    <CartaEditGasto @actualizar_tabla="obtenerGastos" :id="id_gasto" />
  </v-dialog>
  <v-dialog v-model="this.dialog_2">
    <v-icon
      icon="mdi-close"
      class="position-absolute right-0"
      color="white"
      @click="this.dialog_2 = false"
    ></v-icon>
    <CartaVerGasto :id="id_gasto" />
  </v-dialog>
  <v-dialog v-model="this.dialog_3" width="auto">
    <v-card
      max-width="400"
      prepend-icon="mdi-delete-alert"
      text="¿Estas Seguro/a de querer eliminar a este gasto?"
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
        <v-btn class="ms-auto" text="Ok" @click="eliminarGasto"></v-btn>
      </template>
    </v-card>
  </v-dialog>
</template>

<script>
import newGoalService from "@/services/newGoalService";
import CartaEditGasto from "../Cards/CartaEditGasto.vue";
import CartaVerGasto from "../Cards/CartaVerGasto.vue";

export default {
  components: { CartaEditGasto, CartaVerGasto },
  data: () => ({
    loadingConfig: true,
    search: null,
    dialog_1: false,
    dialog_2: false,
    dialog_3: false,
    id_gasto: null,
    gastos: [],
    headers: [
      { title: "Orden", align: "start", key: "id_gasto" },
      { title: "Nombre", align: "start", key: "nombre_gasto" },
      { title: "Tipo", align: "end", key: "nombre_tipo_gasto" },
      { title: "Monto", align: "end", key: "cantidad_gasto" },
      { title: "Metodo de pago", align: "end", key: "nombre_metodo_pago" },
      { title: "Fecha", align: "end", key: "fecha_gasto" },
      { title: "Acciones", align: "end", key: "actions" },
    ],
  }),
  methods: {
    async obtenerGastos() {
      try {
        const res = await newGoalService.getGastos();
        console.log(res);
        this.gastos = res.data;
        this.loadingConfig = false

      } catch (error) {
        console.log(error);
      }
    },

    async eliminarGasto() {
      const id = { id_gasto: this.id_gasto };
      try {
        const res = await newGoalService.deleteGasto(id);
        this.dialog_3 = false;
        this.obtenerGastos();
      } catch (error) {
        console.log(error);
      }
    },

    edita(id) {
      this.id_gasto = id;
      console.log(id);
      console.log("hola");
      this.dialog_1 = true;
    },

    ver(id) {
      this.id_gasto = id;
      console.log(id);
      this.dialog_2 = true;
    },
    eliminar(id) {
      this.id_gasto = id;
      console.log("hola");
      this.dialog_3 = true;
      console.log(id);
    },
    async reporteGastos() {
      try {
        const response = await newGoalService.getReporteGastos();
        const url = window.URL.createObjectURL(new Blob([response.data]));
        const link = document.createElement("a");
        link.href = url;

        // Obtener el nombre del archivo desde las cabeceras (si el servidor lo envía)
        const contentDisposition = response.headers["content-disposition"];
        const fileName = contentDisposition
          ? contentDisposition.split("filename=")[1].replace(/"/g, "")
          : `Reporte_Gastos_${new Date().toISOString()}.xlsx`; // Nombre por defecto si no hay header

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
  },

  mounted() {
    this.obtenerGastos();
  },
};
</script>
