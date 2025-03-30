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
    <v-form @submit.prevent="actualizarGasto">
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
              v-model="gasto.fecha.split('T')[0]"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-text-field
              variant="outlined"
              type="number"
              label="Monto"
              v-model="gasto.cantidad"
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
            ></v-textarea>
          </v-col>
        </v-row>
        <div class="d-flex justify-center">
          <v-btn type="submit">Guardar</v-btn>
        </div>
      </v-container>
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
  },

  data: () => ({
    alert: { show: false, message: "" },
    metodos_pago :[],
    tiposDeGastos: [],
    gasto: {
      id_gasto: null,
      metodo_pago: null,
      tipo_gasto: null,
      nombre: null,
      descripcion: null,
      fecha: "",
      cantidad: null,
    },
  }),
  methods: {
    async actualizarGasto(){
        try {
            const res = await newGoalService.putGasto(this.gasto)
            this.alert = {
          show: true,
          color: "success",
          message: "Gasto modificado corectamente",
        };
      } catch (error) {
        console.log(error);
        this.alert = {
          show: true,
          color: "warning",
          message: "Gasto no modificado",
        };
      }
    },
    async obtenerGasto(id) {
      id = this.id;
      try {
        const res = await newGoalService.getGastoById(id);
        const datosApi = res.data[0];
        this.gasto.id_gasto = datosApi.id_gasto;
        this.gasto.metodo_pago = datosApi.id_metodo_pago;
        this.gasto.tipo_gasto = datosApi.id_tipo_gasto;
        this.gasto.nombre = datosApi.nombre_gasto;
        this.gasto.descripcion = datosApi.descripcion_gasto;
        this.gasto.fecha = datosApi.fecha_gasto;
        this.gasto.cantidad = datosApi.cantidad_gasto;
        console.log();
      } catch (error) {
        console.log(error);
      }
    },
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
  },
  mounted() {
    this.obtenerGasto();
    this.leerMetodosdePago()
    this.leerTipoDeGasto()
  },
};
</script>
