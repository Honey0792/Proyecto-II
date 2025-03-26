import { toValue } from "vue";
import newGoalApi from "./newGoalApi";

export default {
  //POST
  userLog(value) {
    return newGoalApi().post("/auth", value);
  },
  //ESTUDIANTES
  postEstudiante(value) {
    return newGoalApi().post("/estudiantes", value);
  },
  //REPRESENTANTES
  postRepresentante(value) {
    return newGoalApi().post("/representantes", value);
  },
  //PERIODOS
  postPeriodo(value) {
    return newGoalApi().post("/periodos", value);
  },

  //PAGOS
  postPagos(value) {
    return newGoalApi().post("/pagos", value);
  },

  //GASTOS
  postGastos(value) {
    return newGoalApi().post("/gastos", value);
  },
  //GET

  // SELECTS
  getNacionalidad() {
    return newGoalApi().get("/select/nacionalidad");
  },

  getEstado() {
    return newGoalApi().get("/select/estado");
  },
  getDiscapacidad() {
    return newGoalApi().get("/select/discapacidad");
  },

  getGenero() {
    return newGoalApi().get("/select/genero");
  },

  getNivelEducacion() {
    return newGoalApi().get("/select/nivel-educativo");
  },

  getNivelIngles() {
    return newGoalApi().get("/select/nivel-ingles");
  },
  getMetodoDePago() {
    return newGoalApi().get("/select/metodo-pago");
  },

  getTipoDeGasto() {
    return newGoalApi().get("/select/tipo-gasto");
  },
  // ESTUDIANTES
  getEstudiante() {
    return newGoalApi().get("/estudiantes?pagina=1&limit=1000");
  },

  getEstudianteById(id) {
    return newGoalApi().get(`/estudiantes/${id}`);
  },
  // REPRESENTANTES
  getRepresentante() {
    return newGoalApi().get("/representantes?pagina=1&limit=1000");
  },

  getRepresentanteById(id) {
    return newGoalApi().get(`/representantes/${id}`);
  },

  // PERIODOS
  getPeriodos() {
    return newGoalApi().get("/periodos?pagina=1&limit=1000");
  },

  getPeriodoById(id) {
    return newGoalApi().get(`/periodos/${id}`);
  },

  //PAGOS
  getPagos() {
    return newGoalApi().get(`/pagos?pagina=1&limit=1000`);
  },

  getPagoById(id) {
    return newGoalApi().get(`/pagos/${id}`);
  },
  //PUT

  //REPRESENTANTES
  putRepresentante(value) {
    return newGoalApi().put("/representantes", value);
  },

  //ESTUDIANTES
  putEstudiante(value) {
    return newGoalApi().put("/estudiantes", value);
  },

  //PERIODOS
  putPeriodo(value) {
    return newGoalApi().put("/periodos", value);
  },

  //PAGOS
  putPago(value) {
    return newGoalApi().put("/pagos", value);
  },

  //DELETE

  //ESTUDIANTES
  deleteEstudiante(value) {
    return newGoalApi().delete("/estudiantes",{ data: value });
  },

  //REPRESENTANTES
  deleteRepresentante(value) {
    return newGoalApi().delete("/representantes",{ data: value });
  },

  //PERIODOS
  deletePeriodo(value) {
    return newGoalApi().delete("/periodos",{ data: value });
  },


  //PAGOS
  deletePago(value) {
    return newGoalApi().delete("/pagos",{ data: value });
  },
};
