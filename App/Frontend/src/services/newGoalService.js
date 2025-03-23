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
  //Periodos
  postPeriodo(value) {
    return newGoalApi().post("/periodos", value);
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
  // ESTUDIANTES
  getEstudiante() {
    return newGoalApi().get("/estudiantes");
  },

  getEstudianteById(id) {
    return newGoalApi().get(`/estudiantes/${id}`);
  },
  // REPRESENTANTES
  getRepresentante() {
    return newGoalApi().get("/representantes");
  },

  getRepresentanteById(id) {
    return newGoalApi().get(`/representantes/${id}`);
  },

  // PERIODOS
  getPeriodos() {
    return newGoalApi().get("/periodos");
  },

  getPeriodoById(id) {
    return newGoalApi().get(`/periodos/${id}`);
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
  //DELETE

  //ESTUDIANTES
  deleteEstudiante(value) {
    return newGoalApi().delete("/estudiantes",{ data: value });
  },
};
