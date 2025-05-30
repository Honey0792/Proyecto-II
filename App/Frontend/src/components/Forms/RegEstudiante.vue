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
    <v-form ref="form" @submit.prevent="registrarEstudiante">
      <v-card-title class="bg-cyan-lighten-5">
        Registro de Estudiante
      </v-card-title>
      <v-card-text class="d-flex flex-column aling-center justify-center pa-0">
        <h3 class="pa-3">Datos Del Estudiante</h3>

        <v-divider></v-divider>
        <v-container class="">
          <v-row>
            <v-col>
              <v-text-field
                v-model="estudiante.nombre"
                variant="outlined"
                label="Nombres"
                :rules="nombresRules"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                variant="outlined"
                v-model="estudiante.apellido"
                label="Apellidos"
                :rules="nombresRules"
              >
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                v-model="estudiante.fecha_canimiento"
                variant="outlined"
                type="date"
                label="Fecha de Nacimiento"
                :rules="dateRules"
              ></v-text-field>
            </v-col>
          </v-row>
          <v-divider class="mx-8"></v-divider>
        </v-container>
        <v-container>
          <v-row>
            <v-col>
              <v-select
                variant="outlined"
                label="Nivel de Educación"
                :items="nivelEducativo"
                item-title="nombre_nv_edu"
                item-value="id_nv_edu"
                v-model="estudiante.nivel_edu"
                :rules="globalRules"
              ></v-select>
            </v-col>
            <v-col>
              <v-select
                label="Nivel de Ingles"
                variant="outlined"
                :items="levelEnglish"
                item-title="nombre_nivel_ingles"
                item-value="id_nivel_ingles"
                v-model="estudiante.nivel_ingles"
                :rules="globalRules"
              ></v-select>
            </v-col>
            <v-col>
              <v-select
                variant="outlined"
                label="Estado"
                :items="estados"
                item-title="nombre_estado"
                item-value="id_estado"
                v-model="estudiante.estado"
                :rules="globalRules"
              >
              </v-select>
            </v-col>
            <v-col>
              <v-select
                variant="outlined"
                label="Nacionalidad"
                :items="nacionalidades"
                item-title="nombre_ncd"
                item-value="id_ncd"
                v-model="estudiante.nacionalidad"
                :rules="globalRules"
              >
              </v-select>
            </v-col>
          </v-row>
        </v-container>
        <v-divider class="mx-8"></v-divider>
        <v-container>
          <v-row>
            <v-col>
              <v-select
                label="Discapacidad"
                variant="outlined"
                :items="discapacidades"
                item-title="nombre_discd"
                item-value="id_discd"
                v-model="estudiante.discapacidad"
                :rules="globalRules"
              ></v-select>
            </v-col>
            <v-col>
              <v-select
                variant="outlined"
                label="genero"
                :items="generos"
                item-title="nombre_genero"
                item-value="id_genero"
                v-model="estudiante.genero"
                :rules="globalRules"
              >
              </v-select>
            </v-col>
            <v-col>
              <v-text-field
                v-model="estudiante.direccion"
                variant="outlined"
                label="Direccion"
                :rules="globalRules"
              >
              </v-text-field>
            </v-col>
          </v-row>
        </v-container>
        <v-divider class="mx-8"></v-divider>
        <v-container>
          <v-row class="mx-auto">
            <v-col class="d-flex">
              <v-checkbox class="mx-3" v-model="activate"></v-checkbox>
              <v-text-field
                :rules="cedulaRules"
                :disabled="!activate"
                type=""
                variant="outlined"
                hint="Desmarque la casilla si el estudiante no posee cedula"
                label="Cedula"
                v-model="estudiante.cedula"
              >
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                :rules="phoneRules"
                variant="outlined"
                label="Numero de Telefono"
                v-model="estudiante.telefono"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                v-model="estudiante.correo"
                type="email"
                variant="outlined"
                label="Correo Electronico"
                :rules="emailRules"
              >
              </v-text-field>
            </v-col>
          </v-row>
        </v-container>
        <v-divider class="mx-8"></v-divider>
        <v-container class="">
          <v-row>
            <v-col>
              <v-text-field
                :rules="emergencyContactRules"
                v-model="estudiante.contacto_emergencia"
                variant="outlined"
                label="Contacto de emergencia"
              >
              </v-text-field>
            </v-col>
            <v-col>
              <v-autocomplete
                v-if="edadEstudiante !== null && edadEstudiante < 18"
                label="representante"
                variant="outlined"
                v-model="estudiante.representante"
                :items="representantes"
                :item-title="fullName"
                item-value="id_rt"
              ></v-autocomplete>
            </v-col>
            <v-col>
              <v-text-field
                variant="outlined"
                label="Encargado/s de retirar el Estudiante"
                v-model="estudiante.quien_retira"
              >
              </v-text-field>
            </v-col>
          </v-row>
        </v-container>
        <v-container class="d-flex aling-center">
          <v-btn class="text-white bg-orange-lighten-2 mx-auto" type="submit"
            >Registrar</v-btn
          >
          <v-btn
            @click="limpiarFormulario"
            class="text-white bg-orange-lighten-2 mx-auto"
            >Limpiar</v-btn
          >
        </v-container>
      </v-card-text>
    </v-form>
  </v-card>
</template>
<script>
import newGoalService from "@/services/newGoalService";
import { computed } from "vue";
export default {
  data: () => ({
    menuFechaNacimiento: false,
    maxDate: new Date().toISOString().split("T")[0], // Fecha actual
    minDate: new Date(new Date().setFullYear(new Date().getFullYear() - 100))
      .toISOString()
      .split("T")[0], // Hace 100 años
    alert: { show: false, message: "" },
    nacionalidades: [],
    levelEnglish: [],
    nivelEducativo: [],
    discapacidades: [],
    estados: [],
    generos: [],
    estudiante: {
      representante: null, //Requerido
      estado: null, //Requerido
      discapacidad: null, //Opcional
      genero: null, //Requerido
      nivel_edu: null, //Requerido
      nacionalidad: 188, //Requerido
      nivel_ingles: null, //Opcional pronto requerido
      nombre: "", //Requerido
      apellido: "", //Requerido
      fecha_canimiento: null, //Requerido
      cedula: null, //Requerido pronto Opcional
      direccion: "", //Requerido
      telefono: "", //Requerido
      correo: "", //Requerido
      contacto_emergencia: "", //Requerido
      quien_retira: null, //Opcional
      // edad: null,
    },
    formValid: false,
    representantes: [],
    emailRules: [
      (v) => !!v || "Requerido",
      (v) => /.+@.+\..+/.test(v) || "Correo electrónico no válido",
    ],
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
    phoneRules: [
      (v) => !!v || "Requerido",
      (v) =>
        /^(0)?(414|412|416|424|422|426)\d{7}$/.test(v) || "Teléfono inválido",
    ],
    emergencyContactRules: [
      (v) => !!v || "Requerido",
      (v) => /^\d{10,11}$/.test(v) || "Número inválido",
    ],
    cedulaRules: [
      (v) =>
        !v || // Permite campo vacío
        /^\d{7,8}$/.test(v) || // Solo números, 7 u 8 dígitos
        "Formato inválido (Ej: 12345678)",
    ],
    dateRules: [
      (v) => !!v || "Fecha requerida",
      (v) => {
        const date = new Date(v);
        const minDate = new Date();
        minDate.setFullYear(minDate.getFullYear() - 100);
        const maxDate = new Date();
        maxDate.setFullYear(maxDate.getFullYear() - 3);
        return (
          (date >= minDate && date <= maxDate) || "Edad inválida (3-100 años)"
        );
      },
    ],

    activate: true,
    prueba: null,
  }),
  computed: {
    fechaFormateada() {
      return this.estudiante.fecha_nacimiento
        ? new Date(this.estudiante.fecha_nacimiento).toLocaleDateString("es-ES")
        : "";
    },
  },

  methods: {
    fullName(item) {
      return `${item.nombre_rt} ${item.apellido_rt}`;
    },
    limpiarFormulario() {
      // Restablece el objeto estudiante
      this.estudiante = {
        representante: null,
        estado: null,
        discapacidad: null,
        genero: null,
        nivel_edu: null,
        nacionalidad: 188,
        nivel_ingles: null,
        nombre: "",
        apellido: "",
        fecha_canimiento: null,
        cedula: null,
        direccion: "",
        telefono: "",
        correo: "",
        contacto_emergencia: "",
        quien_retira: null,
      };

      // Restablece el checkbox de cédula
      this.activate = true;

      // Opcional: Cierra la alerta si está visible
      this.alert.show = false;
    },

    // PETICIONES GET
    async leerNacionalidades() {
      try {
        const res = await newGoalService.getNacionalidad();
        this.nacionalidades = res.data.datos;
        console.log(this.nacionalidades);
      } catch (error) {
        console.log("error");
      }
    },

    async leerEstados() {
      try {
        const res = await newGoalService.getEstado();
        this.estados = res.data.datos;
      } catch (error) {
        console.log("error");
      }
    },

    async leerDiscapacidades() {
      try {
        const res = await newGoalService.getDiscapacidad();
        this.discapacidades = res.data.datos;
        //   console.log(res.data)
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
    async leerNivelEducativo() {
      try {
        const res = await newGoalService.getNivelEducacion();
        console.log(res.data);
        this.nivelEducativo = res.data.datos;
      } catch (error) {
        console.log(error);
      }
    },
    async leerNivelIngles() {
      try {
        const res = await newGoalService.getNivelIngles();
        console.log(res.data);
        this.levelEnglish = res.data.datos;
      } catch (error) {
        console.log(error);
      }
    },
    async obtenerRepresentantes() {
      try {
        const res = await newGoalService.getRepresentante();
        this.representantes = res.data;
        console.log(this.representantes);
      } catch (error) {
        console.log(error);
      }
    },
    // async registrarEstudiante() {
    //   console.log(this.estudiante);
    //   try {
    //     const res = await newGoalService.postEstudiante(this.estudiante);
    //     this.alert = {
    //       show: true,
    //       color: "success",
    //       message: "Estudiante registrado correctamente",
    //     };
    //   } catch (error) {
    //     console.log(error);
    //     this.alert = {
    //       show: true,
    //       color: "warning",
    //       message: "Estudiante no Registrado",
    //     };
    //   }
    // },
    async registrarEstudiante() {
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
        const res = await newGoalService.postEstudiante(this.estudiante);

        this.alert = {
          show: true,
          color: "success",
          message: "Estudiante registrado correctamente",
        };
        // this.limpiarFormulario();
      } catch (error) {
        console.error(error);
        this.alert = {
          show: true,
          color: "error",
          message:
            error.response?.data?.message || "Error al registrar estudiante",
        };
      }
    },
  },

  mounted() {
    this.leerEstados();
    this.leerDiscapacidades();
    this.leerGeneros();
    this.leerNivelEducativo();
    this.leerNivelIngles();
    this.leerNacionalidades();
    this.obtenerRepresentantes();
  },

  computed: {
    fechaFormateada() {
      return this.estudiante.fecha_nacimiento
        ? new Date(this.estudiante.fecha_nacimiento).toLocaleDateString("es-ES")
        : "";
    },
    edadEstudiante() {
      if (!this.estudiante.fecha_canimiento) return null;
      const hoy = new Date();
      const nacimiento = new Date(this.estudiante.fecha_canimiento);
      let edad = hoy.getFullYear() - nacimiento.getFullYear();
      const m = hoy.getMonth() - nacimiento.getMonth();
      if (m < 0 || (m === 0 && hoy.getDate() < nacimiento.getDate())) {
        edad--;
      }
      return edad;
    },
  },

  watch: {
    "estudiante.cedula"(newVal) {
      if (newVal?.trim() === "") {
        this.estudiante.cedula = null;
      }
    },
    activate(newVal) {
      if (!newVal) {
        this.estudiante.cedula = null;
      }
    },
  },
};
</script>
