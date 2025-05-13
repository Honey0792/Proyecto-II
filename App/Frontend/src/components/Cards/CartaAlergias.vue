<template>
  <v-dialog
    v-model="alert.show"
    width="auto"
    class="justify-center align-center"
  >
    <v-alert
      v-model="alert.show"
      :color="alert.color"
      variant="elevated"
      prominent
      closable
      width="400px"
      >{{ alert.message }}</v-alert
    >
  </v-dialog>
  <div class="d-flex justify-center">
    <v-card width="500">
      <!-- <v-tabs v-model="tab">
        <v-tab value="one">Alergias</v-tab>
        <v-tab value="two">Agregar alergias al listado</v-tab>
      </v-tabs>

      <v-tabs-window v-model="tab">
        <v-tabs-window-item value="one"> -->
      <v-container>
        <v-form @submit.prevent="agregarAlergiaEstudiante">
          <v-row class="">
            <v-col>
              <v-select
                label="Alergia"
                variant="outlined"
                :items="alergias"
                item-title="nombre_alergia"
                item-value="id_alergia"
                v-model="alergia.id_alergia"
              ></v-select>

              <v-btn type="submit"> Agregar al estudiante </v-btn>
            </v-col>
          </v-row>
        </v-form>
      </v-container>
      <!-- </v-tabs-window-item>
        <v-tabs-window-item value="two">
          <v-container>
            <v-form>
              <v-row>
                <v-col>
                  <v-text-field></v-text-field>
                  <v-text-field></v-text-field>
                </v-col>
              </v-row>
            </v-form>
          </v-container>
        </v-tabs-window-item>
      </v-tabs-window> -->
    </v-card>
  </div>
</template>

<script>
import newGoalService from "@/services/newGoalService";

export default {
  props: {
    id: {
      type: Number,
      required: true,
    },
  },
  data: () => ({
    tab: null,
    alert: { show: false, message: "", color:null },
    alergia: {
      id_etd: null,
      id_alergia: null,
    },
    alergias: [],
  }),
  methods: {
    async obtenerAlergias() {
      try {
        const res = await newGoalService.getAlergias();
        console.log(res);
      } catch (error) {
        console.log(error);
      }
    },
    async obtenerSelectAlergias() {
      try {
        const res = await newGoalService.getSelectAlergias();
        this.alergias = res.data.datos;
        console.log();
      } catch (error) {
        console.log(error);
      }
    },
    async agregarAlergiaEstudiante() {
      this.alergia.id_etd = this.id;
      try {
        const res = await newGoalService.postAlergia(this.alergia);
        this.$emit('actualizar_alergias')
        this.alert.show = true
        this.alert.message= "Alergia registrada correctamente"
        this.alert.color = "success"
      } catch(error){
        console.log(error)
        this.alert.show = true
        this.alert.message= "Error al registar alergia"
        this.alert.color = "error"
      }
    },
  },
  mounted() {
    this.obtenerAlergias();
    this.obtenerSelectAlergias();
  },
};
</script>
