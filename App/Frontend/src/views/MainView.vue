<!-- <template>
  <v-container class="ga-4">
    <v-row class="">
      <v-col>
        <v-card
          class="mx-auto text-center"
          color="cyan-lighten-2"
          width="700"
          height="270"
          dark
        >
          <v-card-text>
            <v-sheet color="rgba(0, 0, 0, .12)">
              <v-sparkline
                :model-value="chartData.map((p) => p.value)"
                :labels="chartData.map((p) => p.label)"
                color="rgba(255, 255, 255, .7)"
                stroke-linecap="round"
                smooth
                padding="24"
              >
                <template v-slot:label="{ value, index }">
                  {{ chartData[index].label}}:
                  {{ chartData[index].value }}
                </template>
              </v-sparkline>
            </v-sheet>
          </v-card-text>
          <v-card-text>
            <div class="text-h5 font-weight-thin text-white">
              Inscriptions in the Last 5 Trimesters
            </div></v-card-text
          >
        </v-card>
      </v-col>
      <v-col>
        <v-select
          variant="outlined"
          v-model="selectedPeriodoId"
          :items="periodoOptions"
          label="Selecciona un período"
          item-title="nombre"
          item-value="id"
          outlined
          dense
          class="mb-2"
        />
        <v-card variant="" class="mx-auto" width="300" height="231">
          <canvas
            ref="doughnutCanvas"
            style="height: 100%; width: 100%"
          ></canvas>
        </v-card>
      </v-col>
    </v-row>
    <v-row class="pa-6">
      <v-col>
        <v-card variant="tonal" class="mx-auto" width="300" height="231">
        </v-card>
      </v-col>
      <v-col>
        <v-card variant="" class="mx-auto" width="600">
          <v-data-table-virtual
            height="231"
            :items="estudiantes"
            :headers
            fixed-header
          ></v-data-table-virtual>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template> -->

<!-- <script>
import TablaEstudiantes from "@/components/Tables/tablaEstudiantes.vue";
import newGoalService from "@/services/newGoalService";
import {
  Chart,
  DoughnutController,
  ArcElement,
  Tooltip,
  Legend,
} from "chart.js";

Chart.register(DoughnutController, ArcElement, Tooltip, Legend);

export default {
  data: () => ({
    selectedPeriodoId: null,
    doughnutChartInstance: null,
    datosMain: [],
    estudiantes: [],
    itemsToShow: 10,
    alert: { show: false, message: "" },
    headers: [
      // { title: "Orden", key: "id_etd" }, // Columna para el estado
      // { title: "Estado", key: "estado" }, // Columna para el estado
      { title: "Nombre", key: "nombre_etd" }, // Columna para el nombre
      { title: "Apellido", key: "apellido_etd" }, // Columna para el apellido
      { title: "Correo", key: "correo_etd" }, // Columna para el correo
      { title: "Cedula", key: "cedula_etd" }, // Columna para el correo
      // Agrega más columnas según los datos que tengas
    ],
  }),
  components: {
    TablaEstudiantes,
  },
  methods: {
    async obtenerDatosMain() {
      try {
        const res = await newGoalService.getHome();
        this.datosMain = res.data.datos;

        if (this.datosMain.length > 0) {
          this.selectedPeriodoId = this.datosMain[0].id_periodo; // auto-selecciona el último periodo
        }
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
    renderDoughnut() {
      if (!this.selectedPeriodoId) return;

      const periodo = this.datosMain.find(
        (p) => p.id_periodo === this.selectedPeriodoId
      );

      if (!periodo) return;

      if (this.doughnutChartInstance) {
        this.doughnutChartInstance.destroy();
      }

      const mayores = parseInt(periodo.mayores_edad);
      const menores = parseInt(periodo.menores_edad);

      const ctx = this.$refs.doughnutCanvas.getContext("2d");

      this.doughnutChartInstance = new Chart(ctx, {
        type: "doughnut",
        data: {
          labels: ["Mayores de edad", "Menores de edad"],
          datasets: [
            {
              data: [mayores, menores],
              backgroundColor: ["#4CAF50", "#E91E63"],
            },
          ],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: {
              position: "bottom",
              labels: {
                color: "#fff",
              },
            },
          },
        },
      });
    },
  },
  computed: {
    chartData() {
      const sorted = [...this.datosMain].sort(
        (a, b) => b.id_periodo - a.id_periodo
      );
      return sorted.map((p) => ({
        label: p.nombre_periodo,
        value: parseInt(p.total_inscripciones),
      }));
    },
    limitedItems() {
      return this.estudiantes.slice(0, this.itemsToShow);
    },
    periodoOptions() {
      return this.datosMain.map((p) => ({
        id: p.id_periodo,
        nombre: p.nombre_periodo,
      }));
    },
  },
  watch: {
    selectedPeriodoId(newId) {
      this.renderDoughnut();
    },
  },
  mounted() {
    this.obtenerEstudiantes();
    this.obtenerDatosMain();
  },
};
</script> -->

<!-- <style scoped>
.scroll-overlay {
  height: 100%;
  overflow-y: overlay; /* Scroll superpuesto */
  padding-right: 8px; /* Compensa el espacio del scroll */
}

/* Scrollbar transparente que solo se ve al hacer hover */
.scroll-overlay::-webkit-scrollbar {
  width: 10px;
  background: transparent;
}

.scroll-overlay:hover::-webkit-scrollbar-thumb {
  background: #888;
  border-radius: 4px;
}

/* Para penetrar en el componente hijo (tabla) */
.scroll-overlay :deep(.v-data-table) {
  margin-right: -8px; /* Compensación del padding */
}
</style> -->

<template>
  <v-container fluid>
    <!-- Resumen de tarjetas -->
    <v-row class="mb-4" align="stretch">
      <v-col cols="12" sm="6" md="4">
        <v-card color="#4CE08E" dark>
          <v-card-text>
            <h3 class="text-h6 mb-1">Total estudiantes</h3>
            <div class="text-h4 font-weight-bold">{{ estudiantes.length }}</div>
          </v-card-text>
        </v-card>
      </v-col>

      <v-col cols="12" sm="6" md="4">
        <v-card color="#4CA0E0" dark>
          <v-card-text>
            <h3 class="text-h6 mb-1">Total inscripciones</h3>
            <div class="text-h4 font-weight-bold">
              {{ totalInscripciones }}
            </div>
          </v-card-text>
        </v-card>
      </v-col>

      <v-col cols="12" sm="6" md="4">
        <v-card color="#4CE0C1" dark>
          <v-card-text>
            <h3 class="text-h6 mb-1">Último período</h3>
            <div class="text-h6">
              {{ latestPeriodo?.nombre_periodo || "---" }}
            </div>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>

    <!-- Gráficos: sparkline y dona -->
    <v-row class="mb-4" align="stretch">
      <!-- Sparkline -->
      <v-col cols="12" md="6">
        <v-card
          class="mx-auto text-center"
          color="cyan-lighten-2"
          max-width="600"
          height="270"
          dark
        >
          <v-card-text>
            <v-sheet color="rgba(0, 0, 0, .12)">
              <v-sparkline
                :model-value="chartData.values"
                :labels="chartData.labels"
                color="rgba(255, 255, 255, .7)"
                height="100"
                padding="24"
                stroke-linecap="round"
                smooth
              >
                <template v-slot:label="{ index }">

                    {{ chartData.labels[index] }}:{{ chartData.values[index] }}

                </template>
              </v-sparkline>
            </v-sheet>
            <v-card-text class="text-white">
              Inscripciones en los últimos periodos
            </v-card-text>
          </v-card-text>
        </v-card>
      </v-col>

      <!-- Dona -->
      <v-col cols="12" md="6" class="d-flex justify-center">
        <v-card color="#328994" width="400" height="270" dark>
          <v-card-title class="d-flex justify-space-between ma-1 text-h6">
            <span>Distribución por edad</span>
            <v-select
              v-model="selectedPeriodoId"
              :items="periodoOptions"
              item-title="nombre"
              item-value="id"
             variant=" outlined"
              style="max-width: 160px"
            />
          </v-card-title>
          <v-card-text style="height: 150px">
            <canvas
              ref="doughnutCanvas"
              style="height: 100%; width: 100%"
            ></canvas>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>

    <!-- Tabla de estudiantes -->
    <v-row>
      <v-col cols="12">
        <v-card>
          <v-card-title class="text-h6">Estudiantes registrados</v-card-title>
          <v-data-table-virtual
            :items="estudiantes"
            :headers="headers"
            height="400"
            fixed-header
          />
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import {
  Chart,
  DoughnutController,
  ArcElement,
  Tooltip,
  Legend,
} from "chart.js";
import newGoalService from "@/services/newGoalService";

Chart.register(DoughnutController, ArcElement, Tooltip, Legend);

export default {
  data() {
    return {
      datosMain: [],
      estudiantes: [],
      selectedPeriodoId: null,
      doughnutChartInstance: null,
      headers: [
        { title: "Nombre", key: "nombre_etd" },
        { title: "Apellido", key: "apellido_etd" },
        { title: "Correo", key: "correo_etd" },
        { title: "Cédula", key: "cedula_etd" },
      ],
    };
  },
  computed: {
    chartData() {
      const sorted = [...this.datosMain].sort(
        (a, b) => b.id_periodo - a.id_periodo
      );

      return {
        values: sorted.map((p) => Number(p.total_inscripciones)), // 👈 Asegúrate que es número
        labels: sorted.map((p) => p.nombre_periodo.trim()), // 👈 Etiquetas limpias
      };
    },
    periodoOptions() {
      return this.datosMain.map((p) => ({
        id: p.id_periodo,
        nombre: p.nombre_periodo,
      }));
    },
    latestPeriodo() {
      return this.datosMain.length > 0
        ? [...this.datosMain].sort((a, b) => b.id_periodo - a.id_periodo)[0]
        : null;
    },
    totalInscripciones() {
      return this.datosMain.reduce(
        (sum, p) => sum + parseInt(p.total_inscripciones),
        0
      );
    },
  },
  watch: {
    selectedPeriodoId() {
      this.renderDoughnut();
    },
  },
  methods: {
    async obtenerDatosMain() {
      try {
        const res = await newGoalService.getHome();
        this.datosMain = res.data.datos;

        // Selecciona el último período por defecto
        if (this.datosMain.length > 0) {
          this.selectedPeriodoId = this.datosMain[0].id_periodo;
        }
      } catch (error) {
        console.error(error);
      }
    },
    async obtenerEstudiantes() {
      try {
        const res = await newGoalService.getEstudiante();
        this.estudiantes = res.data;
      } catch (error) {
        console.error(error);
      }
    },
    renderDoughnut() {
      if (!this.selectedPeriodoId) return;

      const periodo = this.datosMain.find(
        (p) => p.id_periodo === this.selectedPeriodoId
      );
      if (!periodo) return;

      if (this.doughnutChartInstance) {
        this.doughnutChartInstance.destroy();
      }

      const mayores = parseInt(periodo.mayores_edad);
      const menores = parseInt(periodo.menores_edad);

      const ctx = this.$refs.doughnutCanvas.getContext("2d");

      this.doughnutChartInstance = new Chart(ctx, {
        type: "doughnut",
        data: {
          labels: ["Mayores de edad", "Menores de edad"],
          datasets: [
            {
              data: [mayores, menores],
              backgroundColor: ["#4CCFE0", "#E08D4C"],
              borderWidth: 0,
            },
          ],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: {
              position: "bottom",
              labels: { color: "#fff" },
            },
          },
        },
      });
    },
  },
  mounted() {
    this.obtenerEstudiantes();
    this.obtenerDatosMain();
  },
};
</script>

<style scoped>
.text-white {
  color: white !important;
}
.v-card-title {
  font-weight: 600;
}
</style>
