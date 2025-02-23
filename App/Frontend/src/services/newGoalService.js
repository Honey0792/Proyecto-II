import { toValue } from "vue";
import newGoalApi from "./newGoalApi";

export default {
  //POST
  userLog(value) {
    return newGoalApi().post('/auth', value)
  },
  //GET
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
  //DELETE
  //PUT
};
