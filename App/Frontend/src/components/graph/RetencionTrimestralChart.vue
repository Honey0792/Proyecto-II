<template>
  <v-card height="300" rounded="xl" color="white">
    <v-card-title class="text-grey-darken-3 text-center">
      Retención Trimestral
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
      
      const labels = this.datos.map(d => d.trimestre_actual || d.trimestre);
      const anterior = this.datos.map(d => Number(d.estudiantes_anterior || 0));
      const actual = this.datos.map(d => Number(d.estudiantes_actual || 0));
      const tasa = this.datos.map(d => Number(d.tasa_retencion || 0));

      return {
        labels,
        datasets: [
          {
            type: "bar",
            label: "Est. Anterior",
            data: anterior,
            backgroundColor: "#9E9E9E",
            order: 2,
          },
          {
            type: "bar",
            label: "Est. Actual",
            data: actual,
            backgroundColor: "#2196F3",
            order: 1,
          },
          {
            type: "line",
            label: "Tasa %",
            data: tasa,
            borderColor: this.getColorTasa(tasa),
            backgroundColor: this.getColorTasa(tasa),
            tension: 0.3,
            order: 0,
            pointRadius: 5,
            yAxisID: 'y1',
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
          y: { 
            ticks: { color: "#333" },
            type: 'linear',
            display: true,
            position: 'left',
          },
          y1: {
            type: 'linear',
            display: true,
            position: 'right',
            grid: {
              drawOnChartArea: false,
            },
            ticks: { color: "#333" },
            title: {
              display: true,
              text: '%'
            }
          },
        },
      };
    },
  },

  methods: {
    getColorTasa(tasaArray) {
      if (!tasaArray || tasaArray.length === 0) return "#4CAF50";
      const tasa = tasaArray[0] || 0;
      if (tasa < 70) return "#F44336";      // rojo
      if (tasa < 85) return "#FF9800";      // amarillo
      return "#4CAF50";                    // verde
    },
    
    async obtenerDatos() {
      this.loading = true;
      try {
        const params = new URLSearchParams({ anio: this.anio });
        const res = await newGoalService.getRetencionTrimestral(params);
        this.datos = res.data;
      } catch (error) {
        console.error("Error obteniendo retención trimestral:", error);
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
