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
    <v-form @submit.prevent="registrarPersona">
      <h3 class="pa-3">Registrar Persona</h3>
      <v-divider></v-divider>
      <v-container class="">
        <v-row>
          <v-col>
            <v-text-field variant="outlined" label="Nombre" v-model="persona.nombre"></v-text-field>
          </v-col>
          <v-col>
            <v-text-field label="Apellido" variant="outlined" v-model="persona.apellido"></v-text-field>
          </v-col>
        </v-row>
      </v-container>
      <v-container>
        <v-row>
          <v-col>
            <v-text-field variant="outlined" label="Cedula" v-model="persona.cedula"></v-text-field>
          </v-col>
          <v-col>
            <v-text-field variant="outlined" label="Cargo" v-model="persona.cargo"></v-text-field>
          </v-col>
        </v-row>
        <div class="d-flex justify-center">
          <v-btn type="submit">Registrar</v-btn>
        </div>
      </v-container>
    </v-form>
    <v-divider></v-divider>
    <TablaPersonas />
  </v-card>
</template>
<script>
import newGoalService from '@/services/newGoalService';
import TablaPersonas from '../Tables/tablaPersonas.vue';

export default {
  components: {TablaPersonas},
  data: () => ({
    alert: { show: false, message: "" },
    persona: {
      nombre: null,
      apellido: null,
      cedula: null,
      cargo: null,
    },
  }),
  methods: {
   async registrarPersona(){
    try {
        const res = await newGoalService.postPersonas(this.persona)
        console.log(res)
        this.alert = {
          show: true,
          color: 'success',
          message: "Persona registrada corectamente",
        }
      } catch (error) {
        console.log(error);
        this.alert = {
          show: true,
          color: 'warning',
          message: "Persona no registrada",
        }
        
      }
   },
  },
};
</script>
