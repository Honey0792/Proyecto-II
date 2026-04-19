<template>
  <v-card height="300" rounded="xl" color="white">
    <v-card-title class="text-grey-darken-3 text-center">
      Balance Trimestral
    </v-card-title>
    <v-card-text style="height: 220px">
      <Bar v-if="chartData" :data="chartData" :options="chartOptions" />
      <div v-else class="d-flex align-center justify-center fill-height">
        <span class="text-grey">Sin datos para mostrar</span>
      </div>
    </v-card-text>
  </v-card>
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
} from "chart.js";
import { Bar } from "vue-chartjs";
import newGoalService from "@/services/newGoalService";

Chart.register(
  Title,
  Tooltip,
  Legend,
  BarElement,
  LineElement,
  CategoryScale,
  LinearScale,
  PointElement
);

export default {
  components: { Bar },
  
  props: {
    anio: {
      type: [String, Number],
      default: new Date().getFullYear()
    }
  },

  data() {
    return {
      datos: [],
      loading: false,
    };
  },

  computed: {
    chartData() {
      if (!this.datos || this.datos.length === 0) return null;
      
      const labels = this.datos.map(d => d.trimestre);
      const ingresos = this.datos.map(d => Number(d.ingresos_usd || 0));
      const egresos = this.datos.map(d => Number(d.egresos_usd || 0));
      const bilan = this.datos.map(d => Number(d.balance_usd || 0));

      return {
        labels,
        datasets: [
          {
            type: "bar",
            label: "Ingresos",
            data: ingresos,
            backgroundColor: "#4CAF50",
            order: 1,
          },
          {
            type: "bar",
            label: "Egresos",
            data: egresos,
            backgroundColor: "#F44336",
            order: 2,
          },
          {
            type: "line",
            label: "Balance",
            data: bilan,
            borderColor: "#2196F3",
            backgroundColor: "#2196F3",
            tension: 0.3,
            order: 0,
            pointRadius: 5,
          },
        ],
      };
    },

    chartOptions() {
      return {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            position: "bottom",
            labels: { color: "#333" },
          },
        },
        scales: {
          x: { ticks: { color: "#333" } },
          y: { ticks: { color: "#333" } },
        },
      };
    },
  },

  methods: {
    async obtenerDatos() {
      this.loading = true;
      try {
        const params = new URLSearchParams({ anio: this.anio });
        const res = await newGoalService.getBalanceTrimestral(params);
        this.datos = res.data;
      } catch (error) {
        console.error("Error obteniendo balance trimestral:", error);
        this.datos = [];
      } finally {
        this.loading = false;
      }
    },
  },

  watch: {
    anio: {
      immediate: false,
      handler(newAnio) {
        if (newAnio) {
          this.obtenerDatos();
        }
      },
    },
  },

  mounted() {
    this.obtenerDatos();
  },
};
</script>
