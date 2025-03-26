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
      component: () => import("../views/MainView.Vue"),
      meta: { requiresAuth: true },
    },
    {
      path: "/nuketown",
      name: "Nuketown",
      component: () => import("../views/NuketownView.vue"),
      meta: { requiresAuth: true },
    },
    {
      path: "/estudiantes",
      name: "Listado_Estudiantes",
      component: () => import("../views/ListadoEstudiantesView.vue"),
      meta: { requiresAuth: true },
    },
    {
      path: "/representantes",
      name: "Listado_Representantes",
      component: () => import("../views/ListadoRepresentantesView.vue"),
      meta: { requiresAuth: true },
    },
    {
      path: "/registrar/cliente",
      name: "Registro_Clientes",
      component: () => import("../views/RegistrarClienteView.vue"),
      meta: { requiresAuth: true },
    },
    {
      path: "/periodos",
      name: "Periodos",
      component: () => import("../views/PeriodosView.vue"),
      meta: { requiresAuth: true },
    },
    {
      path: "/transsacciones",
      name: "Transsacciones",
      component: () => import("../views/TranssaccionesView.vue"),
      meta: { requiresAuth: true },
    },
  ],
});
router.beforeEach((to, from, next) => {
  const isAuthenticated = sessionStorage.getItem('token');
  
  if (to.meta.requiresAuth && !isAuthenticated) {
    next('/');
  } 
  // // Si el usuario está autenticado pero intenta acceder al login
  // else if (isAuthenticated && to.path === '/main') {
  //   next('/'); // Redirige al inicio
  // } 
  else {
    next(); // Permite la navegación
  }
});
export default router;
