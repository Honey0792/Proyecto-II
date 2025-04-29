<template>
  <v-btn
    append-icon="mdi-plus"
    variant="elevated"
    class="mx-7"
    color="#B2EBF2"
    to="/registrar/cliente"
    >Añadir</v-btn
  >
  <v-card class="d-flex mx-10 ma-7">
    <v-data-table
      height="460"
      :headers="headers"
      :sort-by="[{ key: 'id_rt', order: 'desc' }]"
      :items="representantes"
      :search="search"
    >
      <template v-slot:item.id_rt="{ item }"></template>
      <template v-slot:top>
        <v-text-field
          v-model="search"
          placeholder="Buscar"
          prepend-inner-icon="mdi-magnify"
          clearable
          density="compact"
          single-line
          hint="Te recomendamos buscar por el número de cédula"
        ></v-text-field>
      </template>
      <template v-slot:item.nombre_rt="{ item }">
        {{ item.nombre_rt }}
      </template>

      <template v-slot:item.actions="{ item }">
        <div class="d-flex ga-2 justify-end">
          <v-icon
            color="medium-emphasis"
            icon="mdi-pencil"
            size="small"
            @click="edita(item.id_rt)"
          ></v-icon>
          <v-icon
            color="medium-emphasis"
            icon="mdi-eye"
            size="small"
            @click="ver(item.id_rt)"
          ></v-icon>
          <v-icon
            color="medium-emphasis"
            icon="mdi-delete"
            size="small"
            @click="eliminar(item.id_rt)"
          ></v-icon>
        </div>
      </template>
    </v-data-table>
  </v-card>

  <v-dialog v-model="this.dialog_1">
    <v-icon
      icon="mdi-close"
      class="position-absolute right-0"
      color="white"
      @click="this.dialog_1 = false"
    ></v-icon>
    <CartaEditRepresentante :id="id_rt" />
  </v-dialog>
  <v-dialog v-model="this.dialog_2">
    <v-icon
      icon="mdi-close"
      class="position-absolute right-0"
      color="white"
      @click="this.dialog_2 = false"
    ></v-icon>
    <CartaVerRepresentante :id="id_rt" />
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
        <v-btn class="ms-auto" text="Ok" @click="eliminarRepresentante"></v-btn>
      </template>
    </v-card>
  </v-dialog>
</template>

<script>
import newGoalService from "@/services/newGoalService";
import CartaVerRepresentante from "../Cards/CartaVerRepresentante.vue";
import CartaEditRepresentante from "../Cards/CartaEditRepresentante.vue";

export default {
  components: {
    CartaVerRepresentante,
    CartaEditRepresentante,
  },
  data: () => ({
    search: null,
    id_rt: null,
    dialog_1: false,
    dialog_2: false,
    dialog_3: false,
    representantes: [],
    headers: [
      { title: "Orden", key: "id_rt" }, // Columna para el estado
      { title: "Nombre", key: "nombre_rt" }, // Columna para el nombre
      { title: "Apellido", key: "apellido_rt" }, // Columna para el apellido
      { title: "Telefono", key: "telefono_rt" }, // Columna para el estado
      { title: "Correo", key: "correo_rt" }, // Columna para el correo
      { title: "Actions", key: "actions", align: "end", sortable: false }, //columna para las acciones
      // Agrega más columnas según los datos que tengas
    ],
  }),
  methods: {
    async obtenerRepresentantes() {
      try {
        const res = await newGoalService.getRepresentante();
        this.representantes = res.data;
        console.log(this.representantes);
      } catch (error) {
        console.log(error);
      }
    },
    async eliminarRepresentante() {
      const id = { id_representante: this.id_rt };
      try {
        const res = await newGoalService.deleteRepresentante(id);
        this.dialog_3 = false;
        this.obtenerRepresentantes();
      } catch (error) {
        console.log(error);
      }
    },
    edita(id) {
      this.id_rt = id;
      console.log("hola");
      this.dialog_1 = true;
    },

    ver(id) {
      this.id_rt = id;
      console.log("hola");
      this.dialog_2 = true;
    },
    eliminar(id) {
      this.id_rt = id;
      console.log("hola");
      this.dialog_3 = true;
      console.log(id);
    },
  },
  mounted() {
    this.obtenerRepresentantes();
  },
};
</script>
