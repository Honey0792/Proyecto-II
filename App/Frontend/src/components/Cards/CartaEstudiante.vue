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
                v-model="estudiante.nombre_etd"
                variant="plain"
                label="Nombres"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                variant="plain"
                v-model="estudiante.apellido_etd"
                label="Apellidos"
              >
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                v-model="estudiante.fecha_nacimiento_etd"
                variant="plain"
                type=""
                label="Fecha de Nacimiento"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                variant="plain"
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
                variant="plain"
                label="Nivel de Educación"
                :items="nivelEducativo"
                item-title="nombre_nv_edu"
                item-value="id_nv_edu"
                v-model="estudiante.id_nv_edu"
              ></v-select>
            </v-col>
            <v-col>
              <v-select
                label="Nivel de Ingles"
                variant="plain"
                v-model="estudiante.id_nivel_ingles"
                :items="levelEnglish"
                item-title="nombre_nivel_ingles"
                item-value="id_nivel_ingles"
              ></v-select>
            </v-col>
            <v-col>
              <v-select
                variant="plain"
                label="Estado"
                v-model="estudiante.id_estado"
                :items="estados"
                item-title="nombre_estado"
                item-value="id_estado"
              >
              </v-select>
            </v-col>
            <v-col>
              <v-select 
              variant="plain"
              label="Nacionalidad"
              v-model="estudiante.id_ncd"
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
                variant="plain"
                v-model="estudiante.id_discd"
                :items="discapacidades"
                item-title="nombre_discd"
                item-value="id_discd"
              ></v-select>
            </v-col>
            <v-col>
              <v-select
                variant="plain"
                label="genero"
                v-model="estudiante.id_genero"
                :items="generos"
                item-title="nombre_genero"
                item-value="id_genero"
              >
              </v-select>
            </v-col>
            <v-col>
              <v-text-field
                label="Persona que registro"
                variant="plain"
                v-model="estudiante.id_persona"
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
                variant="plain"
                hint="Desmarque la casilla si el estudiante no posee cedula"
                label="Cedula"
                v-model="estudiante.cedula_etd"
              >
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                v-model="estudiante.contacto_emergencia_etd"
                variant="plain"
                label="Contacto de emergencia"
              >
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                variant="plain"
                label="Encargado/s de retirar el Estudiante"
                v-model="estudiante.quien_retira_etd"
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
                variant="plain"
                label="Numero de Telefono"
                v-model="estudiante.telefono_etd"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                v-model="estudiante.direccion_etd"
                variant="plain"
                label="Direccion"
              >
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                v-model="estudiante.correo_etd"
                type="email"
                variant="plain"
                label="Correo Electronico"
              >
              </v-text-field>
            </v-col>
          </v-row>
        </v-container>
        <v-container class="d-flex aling-center">
        </v-container>
      </v-card-text>
    </v-form>
    </v-card>
</template>


<script>
import newGoalService from '@/services/newGoalService';
export default {
data: () => ({
  nacionalidades: [],
    levelEnglish: [],
    nivelEducativo: [],
    discapacidades: [],
    estados: [],
    generos: [],
    estudiante:{
      id_estado: null, //Requerido
      id_discd: null, //Opcional
      id_genero: null, //Requerido
     id_nv_edu: null, //Requerido
      id_ncd: null, //Requerido
      id_nivel_ingles: null, //Opcional pronto requerido
      id_persona: null, //Requerido
      nombre_etd:null, //Requerido
      apellido_etd:null, //Requerido
      fecha_nacimiento_etd: null, //Requerido
      cedula_etd: null, //Requerido pronto Opcional
      direccion_etd:null, //Requerido
      telefono_etd:null, //Requerido
      correo_etd:null, //Requerido
      contacto_emergencia_etd: null, //Requerido
      quien_retira_etd: null, //Opcional
      // edad: null,
    },
}),
methods: {


async obtenerEstudianteById (){
try {

    const res = await newGoalService.getEstudianteById(1)
    const datosApi = res.data.datos;

// Itera sobre las propiedades de `estudiante`
for (const key in this.estudiante) {
  if (datosApi.hasOwnProperty(key)) {
    this.estudiante[key] = datosApi[key];
  }
}

console.log("Estudiante actualizado:", this.estudiante);
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