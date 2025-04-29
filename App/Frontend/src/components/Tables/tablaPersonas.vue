<template>
  <v-data-table :search="search" :items="personas" :headers height="200">
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
    <template v-slot:item.id_persona="{ item }"> </template>
    <template v-slot:item.actions="{ item }">
      <div class="d-flex ga-2 justify-center">
        <v-icon
          color="medium-emphasis"
          icon="mdi-pencil"
          size="small"
          @click="edita(item.id_persona)"
        ></v-icon>
        <!-- <v-icon
            color="medium-emphasis"
            icon="mdi-eye"
            size="small"
          ></v-icon> -->
        <v-icon
          color="medium-emphasis"
          icon="mdi-delete"
          size="small"
          @click="eliminar(item.id_persona)"
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
    <CartaEditPersona :id="id_persona" />
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
        <v-btn class="ms-auto" text="Ok" @click="eliminarPersona"></v-btn>
      </template>
    </v-card>
  </v-dialog>
</template>

<script>
import newGoalService from "@/services/newGoalService";
import CartaEditPersona from "../Cards/CartaEditPersona.vue";

export default {
  components: { CartaEditPersona },
  data: () => ({
    search: null,
    dialog_1: false,
    dialog_3: false,
    id_persona: null,
    personas: [],
    headers: [
      { title: "Orden", align: "center", key: "id_persona" },
      { title: "Nombres", align: "center", key: "nombre_persona" },
      { title: "Apellidos", align: "center", key: "apellido_persona" },
      { title: "Cargo", align: "center", key: "cargo_persona" },
      { title: "Cedula", align: "center", key: "cedula_persona" },
      { title: "Acciones", align: "center", key: "actions" },
    ],
  }),
  methods: {
    async obtenerPersonas() {
      try {
        const res = await newGoalService.getPersonas();
        this.personas = res.data;
        console.log(res);
      } catch (error) {
        console.log(error);
      }
    },

    async eliminarPersona(){
        const id = { id_persona: this.id_persona };
        try {
            const res = await newGoalService.deletePersona(id)
            this.obtenerPersonas()
            this.dialog_3 = false
        } catch (error) {
            console.log(error)
        }
    },

    edita(id) {
      this.id_persona = id;
      this.dialog_1 = true;
    },
    eliminar(id) {
      this.id_persona = id;
      this.dialog_3 = true;
      console.log(id);
    },
  },
  mounted() {
    this.obtenerPersonas();
  },
};
</script>
