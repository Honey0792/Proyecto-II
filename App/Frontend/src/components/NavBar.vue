<template>
  <v-layout class="ma-3">

    <!-- ================= APP BAR ================= -->
    <v-app-bar
      elevation="4"
      class="px-4"
      style="background: linear-gradient(90deg, #FF9100, #FF6D00);"
    >
      <v-app-bar-nav-icon
        variant="text"
        color="white"
        @click.stop="drawer = !drawer"
      />

      <v-toolbar-title class="font-weight-bold text-white">
        New Goal English Academy
      </v-toolbar-title>

      <v-spacer />

      <!-- Usuario -->
      <div class="d-flex align-center mr-4">
        <v-avatar color="white" size="40" class="mr-3">
          <span class="text-orange-darken-2 font-weight-bold">
            {{ nombre_persona?.charAt(0) }}
          </span>
        </v-avatar>

        <div class="text-white text-right">
          <div class="text-subtitle-2 font-weight-bold">
            {{ nombre_persona }} {{ apellido_persona }}
          </div>
          <div class="text-caption">
            {{ cargo_persona }}
          </div>
        </div>
      </div>

      <v-btn
        icon="mdi-logout"
        variant="text"
        color="white"
        title="Cerrar sesión"
        @click="cerrarSesion"
      />
    </v-app-bar>

    <!-- ================= DRAWER ================= -->
    <v-navigation-drawer
      v-model="drawer"
      elevation="6"
      width="280"
      permanent
    >
      <!-- Header del Drawer -->
      <v-sheet
        color="orange-lighten-5"
        class="pa-4 text-center"
      >
        <v-icon size="40" color="orange-darken-2">mdi-school</v-icon>
        <div class="text-subtitle-1 font-weight-bold mt-2">
          Panel Administrativo
        </div>
      </v-sheet>

      <v-list nav>

        <!-- ADMINISTRACIÓN -->
        <v-list-group
          v-if="esVisible"
          prepend-icon="mdi-account-group"
          value="administracion"
        >
          <template v-slot:activator="{ props }">
            <v-list-item
              v-bind="props"
              title="Administración"
              class="font-weight-medium"
            />
          </template>

          <v-list-item
            to="/analiticas"
            title="Analíticas"
            prepend-icon="mdi-home-analytics"
            class="rounded-lg mx-2 my-1"
          />
          <v-list-item
            to="/usuarios"
            title="Usuarios"
            prepend-icon="mdi-account-group"
            class="rounded-lg mx-2 my-1"
          />
          <v-list-item
            to="/empleados"
            title="Empleados"
            prepend-icon="mdi-briefcase"
            class="rounded-lg mx-2 my-1"
          />
          <v-list-item
            to="/niveles"
            title="Niveles"
            prepend-icon="mdi-book-multiple"
            class="rounded-lg mx-2 my-1"
          />
        </v-list-group>

        <!-- FINANCIERO -->
        <v-list-group
          prepend-icon="mdi-cash-multiple"
          value="financiero"
        >
          <template v-slot:activator="{ props }">
            <v-list-item
              v-bind="props"
              title="Financiero"
              class="font-weight-medium"
            />
          </template>

          <v-list-item
            to="/transacciones"
            title="Transacciones"
            prepend-icon="mdi-cash-register"
            class="rounded-lg mx-2 my-1"
          />
        </v-list-group>

        <!-- ACADÉMICO -->
        <v-list-group
          prepend-icon="mdi-school"
          value="academico"
        >
          <template v-slot:activator="{ props }">
            <v-list-item
              v-bind="props"
              title="Académico"
              class="font-weight-medium"
            />
          </template>

          <v-list-item
            to="/main"
            title="Home"
            prepend-icon="mdi-home"
            class="rounded-lg mx-2 my-1"
          />
          <v-list-item
            to="/estudiantes"
            title="Estudiantes"
            prepend-icon="mdi-account-school"
            class="rounded-lg mx-2 my-1"
          />
          <v-list-item
            to="/representantes"
            title="Representantes"
            prepend-icon="mdi-human-male-female-child"
            class="rounded-lg mx-2 my-1"
          />
          <v-list-item
            to="/periodos"
            title="Periodos"
            prepend-icon="mdi-calendar"
            class="rounded-lg mx-2 my-1"
          />
          <v-list-item
            to="/inscripciones"
            title="Inscripciones"
            prepend-icon="mdi-text-box-edit"
            class="rounded-lg mx-2 my-1"
          />
          <v-list-item
            to="/notas"
            title="Notas"
            prepend-icon="mdi-chair-school"
            class="rounded-lg mx-2 my-1"
          />
        </v-list-group>

      </v-list>
    </v-navigation-drawer>

    <v-main />
  </v-layout>
</template>

<script>
import newGoalService from "@/services/newGoalService";

export default {
  data: () => ({
    nombre_persona: null,
    apellido_persona: null,
    cargo_persona: null,
    drawer: false,
  }),

  computed: {
    esVisible() {
      return sessionStorage.getItem("role") === "1";
    },
  },

  methods: {
    async obtenerDatosMain() {
      try {
        const res = await newGoalService.getHome();
        const usuario = res.data.usuario[0];

        this.nombre_persona = usuario.nombre_persona;
        this.apellido_persona = usuario.apellido_persona;
        this.cargo_persona = usuario.cargo_persona;

      } catch (error) {
        console.error(error);
      }
    },

    cerrarSesion() {
      sessionStorage.clear();
      this.$router.push("/").then(() => {
        this.$router.go(0);
      });
    },
  },

  mounted() {
    this.obtenerDatosMain();
  },
};
</script>

<style scoped>
.v-list-item--active {
  background-color: rgba(255, 145, 0, 0.15) !important;
  border-left: 4px solid #FF9100;
  border-radius: 8px;
}
</style>
