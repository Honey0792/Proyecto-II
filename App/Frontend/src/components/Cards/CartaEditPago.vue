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
    <v-form @submit.prevent="actualizarPago">
      <h3 class="pa-3">Datos del Pago</h3>
      <v-divider></v-divider>
      <v-container>
        <v-row>
          <v-col>
            <v-autocomplete
              :items="estudiantes"
              item-value="id_etd"
              :item-title="fullName"
              variant="outlined"
              label="Estudiante"
              v-model="pago.id_estudiante"
            ></v-autocomplete>
          </v-col>
        </v-row>
      </v-container>
      <v-container class="">
        <v-row>
          <v-col>
            <v-text-field
              variant="outlined"
              type="date"
              label="Fecha del Pago"
              v-model="pago.fecha_pago.split('T')[0]"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-select
              :items="metodos_pago"
              item-value="id_metodo_pago"
              item-title="nombre_metodo_pago"
              label="Metodo de Pago"
              variant="outlined"
              v-model="pago.metodo_pago"
            ></v-select>
          </v-col>
        </v-row>
      </v-container>
      <v-container>
        <v-row>
          <v-col>
            <v-text-field
              type="number"
              variant="outlined"
              label="Monto Total"
              v-model="pago.monto_total"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-text-field
              variant="outlined"
              type="number"
              label="Monto Cancelado"
              v-model="pago.monto_cancelado"
            ></v-text-field>
          </v-col>
        </v-row>
        <div class="d-flex justify-center">
          <v-btn type="submit">Guardar</v-btn>
        </div>
      </v-container>
      <!-- <v-container>
            <v-row>
        </v-row>
        </v-container> -->
      <!-- <v-container>
            <v-row>
                <v-col>
            <v-textarea
              variant="outlined"
              label="Descripcion"
              rows="4"
              no-resize
            ></v-textarea>
          </v-col>
            </v-row>
        </v-container> -->
    </v-form>
  </v-card>
</template>

<script>
import newGoalService from "@/services/newGoalService";

export default {
  components: {},
  props: {
    id: {
      type: Number,
      required: true,
    },
  },
  data: () => ({
    alert: { show: false, message: "" },
    metodos_pago: [],
    estudiantes: [], // Lista de estudiantes
    pago: {
      id_pago: null,
      id_estudiante: null,
      metodo_pago: null,
      fecha_pago: "",
      monto_total: null,
      monto_cancelado: null,
    },
  }),
  methods: {
    async actualizarPago() {
      try {
        const res = await newGoalService.putPago(this.pago)
        this.alert = {
          show: true,
          color: "success",
          message: "Pago modificado corectamente",
        };
      } catch (error) {
        console.log(error);
        this.alert = {
          show: true,
          color: "warning",
          message: "Pago no modificado",
        };
      }
    },
    fullName(item) {
      return `${item.nombre_etd} ${item.apellido_etd}`;
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
    async obtenerPagoById() {
      const id = this.id;
      try {
        const res = await newGoalService.getPagoById(id);
        const datosApi = res.data[0];

        this.pago.id_pago = datosApi.id_pago;
        this.pago.id_estudiante = datosApi.id_etd;
        this.pago.metodo_pago = datosApi.id_metodo_pago;
        this.pago.fecha_pago = datosApi.fecha_pago;
        this.pago.monto_total = datosApi.monto_total_pago;
        this.pago.monto_cancelado = datosApi.monto_cancelado_pago;

        console.log(this.pago);
      } catch (error) {
        console.log(error);
      }
    },
    async obtenerEstudiantes() {
      try {
        const res = await newGoalService.getEstudiante();
        this.estudiantes = res.data;
        console.log(this.estudiantes);
      } catch (error) {
        console.log(error);
      }
    },
  },
  computed: {},
  mounted() {
    this.obtenerEstudiantes();
    this.obtenerPagoById();
    this.leerMetodosdePago();
  },
};
</script>
