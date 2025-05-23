<template>
  <v-layout class="ma-3">
    <v-app-bar color="#FF9100">
      <v-app-bar-nav-icon
        variant="text"
        @click.stop="drawer = !drawer"
      ></v-app-bar-nav-icon>

      <v-toolbar-title>New Goal</v-toolbar-title>

      <v-spacer></v-spacer>

      <template v-if="$vuetify.display.mdAndUp">
        <v-btn title="Salir" icon="mdi-logout" variant="text" @click="cerrarSesion()"></v-btn>
      </template>
    </v-app-bar>

    <v-navigation-drawer
      v-model="drawer"
      :location="$vuetify.display.mobile ? 'bottom' : undefined"
      temporary
    >
      <!-- <v-menu>
        <template v-slot:activator="{ props }"> -->
      <v-list>
        <v-list-item to="/main" prepend-icon="mdi-home"> Home </v-list-item>
        <v-list-item to="/estudiantes" prepend-icon="mdi-account-school">
          Estudiantes
        </v-list-item>
        <v-list-item
          to="/representantes"
          prepend-icon="mdi-human-male-female-child"
        >
          Representantes
        </v-list-item>
        <v-list-item to="/periodos" prepend-icon="mdi-calendar">
          Periodos
        </v-list-item>
        <v-list-item
          v-show="esVisible"
          to="/transacciones"
          prepend-icon="mdi-cash-register"
        >
          Transacciones
        </v-list-item>
        <v-list-item to="/inscripciones" prepend-icon="mdi-text-box-edit">
          Inscripciones
        </v-list-item>
        <v-list-item
          v-show="esVisible"
          to="/notas"
          prepend-icon="mdi-chair-school"
        >
          Notas
        </v-list-item>
        <v-list-item
          v-show="esVisible"
          to="/usuarios"
          prepend-icon="mdi-account-group"
        >
          Usuarios
        </v-list-item>
        <v-list-item
          v-show="esVisible"
          to="/empleados"
          prepend-icon="mdi-briefcase"
        >
          Empleados
        </v-list-item>
        <!-- <v-list-item to="/nuketown" prepend-icon="mdi-nuke">
          Nuketown
        </v-list-item> -->
      </v-list>
      <!-- </template> -->

      <!-- </v-menu> -->
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
  methods: {
    cerrarSesion() {
      sessionStorage.clear();
      this.$router.push("/").then(() => {
        this.$router.go(0);
      });
    },
  },
  computed: {
    esVisible() {
      return sessionStorage.getItem("role") === "1";
    },
  },
  watch: {
    group() {
      this.drawer = false;
    },
  },
};
</script>
