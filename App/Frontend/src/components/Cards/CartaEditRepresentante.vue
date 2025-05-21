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
    <v-form ref="form" @submit.prevent="modificarRepresentante">
      <v-card-title class="bg-cyan-lighten-5">
        Registro de Representante
      </v-card-title>
      <v-card-text class="d-flex flex-column aling-center justify-center pa-0">
        <h3 class="pa-3">Datos Del Representante</h3>

        <v-divider></v-divider>
        <v-container class="">
          <v-row>
            <v-col>
              <v-text-field
                variant="outlined"
                label="Nombres"
                v-model="representante.nombre"
                :rules="nombresRules"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                variant="outlined"
                label="Apellidos"
                v-model="representante.apellido"
                :rules="nombresRules"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-select
                variant="outlined"
                label="Genero"
                :items="generos"
                item-title="nombre_genero"
                item-value="id_genero"
                v-model="representante.id_genero"
                :rules="globalRules"
              ></v-select>
            </v-col>
            <v-divider class="mx-8"></v-divider>
          </v-row>
        </v-container>
        <v-container>
          <v-row>
            <v-col>
              <v-text-field
                variant="outlined"
                label="Cedula"
                v-model="representante.cedula"
                :rules="cedulaRules"
              >
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                variant="outlined"
                label="Numero de Telefono"
                v-model="representante.telefono"
                :rules="phoneRules"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                type="email"
                variant="outlined"
                label="Correo Electronico"
                v-model="representante.correo"
                :rules="emailRules"
              >
              </v-text-field>
            </v-col>
          </v-row>
        </v-container>
        <v-divider class="mx-8"></v-divider>
        <v-container>
          <v-row class="mx-auto">
            <v-col class="d-flex">
              <v-textarea
                rows="3"
                no-resize
                type=""
                variant="outlined"
                label="Dirección"
                v-model="representante.direccion"
                :rules="globalRules"
              >
              </v-textarea>
            </v-col>
          </v-row>
        </v-container>
        <v-divider class="mx-8"></v-divider>
        <v-container class="">
          <v-row>
            <v-col class="d-flex justify-center">
              <v-btn class="text-white bg-orange-lighten-2 ma-3" type="submit"
                >Guardar</v-btn
              >
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>
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
    alert: { show: false, message: "" },
    generos: [],
    representante: {
      id_representante: null,
      id_genero: null,
      cedula: null,
      nombre: null,
      apellido: null,
      direccion: null,
      correo: null,
      telefono: null,
    },
    globalRules: [(value) => !!value || "Requerido"],
    cedulaRules: [
      (v) => !!v || "requerido",
      (v) =>
        /^\d{7,8}$/.test(v) || // Solo números, 7 u 8 dígitos
        "Formato inválido (Ej: 12345678)",
    ],
    emailRules: [
      (v) => !!v || "Requerido",
      (v) => /.+@.+\..+/.test(v) || "Correo electrónico no válido",
    ],
    phoneRules: [
      (v) => !!v || "Requerido",
      (v) => /^(0)?(414|412|416|424|426)\d{7}$/.test(v) || "Teléfono inválido",
    ],
    nombresRules: [
      (value) => !!value || "Requerido",
      (value) =>
        /^[a-zA-Zñáéíóúü\s]+$/i.test(value) || "Solo se admiten letras",
      (value) => value.length >= 3 || "El campo debe tener mínimo 3 caracteres",
      (value) =>
        !/(.)\1{2,}/.test(value) ||
        "No se permiten caracteres repetidos consecutivamente",
    ],
  }),

  methods: {
    async modificarRepresentante() {
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
        const res = await newGoalService.putRepresentante(this.representante);
        this.alert = {
          show: true,
          color: "success",
          message: "Representante modificado corectamente",
        };
        this.$emit("actualizar_tabla");
      } catch (error) {
        console.log(error);
        this.alert = {
          show: true,
          color: "warning",
          message: "Error al intentar modificar representante",
        };
      }
    },
    async obtenerRepresentanteById(id) {
      id = this.id;
      try {
        const res = await newGoalService.getRepresentanteById(id);

        const datosApi = res.data[0];
        this.representante.id_representante = datosApi.id_rt;
        this.representante.id_genero = datosApi.id_genero;
        this.representante.cedula = datosApi.cedula_rt;
        this.representante.nombre = datosApi.nombre_rt;
        this.representante.apellido = datosApi.apellido_rt;
        this.representante.direccion = datosApi.direccion_rt;
        this.representante.correo = datosApi.correo_rt;
        this.representante.telefono = datosApi.telefono_rt;

        console.log("--------------------");
        console.log(this.representante);
        console.log("--------------------");
        // Este ciclo es una mierda por eso lo comento
        // Itera sobre las propiedades de `estudiante`
        // for (const key in this.estudiante) {
        //   if (datosApi.hasOwnProperty(key)) {
        //     this.estudiante[key] = datosApi[key];
        //   }
        // }

        // console.log("Estudiante actualizado:", this.estudiante);
      } catch (error) {
        console.log(error);
      }
    },
    async leerGeneros() {
      try {
        const res = await newGoalService.getGenero();
        this.generos = res.data.datos;
      } catch (error) {
        console.log(error);
      }
    },
  },

  mounted() {
    this.obtenerRepresentanteById();
    this.leerGeneros();
  },
};
</script>
