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
    <h3 class="pa-3">Reporte de Inscripciones</h3>
    <v-divider></v-divider>
    <v-container>
      <v-form ref="form">
        <v-row>
          <v-col></v-col>
          <v-col>
            <v-select
              variant="outlined"
              label="Formato"
              :items="formato_reporte"
              item-title="nombre_tipo"
              item-value="id_tipo"
              v-model="reporte.id_formato"
              :rules="globalRules"
            >
            </v-select>
          </v-col>
          <v-col></v-col>
        </v-row>
        <v-row>
          <v-col>
            <v-autocomplete
              :items="estudiantes"
              item-value="id_etd"
              :item-title="fullName"
              variant="outlined"
              label="Estudiante"
              v-model="reporte.id_etd"
            ></v-autocomplete>
          </v-col>
        </v-row>
        <v-row>
          <v-col
            ><v-text-field
              variant="outlined"
              type="date"
              label="Fecha Inicio"
              v-model="reporte.fecha_ini"
              :rules="fechaInicioRules"
            ></v-text-field>
          </v-col>
          <v-col
            ><v-text-field
              variant="outlined"
              type="date"
              label="Fecha Final"
              v-model="reporte.fecha_fin"
              :rules="fechaFinRules"
            ></v-text-field>
          </v-col>
        </v-row>
        <v-row>
          <v-col>
            <v-autocomplete
              variant="outlined"
              label="Periodo"
              :items="periodos"
              item-title="nombre_periodo"
              item-value="id_periodo"
              v-model="reporte.id_periodo"
            >
            </v-autocomplete>
          </v-col>
          <v-col>
            <v-autocomplete
              variant="outlined"
              label="Nivel"
              :items="niveles"
              item-title="nombre_nivel"
              item-value="id_nivel"
              v-model="reporte.id_nivel"
            >
            </v-autocomplete>
          </v-col>
        </v-row>
        <div class="d-flex justify-center">
          <v-btn @click="generarReporte"> Generar </v-btn>
        </div>
      </v-form>
    </v-container>
  </v-card>
</template>

<script>
import newGoalService from "@/services/newGoalService";

export default {
  data: () => ({
    alert: { show: false, message: "" },
    periodos: [],
    estudiantes: [],
    niveles: [],
    formato_reporte: [
      { id_tipo: 1, nombre_tipo: "EXCEL" },
      { id_tipo: 2, nombre_tipo: "PDF" },
    ],

    reporte: {
      id_formato: null,
      id_etd: null,
      fecha_ini: null,
      fecha_fin: null,
      id_periodo: null,
      id_nivel: null,
    },
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
    async obtenerPeriodos() {
      try {
        const res = await newGoalService.getPeriodos();
        this.periodos = res.data;
        console.log(res);
      } catch (error) {
        console.log(error);
      }
    },
    async obtenerNiveles() {
      try {
        const res = await newGoalService.getNivelInscripcion();
        this.niveles = res.data.datos;
        console.log(this.niveles);
      } catch (error) {
        console.log(error);
      }
    },
    async generarReporte() {
      const { valid } = await this.$refs.form.validate();

      if (!valid) {
        this.alert = {
          show: true,
          color: "warning",
          message: "Complete todos los campos requeridos",
        };
        return;
      }
      const params = new URLSearchParams();

      // Agrega los parámetros si existen
      if (this.reporte.id_formato)
        params.append("type", this.reporte.id_formato);
      if (this.reporte.fecha_ini)
        params.append("fecha_ini", this.reporte.fecha_ini);
      if (this.reporte.fecha_fin)
        params.append("fecha_fin", this.reporte.fecha_fin);
      if (this.reporte.id_periodo)
        params.append("id_periodo", this.reporte.id_periodo);
      if (this.reporte.id_nivel)
        params.append("id_nivel", this.reporte.id_nivel);
      if (this.reporte.id_etd) params.append("id_estudiante", this.reporte.id_etd);

      try {
        const res = await newGoalService.generarReporteInscripciones(params);
        const blob = new Blob([res.data], {
          type: res.headers["content-type"],
        });

        const hoy = new Date();
        const fechaStr = hoy.toISOString().split("T")[0];

        const fileExtension = this.reporte.id_formato === 1 ? "xlsx" : "pdf";
        const url = window.URL.createObjectURL(blob);
        const link = document.createElement("a");
        link.href = url;
        link.setAttribute(
          "download",
          `reporte_inscripciones ${fechaStr}.${fileExtension}`
        );
        document.body.appendChild(link);
        link.click();
        link.remove();
      } catch (error) {
        console.error("Error al generar el reporte:", error);
        const status = error.response?.status;
        const msg = error.response?.data?.message || error.message;

        this.alert = {
          show: true,
          color: "warning",
          message:
            status === 404
              ? "No se encontraron resultados con esos filtros"
              : msg || "Error al generar el reporte",
        };
      }
    },
  },

  computed: {
    fechaInicioRules() {
      return [
        (v) => {
          if (!this.reporte.fecha_fin) return true;
          return (
            new Date(v) <= new Date(this.reporte.fecha_fin) ||
            "Debe ser anterior a la fecha de culminación"
          );
        },
      ];
    },
    fechaFinRules() {
      return [
        (v) => {
          if (!this.reporte.fecha_ini) return true;
          const start = new Date(this.reporte.fecha_ini);
          const end = new Date(v);

          if (end < start) return "No puede ser anterior a la fecha de inicio";
        },
      ];
    },
  },
  mounted() {
    this.obtenerEstudiantes(), this.obtenerPeriodos(), this.obtenerNiveles();
  },
};
</script>
