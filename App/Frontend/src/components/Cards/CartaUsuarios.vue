<template>
  <v-container fluid>
    <v-row>
      <v-col class="d-flex" v-for="cards in usuarios" :key="cards.id_usuario">
        <v-card variant="elevated" width="400">
          <!-- <v-card-title>
            <v-icon color="primary" icon="mdi-account"></v-icon
            >{{ cards.nombre_usuario }}</v-card-title
          >
          <v-card-subtitle
            >{{ cards.nombre_persona }}
            {{ cards.apellido_persona }}</v-card-subtitle
          > -->
          <template v-slot:title>
            {{ cards.nombre_usuario }}
        </template>
          <template v-slot:subtitle>
            {{ cards.nombre_persona }}
            {{ cards.apellido_persona }}
          </template>
          <template v-slot:prepend>
            <v-icon color="primary" icon="mdi-account"></v-icon>
          </template>
          <template v-slot:actions>
            <v-spacer></v-spacer>
            <v-btn variant="outlined" size="small" color="#00ACC1">Modificar</v-btn>
            <v-btn variant="outlined" size="small" color="#E65100">Elminar</v-btn>

          </template>
          <!-- <template v-slot:append>
          <v-icon color="success" icon="mdi-check"></v-icon>
        </template> -->
          <!-- <v-card-text>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.</v-card-text> -->
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import newGoalService from "@/services/newGoalService";

export default {
  data: () => ({
    usuarios: [],
  }),

  methods: {
    async obtenerUsuarios() {
      try {
        const res = await newGoalService.getSesiones();
        this.usuarios = res.data;
        console.log(res);
      } catch (error) {
        console.log(error);
      }
    },
  },
  mounted() {
    this.obtenerUsuarios();
  },
};
</script>
