<template>
 <v-tabs
        v-model="tab"
      >
        <v-tab value="one">Pagos</v-tab>
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
}
</script>