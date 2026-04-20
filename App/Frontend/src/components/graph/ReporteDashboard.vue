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

        <!-- Datos de Balance Trimestral -->
        <div class="seccion">
          <h2>Datos de Balance Trimestral</h2>
          <table class="tabla-datos">
            <thead>
              <tr><th>Trimestre</th><th>Ingresos</th><th>Egresos</th><th>Balance</th></tr>
            </thead>
            <tbody>
              <tr><td>Ene - Mar</td><td class="numero">$100.00</td><td class="numero">$0.00</td><td class="numero positivo">$100.00</td></tr>
              <tr><td>Abr - Jun</td><td class="numero">$50.00</td><td class="numero">$0.00</td><td class="numero positivo">$50.00</td></tr>
              <tr><td>Jul - Sep</td><td class="numero">$0.00</td><td class="numero">$0.00</td><td class="numero">$0.00</td></tr>
              <tr><td>Oct - Dic</td><td class="numero">$0.00</td><td class="numero">$0.00</td><td class="numero">$0.00</td></tr>
            </tbody>
          </table>
        </div>

        <div class="seccion">
          <h2>Datos de Retención Trimestral</h2>
          <table class="tabla-datos">
            <thead>
              <tr><th>Período</th><th>Retenidos</th><th>Tasa %</th></tr>
            </thead>
            <tbody>
              <tr><td>T1 → T2</td><td class="numero">1</td><td class="numero">100%</td></tr>
              <tr><td>T2 → T3</td><td class="numero">0</td><td class="numero">0%</td></tr>
              <tr><td>T3 → T4</td><td class="numero">0</td><td class="numero">0%</td></tr>
            </tbody>
          </table>
        </div>

        <div class="seccion">
          <h2>Inscripciones por Período</h2>
          <table class="tabla-datos">
            <thead>
              <tr><th>Período</th><th>Inscripciones</th><th>Mayores de edad</th></tr>
            </thead>
            <tbody>
              <tr v-for="p in datosMainSorted" :key="p.id_periodo">
                <td>{{ p.nombre_periodo }}</td>
                <td class="numero">{{ p.total_inscripciones }}</td>
                <td class="numero">{{ p.mayores_edad }}</td>
              </tr>
            </tbody>
          </table>
        </div>

        <div class="seccion">
          <h2>Distribución por Edad (Último Período)</h2>
          <table class="tabla-datos">
            <tbody>
              <tr><td>Mayores de edad</td><td class="numero">{{ latestPeriodo?.mayores_edad || 0 }}</td></tr>
              <tr><td>Menores de edad</td><td class="numero">{{ latestPeriodo?.menores_edad || 0 }}</td></tr>
            </tbody>
          </table>
        </div>
      </div>
    </v-card-text>
  </v-card>
</template>

<script>
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

    datosMainSorted() {
      return [...this.datosMain].sort((a, b) => a.id_periodo - b.id_periodo);
    },

    totalInscripciones() {
      return this.datosMain.reduce((sum, p) => sum + Number(p.total_inscripciones), 0);
    },
  },

  watch: {
    generarPDF: {
      async handler(val) {
        if (val) {
          await this.generarPDFReport();
        }
      }
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

    cerrar() {
      this.$emit('cerrar');
    },

    async generarPDFReport() {
      try {
        const html2pdf = (await import('html2pdf.js')).default;

        const elemento = this.$refs.reporteContainer;

        const opciones = {
          margin: [10, 10, 10, 10],
          filename: `reporte-indicadores-${new Date().getFullYear()}.pdf`,
          image: { type: 'jpeg', quality: 0.98 },
          html2canvas: { scale: 2, useCORS: true },
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

.tabla-datos th {
  padding: 8px 12px;
  border: 1px solid #ddd;
  background: #f5f5f5;
  text-align: left;
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

.pdf-generator {
  background: #f5f5f5;
  min-height: 100vh;
}
</style>