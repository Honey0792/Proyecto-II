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
    <v-form>
      <h3 class="pa-3">Persona que registro el pago</h3>
      <v-divider></v-divider>
      <v-container>
        <v-row>
          <v-col>
            <v-text-field
            readonly
              variant="outlined"
              label="Nombre"
              v-model="gasto.nombre_persona"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-text-field
            readonly
              variant="outlined"
              label="Apellido"
              v-model="gasto.apellido_persona"
            ></v-text-field>
          </v-col>
        </v-row>
      </v-container>
      <v-divider></v-divider>
      <h3 class="pa-3">Datos del Gasto</h3>
      <v-divider></v-divider>
      <v-container class="">
        <v-row>
          <v-col>
            <v-text-field
            readonly
              :items="tiposDeGastos"
              item-value="id_tipo_gasto"
              item-title="nombre_tipo_gasto"
              label="Tipo de Gasto"
              variant="outlined"
              v-model="gasto.tipo_gasto"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-text-field
            readonly
              :items="metodos_pago"
              item-value="id_metodo_pago"
              item-title="nombre_metodo_pago"
              label="Metodo de Pago"
              variant="outlined"
              v-model="gasto.metodo_pago"
            ></v-text-field>
          </v-col>
        </v-row>
      </v-container>
      <v-container>
        <v-row>
          <v-col>
            <v-text-field
            readonly
              variant="outlined"
              type="date"
              label="Fecha del Gasto"
              v-model="gasto.fecha.split('T')[0]"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-text-field
            readonly
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
            readonly
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
            readonly
              variant="outlined"
              label="Descripcion"
              v-model="gasto.descripcion"
              rows="4"
              no-resize
            ></v-textarea>
          </v-col>
        </v-row>
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
    gasto: {
      nombre_persona: null,
      apellido_persona: null,
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
    async obtenergasto(id) {
      id = this.id;
      try {
        const res = await newGoalService.getGastoById(id);
        const datosApi = res.data[0];
        this.gasto.apellido_persona = datosApi.apellido_persona;
        this.gasto.nombre_persona = datosApi.nombre_persona;
        this.gasto.id_gasto = datosApi.id_gasto;
        this.gasto.metodo_pago = datosApi.nombre_metodo_pago;
        this.gasto.tipo_gasto = datosApi.nombre_tipo_gasto;
        this.gasto.nombre = datosApi.nombre_gasto;
        this.gasto.descripcion = datosApi.descripcion_gasto;
        this.gasto.fecha = datosApi.fecha_gasto;
        this.gasto.cantidad = datosApi.cantidad_gasto;
        console.log(datosApi);
      } catch (error) {
        console.log(error);
      }
    },
  },
  mounted() {
    this.obtenergasto();
  },
};
</script>
