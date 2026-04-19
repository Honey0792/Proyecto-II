<template>
  <v-container fluid>
    <!-- ===== TARJETAS ===== -->
    <v-row class="mb-4" align="stretch">
      <v-col cols="12" sm="6" md="4">
        <v-card color="#4CE08E" min-height="120" dark>
          <v-card-text>
            <h3>Total estudiantes</h3>
            <div class="text-h4 font-weight-bold">
              {{ estudiantes.length }}
            </div>
          </v-card-text>
        </v-card>
      </v-col>

      <v-col cols="12" sm="6" md="4">
        <v-card color="#4CA0E0" min-height="120" dark>
          <v-card-text>
            <h3>Total inscripciones</h3>
            <div class="text-h4 font-weight-bold">
              {{ totalInscripciones }}
            </div>
          </v-card-text>
          <v-card-subtitle>Últimos períodos</v-card-subtitle>
        </v-card>
      </v-col>

      <v-col cols="12" sm="6" md="4">
        <v-card color="#4CE0C1" min-height="120" dark>
          <v-card-text>
            <h3>Último período</h3>
            <div class="text-h6">
              {{ latestPeriodo?.nombre_periodo || "---" }}
            </div>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>

    <!-- ===== CHARTS ===== -->
    <v-row>
      <!-- BAR + LINE -->
      <v-col cols="12" md="6">
        <v-card height="300" color="cyan-darken-2" dark>
          <v-card-text style="height: 260px">
            <Bar :data="chartDataBarLine" :options="chartOptionsBarLine" />
          </v-card-text>
        </v-card>
      </v-col>

      <!-- DOUGHNUT -->
      <v-col cols="12" md="6">
        <v-card height="300" color="#328994" dark>
          <v-card-title class="d-flex justify-space-between">
            <span>Distribución por edad</span>
            <v-select
              v-model="selectedPeriodoId"
              :items="periodoOptions"
              item-title="nombre"
              item-value="id"
              density="compact"
              style="max-width: 160px"
            />
          </v-card-title>

          <v-card-text style="height: 200px">
            <Doughnut
              v-if="chartDataDoughnut"
              :data="chartDataDoughnut"
              :options="chartOptionsDoughnut"
            />
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import {
  Chart,
  Title,
  Tooltip,
  Legend,
  BarElement,
  LineElement,
  CategoryScale,
  LinearScale,
  PointElement,
  ArcElement,
  DoughnutController,
} from "chart.js";

import { Bar, Doughnut } from "vue-chartjs";
import newGoalService from "@/services/newGoalService";

Chart.register(
  Title,
  Tooltip,
  Legend,
  BarElement,
  LineElement,
  CategoryScale,
  LinearScale,
  PointElement,
  ArcElement,
  DoughnutController
);

export default {
  components: { Bar, Doughnut },

  data() {
    return {
      datosMain: [],
      estudiantes: [],
      selectedPeriodoId: null,
    };
  },

  computed: {
    latestPeriodo() {
      return this.datosMain.length
        ? [...this.datosMain].sort((a, b) => b.id_periodo - a.id_periodo)[0]
        : null;
    },

    totalInscripciones() {
      return this.datosMain.reduce(
        (sum, p) => sum + Number(p.total_inscripciones),
        0
      );
    },

    periodoOptions() {
      return this.datosMain.map((p) => ({
        id: p.id_periodo,
        nombre: p.nombre_periodo,
      }));
    },

   chartDataBarLine() {
  const sorted = [...this.datosMain].sort(
    (a, b) => a.id_periodo - b.id_periodo
  );

  return {
    labels: sorted.map((p) => p.nombre_periodo),
    datasets: [
      {
        type: "bar",
        label: "Inscripciones",
        data: sorted.map((p) => Number(p.total_inscripciones)),
        backgroundColor: "#00bcd4",
        order: 1, // 👈 SE DIBUJA PRIMERO (ABAJO)
      },
      {
        type: "line",
        label: "Mayores de edad",
        data: sorted.map((p) => Number(p.mayores_edad)),
        borderColor: "#4caf50",
        backgroundColor: "#4caf50",
        tension: 0.3,
        order: 2, // 👈 ENCIMA DE LAS BARRAS
        pointRadius: 5,
        pointBackgroundColor: "#4caf50",
      },
      {
        type: "line",
        label: "Menores de edad",
        data: sorted.map((p) => Number(p.menores_edad)),
        borderColor: "#ff9800",
        backgroundColor: "#ff9800",
        tension: 0.3,
        order: 2, // 👈 ENCIMA DE LAS BARRAS
        pointRadius: 5,
        pointBackgroundColor: "#ff9800",
      },
    ],
  };
},


    chartOptionsBarLine() {
      return {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: { labels: { color: "#fff" } },
          title: {
            display: true,
            text: "Inscripciones por período",
            color: "#fff",
          },
        },
        scales: {
          x: { ticks: { color: "#fff" } },
          y: { ticks: { color: "#fff" } },
        },
      };
    },

    chartDataDoughnut() {
      if (!this.selectedPeriodoId) return null;

      const p = this.datosMain.find(
        (x) => x.id_periodo === this.selectedPeriodoId
      );
      if (!p) return null;

      return {
        labels: ["Mayores de edad", "Menores de edad"],
        datasets: [
          {
            data: [Number(p.mayores_edad), Number(p.menores_edad)],
            backgroundColor: ["#4CCFE0", "#E08D4C"],
          },
        ],
      };
    },

    chartOptionsDoughnut() {
      return {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            position: "bottom",
            labels: { color: "#fff" },
          },
        },
      };
    },
  },

  async mounted() {
    await this.obtenerDatosMain();
    this.obtenerEstudiantes();
  },

  methods: {
    async obtenerDatosMain() {
      const res = await newGoalService.getHome();
      this.datosMain = res.data.datos;

      if (this.datosMain.length) {
        this.selectedPeriodoId = this.latestPeriodo.id_periodo;
      }
    },

    async obtenerEstudiantes() {
      const res = await newGoalService.getEstudiante();
      this.estudiantes = res.data;
    },
  },
};
</script>
