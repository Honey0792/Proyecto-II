<template>
  <v-card class="mx-auto" max-width="300">
    <v-list
      :items="representante"
      item-title="nombre_rt"
      item-value="id_rt"
    >
    </v-list>
  </v-card>
</template>

<script>
import newGoalService from '@/services/newGoalService';

export default {
  data: () => ({
    representante: [],
  }),
  methods: {
    async obtenerRepresentantes() {
      try {
        const res = await newGoalService.getRepresentante();
        this.representante = res.data.datos;
        console.log(this.representante);
      } catch (error) {
        console.log(error);
      }
    },
  },
  mounted() {
 this.obtenerRepresentantes()
  },
};
</script>
