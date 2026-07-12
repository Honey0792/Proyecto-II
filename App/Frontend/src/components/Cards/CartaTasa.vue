<template>
  <v-container grid-list-xs>
    <v-card class="align-center justify-center">
      <v-form class="ma-8" @submit.prevent="registrarTasa">
        <v-text-field
          variant="outlined"
          type="number"
          label="Tasa Cambiaria"
          hint="Ingrese la tasa Cambiaria del Dia aqui"
          v-model.number="tasa_bolivares"
        ></v-text-field>

        <div class="d-flex ga-2 mb-4">
          <v-btn
            color="blue-darken-1"
            variant="tonal"
            :loading="cargandoDolar"
            @click="obtenerTasaBCV('USD')"
          >
            <v-icon start>mdi-currency-usd</v-icon>
            Dólar BCV
          </v-btn>
          <v-btn
            color="amber-darken-1"
            variant="tonal"
            :loading="cargandoEuro"
            @click="obtenerTasaBCV('EUR')"
          >
            <v-icon start>mdi-currency-eur</v-icon>
            Euro BCV
          </v-btn>
        </div>

        <v-btn color="success" type="submit">Registrar</v-btn>
      </v-form>
    </v-card>
  </v-container>
</template>

<script>
import newGoalService from "@/services/newGoalService";

const API_BASE = "https://rates.dolarvzla.com/bcv";

export default {
  data: () => ({
    tasa_bolivares: null,
    cargandoDolar: false,
    cargandoEuro: false,
  }),

  methods: {
    async obtenerTasaBCV(moneda) {
      const esDolar = moneda === "USD";
      const loadingKey = esDolar ? "cargandoDolar" : "cargandoEuro";
      this[loadingKey] = true;

      try {
        const res = await fetch(`${API_BASE}/current.json`);
        const data = await res.json();

        const tasa = esDolar ? data.current.usd : data.current.eur;
        if (tasa) {
          this.tasa_bolivares = Number(tasa.toFixed(2));
        }
      } catch (error) {
        console.error(`Error obteniendo tasa ${moneda}:`, error);
      } finally {
        this[loadingKey] = false;
      }
    },

    async registrarTasa() {
      try {
        const res = await newGoalService.postTasa({tasaBolivares: this.tasa_bolivares});
        this.$emit("actualizarTasa");
        console.log(res);
      } catch (error) {
        console.log(error);
      }
    },
  },
};
</script>
