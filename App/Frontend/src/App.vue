<template>
  <NavBar v-if="!isLoginPage" />
 <v-app>
    <!-- <main class="main-content"> -->
      <v-main>
      <router-view v-slot="{ Component }">
        <component :is="Component" />
      </router-view>
    </v-main>
    <!-- </main> -->
  </v-app>
  <Footer />
  <!-- <NavBar v-if="!isLoginPage" />

  <router-view v-slot="{ Component }">
    <component :is="Component" />
  </router-view>

  <Footer /> -->
</template>

<script>
import Footer from "@/components/Footer.vue";
import { RouterLink, RouterView } from "vue-router";
import NavBar from "./components/NavBar.vue";
import newGoalApi from "./services/newGoalApi";
import newGoalService from "./services/newGoalService";

export default {
  components: {
    Footer,
    NavBar,
  },
 methods:{
  // async obtenerRepresentanteById() {
  //     try {
  //       const res = await newGoalService.getRepresentanteById(6);
  //       console.log(res)
  //     } catch (error) {
  //       console.log(error);
  //       if(error.status == 400){
  //       this.$router.push('/')
  //     }
  //     }
  //   },
 },
  computed: {
    // Computed property para verificar si la ruta actual es 'login'
    isLoginPage() {
      return this.$route.name === "Login";
    },
  },
  mounted(){
    // this.obtenerRepresentanteById()
  }
};
</script>
<style>
/* Asegura que el contenedor ocupe toda la altura */
.v-application {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
} */

/* Empuja el footer hacia abajo */
 .v-main {
  flex: 1 0 auto;
}
</style>
<!-- <style scoped>
.app-container {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.main-content {
  flex: 1 0 auto;
}
html, body {
  height: 100%;
  margin: 0;
}
</style> -->