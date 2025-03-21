<template>
<v-expansion-panels>
  <v-expansion-panel
    title="Registrar Perido"
  >
  <v-expansion-panel-content>
  <RegPeriodo/>
</v-expansion-panel-content>
  </v-expansion-panel>
</v-expansion-panels>
</template>

<script>
import RegPeriodo from '@/components/Forms/RegPeriodo.vue';
export default {
    components:{
        RegPeriodo,},
}
</script>