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
  <v-card class="ma-7">
    <h3 class="pa-3">Añadir Nivel</h3>
    <v-divider></v-divider>
    <v-container>
      <v-form ref="form" @submit.prevent="agregarNivel">
        <v-row>
          <v-col>
            <v-text-field
              variant="outlined"
              label="Grupo/Categoria"
              v-model="nivel.categoria"
              hint='Aqui puede colocar la categoria del nivel por ejemplo: "ADULTS", "KIDS", "ESPECIAL", entre otros '
              :rules="globalRules"
            >
            </v-text-field>
          </v-col>
          <v-col>
            <v-text-field
              variant="outlined"
              label="Nombre"
              v-model="nivel.nombre"
              hint='Aqui puede colocar el nombre del nivel por ejemplo: "INTRO", IC1, "COFFE BREAK", entre otros'
              :rules="globalRules"
            >
            </v-text-field>
          </v-col>
          <v-col>
            <v-text-field
              variant="outlined"
              label="Descripción"
              v-model="nivel.descripcion"
              :rules="globalRules"
            >
            </v-text-field>
          </v-col>
        </v-row>
        <div class="d-flex pa-4 justify-center">
          <v-btn type="submit">Agregar</v-btn>
        </div>
      </v-form>
    </v-container>
    <v-divider></v-divider>
    <TablaNiveles ref="hijo" />
  </v-card>
</template>

<script>
import newGoalService from "@/services/newGoalService";
import TablaNiveles from "../Tables/tablaNiveles.vue";

export default {
  components: {
    TablaNiveles,
  },
  data: () => ({
    alert: { show: false, message: "" },
    nivel: {
      categoria: null,
      nombre: null,
      descripcion: null,
    },
    globalRules: [(value) => !!value || "Requerido"],
  }),

  methods: {
    async agregarNivel() {
      const { valid } = await this.$refs.form.validate();

      if (!valid) {
        this.alert = {
          show: true,
          color: "warning",
          message: "Complete todos los campos requeridos",
        };
        return;
      }
      try {
        const res = newGoalService.postNivel(this.nivel);
        console.log(res);
        this.alert = {
          show: true,
          color: "success",
          message: "Nivel creado corectamente",
        };
        this.$refs.hijo.obtenerNiveles();
      } catch (error) {
        console.log(error);
        this.alert = {
          show: true,
          color: "warning",
          message: "Nivel no registrado",
        };
      }
    },
  },
};
</script>
