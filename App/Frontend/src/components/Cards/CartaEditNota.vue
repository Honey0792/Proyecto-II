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
    <v-form ref="form" @submit.prevent="modificarNota">
      <h3 class="pa-3">Modificar Nota</h3>
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
            <v-select
              variant="outlined"
              label="Nota"
              v-model="nota.valor_nota"
              :items="valorNota"
            ></v-select>
          </v-col>
        </v-row>
        <div class="d-flex pa-4 justify-center">
          <v-btn type="submit">Guardar</v-btn>
        </div>
      </v-container>
    </v-form>
    <v-divider></v-divider>
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
    nivelInscripcion: [],
    valorNota:['Aprobado','Moderado','Reprobado'],
    periodos: [],
    estudiantes: [],
    nota: {
      id_nota: null,
      id_estudiante: null,
      id_nivel: null,
      id_periodo: null,
      valor_nota: null,
      fecha_creacion: "",
    },
  }),
  methods: {
    fullName(item) {
      return `${item.nombre_etd} ${item.apellido_etd}`;
    },
    async obtenerNotaById() {
      const id = this.id;
      try {
        const res = await newGoalService.getNotasById(id);
        const datosApi = res.data[0];
        this.nota.id_nota = datosApi.id_nota;
        this.nota.fecha_creacion = datosApi.fecha_creacion_nota.split("T")[0];
        this.nota.id_estudiante = datosApi.id_etd;
        this.nota.id_nivel = datosApi.id_nivel;
        this.nota.id_periodo = datosApi.id_periodo;
        this.nota.valor_nota = datosApi.valor_nota;
        console.log(res);
      } catch (error) {
        console.log(error);
      }
    },

    async modificarNota() {
      const { valid } = await this.$refs.form.validate();

      if (!valid) {
        this.alert = {
          show: true,
          color: "warning",
          message: "Complete todos los campos requeridos",
        };
        this.$emit("actualizar_tabla");
        return;
      }
      try {
        const res = await newGoalService.putNota(this.nota);
        console.log(res);
        this.alert = {
          show: true,
          color: "success",
          message: "Nota modificada corectamente",
        };
        this.$emit("actualizar_tabla");
      } catch (error) {
        console.log(error);
        this.alert = {
          show: true,
          color: "warning",
          message: "Inscripción no Modificada",
        };
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
    this.obtenerNotaById();
    this.obtenerEstudiantes();
    this.obtenerPeriodos();
    this.leerNivelInscripcion();
  },
};
</script>
