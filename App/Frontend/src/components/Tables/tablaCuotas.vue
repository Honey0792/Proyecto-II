<template>
  <v-data-table :headers="headers" :items="cuotas" :loading="loading">
    <template v-slot:item.actions="{ item }">
      <v-icon
        color="medium-emphasis"
        icon="mdi-cash-edit"
        size="large"
        @click="edita(item.id_sub_pago)"
      ></v-icon>
    </template>
  </v-data-table>

  <v-dialog
    v-model="dialog_1"
    persistent
    :overlay="false"
    max-width="500px"
    transition="dialog-transition"
  >
    <v-icon
      icon="mdi-close"
      class="position-absolute right-0"
      color="white"
      @click="this.dialog_1 = false"
    ></v-icon>
    <CartaEditSubPago :id="id_sub_pago" />
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
    id_sub_pago: null,
    cuotas: [],
    loading: true,
  }),

  methods: {
    async obtenerCuotasPorId() {
      try {
        const res = await newGoalService.getSubPagosById(this.id);
        console.log(res);
        this.cuotas = res.data.sub_pagos;
        this.loading = false;
      } catch (error) {
        console.log(error);
      }
    },
    edita(id) {
      this.id_sub_pago = id;
      console.log(id);
      this.dialog_1 = true;
    },
  },

  mounted() {
    this.obtenerCuotasPorId();
  },
};
</script>
