<template>
  <v-layout>
    <v-app-bar color="#FF9100">
      <v-app-bar-nav-icon
        variant="text"
        @click.stop="drawer = !drawer"
      ></v-app-bar-nav-icon>

      <v-toolbar-title>New Goal</v-toolbar-title>

      <v-spacer></v-spacer>

      <template v-if="$vuetify.display.mdAndUp">
        <v-btn icon="mdi-magnify" variant="text"></v-btn>

        <v-btn icon="mdi-filter" variant="text"></v-btn>
      </template>

      <v-btn icon="mdi-dots-vertical" variant="text"></v-btn>
    </v-app-bar>

    <v-navigation-drawer
      v-model="drawer"
      :location="$vuetify.display.mobile ? 'bottom' : undefined"
      temporary
    >
    <v-menu>
      <template v-slot:activator="{ props }">
      <v-list :props> 
        <v-list-item
        to="/Main">
          Home
        </v-list-item>
        <v-list-item
        to="/Nuketown">
          Nuketown
        </v-list-item>
        <v-list-item
        to="/Estudiantes">
          Estudiantes
        </v-list-item>
      </v-list>
    </template>
    <v-list>
      <v-list-item @click="accion1">Opción 1</v-list-item>
      <v-list-item @click="accion2">Opción 2</v-list-item>
    </v-list>
    </v-menu>
    </v-navigation-drawer>
    <v-main style="height: 20px"> </v-main>
  </v-layout>
</template>
<script>
export default {
  data: () => ({
    drawer: false,
    group: null,
  }),

  watch: {
    group() {
      this.drawer = false;
    },
  },
};
</script>
