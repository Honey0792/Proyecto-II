<template>
    <v-form>
  <v-card class="ma-7">
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
  </v-card>
</v-form>
</template>

<script>
export default {
  data: () => ({}),
};
</script>
