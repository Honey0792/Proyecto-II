import { createRouter, createWebHistory } from "vue-router";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "Login",
      component: () => import("../views/LoginView.vue"),
    },
    {
      path: "/Main",
      name: "Main",
      component: () => import("../views/MainView.Vue")
    }
  ],
});

export default router;
