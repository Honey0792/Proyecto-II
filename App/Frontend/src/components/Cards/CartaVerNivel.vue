<template>
      <v-card class="ma-7">
    <h3 class="pa-3">Añadir Nivel</h3>
    <v-divider></v-divider>
    <v-container>
      <v-form>
        <v-row>
          <v-col>
            <v-text-field
            readonly
              variant="outlined"
              label="Grupo/Categoria"
              v-model="nivel.categoria"
              :rules="globalRules"
            >
            </v-text-field>
          </v-col>
          <v-col>
            <v-text-field
            readonly
              variant="outlined"
              label="Nombre"
              v-model="nivel.nombre"
              :rules="globalRules"
            >
            </v-text-field>
          </v-col>
          <v-col>
            <v-text-field
            readonly
              variant="outlined"
              label="Descripción"
              v-model="nivel.descripcion"
              :rules="globalRules"
            >
            </v-text-field>
          </v-col>
        </v-row>
        <!-- <div class="d-flex pa-4 justify-center">
          <v-btn type="submit">Agregar</v-btn>
        </div> -->
      </v-form>
    </v-container>
  </v-card>
</template>

<script>
import newGoalService from '@/services/newGoalService';

export default{
      props: {
    id: {
      type: Number,
      required: true,
    },
  },
  data: () => ({
    alert: { show: false, message: "" },
    nivel: {
      id_nivel: null,
      categoria: null,
      nombre: null,
      descripcion: null,
    },
    globalRules: [(value) => !!value || "Requerido"],
  }),

  methods:{
       async obtenerNivelPorId() {
      try {
        const res = await newGoalService.getNivel(this.id);
        console.log("nivel id", res);
        const datosApi = res.data[0];
        this.nivel.categoria = datosApi.categoria_nivel;
        this.nivel.nombre = datosApi.nombre_nivel;
        this.nivel.descripcion = datosApi.descripcion_nivel;
        this.nivel.id_nivel = datosApi.id_nivel
      } catch (error) {
        console.log(error);
      }
    },
  },
  mounted(){
    this.obtenerNivelPorId()
  }
}
</script>