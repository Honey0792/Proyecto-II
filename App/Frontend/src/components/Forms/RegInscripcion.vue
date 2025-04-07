<template>
  <v-form>
    <v-card class="ma-7">
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
            ></v-autocomplete>
          </v-col>
        </v-row>
        <v-row>
          <v-col>
            <v-text-field
              variant="outlined"
              type="date"
              label="Fecha de Inscripcion"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-select variant="outlined" label="Grupo"></v-select>
          </v-col>
          <v-col>
            <v-select label="Nivel" variant="outlined"></v-select>
          </v-col>
        </v-row>
      </v-container>
      <v-divider></v-divider>
    </v-card>
  </v-form>
</template>

<script>
import newGoalService from '@/services/newGoalService';

export default {
  data: () => ({
    nivelInscripcion:[],
    estudiantes:[]
  }),
  methods:{
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

    async leerNivelInscripcion(){
try {
  const res = await newGoalService.getNivelInscripcion()
  this.nivelInscripcion = res.data.datos
  console.log(res)
} catch (error) {
  console.log(error)
}
    }
  },
  mounted(){
    this.obtenerEstudiantes()
    this.leerNivelInscripcion()
  },
};
</script>
