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
    <v-form ref="form" @submit.prevent="registrarInscripcion">
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
              :rules="globalRules"
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
              :rules="fechaRules"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-select
              variant="outlined"
              label="Grupo"
              :items="nivelInscripcion"
              item-title="categoria_nivel"
              :rules="globalRules"
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
              :rules="globalRules"
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
              :rules="globalRules"
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
    <TablaInscripciones ref="hijo" />
  </v-card>
</template>

<script>
import newGoalService from "@/services/newGoalService";
import TablaInscripciones from "../Tables/tablaInscripciones.vue";

export default {
  components: { TablaInscripciones },
  data: () => ({
    alert: { show: false, message: "" },
    periodos: [],
    nivelInscripcion: [],
    estudiantes: [],
    inscripcion: {
      id_etd: null,
      id_nivel: null,
      id_periodo: null,
      fecha_inscripcion: null,
    },
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
    globalRules: [(value) => !!value || "Requerido"],
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
    async registrarInscripcion() {
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
        console.log(this.inscripcion);
        const res = await newGoalService.postInscripcion(this.inscripcion);
        this.alert = {
          show: true,
          color: "success",
          message: "Inscripción registrada corectamente",
        };
        this.$refs.hijo.obtenerInscripciones();
      } catch (error) {
        console.log(error);
        this.alert = {
          show: true,
          color: "warning",
          message: "Inscripción no registrada",
        };
      }
    },
  },
  mounted() {
    this.obtenerEstudiantes();
    this.leerNivelInscripcion();
    this.obtenerPeriodos();
  },
};
</script>
