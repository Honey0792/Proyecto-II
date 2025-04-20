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
      meta: { requiresAuth: true, allowedRoles: ["1", "2"] },
    },
    {
      path: "/nuketown",
      name: "Nuketown",
      component: () => import("../views/NuketownView.vue"),
      meta: { requiresAuth: true, allowedRoles: ["1", "2"] },
    },
    {
      path: "/estudiantes",
      name: "Listado_Estudiantes",
      component: () => import("../views/ListadoEstudiantesView.vue"),
      meta: { requiresAuth: true, allowedRoles: ["1", "2"] },
    },
    {
      path: "/representantes",
      name: "Listado_Representantes",
      component: () => import("../views/ListadoRepresentantesView.vue"),
      meta: { requiresAuth: true, allowedRoles: ["1", "2"] },
    },
    {
      path: "/registrar/cliente",
      name: "Registro_Clientes",
      component: () => import("../views/RegistrarClienteView.vue"),
      meta: { requiresAuth: true, allowedRoles: ["1", "2"] },
    },
    {
      path: "/periodos",
      name: "Periodos",
      component: () => import("../views/PeriodosView.vue"),
      meta: { requiresAuth: true, allowedRoles: ["1", "2"] },
    },
    {
      path: "/transsacciones",
      name: "Transsacciones",
      component: () => import("../views/TranssaccionesView.vue"),
      meta: { requiresAuth: true, allowedRoles: ["1", "2"] },
    },
    {
      path: "/inscripciones",
      name: "Inscripciones",
      component: () => import("../views/InscripcionesView.vue"),
      meta: { requiresAuth: true, allowedRoles: ["1", "2"] },
    },
    {
      path: "/usuarios",
      name: "Usuarios",
      component: () => import("../views/UsuariosView.vue"),
      meta: { requiresAuth: true, allowedRoles: ['1'] },
    },
    {
      path: "/empleados",
      name: "Empleados",
      component: () => import("../views/PersonasView.vue"),
      meta: { requiresAuth: true, allowedRoles: ['1'] },
    },
    {
      path: "/notas",
      name: "Notas",
      component: () => import("../views/NotasView.vue"),
      meta: { requiresAuth: true, allowedRoles: ['1'] },
    },
  ],
});
// router.beforeEach((to, from, next) => {
//   const isAuthenticated = sessionStorage.getItem("token");
//   const userRole = sessionStorage.getItem("role");
//   console.log(sessionStorage.getItem("role"));
//   console.log(typeof userRole);
//   if (to.meta.requiresAuth && !isAuthenticated) {
//     next("/");
//   } else {
//     next(); // Permite la navegación
//   }
//   // Verificar roles (ambos como strings)
//   if (to.meta.allowedRoles) {
//     const rolesPermitidos = to.meta.allowedRoles.map(String); // Convertir a strings por si acaso

//     if (!rolesPermitidos.includes(userRole)) {
//       return next("/main");
//     }
//   }

//   return next();
//   // // Si el usuario está autenticado pero intenta acceder al login
//   // else if (isAuthenticated && to.path === '/main') {
//   //   next('/'); // Redirige al inicio
//   // }
// });

router.beforeEach((to, from, next) => {
  const isAuthenticated = sessionStorage.getItem("token");
  const userRole = sessionStorage.getItem("role");

  // Redirigir usuarios autenticados que intenten volver al login
  if (isAuthenticated && to.name === 'Login') {
    return next('/main');
  }

  // Validar rutas protegidas
  if (to.meta.requiresAuth) {
    if (!isAuthenticated) {
      return next("/");
    }

    // Validar roles si existen restricciones
    if (to.meta.allowedRoles) {
      if (!to.meta.allowedRoles.includes(userRole)) {
        return next('/main'); // o ruta de acceso denegado
      }
    }
  }

  next();
});
export default router;
