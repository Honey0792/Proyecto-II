<template>
  <v-data-table
    :loading="loadingConfig"
    :items="pagos"
    :headers
    :items-per-page-options="itemsPerPage"
    v-model:items-per-page="paginacion.items"
    v-model:page="paginacion.pagina"
    :search="search"
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
    <template v-slot:item.fecha_pago="{ item }">
      {{ item.fecha_pago.split("T")[0] }}
    </template>

    <template v-slot:item.monto_cancelado_pago="{ item }">
      <span
        :class="{
          'bg-success': item.monto_cancelado_pago === item.monto_total_pago,
          'bg-warning': item.monto_cancelado_pago !== item.monto_total_pago,
        }"
        class="pa-2 rounded"
      >
        {{ item.monto_cancelado_pago }}
      </span>
    </template>
    <template v-slot:item.id_pago="{ item }"> </template>
    <template v-slot:item.actions="{ item }">
      <div class="d-flex ga-2 justify-end">
        <v-icon
          color="medium-emphasis"
          icon="mdi-pencil"
          size="small"
          @click="edita(item.id_pago)"
        ></v-icon>
        <v-icon
          color="medium-emphasis"
          icon="mdi-eye"
          size="small"
          @click="ver(item.id_pago)"
        ></v-icon>
        <v-icon
          color="medium-emphasis"
          icon="mdi-delete"
          size="small"
          @click="eliminar(item.id_pago)"
        ></v-icon>
      </div>
    </template>
    <!-- <template v-slot:bottom>
      <div class="text-center pt-2">
        <v-pagination
          length="5"
        ></v-pagination>
      </div>
    </template> -->
    <template v-slot:footer.prepend>
      <div class="mx-3">
        <v-btn @click="reportePagos">Generar Listado</v-btn>
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
    <CartaEditPago @actualizar_tabla="obtenerPagos" :id="id_pago" />
  </v-dialog>
  <v-dialog v-model="this.dialog_2">
    <v-icon
      icon="mdi-close"
      class="position-absolute right-0"
      color="white"
      @click="this.dialog_2 = false"
    ></v-icon>
    <CartaVerPago :id="id_pago" />
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
        <v-btn class="ms-auto" text="Ok" @click="eliminarPago"></v-btn>
      </template>
    </v-card>
  </v-dialog>
</template>

<script>
import newGoalService from "@/services/newGoalService";
import { ref } from "vue";
import CartaVerPago from "../Cards/CartaVerPago.vue";
import CartaEditPago from "../Cards/CartaEditPago.vue";

export default {
  components: {
    CartaVerPago,
    CartaEditPago,
  },
  data: () => ({
    loadingConfig: true,
    search: null,
    dialog_1: false,
    dialog_2: false,
    dialog_3: false,
    paginacion: {
      items: 10,
      pagina: 1,
    },
    itemsPerPage: [
      { value: 10, title: "10" },
      { value: 25, title: "25" },
      { value: 50, title: "50" },
      { value: 100, title: "100" },
    ],
    headers: [
      { title: "Orden", align: "start", key: "id_pago" },
      { title: "Nombre", align: "start", key: "nombre_etd" },
      { title: "Apellido", align: "start", key: "apellido_etd" },
      { title: "Fecha", align: "end", key: "fecha_pago" },
      { title: "Metodo de Pago", align: "end", key: "nombre_metodo_pago" },
      { title: "Monto Cancelado", align: "end", key: "monto_cancelado_pago" },
      { title: "Monto Total", align: "end", key: "monto_total_pago" },
      { title: "Acciones", align: "end", key: "actions" },
    ],
    id_pago: null,
    pago: {
      id_estudiante: null,
      metodo_pago: null,
      fecha_pago: "",
      monto_total: null,
      monto_cancelado: null,
    },
    pagos: [],
  }),
  methods: {
    async obtenerPagos() {
      try {
        const res = await newGoalService.getPagos();
        this.pagos = res.data;
        console.log(res);
        this.loadingConfig = false;
      } catch (error) {
        console.log(error);
      }
    },
    async eliminarPago() {
      const id = { id_pago: this.id_pago };
      try {
        const res = await newGoalService.deletePago(id);
        this.dialog_3 = false;
        this.obtenerPagos();
      } catch (error) {
        console.log(error);
      }
    },

    async reportePagos() {
      try {
        const response = await newGoalService.getReportePagos();
        const url = window.URL.createObjectURL(new Blob([response.data]));
        const link = document.createElement("a");
        link.href = url;

        // Obtener el nombre del archivo desde las cabeceras (si el servidor lo envía)
        const contentDisposition = response.headers["content-disposition"];
        const fileName = contentDisposition
          ? contentDisposition.split("filename=")[1].replace(/"/g, "")
          : `Reporte_Pagos_${new Date().toISOString()}.xlsx`; // Nombre por defecto si no hay header

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
      this.id_pago = id;
      console.log("hola");
      this.dialog_1 = true;
    },

    ver(id) {
      this.id_pago = id;
      console.log(id);
      this.dialog_2 = true;
    },
    eliminar(id) {
      this.id_pago = id;
      console.log("hola");
      this.dialog_3 = true;
      console.log(id);
    },
  },
  mounted() {
    this.obtenerPagos();
  },
};
</script>
