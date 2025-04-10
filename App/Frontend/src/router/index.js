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
      meta: { requiresAuth: true, allowedRoles: ['1', '2'] },
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
    {
      path: "/inscripciones",
      name: "Inscripciones",
      component: () => import("../views/InscripcionesView.vue"),
      meta: { requiresAuth: true },
    },
    {
      path: "/usuarios",
      name: "Usuarios",
      component: () => import("../views/UsuariosView.vue"),
      meta: { requiresAuth: true, allowedRoles: ['1'] },
    },
  ],
});
router.beforeEach((to, from, next) => {
  const isAuthenticated = sessionStorage.getItem("token");
  const userRole = sessionStorage.getItem("role");
  console.log(sessionStorage.getItem("role"));

  if (to.meta.requiresAuth && !isAuthenticated) {
    next("/");
  } else {
    next(); // Permite la navegación
  }
 if(to.meta.allowedRoles && !userRole){
 return next("/main")
 }
  // // Si el usuario está autenticado pero intenta acceder al login
  // else if (isAuthenticated && to.path === '/main') {
  //   next('/'); // Redirige al inicio
  // }
});
export default router;
