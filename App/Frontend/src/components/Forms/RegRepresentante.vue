<template>
  <v-card class="ma-7">
    <v-form @submit.prevent="registrarRepresentante">
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
               ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field 
              variant="outlined"
               label="Apellidos"
               v-model="representante.apellido"
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
              > </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                variant="outlined"
                label="Numero de Telefono"
                v-model="representante.telefono"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                type="email"
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
              variant="outlined" 
              label="Dirección"
              v-model="representante.direccion"
              >
              </v-textarea>
            </v-col>
          </v-row>
        </v-container>
        <v-divider class="mx-8"></v-divider>
        <v-container class="">
          <v-row>    <v-btn class="text-white bg-orange-lighten-2 mx-auto" type="submit"
            >Registrar</v-btn
          > </v-row>
        </v-container>
      </v-card-text>
    </v-form>
    </v-card>
</template>

<script>
import newGoalService from "@/services/newGoalService";

export default {
  data: () => ({
    generos: [],
    representante: {
      
      id_genero: null, 
    cedula: '', 
    nombre: '', 
    apellido: '', 
    direccion: '', 
    correo: '', 
    telefono: '',

    }
  }),

  methods: {

// PETICIONES GET
    async leerGeneros() {
      try {
        console.log(this.representante)
        const res = await newGoalService.getGenero();
        this.generos = res.data.datos;
      } catch (error) {
        console.log(error);
      }
    },

    //PETICIONES POST
    async registrarRepresentante(){
try {
  const res = await newGoalService.postRepresentante(this.representante)

} catch (error) {
  console.log(error) 
}
    },
  },
  mounted(){
    this.leerGeneros()
  }
};
</script>
