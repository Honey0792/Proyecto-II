<template>
  <v-card class="ma-7">
    <v-form>
      <h3 class="pa-3">Datos de la Inscripcion</h3>
      <v-divider></v-divider>
      <v-container class="">
        <v-row>
          <v-col>
            <v-autocomplete
              :items="estudiantes"
              item-value="id_etd"
              :item-title="fullName"
              variant="outlined"
              readonly
              label="Estudiante"
              v-model="inscripcion.id_etd"
            ></v-autocomplete>
          </v-col>
        </v-row>
        <v-row>
          <v-col>
            <v-text-field
              variant="outlined"
              readonly
              type="date"
              label="Fecha de Inscripcion"
              v-model="inscripcion.fecha_inscripcion.split('T')[0]"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-autocomplete
              readonly
              label="Nivel"
              variant="outlined"
              :items="nivelInscripcion"
              :item-title="fullNameNivel"
              item-value="id_nivel"
              v-model="inscripcion.id_nivel"
              :rules="globalRules"
            ></v-autocomplete>
          </v-col>
          <v-col>
            <v-select
              label="Periodo"
              variant="outlined"
              readonly
              :items="periodos"
              item-title="nombre_periodo"
              item-value="id_periodo"
              v-model="inscripcion.id_periodo"
            ></v-select>
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
    periodos: [],
    nivelInscripcion: [],
    estudiantes: [],
    inscripcion: {
      id_inscripcion: null,
      id_etd: null,
      id_nivel: null,
      id_periodo: null,
      fecha_inscripcion: "",
    },
  }),
  methods: {
    fullName(item) {
      return `${item.nombre_etd} ${item.apellido_etd}`;
    },

    fullNameNivel(item) {
      return ` ${item.categoria_nivel} ${item.nombre_nivel}`;
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
    async obtenerInscripcionByID() {
      const id = this.id;
      try {
        const res = await newGoalService.getInscripcionById(id);
        const datosApi = res.data[0];
        this.inscripcion.id_inscripcion = datosApi.id_inscripcion;
        this.inscripcion.id_etd = datosApi.id_etd;
        this.inscripcion.id_nivel = datosApi.id_nivel;
        this.inscripcion.fecha_inscripcion = datosApi.fecha_inscripcion;
        this.inscripcion.id_periodo = datosApi.id_periodo;
        console.log(res);
      } catch (error) {
        console.log(error);
      }
    },
    async leerNivelInscripcion() {
      try {
        const res = await newGoalService.getNivelInscripcion();
        this.nivelInscripcion = res.data.datos;
        console.log(res);
      } catch (error) {
        console.log(error);
      }
    },
    async obtenerPeriodos() {
      try {
        const res = await newGoalService.getPeriodos();
        this.periodos = res.data;
        console.log(res);
      } catch (error) {
        console.log(error);
      }
    },
    async modificarInscripcion() {
      try {
        const res = await newGoalService.putSInscripcion(this.inscripcion);
        console.log(res);
      } catch (error) {
        console.log(error);
      }
    },
  },
  mounted() {
    this.obtenerEstudiantes();
    this.leerNivelInscripcion();
    this.obtenerInscripcionByID();
    this.obtenerPeriodos();
  },
};
</script>
