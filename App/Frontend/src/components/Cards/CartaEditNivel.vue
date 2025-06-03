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
      <v-form ref="form" @submit.prevent="actualizarNivel">
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
  </v-card>
</template>

<script>
import newGoalService from "@/services/newGoalService";

export default {
  props: {
    id: {
      type: Number,
      required: true,
    },
  },
  data: () => ({
    alert: { show: false, message: "" },
    nivel: {
      id_nivel: null,
      categoria: null,
      nombre: null,
      descripcion: null,
    },
    globalRules: [(value) => !!value || "Requerido"],
  }),

  methods: {
    async obtenerNivelPorId() {
      try {
        const res = await newGoalService.getNivel(this.id);
        console.log("nivel id", res);
        const datosApi = res.data[0];
        this.nivel.categoria = datosApi.categoria_nivel;
        this.nivel.nombre = datosApi.nombre_nivel;
        this.nivel.descripcion = datosApi.descripcion_nivel;
        this.nivel.id_nivel = datosApi.id_nivel
      } catch (error) {
        console.log(error);
      }
    },

    async actualizarNivel() {
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
        const res = await newGoalService.putNivel(this.nivel);
        this.alert = {
          show: true,
          color: "success",
          message: "Nivel modificado corectamente",
        };
        this.$emit("actualizar_tabla");
      } catch (error) {
        console.log(error);
        this.alert = {
          show: true,
          color: "warning",
          message: "Nivel no modificado",
        };
      }
    },
  },

  mounted() {
    this.obtenerNivelPorId();
  },
};
</script>
