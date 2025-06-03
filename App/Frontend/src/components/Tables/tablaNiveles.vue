<template>
  <v-data-table :search :headers :items="niveles" :loading>
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
    <template v-slot:item.id_nivel="{item}"></template>
    <template v-slot:item.actions="{ item }">
      <div class="d-flex ga-2 justify-center">
        <v-icon
          color="medium-emphasis"
          icon="mdi-pencil"
          size="small"
          @click="edita(item.id_nivel)"
        ></v-icon>
        <v-icon
          color="medium-emphasis"
          icon="mdi-eye"
          size="small"
          @click="ver(item.id_nivel)"
        ></v-icon>
        <v-icon
          color="medium-emphasis"
          icon="mdi-delete"
          size="small"
          @click="eliminar(item.id_nivel)"
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
    <CartaEditNivel @actualizar_tabla="obtenerNiveles" :id="id_nivel" />
  </v-dialog>
  <v-dialog v-model="this.dialog_2">
    <v-icon
      icon="mdi-close"
      class="position-absolute right-0"
      color="white"
      @click="this.dialog_2 = false"
    ></v-icon>
    <CartaVerNivel :id="id_nivel" />
  </v-dialog>

  <v-dialog v-model="this.dialog_3" width="auto">
    <v-card
      max-width="400"
      prepend-icon="mdi-delete-alert"
      text="¿Estas Seguro/a de querer eliminar a este nivel?"
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
        <v-btn class="ms-auto" text="Ok" @click="eliminarNivel"></v-btn>
      </template>
    </v-card>
  </v-dialog>
</template>

<script>
import newGoalService from "@/services/newGoalService";
import CartaVerNivel from "../Cards/CartaVerNivel.vue";
import CartaEditNivel from "../Cards/CartaEditNivel.vue";

export default {
  components: {
    CartaEditNivel,
    CartaVerNivel,
  },
  data: () => ({
    id_nivel: null,
    search: "",
    dialog_1: null,
    dialog_2: null,
    dialog_3: null,
    niveles: [],
    loading: true,
    headers: [
      { title: "Orden", align: "center", key: "id_nivel" },
      { title: "Grupo", align: "center", key: "categoria_nivel" },
      { title: "Nivel", align: "center", key: "nombre_nivel" },
      { title: "Acciones", align: "center", key: "actions" },
    ],
  }),
  methods: {
    async obtenerNiveles() {
      try {
        const res = await newGoalService.getNiveles();
        console.log(res);
        this.niveles = res.data;
        this.loading = false;
      } catch (error) {
        console.log(error);
      }
    },

    async eliminarNivel() {
      const id = { id_nivel: this.id_nivel };
      try {
        const res = await newGoalService.deleteNivel(id);
        this.dialog_3 = false;
        this.obtenerNiveles();
        console.log(res);
      } catch (error) {
        console.log(error);
      }
    },

    edita(id) {
      this.id_nivel = id;
      console.log(id);
      console.log("hola");
      this.dialog_1 = true;
    },

    ver(id) {
      this.id_nivel = id;
      console.log(id);
      this.dialog_2 = true;
    },
    eliminar(id) {
      this.id_nivel = id;
      console.log("hola");
      this.dialog_3 = true;
      console.log(id);
    },
  },
  mounted() {
    this.obtenerNiveles();
  },
};
</script>
