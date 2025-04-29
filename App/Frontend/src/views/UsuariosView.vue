<template>
  
    <v-tabs
        v-model="tab"
      >
        <v-tab @click="refrescarUsuarios" value="one">Usuarios</v-tab>
        <v-tab value="two">Registrar</v-tab>
      </v-tabs>
  
        <v-tabs-window v-model="tab">
          <v-tabs-window-item value="one">
<CartaUsuarios ref="hijo" />
          </v-tabs-window-item>
  
          <v-tabs-window-item value="two">
<RegSesion />
          </v-tabs-window-item>
        </v-tabs-window>
  
  </template>
  
  <script>
  import CartaUsuarios from "@/components/Cards/CartaUsuarios.vue";
import RegSesion from "@/components/Forms/RegSesion.vue";
  export default {
    components: {
CartaUsuarios,
RegSesion,
    },
    data: () => ({
      tab: null,
    }),
    methods:{
      refrescarUsuarios(){
        this.$refs.hijo.obtenerUsuarios()
      }
    },
  };
  </script>