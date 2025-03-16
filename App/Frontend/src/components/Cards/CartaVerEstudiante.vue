<template>
  <v-card class="ma-7">
    <v-form>
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
                variant="underlined"
                readonly
                label="Nombres"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                variant="underlined"
                v-model="estudiante.apellido"
                readonly
                label="Apellidos"
              >
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                v-model="estudiante.fecha_canimiento.split('T')[0]"
                variant="underlined"
                type="date"
                readonly
                label="Fecha de Nacimiento"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                variant="underlined"
                type=""
                readonly
                label="Edad"
                  v-model:model-value="edad"
              ></v-text-field>
            </v-col>
          </v-row>
          <v-divider class="mx-8"></v-divider>
        </v-container>
        <v-container>
          <v-row>
            <v-col>
              <v-text-field
                variant="underlined"
                readonly
                label="Nivel de Educación"
                v-model="estudiante.nivel_edu"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                readonly
              label="Nivel de Ingles"
                variant="underlined"
                v-model="estudiante.nivel_ingles"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                variant="underlined"
                readonly
                label="Estado"
                v-model="estudiante.estado"
              >
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                variant="underlined"
                readonly
                label="Nacionalidad"
                v-model="estudiante.nacionalidad"
              >
              </v-text-field>
            </v-col>
          </v-row>
        </v-container>
        <v-divider class="mx-8"></v-divider>
        <v-container>
          <v-row>
            <v-col>
              <v-text-field
                readonly
              label="Discapacidad"
                variant="underlined"
                v-model="estudiante.discapacidad"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                variant="underlined"
                readonly
                label="genero"
                v-model="estudiante.genero"
              >
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                readonly
              label="Representante"
                variant="underlined"
                v-model="estudiante.representante"
              ></v-text-field>
            </v-col>
          </v-row>
        </v-container>
        <v-divider class="mx-8"></v-divider>
        <v-container>
          <v-row class="mx-auto">
            <v-col class="d-flex">
              <v-text-field
                type=""
                variant="underlined"
                hint="Desmarque la casilla si el estudiante no posee cedula"
                readonly
                label="Cedula"
                v-model="estudiante.cedula"
              >
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                v-model="estudiante.contacto_emergencia"
                variant="underlined"
                readonly
                label="Contacto de emergencia"
              >
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                variant="underlined"
                readonly
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
                variant="underlined"
                readonly
                label="Numero de Telefono"
                v-model="estudiante.telefono"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                v-model="estudiante.direccion"
                variant="underlined"
                readonly
                label="Direccion"
              >
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                v-model="estudiante.correo"
                type="email"
                variant="underlined"
                readonly
                label="Correo Electronico"
              >
              </v-text-field>
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
    nacionalidades: [],
    levelEnglish: [],
    nivelEducativo: [],
    discapacidades: [],
    estados: [],
    generos: [],
    estudiante: {
      id_estudiante: null,
      representante: null,
      estado: null, //Devuelve el nombre pero no el id, necesitamos el id
      discapacidad: null, //Devuelve el nombre pero no el id, necesitamos el id
      genero: null,
      nivel_edu: null,
      nacionalidad: null,
      nivel_ingles: null,
      nombre: null,
      apellido: null,
      fecha_canimiento: "",
      cedula: null,
      direccion: null,
      telefono: null,
      correo: null,
      contacto_emergencia: null,
      quien_retira: null,
    },
  }),
  
  methods: {
    async obtenerEstudianteById(id) {
      id = this.id;
      try {
        const res = await newGoalService.getEstudianteById(id);

        const datosApi = res.data[0];

        this.estudiante.id_estudiante = datosApi.id_etd;
        this.estudiante.representante = datosApi.nombre_representante
         this.estudiante.estado = datosApi.estado
         this.estudiante.discapacidad = datosApi.nombre_discapacidad
         this.estudiante.genero = datosApi.genero
         this.estudiante.nivel_edu = datosApi.nivel_educacion
         this.estudiante.nacionalidad = datosApi.nacionalidad
         this.estudiante.nivel_ingles = datosApi.nivel_ingles
        this.estudiante.nombre = datosApi.nombre_etd;
        this.estudiante.apellido = datosApi.apellido_etd;
        this.estudiante.fecha_canimiento = datosApi.fecha_nacimiento_etd;
        this.estudiante.cedula = datosApi.cedula_etd;
        this.estudiante.direccion = datosApi.direccion_etd;
        this.estudiante.telefono = datosApi.telefono_etd;
        this.estudiante.correo = datosApi.correo_etd;
        this.estudiante.contacto_emergencia = datosApi.contacto_emergencia_etd;
        this.estudiante.quien_retira = datosApi.quien_retira_etd;
        console.log("--------------------");
        console.log(datosApi);
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
  },
  computed: {
    edad() {
      if (!this.estudiante.fecha_canimiento) return "";
      
      const fechaNacimiento = new Date(this.estudiante.fecha_canimiento);
      const hoy = new Date();
      
      // Validar fecha
      if (isNaN(fechaNacimiento.getTime())) return "Fecha inválida";
      
      let edad = hoy.getFullYear() - fechaNacimiento.getFullYear();
      const mes = hoy.getMonth() - fechaNacimiento.getMonth();
      
      if (mes < 0 || (mes === 0 && hoy.getDate() < fechaNacimiento.getDate())) {
        edad--;
      }
      
      return edad;
    }
},

  mounted() {
    this.obtenerEstudianteById();
  },
};
</script>
