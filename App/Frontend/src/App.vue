<template>
  <div id="router">
    <NavBar/>
    <router-view v-slot="{ Component }">
      <component :is="Component" />
    </router-view>
    <Footer />
  </div>
</template>

<script>
import Footer from "@/components/Footer.vue";
import { RouterLink, RouterView } from "vue-router";
import NavBar from "./components/NavBar.vue";

export default {
  components: {
    Footer,
    NavBar,
  },
};
</script>

<style scoped>
.app-container {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}
.content-container {
  flex: 1; /* Esto asegura que el contenido principal ocupe todo el espacio disponible */
}
footer {
  width: 100%;
  background-color: #f8f9fa;
  text-align: center;
}
</style>
