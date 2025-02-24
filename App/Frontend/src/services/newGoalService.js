import { toValue } from "vue";
import newGoalApi from "./newGoalApi";

export default {
  //POST
  userLog(value) {
    return newGoalApi().post('/auth', value)
  },

  postEstudiante(value){
    return newGoalApi().post('/estudiantes', value)
  },
  //GET
  getNacionalidad(){
    return newGoalApi().get('/select/nacionalidad')
  },

  getEstado(){
    return newGoalApi().get('/select/estado')
  },
  getDiscapacidad(){
    return newGoalApi().get('/select/discapacidad')
  },

  getGenero(){
    return newGoalApi().get('/select/genero')
  },

  getNivelEducacion(){
    return newGoalApi().get('/select/nivel-educativo')
  },

  getNivelIngles(){
    return newGoalApi().get('/select/nivel-ingles')
  },

  getEstudiante(){
    return newGoalApi().get('/estudiantes')
  }


  //DELETE
  //PUT
};
