<template>
  <v-data-table :headers="headers" :items="cuotas" :loading="loading">
    <!-- Estado con color -->
    <template v-slot:item.estado="{ item }">
      <v-chip size="small" :color="getEstadoColor(item.estado)">
        {{ item.estado }}
      </v-chip>
    </template>

    <!-- Formato fecha -->
    <template v-slot:item.fecha_pago="{ item }">
      {{ formatFecha(item.fecha_pago) }}
    </template>

    <!-- Formato -->
    <template v-slot:item.monto="{ item }">
      ${{ Number(item.monto).toFixed(2) }}
    </template>
    <template v-slot:item.tasa_bolivares="{ item }">
      {{ Number(item.tasa_bolivares).toFixed(2) }}
    </template>
    <template v-slot:item.monto_total_pago="{ item }">
      ${{ Number(item.monto_total_pago).toFixed(2) }}
    </template>
    <template v-slot:item.monto_cancelado_pago="{ item }">
      ${{ Number(item.monto_cancelado_pago).toFixed(2) }}
    </template>
    <template v-slot:item.saldo_pendiente="{ item }">
      ${{ Number(item.saldo_pendiente).toFixed(2) }}
    </template>
    <!-- Botones editar y eliminar -->
    <template v-slot:item.actions="{ item }">
      <v-icon
        color="success"
        icon="mdi-cash-edit"
        size="small"
        class="mr-2"
        @click="edita(item)"
      ></v-icon>
      <v-icon
        color="error"
        icon="mdi-delete"
        size="small"
        @click="eliminar(item)"
      ></v-icon>
    </template>
  </v-data-table>

  <v-dialog
    v-model="dialog_1"
    persistent
    :overlay="false"
    max-width="500px"
    transition="dialog-transition"
    scrollable
  >
    <v-card
      v-if="dialog_1"
      class="pa-2"
      style="max-height: 90vh; overflow-y: auto"
    >
      <CartaEditSubPago
        :id="id_sub_pago"
        :datos="cuota_seleccionada"
        @pago-exitoso="obtenerCuotasPorId"
        @cerrar="cerrarDialog"
      />
    </v-card>
  </v-dialog>

  <!-- Dialog confirmar eliminar -->
  <v-dialog v-model="dialog_3" width="auto">
    <v-card
      max-width="400"
      prepend-icon="mdi-delete-alert"
      title="Oprimiste eliminar"
      color="warning"
    >
      <v-card-text>
        ¿Estas seguro de querer eliminar la cuota "{{ descripcionEliminar }}"?
      </v-card-text>
      <template v-slot:actions>
        <v-spacer></v-spacer>
        <v-btn
          class="ms-auto"
          text="Cancelar"
          @click="dialog_3 = false"
        ></v-btn>
        <v-btn class="ms-auto" text="Ok" @click="eliminarCuotaConfirmada"></v-btn>
      </template>
    </v-card>
  </v-dialog>
</template>

<script>
import newGoalService from "@/services/newGoalService";
import CartaEditSubPago from "../Cards/CartaEditSubPago.vue";

export default {
  components: { CartaEditSubPago },
  props: {
    id: {
      type: Number,
      required: true,
    },
  },
  data: () => ({
    headers: [
      { title: "ID", key: "id_sub_pago", align: "start" },
      { title: "Estudiante", key: "nombre_etd", align: "start" },
      { title: "Apellido", key: "apellido_etd", align: "start" },
      { title: "Cédula", key: "cedula_etd", align: "center" },

      { title: "Cuota", key: "descripcion_sub_pago", align: "start" },
      { title: "Estado", key: "estado", align: "center" },
      { title: "Fecha Pago", key: "fecha_pago", align: "center" },

      { title: "Método", key: "nombre_metodo_pago", align: "center" },

      { title: "Monto ($)", key: "monto", align: "end" },
      { title: "Tasa Bs", key: "tasa_bolivares", align: "end" },

      { title: "Total Pago ($)", key: "monto_total_pago", align: "end" },
      { title: "Cancelado ($)", key: "monto_cancelado_pago", align: "end" },
      { title: "Saldo ($)", key: "saldo_pendiente", align: "end" },
      { title: "Modificar/Pagar", key: "actions", align: "center" },
    ],
    dialog_1: false,
    dialog_3: false,
    id_sub_pago: null,
    cuota_seleccionada: null,
    nombreEliminar: "",
    apellidoEliminar: "",
    descripcionEliminar: "",
    id_sub_pago_eliminar: null,
    cuotas: [],
    loading: true,
  }),

  methods: {
    formatFecha(fecha) {
      if (!fecha) return "-";
      // Si viene con formato ISO, extraer solo la fecha
      return fecha.split("T")[0];
    },
    getEstadoColor(estado) {
      if (!estado) return "grey";
      const est = estado.toUpperCase();
      if (est.includes("PENDIENTE")) return "warning";
      if (est.includes("COMPLETADO")) return "success";
      if (est.includes("CANCELADO")) return "error";
      return "grey";
    },
    async obtenerCuotasPorId() {
      try {
        const res = await newGoalService.getSubPagosById(this.id);
        console.log(res);
        // El endpoint puede devolver directamente o en res.data.sub_pagos
        this.cuotas = res.data.sub_pagos || res.data;
        this.loading = false;
      } catch (error) {
        console.log(error);
      }
    },
    edita(item) {
      this.id_sub_pago = item.id_sub_pago;
      this.cuota_seleccionada = item;
      console.log("Cuota seleccionada:", item);
      this.dialog_1 = true;
    },
    eliminar(item) {
      this.id_sub_pago_eliminar = item.id_sub_pago;
      this.descripcionEliminar = item.descripcion_sub_pago;
      this.dialog_3 = true;
    },
    async eliminarCuotaConfirmada() {
      try {
        await newGoalService.deleteSubPagos(this.id_sub_pago_eliminar);
        this.dialog_3 = false;
        this.obtenerCuotasPorId();
        // Emitir evento global para actualizar otras tablas
        window.dispatchEvent(new Event("pagoActualizado"));
      } catch (error) {
        console.error(error);
        alert("Error al eliminar la cuota");
      }
    },
    cerrarDialog() {
      this.dialog_1 = false;
      this.id_sub_pago = null;
    },
    recargar() {
      this.obtenerCuotasPorId();
    },
  },

  mounted() {
    this.obtenerCuotasPorId();
    // Escuchar evento global de pago actualizado
    window.addEventListener("pagoActualizado", () => {
      this.obtenerCuotasPorId();
    });
  },
};
</script>
