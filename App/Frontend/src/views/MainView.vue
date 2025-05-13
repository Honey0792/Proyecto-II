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
        <v-card
          class="mx-auto text-center"
          color="green"
          max-width="600"
          height="231"
          dark
        >
          <v-card-text>
            <v-sheet color="rgba(0, 0, 0, .12)">
              <v-sparkline
                :model-value="value"
                color="rgba(255, 255, 255, .7)"
                height="100"
                padding="24"
                stroke-linecap="round"
                smooth
              >
                <template v-slot:label="item"> ${{ item.value }} </template>
              </v-sparkline>
            </v-sheet>
          </v-card-text>
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
        <v-card variant="" class="mx-auto" width="600">
          <v-data-table-virtual
            height="231"
            :items="estudiantes"
            :headers
            fixed-header
          ></v-data-table-virtual>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import TablaEstudiantes from "@/components/Tables/tablaEstudiantes.vue";
import newGoalService from "@/services/newGoalService";

export default {
  data: () => ({
    estudiantes: [],
    itemsToShow: 10,
    alert: { show: false, message: "" },
    headers: [
      // { title: "Orden", key: "id_etd" }, // Columna para el estado
      // { title: "Estado", key: "estado" }, // Columna para el estado
      { title: "Nombre", key: "nombre_etd" }, // Columna para el nombre
      { title: "Apellido", key: "apellido_etd" }, // Columna para el apellido
      { title: "Correo", key: "correo_etd" }, // Columna para el correo
      { title: "Cedula", key: "cedula_etd" }, // Columna para el correo
      // Agrega más columnas según los datos que tengas
    ],
  }),
  components: {
    TablaEstudiantes,
  },
  methods: {
    async obtenerEstudiantes() {
      try {
        const res = await newGoalService.getEstudiante();
        this.estudiantes = res.data;
        console.log(this.estudiantes);
      } catch (error) {
        console.log(error);
      }
    },
  },
  computed: {
    limitedItems() {
      return this.estudiantes.slice(0, this.itemsToShow);
    },
  },
  mounted() {
    this.obtenerEstudiantes();
  },
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
