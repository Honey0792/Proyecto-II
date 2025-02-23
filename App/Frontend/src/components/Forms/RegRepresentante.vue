<template>
  <v-form>
    <v-card class="ma-7">
      <v-card-title class="bg-cyan-lighten-5">
        Registro de Representante
      </v-card-title>
      <v-card-text class="d-flex flex-column aling-center justify-center pa-0">
        <h3 class="pa-3">Datos Del Representante</h3>

        <v-divider></v-divider>
        <v-container class="">
          <v-row>
            <v-col>
              <v-text-field variant="outlined" label="Nombres"></v-text-field>
            </v-col>
            <v-col>
              <v-text-field variant="outlined" label="Apellidos"></v-text-field>
            </v-col>
            <v-col>
              <v-select
                variant="outlined"
                label="Genero"
                :items="generos"
                item-title="nombre_genero"
                item-value="id_genero"
              ></v-select>
            </v-col>
            <v-divider class="mx-8"></v-divider>
          </v-row>
        </v-container>
        <v-container>
          <v-row>
            <v-col>
              <v-text-field variant="outlined" label="Cedula"> </v-text-field>
            </v-col>
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
        <v-divider class="mx-8"></v-divider>
        <v-container>
          <v-row class="mx-auto">
            <v-col class="d-flex">
              <v-textarea rows="3" no-resize type="" variant="outlined" label="Dirección">
              </v-textarea>
            </v-col>
          </v-row>
        </v-container>
        <v-divider class="mx-8"></v-divider>
        <v-container class="">
          <v-row> </v-row>
        </v-container>
      </v-card-text>
    </v-card>
  </v-form>
</template>

<script>
import newGoalService from "@/services/newGoalService";

export default {
  data: () => ({
    generos: [],
  }),

  methods: {
    async leerGeneros() {
      try {
        const res = await newGoalService.getGenero();
        this.generos = res.data.datos;
      } catch (error) {
        console.log(error);
      }
    },
  },
  mounted(){
    this.leerGeneros()
  }
};
</script>
