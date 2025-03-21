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
      path: "/main",
      name: "Main",
      component: () => import("../views/MainView.Vue")
    },
    {
      path: "/nuketown",
      name: "Nuketown",
      component: () => import("../views/NuketownView.vue")
    },
    {
      path: "/estudiantes",
      name: "Listado_Estudiantes",
      component: () => import("../views/ListadoEstudiantesView.vue")
    },
    {
      path: "/representantes",
      name: "Listado_Representantes",
      component: () => import("../views/ListadoRepresentantesView.vue")
    },
    {
      path: "/registrar/cliente",
      name: "Registro_Clientes",
      component: () => import("../views/RegistrarClienteView.vue")
    },
    {
      path: "/periodos",
      name: "Periodos",
      component: () => import("../views/PeriodosView.vue")
    },
  ],
});

export default router;
