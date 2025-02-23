<template>
  <v-form>
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
              <v-text-field variant="outlined" label="Apellidos"></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                v-model="estudiante.fechaNacimiento"
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
            <v-divider class="mx-8"></v-divider>
          </v-row>
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
              ></v-select>
            </v-col>
            <v-col>
              <v-select
               label="Nivel de Ingles" 
               variant="outlined"
               :items="levelEnglish"
               item-title="nombre_nivel_ingles"
               item-value="id_nivel_ingles"
               ></v-select>
            </v-col>
            <v-col>
              <v-select
                variant="outlined"
                label="Estado"
                :items="estados"
                item-title="nombre_estado"
                item-value="id_estado"
              >
              </v-select>
            </v-col>
          </v-row>
        </v-container>
        <v-divider class="mx-8"></v-divider>
        <v-container>
          <v-row>
            <v-col>
              <v-text-field variant="outlined" label="Representante"></v-text-field>
            </v-col>
            <v-col>
              <v-select
               label="Discapacidad" 
               variant="outlined"
               :items="discapacidades"
               item-title="nombre_discd"
               item-value="id_discd"
               ></v-select>
            </v-col>
            <v-col>
              <v-select
               variant="outlined"
                label="genero"
                :items="generos"
                item-title="nombre_genero"
                item-value="id_genero"
               > </v-select>
            </v-col>
            <v-col>
              <v-text-field
                label="Persona que registro"
                variant="outlined"
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
              >
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field variant="outlined" label="Contacto de emergencia">
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                variant="outlined"
                label="Encargado/s de retirar el Estudiante"
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
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field variant="outlined" label="Direccion">
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
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
    levelEnglish : [],
    nivelEducativo : [],
    discapacidades: [],
    estados: [],
    generos: [],
    estudiante: {
      nombres: "",
      apellidos: "",
      cedula: "",
      fechaNacimiento: "",
      edad: "",
      nivelIngles: "",
      gradoEscolar: "",
      alergias: "",
      ocupacion: "",
      direccion: "",
      numTlf: "",
      email: "",
    },
    activate: true,
    prueba: null,
  }),
  methods: {

    async leerEstados() {
     try {
       const res = await newGoalService.getEstado();
       this.estados = res.data.datos;
     } catch (error) {
      console.log('error')
     }
    },

    async leerDiscapacidades(){
      try {
        const res = await newGoalService.getDiscapacidad()
        this.discapacidades = res.data.datos
     //   console.log(res.data)
      }catch(error){
        console.log(error)
      }

    },

    async leerGeneros(){
      try {
        const res = await newGoalService.getGenero()
        this.generos = res.data.datos
      } catch (error) {
        console.log(error)
      }

    },
    async leerNivelEducativo(){
      try {
        const res = await newGoalService.getNivelEducacion()
        console.log(res.data)
        this.nivelEducativo = res.data.datos
      } catch (error) {
        console.log(error)
      }
    },
    async leerNivelIngles(){
      try {
        const res = await newGoalService.getNivelIngles()
        console.log(res.data)
        this.levelEnglish = res.data.datos
      } catch (error) {
        console.log(error)
      }
    }
  },

  mounted() {
  this.leerEstados()
  this.leerDiscapacidades()
  this.leerGeneros()
  this.leerNivelEducativo()
  this.leerNivelIngles()
    },


};
</script>
