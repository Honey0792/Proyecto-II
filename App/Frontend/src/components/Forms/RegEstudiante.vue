<template>
  <v-form>
    <v-card class="ma-7">
      <v-card-title class="bg-cyan-lighten-5">
        Registro de Estudiante
      </v-card-title>
      <v-card-text class="d-flex flex-column aling-center justify-center pa-0">
        <h3 class="pa-3">Datos de la Inscripcion</h3>
        <v-divider></v-divider>
        <v-container class="">
          <v-row>
            <v-col>
              <v-text-field
                variant="outlined"
                type="date"
                label="Fecha de Inscripcion"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                variant="outlined"
                type="date"
                label="Fecha de Inicio"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                variant="outlined"
                type="date"
                label="Fecha de Culminacion"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-select variant="outlined" label="Grupo"></v-select>
            </v-col>
            <v-col>
              <v-select label="Nivel" variant="outlined"></v-select>
            </v-col>
          </v-row>
        </v-container>
        <v-divider></v-divider>

        <h3 class="pa-3">Datos Del Estudiante</h3>

        <v-divider></v-divider>
        <v-container class="">
          <v-row>
            <v-col>
              <v-text-field v-model="estudiante.nombre" variant="outlined" label="Nombres"></v-text-field>
            </v-col>
            <v-col>
              <v-text-field variant="outlined" label="Apellidos"></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
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
              <v-select variant="outlined" label="Grado Escolar"></v-select>
            </v-col>
            <v-col>
              <v-select label="Nivel de Ingles" variant="outlined"></v-select>
            </v-col>
            <v-col>
              <v-select label="Alergias" variant="outlined"></v-select>
            </v-col>
          </v-row>
        </v-container>
        <v-divider class="mx-8"></v-divider>
        <v-container>
          <v-row class="mx-auto">
            <v-col class="d-flex">
              <v-checkbox class="mx-3" v-model="activate" title=""></v-checkbox>
              <v-text-field 
              :disabled="activate"
              type="" variant="outlined" hint="Marque la casilla si el estudiante no posee cedula" label="Cedula">
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field variant="outlined" label="Ocupacion">
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field variant="outlined" label="Direccion">
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
        <v-btn class="text-white bg-orange-lighten-2 mx-auto" type="submit">Registrar</v-btn>
        <v-btn @click="clear" class="text-white bg-orange-lighten-2 mx-auto">Limpiar</v-btn>
      </v-container>
      </v-card-text>
    </v-card>
  </v-form>
</template>
<script>
export default {


  data: () => ({
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
    activate: false
  }),
 
};
</script>
