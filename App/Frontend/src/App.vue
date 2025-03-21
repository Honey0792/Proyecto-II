<template>
   <div class="app-container">
    <NavBar v-if="!isLoginPage" />
    <main class="main-content">
      <router-view v-slot="{ Component }">
        <component :is="Component" />
      </router-view>
    </main>
    <Footer />
  </div>
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

  computed: {
    // Computed property para verificar si la ruta actual es 'login'
    isLoginPage() {
      return this.$route.name === "Login";
    },
  },
};
</script>

<style scoped>
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
</style>