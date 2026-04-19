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
        <v-btn color="success" type="submit">Registrar</v-btn>
      </v-form>
    </v-card>
  </v-container>
</template>

<script>
import newGoalService from "@/services/newGoalService";
export default {
  data: () => ({
    tasa_bolivares: null
  }),

  methods: {
    async registrarTasa() {
      try {
        const res = await newGoalService.postTasa({tasaBolivares: this.tasa_bolivares});
        console.log(typeof(this.tasa))
        this.$emit("actualizarTasa");
        console.log(res);
      } catch (error) {
        console.log(error);
      }
    },
  },
};
</script>
