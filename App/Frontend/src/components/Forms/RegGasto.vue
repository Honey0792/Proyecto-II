<template>
  <v-form>
    <v-card class="ma-7">
      <h3 class="pa-3">Datos del Gasto</h3>
      <v-divider></v-divider>
      <v-container class="">
        <v-row>
          <v-col>
            <v-select label="Tipo de Gasto" variant="outlined"></v-select>
          </v-col>
          <v-col>
            <v-select label="Metodo de Pago" variant="outlined"></v-select>
          </v-col>
        </v-row>
    </v-container>
          <v-container>
            <v-row>
                <v-col>
            <v-text-field
              variant="outlined"
              type="date"
              label="Fecha del Gasto"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-text-field
              variant="outlined"
              type="number"
              label="Monto"
            ></v-text-field>
          </v-col>
            </v-row>
          </v-container>
          <v-container>
            <v-row>
          <v-col>
            <v-text-field
              variant="outlined"
              label="Nombre del Gasto"
            ></v-text-field>
          </v-col>
        </v-row>
        </v-container>
        <v-container>
            <v-row>
                <v-col>
            <v-textarea
              variant="outlined"
              label="Descripcion"
              rows="4"
              no-resize
            ></v-textarea>
          </v-col>
            </v-row>
        </v-container>
      <v-divider></v-divider>
    </v-card>
  </v-form>
</template>

<script>


</script>