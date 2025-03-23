<template>
  <div class="d-flex justify-center my-7">
  <RegPeriodo />
</div>
</template>

<script>
import RegPeriodo from "@/components/Forms/RegPeriodo.vue";
import TablaPeriodos from "@/components/Tables/tablaPeriodos.vue";
export default {
  components: {
    RegPeriodo,
    TablaPeriodos
  },
};
</script>
