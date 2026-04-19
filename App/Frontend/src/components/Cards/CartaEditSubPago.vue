<template>
  <v-card class="pa-4" style="max-height: 80vh; overflow-y: auto;">
    <!-- Botón X para cerrar -->
    <v-btn
      icon="mdi-close"
      variant="text"
      size="small"
      class="position-absolute right-0 ma-2"
      color="grey"
      @click="cerrar"
    ></v-btn>

    <v-dialog v-model="alert.show" width="auto" class="justify-center align-center">
      <v-alert
        v-model="alert.show"
        :color="alert.color"
        variant="elevated"
        width="400px"
        >{{ alert.message }}</v-alert
      >
    </v-dialog>

    <v-form ref="form" @submit.prevent="pagarCuota">
      <!-- Título -->
      <h3 class="text-h6 mb-4 text-center">
        Pagar Cuota
      </h3>

      <!-- Info del estudiante (solo lectura) -->
      <v-card color="grey-lighten-4" class="mb-4 pa-3" elevation="2">
        <div class="text-subtitle-2 text-grey-darken-2">Estudiante:</div>
        <div class="text-h6">{{ subpago?.nombre_etd }} {{ subpago?.apellido_etd }}</div>
        <div class="text-caption">Cédula: {{ subpago?.cedula_etd }}</div>
        <div class="text-caption mt-1">Cuota: {{ subpago?.descripcion_sub_pago }}</div>
        <v-divider class="my-2"></v-divider>
        <v-row dense>
          <v-col cols="6">
            <div class="text-caption text-grey">Monto Total:</div>
            <div class="text-subtitle-1 font-weight-bold text-success">
              ${{ subpago?.monto_total_pago }}
            </div>
          </v-col>
          <v-col cols="6">
            <div class="text-caption text-grey">Cancelado:</div>
            <div class="text-subtitle-1 font-weight-bold text-info">
              ${{ subpago?.monto_cancelado_pago }}
            </div>
          </v-col>
        </v-row>
        <div class="text-caption text-error mt-1">
          Saldo Pendiente: ${{ subpago?.saldo_pendiente }}
        </div>
        <div class="text-caption mt-1">
          Estado Actual: <v-chip size="x-small" :color="estadoColor">{{ subpago?.estado }}</v-chip>
        </div>
      </v-card>

      <!-- Formulario de pago -->
      <v-row>
        <v-col cols="12">
          <v-select
            v-model="pago.id_metodo_pago"
            :items="metodos_pago"
            item-value="id_metodo_pago"
            item-title="nombre_metodo_pago"
            label="Método de Pago"
            variant="outlined"
            :rules="globalRules"
          ></v-select>
        </v-col>
      </v-row>

      <v-row>
        <v-col cols="12">
          <v-text-field
            v-model="pago.fecha_pago"
            type="date"
            label="Fecha del Pago"
            variant="outlined"
            :rules="globalRules"
          ></v-text-field>
        </v-col>
      </v-row>

      <v-row>
        <v-col cols="12">
          <!-- Monto se calcula automáticamente en el backend -->
        </v-col>
      </v-row>

      <v-row>
        <v-col cols="12">
          <v-textarea
            v-model="pago.descripcion_sub_pago"
            label="Descripción / Referencia"
            variant="outlined"
            rows="2"
            no-resize
            hint="Referencias bancarias, notas adicionales, etc."
            persistent-hint
          ></v-textarea>
        </v-col>
      </v-row>

      <!-- Botón submit -->
      <div class="d-flex justify-center mt-2">
        <v-btn type="submit" color="success" block>
          <v-icon start>mdi-cash-check</v-icon>
          Confirmar Pago
        </v-btn>
      </div>
    </v-form>
  </v-card>
</template>

<script>
import newGoalService from "@/services/newGoalService";

export default {
  props: {
    id: {
      type: Number,
      required: true,
    },
    datos: {
      type: Object,
      default: null,
    },
  },
  data: () => ({
    alert: { show: false, message: "", color: "" },
    metodos_pago: [],
    subpago: null,
    loading: true,
    pago: {
      id_sub_pago: null,
      id_metodo_pago: null,
      fecha_pago: "",
      monto: null,
      descripcion_sub_pago: "",
    },
    globalRules: [(v) => !!v || "Este campo es requerido"],
    fechaRules: [
      (v) => !!v || "La fecha es requerida",
      (v) => {
        const fecha = new Date(v);
        const hoy = new Date();
        return fecha <= hoy || "La fecha no puede ser futura";
      },
    ],
    montoRules: [
      (v) => !!v || "El monto es requerido",
      (v) => Number(v) > 0 || "Debe ser mayor a 0",
      (v) => {
        const saldo = this.subpago?.saldo_pendiente || 999999;
        return Number(v) <= Number(saldo) || `No puede exceder el saldo pendiente ($${saldo})`;
      },
    ],
  }),

  computed: {
    estadoColor() {
      if (!this.subpago?.estado) return "grey";
      const estado = this.subpago.estado.toUpperCase();
      if (estado.includes("PENDIENTE")) return "warning";
      if (estado.includes("COMPLETADO")) return "success";
      if (estado.includes("CANCELADO")) return "error";
      return "grey";
    },
  },

  methods: {
    cerrar() {
      this.$emit("cerrar");
    },
    async obtenerSubpago() {
      // Si ya nos pasaron los datos directamente, usarlos
      if (this.datos) {
        this.subpago = this.datos;
        this.pago.id_sub_pago = this.id;
        
        // Fecha por defecto hoy
        const hoy = new Date();
        this.pago.fecha_pago = hoy.toISOString().split("T")[0];
        
        this.loading = false;
        return;
      }
      
      // Sinon, intentar con getSubPagosById que trae todos los datos
      try {
        const res = await newGoalService.getSubPagosById(this.id);
        console.log("Datos del subpago:", res.data);
        const lista = res.data.sub_pagos || res.data;
        this.subpago = Array.isArray(lista) 
          ? lista.find(s => s.id_sub_pago === this.id) 
          : lista;
        this.pago.id_sub_pago = this.id;
        
        // Fecha por defecto hoy
        const hoy = new Date();
        this.pago.fecha_pago = hoy.toISOString().split("T")[0];
        
        this.loading = false;
      } catch (error) {
        console.error(error);
        this.alert = {
          show: true,
          color: "error",
          message: "Error al cargar los datos de la cuota",
        };
      }
    },

    async obtenerMetodosPago() {
      try {
        const res = await newGoalService.getMetodoDePago();
        this.metodos_pago = res.data.datos;
      } catch (error) {
        console.error(error);
      }
    },

    async pagarCuota() {
      try {
        // Validación: método y fecha son obligatorios
        if (!this.pago.id_metodo_pago || !this.pago.fecha_pago) {
          this.alert = {
            show: true,
            color: "warning",
            message: "Método de pago y fecha son requeridos",
          };
          return;
        }

        const datosPago = {
          id_sub_pago: this.pago.id_sub_pago,
          id_metodo_pago: this.pago.id_metodo_pago,
          fecha_pago_real: this.pago.fecha_pago,
          descripcion_pago: this.pago.descripcion_sub_pago || ""
        };
        
        console.log("Enviando:", datosPago);
        const res = await newGoalService.putSubPagos(datosPago);
        console.log(res)
        this.alert = {
          show: true,
          color: "success",
          message: "Pago registrado exitosamente",
        };

        // Cerrar diálogo después de 1.5s y recargar
        setTimeout(() => {
          this.$emit("pagoExitoso");
          // Emitir evento global para que otras tablas también se actualicen
          window.dispatchEvent(new Event("pagoActualizado"));
        }, 1500);

      } catch (error) {
        console.error(error);
        this.alert = {
          show: true,
          color: "error",
          message: "Error al registrar el pago",
        };
      }
    },
  },

  mounted() {
    this.obtenerSubpago();
    this.obtenerMetodosPago();
  },
};
</script>

<style scoped>
</style>