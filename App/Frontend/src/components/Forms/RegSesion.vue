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
    <v-form ref="form" @submit.prevent="crearSesion">
      <h3 class="pa-3">Datos del Usuario</h3>
      <v-divider></v-divider>
      <v-container class="">
        <v-row>
          <v-col>
            <v-autocomplete
              :items="personas"
              item-value="id_persona"
              :item-title="fullName"
              variant="outlined"
              label="Persona"
              v-model="sesion.id_persona"
              :rules="globalRules"
            ></v-autocomplete>
          </v-col>
        </v-row>
        <v-row>
          <v-col>
            <v-text-field
              variant="outlined"
              label="Nombre de Usuario"
              v-model="sesion.nombre"
              :rules="usernameRules"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-text-field
              variant="outlined"
              label="Contraseña"
              v-model="sesion.password"
              :rules="contrasenaRules"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-select
              label="Rol"
              :items="roles"
              item-title="nombre_rol"
              item-value="id_rol"
              variant="outlined"
              v-model="sesion.rol"
              :rules="globalRules"
            ></v-select>
          </v-col>
        </v-row>
        <div class="d-flex justify-center">
          <v-btn type="submit" color="#00ACC1">Crear</v-btn>
        </div>
      </v-container>
    </v-form>
  </v-card>
</template>

<script>
import newGoalService from "@/services/newGoalService";

export default {
  data: () => ({
    roles: [
      { id_rol: 1, nombre_rol: "Administrador" },
      { id_rol: 2, nombre_rol: "Empleado" },
    ],
    personas: [],
    alert: { show: false, message: "" },
    sesion: {
      id_persona: null,
      nombre: null,
      password: null,
      rol: null,
    },
    globalRules: [(value) => !!value || "Requerido"],
    usernameRules: [
      (value) => !!value || "Éste campo es requerido",
      (value) =>
        !value.includes(" ") ||
        "El nombre de usuario no puede contener espacios en blanco",
      (value) =>
        /^[A-Za-z\s.\d]+$/.test(value) ||
        "No se permiten caracteres especiales",
      (value) =>
        value.length <= 14 ||
        "El nombre de usuario no puede contener más de 14 caracteres",
      (value) =>
        value.length >= 4 ||
        "El nombre de usuario no puede contener menos de 4 caracteres",
    ],
    contrasenaRules: [
      (value) => !!value || "La contrasena es requerida",
      (value) =>
        !value.includes(" ") || "La contraseña no puede contener espacios",
      (value) =>
        /^[a-zA-Z0-9\._-]*$/.test(value) ||
        "La contraseña solo puede contener letras, números, guiones bajos y puntos",
      (value) =>
        value.length <= 14 ||
        "La contraseña no puede tener más de 18 caracteres",
      (value) =>
        value.length >= 4 ||
        "La contraseña no puede tener menos de 4 caracteres",
    ],
  }),
  methods: {
    fullName(item) {
      return `${item.nombre_persona} ${item.apellido_persona}`;
    },
    async crearSesion() {
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
        console.log(this.sesion);
        const res = await newGoalService.postSesion(this.sesion);
        this.alert = {
          show: true,
          color: "success",
          message: "Usuario creado correctamente",
        };
      } catch (error) {
        this.alert = {
          show: true,
          color: "warning",
          message: "Error al crear usuario",
        };
        console.log(error);
      }
    },
    async obtenerPersonas() {
      try {
        const res = await newGoalService.getPersonas();
        this.personas = res.data;
        console.log(res);
      } catch (error) {
        console.log(error);
      }
    },
  },
  mounted() {
    this.obtenerPersonas();
  },
};
</script>
