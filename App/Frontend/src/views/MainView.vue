<template>
  <v-dialog
    v-model="alert.show"
    width="auto"
    class="justify-center align-center"
  >
    <v-alert
      v-model="alert.show"
      :color="alert.color"
      variant="elevated"
      prominent
      closable
      width="400px"
      >{{ alert.message }}</v-alert
    >
  </v-dialog>
  <v-container class="ga-4">
    <v-row class="pa-6">
      <v-col>
        <v-card variant="tonal" class="mx-auto" width="600" height="231">
        </v-card>
      </v-col>
      <v-col>
        <v-card variant="tonal" class="mx-auto" width="300" height="231">
        </v-card>
      </v-col>
    </v-row>
    <v-row class="pa-6">
      <v-col>
        <v-card variant="tonal" class="mx-auto" width="300" height="231">
        </v-card>
      </v-col>
      <v-col>
        <v-card variant="" class="mx-auto" width="600" height="231">
          <!-- <div class="scroll-overlay">
        <TablaEstudiantes />
      </div> -->
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import TablaEstudiantes from "@/components/Tables/tablaEstudiantes.vue";

export default {
  data: () => ({
    alert: { show: false, message: "" },
  }),
  components: {
    TablaEstudiantes,
  },
  methods: {},
};
</script>

<style scoped>
.scroll-overlay {
  height: 100%;
  overflow-y: overlay; /* Scroll superpuesto */
  padding-right: 8px; /* Compensa el espacio del scroll */
}

/* Scrollbar transparente que solo se ve al hacer hover */
.scroll-overlay::-webkit-scrollbar {
  width: 10px;
  background: transparent;
}

.scroll-overlay:hover::-webkit-scrollbar-thumb {
  background: #888;
  border-radius: 4px;
}

/* Para penetrar en el componente hijo (tabla) */
.scroll-overlay :deep(.v-data-table) {
  margin-right: -8px; /* Compensación del padding */
}
</style>
