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
    <h3 class="pa-3">Nuevo Trimestre</h3>
    <v-form ref="form" @submit.prevent="crearPeriodo">
      <v-divider></v-divider>
      <v-container class="">
        <v-row>
          <v-col>
            <v-text-field
              variant="outlined"
              label="Nombre"
              v-model="periodo.nombre"
              :rules="globalRules"
            ></v-text-field>
          </v-col>
        </v-row>
        <v-row>
          <v-col>
            <v-text-field
              variant="outlined"
              type="date"
              label="Fecha de Inicio"
              v-model="periodo.fecha_inicio"
              :rules="fechaInicioRules"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-text-field
              variant="outlined"
              type="date"
              label="Fecha de Culminacion"
              v-model="periodo.fecha_fin"
              :rules="fechaFinRules"
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
              :rules="globalRules"
            ></v-select>
          </v-col>
        </v-row>
        <v-btn class="text-white bg-orange-lighten-2 mx-auto" type="submit"
          >Crear</v-btn
        >
      </v-container>
    </v-form>
    <v-divider></v-divider>
    <h3 class="pa-3">Periodos Academicos</h3>
    <v-divider></v-divider>
    <tablaPeriodos ref="hijo" />
  </v-card>
</template>

<script>
import newGoalService from "@/services/newGoalService";
import tablaPeriodos from "../Tables/tablaPeriodos.vue";
export default {
  components: {
    tablaPeriodos,
  },
  data: () => ({
    alert: { show: false, message: "" },
    estados: [],
    periodo: {
      id_estado: null,
      nombre: null,
      fecha_inicio: null,
      fecha_fin: null,
      anio_academico: null,
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
    async leerEstados() {
      try {
        console.log("hola");
        const res = await newGoalService.getEstado();
        this.estados = res.data.datos;
      } catch (error) {
        console.log(error);
      }
    },

    async crearPeriodo() {
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
        const res = await newGoalService.postPeriodo(this.periodo);
        console.log(res)
        this.alert = {
          show: true,
          color: "success",
          message: "Periodo creado corectamente",
        };
        this.$refs.hijo.obtenerPeriodos()
      } catch (error) {
        console.log(error);
        this.alert = {
          show: true,
          color: "warning",
          message: "Error al intentar registrar periodo",
        };
      }
    },
  },
computed: {
  fechaInicioRules() {
    return [
      (v) => !!v || 'Fecha de inicio es requerida',
      (v) => !isNaN(new Date(v)) || 'Fecha inválida',
      (v) => {
        if (!this.periodo.fecha_fin) return true;
        return new Date(v) <= new Date(this.periodo.fecha_fin) || 'Debe ser anterior a la fecha de culminación';
      }
    ];
  },
  fechaFinRules() {
    return [
      (v) => !!v || 'Fecha de culminación es requerida',
      (v) => !isNaN(new Date(v)) || 'Fecha inválida',
      (v) => {
        if (!this.periodo.fecha_inicio) return true;
        const start = new Date(this.periodo.fecha_inicio);
        const end = new Date(v);
        
        // Validación 1: La fecha fin no puede ser menor a la inicio
        if (end < start) return 'No puede ser anterior a la fecha de inicio';
        
        // Validación 2: Diferencia mínima de 2 meses y medio (75 días aprox)
        const minEndDate = new Date(start);
        minEndDate.setMonth(minEndDate.getMonth() + 2);
        minEndDate.setDate(minEndDate.getDate() + 15);
        
        return end >= minEndDate || 'Mínimo 2 meses y medio de diferencia requeridos';
      }
    ];
  }
},
  mounted() {
    this.leerEstados();
  },
};
</script>
