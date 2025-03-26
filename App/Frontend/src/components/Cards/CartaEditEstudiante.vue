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
      <v-form @submit="modificarEstudiante">
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
                v-model="estudiante.fecha_canimiento.split('T')[0]"
                variant="outlined"
                type="date"
                label="Fecha de Nacimiento"
              ></v-text-field>
            </v-col>
          </v-row>
        </v-container>
        <v-divider class="mx-8"></v-divider>
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
                v-model="estudiante.nivel_ingles"
                :items="levelEnglish"
                item-title="nombre_nivel_ingles"
                item-value="id_nivel_ingles"
              ></v-select>
            </v-col>
            <v-col>
              <v-select
                variant="outlined"
                label="Estado"
                v-model="estudiante.estado"
                :items="estados"
                item-title="nombre_estado"
                item-value="id_estado"
              >
              </v-select>
            </v-col>
            <v-col>
              <v-select 
              variant="outlined"
              label="Nacionalidad"
              v-model="estudiante.nacionalidad"
              :items="nacionalidades"
              item-title="nombre_ncd"
              item-value="id_ncd"
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
                v-model="estudiante.discapacidad"
                :items="discapacidades"
                item-title="nombre_discd"
                item-value="id_discd"
              ></v-select>
            </v-col>
            <v-col>
              <v-select
                variant="outlined"
                label="genero"
                v-model="estudiante.genero"
                :items="generos"
                item-title="nombre_genero"
                item-value="id_genero"
              >
              </v-select>
            </v-col>
            <v-col>
              <v-text-field
                label="Representante"
                variant="outlined"
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
          <v-btn type="submit"
          >Guardar</v-btn>
        </v-container>
      </v-card-text>
    </v-form>
    </v-card>
</template>


<script>
import newGoalService from '@/services/newGoalService';
export default {
  props:{
    id: {
      type : Number,
      required : true
    }
  },
data: () => ({
  alert: { show: false, message: "" },
  nacionalidades: [],
    levelEnglish: [],
    nivelEducativo: [],
    discapacidades: [],
    estados: [],
    generos: [],
    estudiante:{
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
    quien_retira: null
}
}),
methods: {


async obtenerEstudianteById (id){
  id = this.id
try {

    const res = await newGoalService.getEstudianteById(id)
  
    const datosApi = res.data[0];
    
    
    this.estudiante.id_estudiante = datosApi.id_etd
    // this.estudiante.representante = datosApi.
    //  this.estudiante.estado = datosApi.contacto_emergencia_etd
    //  this.estudiante.discapacidad = datosApi.correo_etd
    //  this.estudiante.genero = datosApi.direccion_etd
//  this.estudiante.nivel_edu = datosApi.nombre_discapacidad
//  this.estudiante.nacionalidad = datosApi.estado
//  this.estudiante.nivel_ingles = datosApi.fecha_nacimiento_etd
this.estudiante.nombre = datosApi.nombre_etd
this.estudiante.apellido = datosApi.apellido_etd
 this.estudiante.fecha_canimiento = datosApi.fecha_nacimiento_etd
 this.estudiante.cedula = datosApi.cedula_etd
this.estudiante.direccion = datosApi.direccion_etd
this.estudiante.telefono = datosApi.telefono_etd
this.estudiante.correo = datosApi.correo_etd
this.estudiante.contacto_emergencia = datosApi.contacto_emergencia_etd
this.estudiante.quien_retira = datosApi.quien_retira_etd
console.log('--------------------')
console.log(datosApi)
console.log('--------------------')
// Este ciclo es una mierda por eso lo comento
// Itera sobre las propiedades de `estudiante`
// for (const key in this.estudiante) {
//   if (datosApi.hasOwnProperty(key)) {
//     this.estudiante[key] = datosApi[key];
//   }
// }

// console.log("Estudiante actualizado:", this.estudiante);
} catch (error) {
    console.log(error)
}
},


async leerNacionalidades() {
      try {
        const res = await newGoalService.getNacionalidad();
        this.nacionalidades = res.data.datos;
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
        this.nivelEducativo = res.data.datos;
      } catch (error) {
        console.log(error);
      }
    },
    async leerNivelIngles() {
      try {
        const res = await newGoalService.getNivelIngles();
        this.levelEnglish = res.data.datos;
      } catch (error) {
        console.log(error);
      }
    },

    async modificarEstudiante(){
      try {
       const res = await newGoalService.putEstudiante(this.estudiante)
       this.alert = {
          show: true,
          color: "success",
          message: "Estudiante modificado corectamente",
        };
      } catch (error) {
        console.log(error);
        this.alert = {
          show: true,
          color: "warning",
          message: "Error al intentar modificar estudiante",
        };
      }
    }
},

    mounted(){
        // this.obtenerEstudiantes()
    this.obtenerEstudianteById()
    this.leerEstados();
    this.leerDiscapacidades();
    this.leerGeneros();
    this.leerNivelEducativo();
    this.leerNivelIngles();
    this.leerNacionalidades()
    }
}
</script>