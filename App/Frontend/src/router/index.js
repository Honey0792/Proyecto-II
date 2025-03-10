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
    },
    {
      path: "/Representantes",
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
      name: "viewPeriodos",
      component: () => import("../views/periodosView.vue")
    },
    {
      path: "/pagos",
      name: "viewPagos",
      component: () => import("../views/pagosView.vue")
    }
  ],
});

export default router;
