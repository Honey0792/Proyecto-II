<template>
    <NavBar />
  <div id="app" class="app-container">
    <div id="router" class="content-container">
      <router-view v-slot="{ Component }">
        <transition name="fade">
          <component :is="Component" />
        </transition>
      </router-view>
    </div>
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
    NavBar
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
