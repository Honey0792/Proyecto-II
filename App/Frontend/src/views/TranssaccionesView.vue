<template>
 <v-tabs
        v-model="tab"
      >
        <v-tab value="one" v-show="mostrarPagos">Pagos</v-tab>
        <v-tab value="two">Gastos</v-tab>
      </v-tabs>
  
        <v-tabs-window v-model="tab">
          <v-tabs-window-item value="one">
            <RegPago />
          </v-tabs-window-item>
  
          <v-tabs-window-item value="two">
            <RegGasto />
          </v-tabs-window-item>
        </v-tabs-window>
</template>

<script>
import RegPago from '@/components/Forms/RegPago.vue'
import RegGasto from '@/components/Forms/RegGasto.vue'
export default{
    components:{
        RegGasto,
        RegPago
    },
 data: () => ({
      tab: null,
    }),
    computed: {
    mostrarPagos() {
      return sessionStorage.getItem("role") === '1';
    }
  },
  watch: {
    mostrarPagos(nuevoValor) {
      if (!nuevoValor) {
        this.tab = 'two';
      }
    }
  },
  mounted() {
    // Inicializar tab según rol al cargar el componente
    if (!this.mostrarPagos) {
      this.tab = 'two';
    }
  }
}
</script>