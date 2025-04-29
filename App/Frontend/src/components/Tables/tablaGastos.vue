<template>
  <v-data-table :search="search" :items="gastos" :headers>
    <template v-slot:top>
      <v-text-field
        v-model="search"
        placeholder="Buscar"
        prepend-inner-icon="mdi-magnify"
        clearable
        density="compact"
        single-line
      ></v-text-field>
    </template>
    <template v-slot:item.id_gasto="{ item }"></template>
    <template v-slot:item.fecha_gasto="{ item }">
      {{ item.fecha_gasto.split("T")[0] }}
    </template>
    <template v-slot:item.actions="{ item }">
      <div class="d-flex ga-2 justify-end">
        <v-icon
          color="medium-emphasis"
          icon="mdi-pencil"
          size="small"
          @click="edita(item.id_gasto)"
        ></v-icon>
        <v-icon
          color="medium-emphasis"
          icon="mdi-eye"
          size="small"
          @click="ver(item.id_gasto)"
        ></v-icon>
        <v-icon
          color="medium-emphasis"
          icon="mdi-delete"
          size="small"
          @click="eliminar(item.id_gasto)"
        ></v-icon>
      </div>
    </template>
  </v-data-table>
  <v-dialog v-model="this.dialog_1">
    <v-icon
      icon="mdi-close"
      class="position-absolute right-0"
      color="white"
      @click="this.dialog_1 = false"
    ></v-icon>
    <CartaEditGasto :id="id_gasto" />
  </v-dialog>
  <v-dialog v-model="this.dialog_2">
    <v-icon
      icon="mdi-close"
      class="position-absolute right-0"
      color="white"
      @click="this.dialog_2 = false"
    ></v-icon>
    <CartaVerGasto :id="id_gasto" />
  </v-dialog>
  <v-dialog v-model="this.dialog_3" width="auto">
    <v-card
      max-width="400"
      prepend-icon="mdi-delete-alert"
      text="¿Estas Seguro/a de querer eliminar a este estdiante?"
      title="Oprimiste eliminar"
      color="warning"
    >
      <template v-slot:actions>
        <v-spacer></v-spacer>
        <v-btn
          class="ms-auto"
          text="Cancelar"
          @click="this.dialog_3 = false"
        ></v-btn>
        <v-btn class="ms-auto" text="Ok" @click="eliminarGasto"></v-btn>
      </template>
    </v-card>
  </v-dialog>
</template>

<script>
import newGoalService from "@/services/newGoalService";
import CartaEditGasto from "../Cards/CartaEditGasto.vue";
import CartaVerGasto from "../Cards/CartaVerGasto.vue";

export default {
  components: { CartaEditGasto, CartaVerGasto },
  data: () => ({
    search: null,
    dialog_1: false,
    dialog_2: false,
    dialog_3: false,
    id_gasto: null,
    gastos: [],
    headers: [
      { title: "Orden", align: "start", key: "id_gasto" },
      { title: "Nombre", align: "start", key: "nombre_gasto" },
      { title: "Tipo", align: "end", key: "nombre_tipo_gasto" },
      { title: "Metodo de pago", align: "end", key: "nombre_metodo_pago" },
      { title: "Fecha", align: "end", key: "fecha_gasto" },
      { title: "Acciones", align: "end", key: "actions" },
    ],
  }),
  methods: {
    async obtenerGastos() {
      try {
        const res = await newGoalService.getGastos();
        console.log(res);
        this.gastos = res.data;
      } catch (error) {
        console.log(error);
      }
    },

    async eliminarGasto() {
      const id = { id_gasto: this.id_gasto };
      try {
        const res = await newGoalService.deleteGasto(id);
        this.dialog_3 = false;
        this.obtenerGastos();
      } catch (error) {
        console.log(error);
      }
    },

    edita(id) {
      this.id_gasto = id;
      console.log(id);
      console.log("hola");
      this.dialog_1 = true;
    },

    ver(id) {
      this.id_gasto = id;
      console.log(id);
      this.dialog_2 = true;
    },
    eliminar(id) {
      this.id_gasto = id;
      console.log("hola");
      this.dialog_3 = true;
      console.log(id);
    },
  },

  mounted() {
    this.obtenerGastos();
  },
};
</script>
