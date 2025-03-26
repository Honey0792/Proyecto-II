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
  <v-card width="1200">
    <h3 class="pa-3">Nuevo Periodo</h3>
    <v-form @submit="modificarPeriodo">
      <v-divider></v-divider>
      <v-container class="">
        <v-row>
          <v-col>
            <v-text-field
              variant="outlined"
              label="Nombre"
              v-model="periodo.nombre"
            ></v-text-field>
          </v-col>
        </v-row>
        <v-row>
          <v-col>
            <v-text-field
              variant="outlined"
              type="date"
              label="Fecha de Inicio"
              v-model="periodo.fecha_inicio.split('T')[0]"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-text-field
              variant="outlined"
              type="date"
              label="Fecha de Culminacion"
              v-model="periodo.fecha_fin.split('T')[0]"
            ></v-text-field>
          </v-col>
        </v-row>
        <v-row>
          <v-col>
            <v-text-field
              label="Año Academico"
              variant="outlined"
              type="number"
              min="2000"
              v-model="periodo.anio_academico"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-select
              label="Estado"
              variant="outlined"
              :items="estados"
              item-title="nombre_estado"
              item-value="id_estado"
              v-model="periodo.id_estado"
            ></v-select>
          </v-col>
        </v-row>
        <v-btn class="text-white bg-orange-lighten-2 mx-auto" type="submit"
          >Guardar</v-btn
        >
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
    estados: [],
    periodo: {
      id_periodo: null,
      id_estado: null,
      nombre: null,
      fecha_inicio: "",
      fecha_fin: "",
      anio_academico: null,
    },
  }),
  methods: {
    async leerEstados() {
      try {
        const res = await newGoalService.getEstado();
        this.estados = res.data.datos;
      } catch (error) {
        console.log("error");
      }
    },
    async obtenerPeriodoById(id) {
      id = this.id;
      try {
        const res = await newGoalService.getPeriodoById(id);
        const datosApi = res.data[0];
        this.periodo.id_periodo =datosApi.id_periodo
        this.periodo.id_estado = datosApi.id_estado
        this.periodo.nombre = datosApi.nombre_periodo
        this.periodo.fecha_inicio = datosApi.fecha_ini_periodo
        this.periodo.fecha_fin = datosApi.fecha_fin_periodo
        this.periodo.anio_academico = datosApi.year_academico
        console.log(this.periodo);
      } catch (error) {}
    },
    async modificarPeriodo(){
        try {
            const res = await newGoalService.putPeriodo(this.periodo)

            console.log(res)
            this.alert = {
          show: true,
          color: "success",
          message: "Periodo modificado corectamente",
        };
      } catch (error) {
        console.log(error);
        this.alert = {
          show: true,
          color: "warning",
          message: "Error al intentar modificar periodo",
        };
      }
    },

  },
  mounted() {
    this.obtenerPeriodoById();
    this.leerEstados()
  },
};
</script>
