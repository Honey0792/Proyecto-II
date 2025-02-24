<template>
  <v-form @submit.prevent="registrarEstudiante">
    <v-card class="ma-7">
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
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                variant="outlined"
                v-model="estudiante.apellido"
                label="Apellidos"
              >
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                v-model="estudiante.fecha_canimiento"
                variant="outlined"
                type="date"
                label="Fecha de Nacimiento"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                variant="outlined"
                type="number"
                label="Edad"
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
              >
              </v-select>
            </v-col>
            <v-col>
              <v-text-field
                label="Persona que registro"
                variant="outlined"
                v-model="estudiante.persona"
              ></v-text-field>
            </v-col>
          </v-row>
        </v-container>
        <v-divider class="mx-8"></v-divider>
        <v-container>
          <v-row class="mx-auto">
            <v-col class="d-flex">
              <v-checkbox class="mx-3" v-model="activate"></v-checkbox>
              <v-text-field
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
                v-model="estudiante.contacto_emergencia"
                variant="outlined"
                label="Contacto de emergencia"
              >
              </v-text-field>
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
        <v-divider class="mx-8"></v-divider>
        <v-container class="">
          <v-row>
            <v-col>
              <v-text-field
                variant="outlined"
                label="Numero de Telefono"
                v-model="estudiante.telefono"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                v-model="estudiante.direccion"
                variant="outlined"
                label="Direccion"
              >
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                v-model="estudiante.correo"
                type="email"
                variant="outlined"
                label="Correo Electronico"
              >
              </v-text-field>
            </v-col>
          </v-row>
        </v-container>
        <v-container class="d-flex aling-center">
          <v-btn class="text-white bg-orange-lighten-2 mx-auto" type="submit"
            >Registrar</v-btn
          >
          <v-btn class="text-white bg-orange-lighten-2 mx-auto">Limpiar</v-btn>
        </v-container>
      </v-card-text>
    </v-card>
  </v-form>
</template>
<script>
import newGoalService from "@/services/newGoalService";
export default {
  data: () => ({
    nacionalidades: [],
    levelEnglish: [],
    nivelEducativo: [],
    discapacidades: [],
    estados: [],
    generos: [],
    estudiante: {
      estado: null, //Requerido
      discapacidad: null, //Opcional
      genero: null, //Requerido
      nivel_edu: null, //Requerido
      nacionalidad: 188, //Requerido
      nivel_ingles: null, //Opcional pronto requerido
      persona: null, //Requerido
      nombre: "", //Requerido
      apellido: "", //Requerido
      fecha_canimiento: null, //Requerido
      cedula: "", //Requerido pronto Opcional
      direccion: "", //Requerido
      telefono: "", //Requerido
      correo: "", //Requerido
      contacto_emergencia: "", //Requerido
      quien_retira: "", //Opcional
      // edad: null,
    },
    activate: true,
    prueba: null,
  }),
  methods: {
    // PETICIONES GET
    async leerNacionalidades() {
      try {
        const res = await newGoalService.getNacionalidad();
        this.nacionalidades = res.data.datos;
        console.log(this.nacionalidades)
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
    // PETICIONES POST
    async registrarEstudiante() {
      console.log(this.estudiante)
      try {
        const res = await newGoalService.postEstudiante(this.estudiante);
      } catch (error) {
        console.log(error);
      }
    },
  },

  mounted() {
    this.leerEstados();
    this.leerDiscapacidades();
    this.leerGeneros();
    this.leerNivelEducativo();
    this.leerNivelIngles();
    this.leerNacionalidades()
  },
};
</script>
