<template>
  <v-layout class="ma-3">
    <v-app-bar color="#FF9100">
      <v-app-bar-nav-icon
        variant="text"
        @click.stop="drawer = !drawer"
      ></v-app-bar-nav-icon>

      <v-toolbar-title>New Goal</v-toolbar-title>

      <v-spacer></v-spacer>

     <h4 class="ma-3"> {{ this.datosMain.nombre_persona }} {{ this.datosMain.apellido_persona }} <br>
    <h5>{{ this.datosMain.cargo_persona }} </h5>
    </h4>

      <template v-if="$vuetify.display.mdAndUp">
        <v-btn
          title="Salir"
          icon="mdi-logout"
          variant="text"
          @click="cerrarSesion()"
        ></v-btn>
      </template>
    </v-app-bar>

    <v-navigation-drawer
      v-model="drawer"
      :location="$vuetify.display.mobile ? 'bottom' : undefined"
      temporary
    >
      <!-- <v-menu>
        <template v-slot:activator="{ props }"> -->
      <!-- <v-list>
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
        <v-list-item to="/nuketown" prepend-icon="mdi-nuke">
          Nuketown
        </v-list-item> -->
      <!-- </v-list> -->
      <!-- </template> -->
      <v-list>
        <!-- Administración -->
        <v-list-group
          v-if="esVisible"
          prepend-icon="mdi-account-group"
          value="administracion"
        >
          <template v-slot:activator="{ props }">
            <v-list-item v-bind="props" title="Administración" />
          </template>

          <v-list-item
            to="/usuarios"
            title="Usuarios"
            prepend-icon="mdi-account-group"
          />
          <v-list-item
            to="/empleados"
            title="Empleados"
            prepend-icon="mdi-briefcase"
          />
          <v-list-item
            to="/niveles"
            title="Niveles"
            prepend-icon="mdi-book-multiple"
          ></v-list-item>
        </v-list-group>

        <!-- Financiero -->
        <v-list-group
          v-if="esVisible"
          prepend-icon="mdi-cash-multiple"
          value="financiero"
        >
          <template v-slot:activator="{ props }">
            <v-list-item v-bind="props" title="Financiero" />
          </template>

          <v-list-item
            to="/transacciones"
            title="Transacciones"
            prepend-icon="mdi-cash-register"
          />
        </v-list-group>

        <!-- Académico -->
        <v-list-group prepend-icon="mdi-school" value="academico">
          <template v-slot:activator="{ props }">
            <v-list-item v-bind="props" title="Académico" />
          </template>

          <v-list-item to="/main" title="Home" prepend-icon="mdi-home" />
          <v-list-item
            to="/estudiantes"
            title="Estudiantes"
            prepend-icon="mdi-account-school"
          />
          <v-list-item
            to="/representantes"
            title="Representantes"
            prepend-icon="mdi-human-male-female-child"
          />
          <v-list-item
            to="/periodos"
            title="Periodos"
            prepend-icon="mdi-calendar"
          />
          <v-list-item
            to="/inscripciones"
            title="Inscripciones"
            prepend-icon="mdi-text-box-edit"
          />
          <v-list-item
            to="/notas"
            title="Notas"
            prepend-icon="mdi-chair-school"
          />
        </v-list-group>
      </v-list>
    </v-navigation-drawer>
    <v-main style="height: 20px"> </v-main>
  </v-layout>
</template>
<script>
import newGoalService from '@/services/newGoalService';

export default {
  data: () => ({
      datosMain: null,
    drawer: false,
    group: null,
  }),
  methods: {
        async obtenerDatosMain() {
      try {
        const res = await newGoalService.getHome();
        this.datosMain = res.data.usuario[0];
        console.log("datos main", this.datosMain);

        // Selecciona el último período por defecto
        // if (this.datosMain.length > 0) {
        //   this.selectedPeriodoId = this.datosMain[0].id_periodo;
        // }
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
  mounted(){
    this.obtenerDatosMain()
  }
};
</script>
