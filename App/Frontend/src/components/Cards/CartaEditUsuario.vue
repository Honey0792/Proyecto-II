<template>
  <v-card class="ma-7">
    <v-form @submit.prevent="modificarSesion">
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
            ></v-autocomplete>
          </v-col>
        </v-row>
        <v-row>
          <v-col>
            <v-text-field
              variant="outlined"
              label="Nombre de Usuario"
              v-model="sesion.nombre"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-text-field
              variant="outlined"
              label="Contraseña"
              v-model="sesion.password"
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
            ></v-select>
          </v-col>
        </v-row>
        <div class="d-flex justify-center">
          <v-btn type="submit" color="#00ACC1">Modificar</v-btn>
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
  data: () => ({
    roles: [
      { id_rol: 1, nombre_rol: "Administrador" },
      { id_rol: 2, nombre_rol: "Empleado" },
    ],
    personas: [],
    sesion: {
      id_usuario: null,
      id_persona: null,
      nombre: null,
      password: null,
      rol: null,
    },
  }),
  methods: {
    fullName(item) {
      return `${item.nombre_persona} ${item.apellido_persona}`;
    },
    async modificarSesion() {
      try {
        console.log(this.sesion);
        const res = await newGoalService.putSesion(this.sesion);
      } catch (error) {
        console.log(error);
      }
    },
    async obtenerSesion() {
      const id = this.id;
      console.log(id);
      try {
        const res = await newGoalService.getSesionesById(id);
        console.log(res);
        const datosApi = res.data[0];
        console.log();
        this.sesion.id_usuario = datosApi.id_usuario
        this.sesion.id_persona = datosApi.id_persona;
        this.sesion.nombre = datosApi.nombre_usuario;
        this.sesion.password = datosApi.password_usuario;
        this.sesion.rol = datosApi.rol_usuario;
      } catch (error) {
        console.log(error);
      }
    },
    async obtenerPersonas() {
      try {
        const res = await newGoalService.getPersonas();
        this.personas = res.data;
        // console.log(res);
      } catch (error) {
        console.log(error);
      }
    },
  },
  mounted() {
    this.obtenerPersonas();
    this.obtenerSesion();
  },
};
</script>
