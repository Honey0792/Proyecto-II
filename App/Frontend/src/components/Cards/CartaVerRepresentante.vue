<template>
  <v-card class="ma-7">
    <v-form>
      <v-card-title class="bg-cyan-lighten-5">
        Planilla del Representante
      </v-card-title>
      <v-card-text class="d-flex flex-column aling-center justify-center pa-0">
        <h3 class="pa-3">Datos Del Representante</h3>

        <v-divider></v-divider>
        <v-container class="">
          <v-row>
            <v-col>
              <v-text-field
              readonly
                variant="outlined"
                label="Nombres"
                v-model="representante.nombre"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
              readonly
                variant="outlined"
                label="Apellidos"
                 v-model="representante.apellido"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
              readonly
                variant="outlined"
                label="Genero"
                   v-model="representante.nombre_genero"
              ></v-text-field>
            </v-col>
            <v-divider class="mx-8"></v-divider>
          </v-row>
        </v-container>
        <v-container>
          <v-row>
            <v-col>
              <v-text-field
              readonly
                variant="outlined"
                label="Cedula"
                   v-model="representante.cedula"
              >
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
              readonly
                variant="outlined"
                label="Numero de Telefono"
                   v-model="representante.telefono"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                type="email"
                readonly
                variant="outlined"
                label="Correo Electronico"
                   v-model="representante.correo"
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
                readonly
                variant="outlined"
                label="Dirección"
                   v-model="representante.direccion"
              >
              </v-textarea>
            </v-col>
          </v-row>
        </v-container>
        <v-divider class="mx-8"></v-divider>
      </v-card-text>
    </v-form>
    <v-divider>
      <h3> Representados </h3>
    </v-divider>
    <v-data-table-virtual max-height="400" :headers :items="representados"></v-data-table-virtual>
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
    representados:[],
    representante: {
      id_representante: null,
      id_genero: null,
      nombre_genero: null,
      cedula: null,
      nombre: null,
      apellido: null,
      direccion: null,
      correo: null,
      telefono: null,
    },
      headers: [
      { title: "Nombre", key: "nombre_estudiante" }, // Columna para el estado
      { title: "Apellido", key: "apellido_estudiante" }, // Columna para el estado
      { title: "Telefono", key: "telefono" }, // Columna para el estado
      { title: "Cedula", key: "cedula_estudiante" }, // Columna para el estado
      // Agrega más columnas según los datos que tengas
    ],
  }),

  methods: {
    async obtenerRepresentanteById(id) {
      id = this.id;
      try {
        const res = await newGoalService.getRepresentanteById(id);

        const datosApi = res.data[0];
        this.representante.id_representante = datosApi.id_rt
        this.representante.id_genero = datosApi.id_genero
        this.representante.nombre_genero = datosApi.nombre_genero
        this.representante.cedula = datosApi.cedula_rt
        this.representante.nombre = datosApi.nombre_rt
        this.representante.apellido = datosApi.apellido_rt
        this.representante.direccion = datosApi.direccion_rt
        this.representante.correo = datosApi.correo_rt
        this.representante.telefono = datosApi.telefono_rt

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
  async  obtenerRepresentados(){
    try {
      const res = await newGoalService.getRepresentados(this.id)
      console.log(res)

      this.representados = res.data.datos
      
    } catch (error) {
      console.log(error)
    }
  },
  },

  mounted() {
    this.obtenerRepresentanteById();
    this.obtenerRepresentados()
  },
};
</script>
