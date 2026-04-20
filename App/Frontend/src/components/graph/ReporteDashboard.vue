<template>
  <v-card v-if="mostrar" class="pdf-generator">
    <v-card-title class="d-flex justify-space-between align-center">
      <span>Reporte de Indicadores</span>
      <v-btn icon="mdi-close" variant="text" @click="cerrar"></v-btn>
    </v-card-title>

    <v-card-text>
      <v-row justify="end" class="mb-4">
        <v-btn color="red-darken-1" variant="tonal" @click="generarPDFReport">
          <v-icon start>mdi-file-pdf-box</v-icon>
          Descargar PDF
        </v-btn>
      </v-row>

      <!-- Contenedor oculto para PDF -->
      <div ref="reporteContainer" class="reporte-container">
    <!-- Header -->
    <div class="reporte-header">
      <h1>Reporte de Indicadores</h1>
      <p>{{ fechaReporte }}</p>
    </div>

    <!-- Balance Financiero -->
    <div class="seccion">
      <h2>Balance Financiero</h2>
      <table class="tabla-datos">
        <tbody>
          <tr>
            <td>Ingresos</td>
            <td class="numero"><span>$</span>{{ formatNumber(balance?.ingresos_usd || 0, 2) }}</td>
          </tr>
          <tr>
            <td>Egresos</td>
            <td class="numero"><span>$</span>{{ formatNumber(balance?.egresos_usd || 0, 2) }}</td>
          </tr>
          <tr>
            <td>Balance</td>
            <td class="numero" :class="(balance?.balance_usd || 0) >= 0 ? 'positivo' : 'negativo'">
              <span>$</span>{{ formatNumber(balance?.balance_usd || 0, 2) }}
            </td>
          </tr>
          <tr>
            <td>Margen</td>
            <td class="numero">{{ formatNumber(balance?.margen_porcentaje || 0, 1) }}%</td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Morosidad -->
    <div class="seccion">
      <h2>Morosidad</h2>
      <table class="tabla-datos">
        <tbody>
          <tr>
            <td>Total Estudiantes</td>
            <td class="numero">{{ morosidad?.total_estudiantes || 0 }}</td>
          </tr>
          <tr>
            <td>Estudiantes Morosos</td>
            <td class="numero">{{ morosidad?.estudiantes_morosos || 0 }}</td>
          </tr>
          <tr>
            <td>Tasa Morosidad</td>
            <td class="numero">{{ formatNumber(morosidad?.tasa_morosidad || 0, 1) }}%</td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Retención -->
    <div class="seccion">
      <h2>Retención de Estudiantes</h2>
      <table class="tabla-datos">
        <tbody>
          <tr>
            <td>Estudiantes Anterior</td>
            <td class="numero">{{ retencion?.estudiantes_anterior || 0 }}</td>
          </tr>
          <tr>
            <td>Estudiantes Actual</td>
            <td class="numero">{{ retencion?.estudiantes_actual || 0 }}</td>
          </tr>
          <tr>
            <td>Estudiantes Retenidos</td>
            <td class="numero">{{ retencion?.estudiantes_retenidos || 0 }}</td>
          </tr>
          <tr>
            <td>Tasa Retención</td>
            <td class="numero">{{ formatNumber(retencion?.tasa_retencion || 0, 1) }}%</td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Indicadores Académicos -->
    <div class="seccion">
      <h2>Indicadores Académicos</h2>
      <table class="tabla-datos">
        <tbody>
          <tr>
            <td>Total Estudiantes</td>
            <td class="numero">{{ estudiantes.length }}</td>
          </tr>
          <tr>
            <td>Total Inscripciones</td>
            <td class="numero">{{ totalInscripciones }}</td>
          </tr>
          <tr>
            <td>Último Período</td>
            <td>{{ latestPeriodo?.nombre_periodo || '---' }}</td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Gráficas -->
    <div class="seccion">
      <h2>Gráficas</h2>
      <div class="graficas-row">
        <div class="grafica"><canvas ref="chartBalanceTrimestral"></canvas></div>
        <div class="grafica"><canvas ref="chartRetencionTrimestral"></canvas></div>
        <div class="grafica"><canvas ref="chartInscripciones"></canvas></div>
        <div class="grafica"><canvas ref="chartEdad"></canvas></div>
      </div>
      </div>
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
  ArcElement,
  DoughnutController,
} from "chart.js";

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
  props: {
    generarPDF: { type: Boolean, default: false },
    datosBalance: { type: Object, default: null },
    datosMorosidad: { type: Object, default: null },
    datosRetencion: { type: Object, default: null },
    datosMain: { type: Array, default: () => [] },
    estudiantes: { type: Array, default: () => [] },
  },

  data() {
    return {
      mostrar: true,
      selectedPeriodoId: null,
      anioSeleccionado: new Date().getFullYear(),
      charts: {},
      datosCargados: false,
    };
  },

  computed: {
    fechaReporte() {
      return new Date().toLocaleDateString('es-ES', {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
      });
    },

    balance() {
      return this.datosBalance || {};
    },

    morosidad() {
      return this.datosMorosidad || {};
    },

    retencion() {
      return this.datosRetencion || {};
    },

    latestPeriodo() {
      return this.datosMain.length
        ? [...this.datosMain].sort((a, b) => b.id_periodo - a.id_periodo)[0]
        : null;
    },

    totalInscripciones() {
      return this.datosMain.reduce((sum, p) => sum + Number(p.total_inscripciones), 0);
    },

    chartDataBalanceTrimestral() {
      return {
        labels: ['T1', 'T2', 'T3', 'T4'],
        datasets: [
          {
            type: 'bar',
            label: 'Ingresos',
            data: [],
            backgroundColor: '#4CAF50',
          },
          {
            type: 'bar',
            label: 'Egresos',
            data: [],
            backgroundColor: '#F44336',
          },
          {
            type: 'line',
            label: 'Balance',
            data: [],
            borderColor: '#2196F3',
            backgroundColor: '#2196F3',
            tension: 0.3,
          },
        ],
      };
    },

    chartDataRetencionTrimestral() {
      return {
        labels: ['T1', 'T2', 'T3', 'T4'],
        datasets: [
          {
            type: 'bar',
            label: 'Est. Anterior',
            data: [],
            backgroundColor: '#2196F3',
          },
          {
            type: 'bar',
            label: 'Est. Actual',
            data: [],
            backgroundColor: '#4CAF50',
          },
          {
            type: 'line',
            label: 'Tasa Retención',
            data: [],
            borderColor: '#FF9800',
            backgroundColor: '#FF9800',
            tension: 0.3,
          },
        ],
      };
    },

    chartDataBarLine() {
      const sorted = [...this.datosMain].sort((a, b) => a.id_periodo - b.id_periodo);
      return {
        labels: sorted.map((p) => p.nombre_periodo),
        datasets: [
          {
            type: 'bar',
            label: 'Inscripciones',
            data: sorted.map((p) => Number(p.total_inscripciones)),
            backgroundColor: '#00BCD4',
          },
          {
            type: 'line',
            label: 'Mayores de edad',
            data: sorted.map((p) => Number(p.mayores_edad)),
            borderColor: '#4CAF50',
            backgroundColor: '#4CAF50',
            tension: 0.3,
          },
        ],
      };
    },

    chartDataDoughnut() {
      if (!this.selectedPeriodoId) return null;
      const p = this.datosMain.find((x) => x.id_periodo === this.selectedPeriodoId);
      if (!p) return null;
      return {
        labels: ['Mayores de edad', 'Menores de edad'],
        datasets: [
          {
            data: [Number(p.mayores_edad), Number(p.menores_edad)],
            backgroundColor: ['#4CCFE0', '#E08D4C'],
          },
        ],
      };
    },
  },

  watch: {
    datosMain: {
      handler() {
        this.$nextTick(() => {
          setTimeout(() => this.inicializarGraficas(), 300);
        });
      },
      immediate: true
    },
  },

  watch: {
    generarPDF: {
      async handler(val) {
        if (val && this.datosCargados) {
          await this.generarPDFReport();
        }
      }
    }
  },

  async mounted() {
    console.log('ReporteDashboard mounted');
    console.log('datosBalance:', this.datosBalance);
    console.log('datosMorosidad:', this.datosMorosidad);
    console.log('datosRetencion:', this.datosRetencion);
    console.log('datosMain:', this.datosMain);
    console.log('estudiantes:', this.estudiantes);
    console.log('selectedPeriodoId:', this.selectedPeriodoId);
    
    await this.cargarDatos();
    await this.$nextTick();
    await new Promise((r) => setTimeout(r, 300));
    this.datosCargados = true;
    
    console.log('Canvas refs:', {
      chartInscripciones: this.$refs.chartInscripciones,
      chartEdad: this.$refs.chartEdad
    });
    
    // Inicializar las gráficas
    this.inicializarGraficas();

    if (this.generarPDF) {
      this.$nextTick(() => this.generarPDFReport());
    }
  },

  methods: {
    formatNumber(value, decimals = 0) {
      if (value === null || value === undefined) return '0';
      return Number(value).toLocaleString('es-ES', {
        minimumFractionDigits: decimals,
        maximumFractionDigits: decimals,
      });
    },

    async cargarDatos() {
      // Los datos ya vienen por props del dashboard
      // Solo necesitamos configurar el selectedPeriodoId
      if (this.datosMain && this.datosMain.length) {
        this.selectedPeriodoId = this.latestPeriodo?.id_periodo;
      }
      this.datosCargados = true;
    },

    inicializarGraficas() {
      console.log('inicializarGraficas called');
      console.log('refs:', {
        chartBalanceTrimestral: this.$refs.chartBalanceTrimestral,
        chartRetencionTrimestral: this.$refs.chartRetencionTrimestral,
        chartInscripciones: this.$refs.chartInscripciones,
        chartEdad: this.$refs.chartEdad
      });
      console.log('datosMain:', this.datosMain);
      console.log('chartDataBarLine:', this.chartDataBarLine);
      console.log('chartDataDoughnut:', this.chartDataDoughnut);
      
      // Balance Trimestral
      if (this.$refs.chartBalanceTrimestral) {
        this.charts.balance = new Chart(this.$refs.chartBalanceTrimestral, {
          type: 'bar',
          data: {
            labels: ['Ene - Mar', 'Abr - Jun', 'Jul - Sep', 'Oct - Dic'],
            datasets: [
              { type: 'bar', label: 'Ingresos', data: [100, 50, 0, 0], backgroundColor: '#4CAF50' },
              { type: 'bar', label: 'Egresos', data: [0, 0, 0, 0], backgroundColor: '#F44336' },
              { type: 'line', label: 'Balance', data: [100, 50, 0, 0], borderColor: '#2196F3' }
            ]
          },
options: { 
            responsive: true, 
            maintainAspectRatio: false,
            animation: false,
            plugins: { legend: { position: 'bottom', labels: { boxWidth: 10, font: { size: 9 } } } },
            layout: { padding: 5 }
          }
        });
      }

      // Retención Trimestral
      if (this.$refs.chartRetencionTrimestral) {
        this.charts.retencion = new Chart(this.$refs.chartRetencionTrimestral, {
          type: 'bar',
          data: {
            labels: ['T1→T2', 'T2→T3', 'T3→T4'],
            datasets: [
              { type: 'bar', label: 'Retenidos', data: [1, 0, 0], backgroundColor: '#4CAF50' },
              { type: 'line', label: 'Tasa %', data: [100, 0, 0], borderColor: '#FF9800', tension: 0.3, yAxisID: 'y1' }
            ]
          },
options: { 
            responsive: true, 
            maintainAspectRatio: false,
            animation: false,
            plugins: { legend: { position: 'bottom', labels: { boxWidth: 10, font: { size: 9 } } },
            layout: { padding: 5 }
          }
          }
        });
      }
      
      // Inscripciones por período (Bar + Line)
      if (this.$refs.chartInscripciones && this.chartDataBarLine) {
        console.log('Creating inscripciones chart');
        this.charts.inscripciones = new Chart(this.$refs.chartInscripciones, {
          type: 'bar',
          data: this.chartDataBarLine,
          options: {
            responsive: true,
            maintainAspectRatio: false,
            animation: false,
            plugins: { legend: { position: 'bottom', labels: { boxWidth: 10, font: { size: 9 } } } },
            scales: { x: { ticks: { font: { size: 8 } } }, y: { ticks: { font: { size: 8 } } } },
            layout: { padding: 5 }
          },
        });
      }

      // Distribución por edad (Doughnut)
      if (this.$refs.chartEdad && this.chartDataDoughnut) {
        console.log('Creating edad chart');
        this.charts.edad = new Chart(this.$refs.chartEdad, {
          type: 'doughnut',
          data: this.chartDataDoughnut,
          options: {
            responsive: true,
            maintainAspectRatio: false,
            animation: false,
            plugins: { legend: { position: 'bottom', labels: { boxWidth: 10, font: { size: 9 } } } },
            layout: { padding: 5 }
          },
        });
      }
    },

    cerrar() {
      this.$emit('cerrar');
    },

    async generarPDFReport() {
      try {
        const html2pdf = (await import('html2pdf.js')).default;

        const elemento = this.$refs.reporteContainer;

        const opciones = {
          margin: [10, 10, 10, 10],
          filename: `reporte-indicadores-${this.anioSeleccionado}.pdf`,
          image: { type: 'jpeg', quality: 0.98 },
          html2canvas: { scale: 2, useCORS: true, logging: false },
          jsPDF: { unit: 'mm', format: 'a4', orientation: 'portrait' },
          pagebreak: { mode: ['avoid-all', 'css', 'legacy'] },
        };

        await html2pdf().set(opciones).from(elemento).save();

        this.$emit('pdf-generado');
      } catch (error) {
        console.error('Error al generar PDF:', error);
      }
    },
  },
};
</script>

<style scoped>
.reporte-container {
  padding: 15px;
  background: white;
  max-width: 190mm;
  margin: 0 auto;
  font-family: Arial, sans-serif;
  box-sizing: border-box;
}

.reporte-header {
  text-align: center;
  margin-bottom: 30px;
  border-bottom: 2px solid #333;
  padding-bottom: 15px;
}

.reporte-header h1 {
  margin: 0;
  font-size: 24px;
  color: #333;
}

.reporte-header p {
  margin: 5px 0 0;
  color: #666;
}

.seccion {
  margin-bottom: 25px;
  page-break-inside: avoid;
}

.seccion h2 {
  font-size: 16px;
  color: #333;
  margin-bottom: 10px;
  border-bottom: 1px solid #ccc;
  padding-bottom: 5px;
}

.tabla-datos {
  width: 100%;
  border-collapse: collapse;
  font-size: 14px;
}

.tabla-datos td {
  padding: 8px 12px;
  border: 1px solid #ddd;
}

.tabla-datos tr:nth-child(odd) {
  background: #f9f9f9;
}

.tabla-datos .numero {
  text-align: right;
  font-weight: bold;
}

.tabla-datos .positivo {
  color: #2e7d32;
}

.tabla-datos .negativo {
  color: #c62828;
}

.graficas-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 10px;
}

.grafica {
  width: 100%;
  height: 180px;
  border: 1px solid #ddd;
  padding: 8px;
  display: block;
  box-sizing: border-box;
  margin-bottom: 8px;
}

.grafica canvas {
  max-width: 100%;
  max-height: 100%;
}

.pdf-generator {
  background: #f5f5f5;
  min-height: 100vh;
}
</style>