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
    <v-form @submit.prevent="crearPeriodo">
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
              v-model="periodo.fecha_inicio"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-text-field
              variant="outlined"
              type="date"
              label="Fecha de Culminacion"
              v-model="periodo.fecha_fin"
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
  computed: {},
  mounted() {
    this.leerEstados();
  },
};
</script>
