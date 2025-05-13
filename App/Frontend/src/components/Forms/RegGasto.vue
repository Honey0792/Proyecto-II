<template>
  <v-dialog
    v-model="alert.show"
    width="auto"
    class="justify-center align-center"
  >
    <v-alert
      v-model="alert.show"
      :color="alert.color"
      variant="elevated"
      prominent
      closable
      width="400px"
      >{{ alert.message }}</v-alert
    >
  </v-dialog>
  <v-card class="ma-7">
    <v-form ref="form" @submit.prevent="registrarGasto">
      <h3 class="pa-3">Datos del Gasto</h3>
      <v-divider></v-divider>
      <v-container class="">
        <v-row>
          <v-col>
            <v-select
              :items="tiposDeGastos"
              item-value="id_tipo_gasto"
              item-title="nombre_tipo_gasto"
              label="Tipo de Gasto"
              variant="outlined"
              v-model="gasto.tipo_gasto"
              :rules="globalRules"
            ></v-select>
          </v-col>
          <v-col>
            <v-select
              :items="metodos_pago"
              item-value="id_metodo_pago"
              item-title="nombre_metodo_pago"
              label="Metodo de Pago"
              variant="outlined"
              v-model="gasto.metodo_pago"
              :rules="globalRules"
            ></v-select>
          </v-col>
        </v-row>
      </v-container>
      <v-container>
        <v-row>
          <v-col>
            <v-text-field
              variant="outlined"
              type="date"
              label="Fecha del Gasto"
              v-model="gasto.fecha"
              :rules="fechaRules"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-text-field
              variant="outlined"
              type="number"
              label="Monto"
              v-model="gasto.cantidad"
              :rules="montoRules"
            ></v-text-field>
          </v-col>
        </v-row>
      </v-container>
      <v-container>
        <v-row>
          <v-col>
            <v-text-field
              variant="outlined"
              label="Nombre del Gasto"
              v-model="gasto.nombre"
              :rules="globalRules"
            ></v-text-field>
          </v-col>
        </v-row>
      </v-container>
      <v-container>
        <v-row>
          <v-col>
            <v-textarea
              variant="outlined"
              label="Descripcion"
              v-model="gasto.descripcion"
              rows="4"
              no-resize
              :rules="globalRules"
            ></v-textarea>
          </v-col>
        </v-row>
        <div class="d-flex justify-center">
          <v-btn type="submit">Registrar</v-btn>
        </div>
      </v-container>
    </v-form>
    <v-divider></v-divider>
    <tablaGastos ref="hijo" />
  </v-card>
</template>

<script>
import newGoalService from "@/services/newGoalService";
import tablaGastos from "../Tables/tablaGastos.vue";
export default {
  components: {
    tablaGastos,
  },
  data: () => ({
    alert: { show: false, message: "" },
    metodos_pago: [],
    tiposDeGastos: [],
    gasto: {
      metodo_pago: null,
      tipo_gasto: null,
      nombre: null,
      descripcion: null,
      fecha: null,
      cantidad: null,
    },
    globalRules: [(value) => !!value || "Requerido"],
    montoRules: [
      (value) => !!value || "Requerido",
      (v) => Number(v) > 0 || "Debe ser mayor a 0",
    ],
    fechaRules: [
      (v) => !!v || "La fecha es requerida",
      (v) => {
        const fechaSeleccionada = new Date(v);
        const fechaActual = new Date();
        return (
          fechaSeleccionada <= fechaActual || "La fecha no puede ser futura"
        );
      },
      (v) => {
        const fechaMinima = new Date();
        fechaMinima.setFullYear(fechaMinima.getFullYear() - 100);
        return (
          new Date(v) >= fechaMinima ||
          "Fecha demasiado antigua (máximo 100 años)"
        );
      },
    ],
  }),
  methods: {
    async leerTipoDeGasto() {
      try {
        const res = await newGoalService.getTipoDeGasto();
        console.log(res);
        this.tiposDeGastos = res.data.datos;
      } catch (error) {
        console.log(error);
      }
    },
    async leerMetodosdePago() {
      try {
        const res = await newGoalService.getMetodoDePago();
        this.metodos_pago = res.data.datos;
        console.log(this.metodos_pago);
      } catch (error) {
        console.log(error);
      }
    },
    async registrarGasto() {
      const { valid } = await this.$refs.form.validate();

      if (!valid) {
        this.alert = {
          show: true,
          color: "warning",
          message: "Complete todos los campos requeridos",
        };
        return;
      }
      try {
        const res = await newGoalService.postGastos(this.gasto);
        console.log(res);
        this.alert = {
          show: true,
          color: "success",
          message: "gasto registrado corectamente",
        };
        this.$refs.hijo.obtenerGastos();
      } catch (error) {
        console.log(error);
        this.alert = {
          show: true,
          color: "warning",
          message: "gasto no registrado",
        };
      }
    },
  },
  mounted() {
    this.leerMetodosdePago();
    this.leerTipoDeGasto();
  },
};
</script>
