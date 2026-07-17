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

  <v-dialog
    v-model="dialog_tasa"
    class="justify-center align-center"
    max-width="500px"
    transition="dialog-transition"
  >
    <CartaTasa @actualizarTasa="obtenerTasa" />
  </v-dialog>
  <v-card class="ma-8">
    <v-form ref="form" @submit.prevent="registrarPago">
      <h3 class="pa-3">Datos del Pago</h3>
      <v-divider></v-divider>
      <v-container>
        <v-row>
          <v-col>
            <v-btn @click="openDialogTasa" class="mt-8" color=""
              >Registrar Tasa Cambiaria</v-btn
            >
          </v-col>
          <v-col>
            <v-card
              color="teal-darken-2"
              class="d-flex flex-column align-center justify-center pa-4 text-white"
              elevation="6"
            >
              <h2 class="font-weight-bold mb-1">
                {{ tasa?.tasaBolivares }} BS
              </h2>

              <span class="text-caption">
                {{ tasa?.fechaTasa }}
              </span>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
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
              :rules="globalRules"
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
              v-model="pago.fecha_pago"
              :rules="fechaRules"
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
              :rules="globalRules"
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
              :rules="montoTotalRules"
              persistent-hint
              hint="El monto debe ingresarse en USD o su equivalente en EUR"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-text-field
              variant="outlined"
              type="number"
              label="Monto Cancelado"
              v-model="pago.monto_cancelado"
              :rules="montoCanceladoRules"
            ></v-text-field>
          </v-col>
          <v-container>
            <v-row>
              <v-col>
                <v-textarea
                  hint="Anotar referencias bancarias, pagos moviles, pequeñas descripciones de los pagos, etc."
                  variant="outlined"
                  label="Descripcion"
                  rows="4"
                  no-resize
                  :rules="globalRules"
                  v-model="pago.descripcion_pago"
                ></v-textarea>
              </v-col>
            </v-row>
          </v-container>
        </v-row>
        <div class="d-flex justify-center">
          <v-btn type="submit">Registrar</v-btn>
        </div>
      </v-container>
      <!-- <v-container>
            <v-row>
        </v-row>
        </v-container> -->
    </v-form>
    <v-divider></v-divider>
    <tablaPagos ref="hijo" />
  </v-card>
</template>

<script>
import newGoalService from "@/services/newGoalService";
import tablaPagos from "../Tables/tablaPagos.vue";
import CartaTasa from "../Cards/CartaTasa.vue";

export default {
  components: { tablaPagos, CartaTasa },
  data: () => ({
    alert: { show: false, message: "" },
    dialog_tasa: false,
    metodos_pago: [],
    estudiantes: [], // Lista de estudiantes
    tasa: {
      tasaBolivares: null,
      fechaTasa: null,
    },
    pago: {
      id_estudiante: null,
      metodo_pago: null,
      fecha_pago: "",
      monto_total: null,
      monto_cancelado: null,
      descripcion_pago: null,
    },
    globalRules: [(value) => !!value || "Requerido"],
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
    async registrarPago() {
      try {
        const { valid } = await this.$refs.form.validate();

        if (!valid) {
          this.alert = {
            show: true,
            color: "warning",
            message: "Complete todos los campos requeridos",
          };
          return;
        }
        console.log(this.pago);
        const res = await newGoalService.postPagos(this.pago);
        this.$refs.hijo.obtenerPagos();
        this.alert = {
          show: true,
          color: "success",
          message: "pago registrado corectamente",
        };
      } catch (error) {
        console.log(error);
        this.alert = {
          show: true,
          color: "warning",
          message: "Pago no registrado",
        };
      }
    },

    openDialogTasa() {
      this.dialog_tasa = true;
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
    async obtenerTasa() {
      try {
        const res = await newGoalService.getTasa();
        this.tasa.tasaBolivares = res.data.tasaBolivares;
        this.tasa.fechaTasa = res.data.fechaTasa.split("T")[0];
        console.log(res);
      } catch (error) {
        console.log(error);
      }
    },
  },
  computed: {
    montoTotalRules() {
      return [
        (v) => !!v || "Monto total es requerido",
        (v) => Number(v) > 0 || "Debe ser mayor a 0",
      ];
    },
    montoCanceladoRules() {
      return [
        (v) => !!v || "Monto cancelado es requerido",
        (v) => Number(v) >= 0 || "No puede ser negativo",
      ];
    },
  },
  mounted() {
    this.obtenerEstudiantes();
    this.leerMetodosdePago();
    this.obtenerTasa();
  },
};
</script>
