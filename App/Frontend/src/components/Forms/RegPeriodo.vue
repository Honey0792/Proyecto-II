<template>
        <v-card width="1200" >
          <h3 class="pa-3">Datos de la Inscripcion</h3>
          <v-form @submit.prevent="">
            <v-divider></v-divider>
            <v-container class="">
              <v-row>
                <v-col>
                  <v-text-field
                    variant="outlined"
                    label="Nombre"
                  ></v-text-field>
                </v-col>
              </v-row>
              <v-row>
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
              </v-row>
              <v-row>
                <v-col>
                  <v-text-field
                    label="Año Academico"
                    variant="outlined"
                    type="number"
                    min="2000"
                  ></v-text-field>
                </v-col>
                <v-col>
                  <v-select
                    label="Estado"
                    variant="outlined"
                    :items="estados"
                    item-title="nombre_estado"
                    item-value="id_estado"
                  ></v-select>
                </v-col>
              </v-row>
              <v-btn
                class="text-white bg-orange-lighten-2 mx-auto"
                type="submit"
                >Crear</v-btn
              >
            </v-container>
          </v-form>
          <v-divider></v-divider>
          <h3 class="pa-3">Periodos Academicos</h3>
          <v-divider></v-divider>
          <tablaPeriodos />
        </v-card>
</template>

<script>
import newGoalService from "@/services/newGoalService";
import tablaPeriodos from "../Tables/tablaPeriodos.vue";
export default {
  components: {
    tablaPeriodos,
  },
  data: () => ({
    estados: [],
  }),
  methods: {
    async leerEstados() {
      try {
        console.log("hola");
        const res = await newGoalService.getEstado();
        this.estados = res.data.datos;
      } catch (error) {
        console.log(error);
      }
    },
  },
  mounted() {
    this.leerEstados();
  },
};
</script>
