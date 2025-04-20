<template>
  <v-card class="ma-7">
    <v-form @submit="registrarNota">
      <h3 class="pa-3">Añadir Nota</h3>
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
              v-model="nota.id_estudiante"
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
              label="Fecha de Nota"
              v-model="nota.fecha_creacion"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-select
              label="Nivel"
              variant="outlined"
              :items="nivelInscripcion"
              item-title="nombre_nivel"
              item-value="id_nivel"
              v-model="nota.id_nivel"
            ></v-select>
          </v-col>
        </v-row>
      </v-container>
      <v-container>
        <v-row>
          <v-col>
            <v-select
              type="number"
              variant="outlined"
              label="Periodo"
              :items="periodos"
              item-title="nombre_periodo"
              item-value="id_periodo"
              v-model="nota.id_periodo"
            ></v-select>
          </v-col>
          <v-col>
            <v-text-field
              variant="outlined"
              label="Nota"
              v-model="nota.valor_nota"
            ></v-text-field>
          </v-col>
        </v-row>
        <div class="d-flex pa-4 justify-center">
          <v-btn type="submit">Agregar</v-btn>
        </div>
      </v-container>
    </v-form>
    <v-divider></v-divider>
    <tabla-notas />
  </v-card>
</template>

<script>
import newGoalService from "@/services/newGoalService";
import TablaNotas from "../Tables/tablaNotas.vue";

export default {
  components:{
    TablaNotas
  },
  data: () => ({
    nivelInscripcion: [],
    periodos: [],
    estudiantes: [],
    nota: {
      id_estudiante: null,
      id_nivel: null,
      id_periodo: null,
      valor_nota: null,
      fecha_creacion: null,
    },

    notaRules: [
      (value) => !!value || "Éste campo es requerido",
      (value) => value <= 10 || "La nota no puede ser mayor a 10",
      (value) => value >= 1 || "La nota no puede ser menor a 1",
    ],
  }),

  methods: {
    fullName(item) {
      return `${item.nombre_etd} ${item.apellido_etd}`;
    },

    async registrarNota() {
      try {
        const res = await newGoalService.postNota(this.nota);
        console.log(res);
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
  },

  mounted() {
    this.obtenerEstudiantes();
    this.obtenerPeriodos();
    this.leerNivelInscripcion();
  },
};
</script>
