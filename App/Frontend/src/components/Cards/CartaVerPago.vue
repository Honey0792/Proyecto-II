<template>
  <v-card class="ma-7">
    <v-form>
      <h3 class="pa-3">Persona que registro el pago</h3>
      <v-divider></v-divider>
      <v-container>
        <v-row>
          <v-col>
            <v-text-field
              variant="outlined"
              readonly
              label="Nombre"
              v-model="pago.nombre_persona"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-text-field
              variant="outlined"
              readonly
              label="Apellido"
              v-model="pago.apellido_persona"
            ></v-text-field>
          </v-col>
        </v-row>
    </v-container>
    <v-divider></v-divider>
      <h3 class="pa-3">Datos del Pago</h3>
      <v-divider></v-divider>
      <v-container>
        <v-row>
          <v-col>
            <v-text-field
              variant="outlined"
              readonly
              label="Nombre del Estudiante"
              v-model="pago.nombre_etd"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-text-field
              variant="outlined"
              readonly
              label="Apellido del Estudiante"
              v-model="pago.apellido_etd"
            ></v-text-field>
          </v-col>
        </v-row>
      </v-container>
      <v-container class="">
        <v-row>
          <v-col>
            <v-text-field
              variant="outlined"
              readonly
              type="date"
              label="Fecha del Pago"
              v-model="pago.fecha_pago.split('T')[0]"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-text-field
              label="Metodo de Pago"
              variant="outlined"
              readonly
              v-model="pago.nombre_metodo_pago"
            ></v-text-field>
          </v-col>
        </v-row>
      </v-container>
      <v-container>
        <v-row>
          <v-col>
            <v-text-field
              type="number"
              variant="outlined"
              readonly
              label="Monto Total"
              v-model="pago.monto_total_pago"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-text-field
              variant="outlined"
              readonly
              type="number"
              label="Monto Cancelado"
              v-model="pago.monto_cancelado_pago"
            ></v-text-field>
          </v-col>
        </v-row>
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
              readonly
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
  props: {
    id: {
      type: Number,
      required: true,
    },
  },
  data: () => ({
    nombre_completo_etd: "",
    pago: {
      id_pago: null,
      id_etd: null,
      nombre_etd: null,
      apellido_etd: null,
      cedula_etd: null,
      id_persona: null,
      nombre_persona: null,
      apellido_persona: null,
      id_metodo_pago: null,
      nombre_metodo_pago: null,
      fecha_pago: "",
      monto_total_pago: null,
      monto_cancelado_pago: null,
    },
  }),
  methods: {
    fullName(item) {
      return `${this.pago.nombre_etd} ${this.pago.apellido_etd}`;
    },
    async obtenerPagoById() {
      try {
        const res = await newGoalService.getPagoById(this.id);
        this.pago = res.data[0];
        console.log(this.pago);
      } catch (error) {
        console.log(error);
      }
    },
  },
  mounted() {
    this.obtenerPagoById();
  },
};
</script>
