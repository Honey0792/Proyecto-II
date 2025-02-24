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
    },
    {
      path: "/Nuketown",
      name: "Nuketown",
      component: () => import("../views/NuketownView.vue")
    },
    {
      path: "/Estudiantes",
      name: "Listado_Estudiantes",
      component: () => import("../views/ListadoEstudiantesView.vue")
    }
  ],
});

export default router;
