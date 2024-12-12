<template>
  <header>
  <nav>
  <v-card>
    <v-layout>
      <v-app-bar color="#FF9100" prominent class="text-white">
        <v-app-bar-nav-icon
          variant="text"
          @click.stop="drawer = !drawer"
        ></v-app-bar-nav-icon>

        <v-spacer></v-spacer>

        <template v-if="$vuetify.display.mdAndUp">
          <v-btn icon="mdi-magnify" variant="text"></v-btn>

          <v-btn icon="mdi-home" variant="text"></v-btn>
        </template>

        <v-btn icon="mdi-dots-vertical" variant="text"></v-btn>
      </v-app-bar>

      <v-navigation-drawer
        v-model="drawer"
        :location="$vuetify.display.mobile ? 'bottom' : undefined"
        temporary
      >
        <v-list :items="items"></v-list>
      </v-navigation-drawer>
    </v-layout>
  </v-card>
</nav>
</header>
</template>

<script>
export default {
  data: () => ({
    drawer: false,
    group: null,
    items: [
      {
        title: "Estudiantes",
        value: "Estudiantes",
      },
      {
        title: "Pagos",
        value: "Pagos",
      },
      {
        title: "Gastos",
        value: "Gastos",
      },
      {
        title: "Periodos",
        value: "Periodos",
      },
    ],
  }),

  watch: {
    group() {
      this.drawer = false;
    },
  },
};
</script>

