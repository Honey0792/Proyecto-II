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
    <v-form ref="form" @submit.prevent="registrarPersona">
      <h3 class="pa-3">Registrar Persona</h3>
      <v-divider></v-divider>
      <v-container class="">
        <v-row>
          <v-col>
            <v-text-field
              variant="outlined"
              label="Nombre"
              v-model="persona.nombre"
              :rules="nombresRules"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-text-field
              label="Apellido"
              variant="outlined"
              v-model="persona.apellido"
              :rules="nombresRules"
            ></v-text-field>
          </v-col>
        </v-row>
      </v-container>
      <v-container>
        <v-row>
          <v-col>
            <v-text-field
              variant="outlined"
              label="Cedula"
              v-model="persona.cedula"
              :rules="cedulaRules"
            ></v-text-field>
          </v-col>
        </v-row>
        <v-row>
          <v-col>
            <v-select
              variant="outlined"
              label="Nivel Educativo"
              :items="nivelesDisponibles"
              item-title="nombre_nv_edu"
              item-value="id_nv_edu"
              v-model="persona.nivel_educativo"
              :rules="globalRules"
            ></v-select>
          </v-col>
          <v-col>
            <v-text-field
              variant="outlined"
              label="Cargo"
              v-model="persona.cargo"
              :rules="globalRules"
            ></v-text-field>
          </v-col>
        </v-row>
        <div class="d-flex justify-center">
          <v-btn type="submit">Registrar</v-btn>
        </div>
      </v-container>
    </v-form>
    <v-divider></v-divider>
    <TablaPersonas ref="hijo" />
  </v-card>
</template>
<script>
import newGoalService from "@/services/newGoalService";
import TablaPersonas from "../Tables/tablaPersonas.vue";

export default {
  components: { TablaPersonas },
  data: () => ({
    alert: { show: false, message: "" },
    nivelEducativo: [],
    persona: {
      nombre: null,
      apellido: null,
      cedula: null,
      cargo: null,
      nivel_educativo: null,
    },
    globalRules: [(value) => !!value || "Requerido"],
    nombresRules: [
      (value) => !!value || "Requerido",
      (value) =>
        /^[a-zA-Zñáéíóúü\s]+$/i.test(value) || "Solo se admiten letras",
      (value) => value.length >= 3 || "El campo debe tener mínimo 3 caracteres",
      (value) =>
        !/(.)\1{2,}/.test(value) ||
        "No se permiten caracteres repetidos consecutivamente",
    ],
    cedulaRules: [
  (v) => !!v || 'Cédula es requerida',  // Validación de campo obligatorio
  (v) => /^\d{7,8}$/.test(v) || 'Formato inválido (Ej: 12345678)'
]
  }),
  computed: {
    nivelesDisponibles() {
      return this.nivelEducativo.filter(n => Number(n.id_nv_edu) >= 15);
    },
  },
  methods: {
    async leerNivelEducativo() {
      try {
        const res = await newGoalService.getNivelEducacion();
        this.nivelEducativo = res.data.datos;
      } catch (error) {
        console.log(error);
      }
    },
    async registrarPersona() {
      try {
                const { valid } = await this.$refs.form.validate();

        if (!valid) {
          this.alert = {
            show: true,
            color: "warning",
            message: "Complete todos los campos requeridos",
          };
          return;
        }
        const res = await newGoalService.postPersonas(this.persona);
        console.log(res);
        this.alert = {
          show: true,
          color: "success",
          message: "Persona registrada correctamente",
        };
        this.$refs.hijo.obtenerPersonas();
      } catch (error) {
        console.log(error);
        this.alert = {
          show: true,
          color: "warning",
          message: "Persona no registrada",
        };
      }
    },
  },
  mounted() {
    this.leerNivelEducativo();
  },
};
</script>
