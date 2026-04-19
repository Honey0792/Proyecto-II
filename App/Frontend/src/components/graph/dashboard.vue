<template>
  <v-container fluid>
    <!-- ===== SECCIÓN: BALANCE ===== -->
    <v-sheet class="mb-4 pa-3" color="orange-lighten-5" rounded="lg">
      <v-row align="center" class="mb-2">
        <v-col cols="12" md="4">
          <div class="text-h6 text-grey-darken-4">
            <v-icon start color="success">mdi-cash-multiple</v-icon>
            Balance Financiero
          </div>
        </v-col>
        <v-col cols="12" md="8" class="d-flex align-center ga-2 justify-end">
          <v-text-field
            v-model="fechaInicio"
            type="date"
            label="Desde"
            variant="outlined"
            density="compact"
            hide-details
            bg-color="white"
            style="max-width: 150px"
          />
          <v-text-field
            v-model="fechaFin"
            type="date"
            label="Hasta"
            variant="outlined"
            density="compact"
            hide-details
            bg-color="white"
            style="max-width: 150px"
          />
          <v-btn color="primary" @click="obtenerBalance" :loading="loadingBalance">
            <v-icon start>mdi-magnify</v-icon>
            Buscar
          </v-btn>
        </v-col>
      </v-row>

      <!-- TARJETAS -->
      <v-row class="mb-3">
        <v-col cols="12" sm="6" md="4">
          <v-card color="white" rounded="xl" elevation="8">
            <v-card-text class="text-center py-4">
              <v-icon size="40" color="success" class="mb-2">mdi-arrow-down-circle</v-icon>
              <div class="text-h6 text-grey-darken-3">Ingresos</div>
              <div class="text-h4 font-weight-bold text-success">
                ${{ Number(balance?.ingresos_usd || 0).toFixed(2) }}
              </div>
            </v-card-text>
          </v-card>
        </v-col>

        <v-col cols="12" sm="6" md="4">
          <v-card color="white" rounded="xl" elevation="8">
            <v-card-text class="text-center py-4">
              <v-icon size="40" color="error" class="mb-2">mdi-arrow-up-circle</v-icon>
              <div class="text-h6 text-grey-darken-3">Egresos</div>
              <div class="text-h4 font-weight-bold text-error">
                ${{ Number(balance?.egresos_usd || 0).toFixed(2) }}
              </div>
            </v-card-text>
          </v-card>
        </v-col>

        <v-col cols="12" sm="6" md="4">
          <v-card 
            :color="balance?.balance_usd >= 0 ? 'success' : 'error'" 
            rounded="xl" 
            elevation="8"
            class="text-center"
          >
            <v-card-text class="py-4">
              <v-icon size="40" class="mb-2">mdi-scale-balance</v-icon>
              <div class="text-h6">Balance</div>
              <div class="text-h4 font-weight-bold">
                ${{ Number(balance?.balance_usd || 0).toFixed(2) }}
              </div>
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>

      <!-- GRÁFICAS -->
      <v-row>
        <v-col cols="12" md="6">
          <v-card height="280" rounded="xl" color="white">
            <v-card-title class="text-grey-darken-3 text-center">Ingresos vs Egresos</v-card-title>
            <v-card-text style="height: 220px">
              <Doughnut
                v-if="chartDataBalance"
                :data="chartDataBalance"
                :options="chartOptionsBalance"
              />
            </v-card-text>
          </v-card>
        </v-col>

<v-col cols="12" md="6">
          <v-card height="280" class="d-flex flex-column align-center justify-center" :color="colorMargen" rounded="xl">
            <v-card-text class="text-center">
              <div class="text-h6 mb-2">Margen de Ganancia</div>
              <div class="text-h1 font-weight-bold">
                {{ Math.round(Number(balance?.margen_porcentaje || 0)) }}%
              </div>
              <div class="text-caption mt-2">
              (Ingresos - Egresos) / Ingresos × 100
            </div>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>

    <!-- Morosidad dentro de Balance -->

</v-sheet>

    <!-- ===== SECCIÓN: ACADÉMICO ===== -->
    <v-sheet class="mb-4 pa-3" color="blue-grey-lighten-5" rounded="lg">
      <div class="text-h6 text-grey-darken-3 mb-3">
        <v-icon start color="info">mdi-chart-bar</v-icon>
        Morosidad
      </div>

      <v-row class="mb-4" align="stretch">
        <v-col cols="12" sm="6" md="4">
          <v-card color="white" rounded="xl" elevation="8">
            <v-card-text class="text-center py-4">
              <v-icon size="40" color="primary" class="mb-2">mdi-account-group</v-icon>
              <div class="text-h6 text-grey-darken-3">Total Estudiantes</div>
              <div class="text-h4 font-weight-bold text-primary">
                {{ morosidad?.total_estudiantes || 0 }}
              </div>
            </v-card-text>
          </v-card>
        </v-col>

        <v-col cols="12" sm="6" md="4">
          <v-card color="white" rounded="xl" elevation="8">
            <v-card-text class="text-center py-4">
              <v-icon size="40" color="warning" class="mb-2">mdi-account-alert</v-icon>
              <div class="text-h6 text-grey-darken-3">Estudiantes Morosos</div>
              <div class="text-h4 font-weight-bold text-warning">
                {{ morosidad?.estudiantes_morosos || 0 }}
              </div>
            </v-card-text>
          </v-card>
        </v-col>

        <v-col cols="12" sm="6" md="4">
          <v-card color="white" rounded="xl" elevation="8">
            <v-card-text class="text-center py-4">
              <v-icon size="40" :color="colorTasaMorosos" class="mb-2">mdi-percent</v-icon>
              <div class="text-h6 text-grey-darken-3">Tasa Morosidad</div>
              <div class="text-h4 font-weight-bold" :class="`text-${colorTasaMorosos}`">
                {{ Number(morosidad?.tasa_morosidad || 0).toFixed(1) }}%
              </div>
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
    </v-sheet>

    <!-- ===== SECCIÓN: RETENCIÓN ===== -->
    <v-sheet class="mb-4 pa-3" color="green-lighten-5" rounded="lg">
      <div class="text-h6 text-grey-darken-3 mb-3">
        <v-icon start color="success">mdi-account-check</v-icon>
        Retención de Estudiantes
      </div>

      <v-row class="mb-3">
        <v-col cols="12" sm="6" md="3">
          <v-card color="white" rounded="xl" elevation="8">
            <v-card-text class="text-center py-4">
              <v-icon size="40" color="primary" class="mb-2">mdi-account-clock</v-icon>
              <div class="text-h6 text-grey-darken-3">Est. Anterior</div>
              <div class="text-h4 font-weight-bold text-primary">
                {{ retencion?.estudiantes_anterior || 0 }}
              </div>
            </v-card-text>
          </v-card>
        </v-col>

        <v-col cols="12" sm="6" md="3">
          <v-card color="white" rounded="xl" elevation="8">
            <v-card-text class="text-center py-4">
              <v-icon size="40" color="info" class="mb-2">mdi-account-multiple</v-icon>
              <div class="text-h6 text-grey-darken-3">Est. Actual</div>
              <div class="text-h4 font-weight-bold text-info">
                {{ retencion?.estudiantes_actual || 0 }}
              </div>
            </v-card-text>
          </v-card>
        </v-col>

        <v-col cols="12" sm="6" md="3">
          <v-card color="white" rounded="xl" elevation="8">
            <v-card-text class="text-center py-4">
              <v-icon size="40" :color="colorRetenidos" class="mb-2">mdi-account-multiple-check</v-icon>
              <div class="text-h6 text-grey-darken-3">Retenidos</div>
              <div class="text-h4 font-weight-bold" :class="`text-${colorRetenidos}`">
                {{ retencion?.estudiantes_retenidos || 0 }}
              </div>
            </v-card-text>
          </v-card>
        </v-col>

        <v-col cols="12" sm="6" md="3">
          <v-card color="white" rounded="xl" elevation="8">
            <v-card-text class="text-center py-4">
              <v-icon size="40" :color="colorRetencion" class="mb-2">mdi-percent</v-icon>
              <div class="text-h6 text-grey-darken-3">Tasa Retención</div>
              <div class="text-h4 font-weight-bold" :class="`text-${colorRetencion}`">
                {{ Number(retencion?.tasa_retencion || 0).toFixed(1) }}%
              </div>
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
    </v-sheet>

    <!-- ===== SECCIÓN: ACADÉMICO ===== -->
    <v-sheet class="mb-4 pa-3" color="blue-grey-lighten-5" rounded="lg">
      <div class="text-h6 text-grey-darken-3 mb-3">
          <v-icon start color="info">mdi-chart-bar</v-icon>
          Indicadores Académicos
        </div>

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

    <!-- Retención dentro de Académico -->
  

    <!-- ===== CHARTS ===== -->
    <v-row>
      <!-- BAR + LINE -->
      <v-col cols="12" md="6">
        <v-card height="300" rounded="xl" color="white">
          <v-card-text style="height: 260px">
            <Bar :data="chartDataBarLine" :options="chartOptionsBarLine" />
          </v-card-text>
        </v-card>
      </v-col>

      <!-- DOUGHNUT -->
      <v-col cols="12" md="6">
        <v-card height="300" rounded="xl" color="white">
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
    </v-sheet>
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
      // Balance
      balance: null,
      fechaInicio: "",
      fechaFin: "",
      loadingBalance: false,
      // Morosidad
      morosidad: null,
      // Retención
      retencion: null,
    };
  },

  computed: {
    colorMargen() {
      const porcentaje = Number(this.balance?.margen_porcentaje || 0);
      if (porcentaje < 5) return "error";       // rojo: < 5%
      if (porcentaje < 10) return "warning";   // amarillo: 5-9%
      return "success";                        // verde: >= 10%
    },
    
    colorTasaMorosos() {
      const tasa = Number(this.morosidad?.tasa_morosidad || 0);
      if (tasa > 15) return "error";       // rojo: > 15%
      if (tasa > 10) return "warning";   // amarillo: 10-15%
      return "success";                  // verde: <= 10%
    },
    
    colorRetencion() {
      const tasa = Number(this.retencion?.tasa_retencion || 0);
      if (tasa < 70) return "error";      // rojo: < 70%
      if (tasa < 85) return "warning";  // amarillo: 70-84%
      return "success";                 // verde: >= 85%
    },
    
    colorRetenidos() {
      const tasa = Number(this.retencion?.tasa_retencion || 0);
      if (tasa < 70) return "error";
      if (tasa < 85) return "warning";
      return "success";
    },
    
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
          legend: { labels: { color: "#333" } },
          title: {
            display: true,
            text: "Inscripciones por período",
            color: "#333",
          },
        },
        scales: {
          x: { ticks: { color: "#333" } },
          y: { ticks: { color: "#333" } },
        },
      };
    },

    chartDataBalance() {
      if (!this.balance) return null;
      return {
        labels: ["Ingresos", "Egresos"],
        datasets: [
          {
            data: [
              Number(this.balance.ingresos_usd || 0),
              Number(this.balance.egresos_usd || 0)
            ],
            backgroundColor: ["#4CAF50", "#F44336"],
          },
        ],
      };
    },

    chartOptionsBalance() {
      return {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            position: "bottom",
            labels: { color: "#333" },
          },
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
            labels: { color: "#333" },
          },
        },
      };
    },
  },

  async mounted() {
    // Fechas por defecto: año actual
    const año = new Date().getFullYear();
    this.fechaInicio = `${año}-01-01`;
    this.fechaFin = `${año}-12-31`;
    
    await this.obtenerDatosMain();
    this.obtenerEstudiantes();
    this.obtenerBalance();
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

    async obtenerBalance() {
      if (!this.fechaInicio || !this.fechaFin) return;
      
      this.loadingBalance = true;
      try {
        const params = new URLSearchParams({
          fecha_ini: this.fechaInicio,
          fecha_fin: this.fechaFin
        });
        
        // Balance
        const resBalance = await newGoalService.getBalanceRango(params);
        this.balance = resBalance.data;
        
        // Morosidad
        const resMorosidad = await newGoalService.getMorosidadRango(params);
        this.morosidad = resMorosidad.data;
        
        // Retención
        const resRetencion = await newGoalService.getRetencionRango(params);
        this.retencion = resRetencion.data;
      } catch (error) {
        console.error(error);
      } finally {
        this.loadingBalance = false;
      }
    },
  },
};
</script>
