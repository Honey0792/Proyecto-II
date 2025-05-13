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

  //PERSONAS
  postPersonas(value) {
    return newGoalApi().post("/personas", value);
  },

  //SESIONES
  postSesion(value) {
    return newGoalApi().post("/sesiones", value);
  },
  //INSCRIPCION
  postInscripcion(value) {
    return newGoalApi().post("/inscripciones", value);
  },
  //NOTAS
  postNota(value) {
    return newGoalApi().post("/notas", value);
  },

  //ALERGIAS
   postAlergia(value) {
    return newGoalApi().post("/alergiaEstudiantes", value);
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

  getNivelInscripcion() {
    return newGoalApi().get("/select/nivel-inscripcion");
  },

  getSelectAlergias() {
    return newGoalApi().get("/select/alergias");
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

  //GASTOS
  getGastos() {
    return newGoalApi().get(`/gastos?pagina=1&limit=1000`);
  },

  getGastoById(id) {
    return newGoalApi().get(`/gastos/${id}`);
  },

  //PERSONAS
  getPersonas() {
    return newGoalApi().get(`/personas?pagina=1&limit=1000`);
  },

  getPersonaById(id) {
    return newGoalApi().get(`/personas/${id}`);
  },

  //SESIONES

  getSesiones() {
    return newGoalApi().get(`/sesiones?pagina=1&limit=1000`);
  },

  getSesionesById(id) {
    return newGoalApi().get(`/sesiones/${id}`);
  },

  //INSCRIPCIONES

  getInscripciones() {
    return newGoalApi().get(`/inscripciones?pagina=1&limit=1000`);
  },

  getInscripcionById(id) {
    return newGoalApi().get(`/inscripciones/${id}`);
  },

  //NOTAS
  getNotas() {
    return newGoalApi().get(`/notas?pagina=1&limit=1000`);
  },

  getNotasById(id) {
    return newGoalApi().get(`/notas/${id}`);
  },

  //ALERGIAS
  getAlergias() {
    return newGoalApi().get(`/alergiaEstudiantes?pagina=1&limit=1000`);
  },

  getAlergiasById(id) {
    return newGoalApi().get(`/alergiaEstudiantes/${id}`);
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

  //GASTOS
  putGasto(value) {
    return newGoalApi().put("/gastos", value);
  },

  //PERSONAS
  putPersona(value) {
    return newGoalApi().put("/personas", value);
  },

  //SESION
  putSesion(value) {
    return newGoalApi().put("/sesiones", value);
  },

  //INSCRIPCION
  putSInscripcion(value) {
    return newGoalApi().put("/inscripciones", value);
  },

  putNota(value) {
    return newGoalApi().put("/notas", value);
  },
  //DELETE

  //ESTUDIANTES
  deleteEstudiante(value) {
    return newGoalApi().delete("/estudiantes", { data: value });
  },

  //REPRESENTANTES
  deleteRepresentante(value) {
    return newGoalApi().delete("/representantes", { data: value });
  },

  //PERIODOS
  deletePeriodo(value) {
    return newGoalApi().delete("/periodos", { data: value });
  },

  //PAGOS
  deletePago(value) {
    return newGoalApi().delete("/pagos", { data: value });
  },

  //GASTOS
  deleteGasto(value) {
    return newGoalApi().delete("/gastos", { data: value });
  },

  //PERSONAS
  deletePersona(value) {
    return newGoalApi().delete("/personas", { data: value });
  },

  //SESION
  deleteSesion(value) {
    return newGoalApi().delete("/sesiones", { data: value });
  },

  //INSCRIPCION
  deleteInscripcion(value) {
    return newGoalApi().delete("/inscripciones", { data: value });
  },

   //NOTAS
   deleteNota(value) {
    return newGoalApi().delete("/notas", { data: value });
  },

  //ALERGIAS
  deletealergia(value) {
    return newGoalApi().delete("/alergiaEstudiantes", { data: value });
  },
};
