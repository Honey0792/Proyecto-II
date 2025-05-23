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
    <v-form ref="form" @submit.prevent="modificarPersona">
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
          <v-btn type="submit">Guardar</v-btn>
        </div>
      </v-container>
    </v-form>
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
  components: {},
  data: () => ({
    alert: { show: false, message: "" },
    persona: {
      id_persona: null,
      nombre: null,
      apellido: null,
      cedula: null,
      cargo: null,
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
      (v) => !!v || "Cédula es requerida", // Validación de campo obligatorio
      (v) => /^\d{7,8}$/.test(v) || "Formato inválido (Ej: 12345678)",
    ],
  }),
  methods: {
    async modificarPersona() {
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
        const res = newGoalService.putPersona(this.persona);
        console.log(res);
        this.alert = {
          show: true,
          color: "success",
          message: "Persona Modificada corectamente",
        };
        this.$emit("actualizar_tabla");
      } catch (error) {
        console.log(error);
        this.alert = {
          show: true,
          color: "warning",
          message: "Persona no modificada",
        };
      }
    },
    async obtenerPersona(id) {
      id = this.id;
      try {
        const res = await newGoalService.getPersonaById(id);
        const datosApi = res.data[0];
        this.persona.id_persona = datosApi.id_persona;
        this.persona.nombre = datosApi.nombre_persona;
        this.persona.apellido = datosApi.apellido_persona;
        this.persona.cedula = datosApi.cedula_persona;
        this.persona.cargo = datosApi.cargo_persona;
        console.log(res);
      } catch (error) {
        console.log(error);
      }
    },
  },
  mounted() {
    this.obtenerPersona();
  },
};
</script>
