<template>
  <v-card class="ma-7">
    <v-form @submit="registrarInscripcion">
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
              label="Estudiante"
              v-model="inscripcion.id_etd"
            ></v-autocomplete>
          </v-col>
        </v-row>
        <v-row>
          <v-col>
            <v-text-field
              variant="outlined"
              type="date"
              label="Fecha de Inscripcion"
              v-model="inscripcion.fecha_inscripcion"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-select
              variant="outlined"
              label="Grupo"
              :items="nivelInscripcion"
              item-title="categoria_nivel"

            ></v-select>
          </v-col>
          <v-col>
            <v-select
              label="Nivel"
              variant="outlined"
              :items="nivelInscripcion"
              item-title="nombre_nivel"
              item-value="id_nivel"
              v-model="inscripcion.id_nivel"
            ></v-select>
          </v-col>
          <v-col>
            <v-select
              label="Periodo"
              variant="outlined"
              :items="periodos"
              item-title="nombre_periodo"
              item-value="id_periodo"
              v-model="inscripcion.id_periodo"
            ></v-select>
          </v-col>
        </v-row>
        <v-row>
          <v-col>
            <div class="d-flex justify-center">
            <v-btn type="submit"> Registrar </v-btn>
          </div>
          </v-col>
        </v-row>
      </v-container>
    </v-form>
      <v-divider></v-divider>
      <TablaInscripciones />
  </v-card>
</template>

<script>
import newGoalService from "@/services/newGoalService";
import TablaInscripciones from "../Tables/tablaInscripciones.vue";

export default {
  components:{TablaInscripciones},
  data: () => ({
    periodos: [],
    nivelInscripcion: [],
    estudiantes: [],
    inscripcion: {
      id_etd: null,
      id_nivel: null,
      id_periodo: null,
      fecha_inscripcion: null,
    },
  }),
  methods: {
    fullName(item) {
      return `${item.nombre_etd} ${item.apellido_etd}`;
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
   async registrarInscripcion(){
    try {
      console.log(this.inscripcion)
      const res = await newGoalService.postInscripcion(this.inscripcion)
      console.log(res)
    } catch (error) {
      console.log(error)
    }
   }
  },
  mounted() {
    this.obtenerEstudiantes();
    this.leerNivelInscripcion();
    this.obtenerPeriodos();
  },
};
</script>
