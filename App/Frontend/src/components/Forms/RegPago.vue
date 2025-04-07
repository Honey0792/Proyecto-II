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
    <v-form @submit.prevent="registrarPago">
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
              v-model="pago.fecha_pago"
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
        <v-btn type="submit">Registrar</v-btn>
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
        <v-divider></v-divider>
      <tablaPagos />
    </v-card>
</template>

<script>
import newGoalService from "@/services/newGoalService";
import tablaPagos from "../Tables/tablaPagos.vue";

export default {
  components: { tablaPagos },
  data: () => ({
    alert: { show: false, message: "" },
    metodos_pago: [],
    estudiantes: [], // Lista de estudiantes
    pago: {
      id_estudiante: null,
      metodo_pago: null,
      fecha_pago: "",
      monto_total: null,
      monto_cancelado: null,
    },
  }),
  methods: {
    fullName(item) {
      return `${item.nombre_etd} ${item.apellido_etd}`;
    },
    async leerMetodosdePago() {
      try {
        const res = await newGoalService.getMetodoDePago();
        this.metodos_pago = res.data.datos
        console.log(this.metodos_pago);
      } catch (error) {
        console.log(error);
      }
    },
    async registrarPago() {
      try {
        console.log(this.pago)
        const res = await newGoalService.postPagos(this.pago);
        this.alert = {
          show: true,
          color: 'success',
          message: "pago registrado corectamente",
        }
      } catch (error) {
        console.log(error);
        this.alert = {
          show: true,
          color: 'warning',
          message: "Pago no registrado",
        }
        
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
    this.leerMetodosdePago()
  },
};
</script>
