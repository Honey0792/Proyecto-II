<template>
  <v-card class="ma-7">
    <v-form>
      <v-card-title class="bg-cyan-lighten-5">
        Registro de Estudiante
      </v-card-title>
      <v-card-text class="d-flex flex-column aling-center justify-center pa-0">
        <h3 class="pa-3">Datos Del Estudiante</h3>

        <v-divider></v-divider>
        <v-container class="">
          <v-row>
            <v-col>
              <v-text-field
                v-model="estudiante.nombre"
                variant="outlined"
                readonly
                label="Nombres"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                variant="outlined"
                v-model="estudiante.apellido"
                readonly
                label="Apellidos"
              >
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                v-model="estudiante.fecha_canimiento.split('T')[0]"
                variant="outlined"
                type="date"
                readonly
                label="Fecha de Nacimiento"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                variant="outlined"
                type=""
                readonly
                label="Edad"
                v-model:model-value="edad"
              ></v-text-field>
            </v-col>
          </v-row>
          <v-divider class="mx-8"></v-divider>
        </v-container>
        <v-container>
          <v-row>
            <v-col>
              <v-text-field
                variant="outlined"
                readonly
                label="Nivel de Educación"
                v-model="estudiante.nivel_edu"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                readonly
                label="Nivel de Ingles"
                variant="outlined"
                v-model="estudiante.nivel_ingles"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                variant="outlined"
                readonly
                label="Estado"
                v-model="estudiante.estado"
              >
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                variant="outlined"
                readonly
                label="Nacionalidad"
                v-model="estudiante.nacionalidad"
              >
              </v-text-field>
            </v-col>
          </v-row>
        </v-container>
        <v-divider class="mx-8"></v-divider>
        <v-container>
          <v-row>
            <v-col>
              <v-text-field
                readonly
                label="Discapacidad"
                variant="outlined"
                v-model="estudiante.discapacidad"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                variant="outlined"
                readonly
                label="genero"
                v-model="estudiante.genero"
              >
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                readonly
                label="Representante"
                variant="outlined"
                :model-value="fullName"
              ></v-text-field>
            </v-col>
          </v-row>
        </v-container>
        <v-divider class="mx-8"></v-divider>
        <v-container>
          <v-row class="mx-auto">
            <v-col class="d-flex">
              <v-text-field
                type=""
                variant="outlined"
                hint="Desmarque la casilla si el estudiante no posee cedula"
                readonly
                label="Cedula"
                v-model="estudiante.cedula"
              >
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                v-model="estudiante.contacto_emergencia"
                variant="outlined"
                readonly
                label="Contacto de emergencia"
              >
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                variant="outlined"
                readonly
                label="Encargado/s de retirar el Estudiante"
                v-model="estudiante.quien_retira"
              >
              </v-text-field>
            </v-col>
          </v-row>
        </v-container>
        <v-divider class="mx-8"></v-divider>
        <v-container class="">
          <v-row>
            <v-col>
              <v-text-field
                variant="outlined"
                readonly
                label="Numero de Telefono"
                v-model="estudiante.telefono"
              ></v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                v-model="estudiante.direccion"
                variant="outlined"
                readonly
                label="Direccion"
              >
              </v-text-field>
            </v-col>
            <v-col>
              <v-text-field
                v-model="estudiante.correo"
                type="email"
                variant="outlined"
                readonly
                label="Correo Electronico"
              >
              </v-text-field>
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>
    </v-form>
    <v-divider></v-divider>
    <div class="pa-3">
      <h3 class="pa-3">Alergias</h3>
      <v-btn @click="showCarta"> Añadir Alergias </v-btn>
      <v-data-table-virtual
        max-height="400"
        :items="alergias"
        :headers
        width="400"
      >
        <template v-slot:item.actions="{ item }">
          <v-icon
            color="medium-emphasis"
            icon="mdi-delete"
            size="small"
            @click="eliminar(item.id_alergia_etd)"
          ></v-icon>
        </template>
      </v-data-table-virtual>
    </div>
    <v-divider></v-divider>
    <div class="pa-3">
      <h3 class="pa-3">Inscripciones</h3>
    </div>
    <v-data-table-virtual max-height="400" :headers="headersNotas" :items="notas">
              <template v-slot:item.fecha_creacion_nota="{ item }">
          {{ item.fecha_creacion_nota.split("T")[0] }}
        </template>
    </v-data-table-virtual>
    <v-divider></v-divider>
    <div class="pa-3">
      <h3 class="pa-3">Pagos</h3>
      <v-data-table-virtual
        max-height="400"
        :headers="headersPagos"
        :items="pagos"
      >
        <template v-slot:item.fecha_pago="{ item }">
          {{ item.fecha_pago.split("T")[0] }}
        </template>
        <template v-slot:item.monto_cancelado_pago="{ item }">
          <span
            :class="{
              'bg-success': item.monto_cancelado_pago === item.monto_total_pago,
              'bg-warning': item.monto_cancelado_pago !== item.monto_total_pago,
            }"
            class="pa-2 rounded"
          >
            {{ item.monto_cancelado_pago }}
          </span>
        </template>
      </v-data-table-virtual>
    </div>
  </v-card>
  <v-dialog v-model="this.dialogAlergia">
    <CartaAlergias :id="id" @actualizar_alergias="obtenerAlergiasById" />
  </v-dialog>
  <v-dialog v-model="this.dialog_1" width="auto">
    <v-card
      max-width="400"
      prepend-icon="mdi-delete-alert"
      title="Oprimiste eliminar"
      color="warning"
    >
      <v-card-text>
        ¿Estas seguro de querer eliminar esta alergia?
      </v-card-text>
      <template v-slot:actions>
        <v-spacer></v-spacer>
        <v-btn
          class="ms-auto"
          text="Cancelar"
          @click="this.dialog_1 = false"
        ></v-btn>
        <v-btn class="ms-auto" text="Ok" @click="eliminarAlergia"></v-btn>
      </template>
    </v-card>
  </v-dialog>
</template>

<script>
import newGoalService from "@/services/newGoalService";
import CartaAlergias from "./CartaAlergias.vue";
export default {
  components: {
    CartaAlergias,
  },
  props: {
    id: {
      type: Number,
      required: true,
    },
  },
  data: () => ({
    dialog_1: null,
    id_alergia: null,
    alergias: [],
    pagos: [],
    notas: [],
    nacionalidades: [],
    levelEnglish: [],
    nivelEducativo: [],
    discapacidades: [],
    estados: [],
    generos: [],
    headers: [
      { title: "Alergias", key: "nombre_alergia" }, // Columna para el estado
      { title: "Severidad", key: "severidad_alergia" }, // Columna para el estado
      { title: "actions", key: "actions" }, // Columna para el estado
      // Agrega más columnas según los datos que tengas
    ],
    headersPagos: [
      { title: "Fecha", key: "fecha_pago" }, // Columna para el estado
      { title: "Metodo de Pago", key: "nombre_metodo_pago" }, // Columna para el estado
      { title: "Monto Cancelado", key: "monto_cancelado_pago" }, // Columna para el estado
      { title: "Monto Total", key: "monto_total_pago" }, // Columna para el estado
    ],
    headersNotas: [
      { title: "Periodo", key: "nombre_periodo" }, // Columna para el estado
      { title: "Fecha", key: "fecha_creacion_nota" }, // Columna para el estado
      { title: "Nivel", key: "nombre_nivel" }, // Columna para el estado
      { title: "Calificación", key: "valor_nota" }, // Columna para el estado
    ],
    estudiante: {
      id_estudiante: null,
      representante: null,
      apellido_representante: null,
      estado: null, //Devuelve el nombre pero no el id, necesitamos el id
      discapacidad: null, //Devuelve el nombre pero no el id, necesitamos el id
      genero: null,
      nivel_edu: null,
      nacionalidad: null,
      nivel_ingles: null,
      nombre: null,
      apellido: null,
      fecha_canimiento: "",
      cedula: null,
      direccion: null,
      telefono: null,
      correo: null,
      contacto_emergencia: null,
      quien_retira: null,
    },
    dialogAlergia: false,
  }),

  methods: {
    eliminar(id) {
      this.id_alergia = id;
      this.dialog_1 = true;
    },
    async obtenerEstudianteById(id) {
      id = this.id;
      try {
        const res = await newGoalService.getEstudianteById(id);

        const datosApi = res.data[0];

        this.estudiante.id_estudiante = datosApi.id_etd;
        this.estudiante.apellido_representante =
          datosApi.apellido_representante;
        this.estudiante.representante = datosApi.nombre_representante;
        this.estudiante.estado = datosApi.estado;
        this.estudiante.discapacidad = datosApi.nombre_discapacidad;
        this.estudiante.genero = datosApi.genero;
        this.estudiante.nivel_edu = datosApi.nivel_educacion;
        this.estudiante.nacionalidad = datosApi.nacionalidad;
        this.estudiante.nivel_ingles = datosApi.nivel_ingles;
        this.estudiante.nombre = datosApi.nombre_etd;
        this.estudiante.apellido = datosApi.apellido_etd;
        this.estudiante.fecha_canimiento = datosApi.fecha_nacimiento_etd;
        this.estudiante.cedula = datosApi.cedula_etd;
        this.estudiante.direccion = datosApi.direccion_etd;
        this.estudiante.telefono = datosApi.telefono_etd;
        this.estudiante.correo = datosApi.correo_etd;
        this.estudiante.contacto_emergencia = datosApi.contacto_emergencia_etd;
        this.estudiante.quien_retira = datosApi.quien_retira_etd;
        console.log("--------------------");
        console.log(datosApi);
        console.log("--------------------");
        // Este ciclo es una mierda por eso lo comento
        // Itera sobre las propiedades de `estudiante`
        // for (const key in this.estudiante) {
        //   if (datosApi.hasOwnProperty(key)) {
        //     this.estudiante[key] = datosApi[key];
        //   }
        // }

        // console.log("Estudiante actualizado:", this.estudiante);
      } catch (error) {
        console.log(error);
      }
    },

    async obtenerPagosEstudiante() {
      try {
        const res = await newGoalService.getPagosEstudiante(this.id);
        console.log(res);
        this.pagos = res.data;
      } catch (error) {
        console.log(error);
      }
    },
    async obtenerNotasEstudiante() {
      try {
        const res = await newGoalService.getNotasByEstudiante(this.id);
        console.log(res);
        this.notas = res.data;
      } catch (error) {
        console.log(error);
      }
    },
    showCarta() {
      this.dialogAlergia = true;
      console.log("ejecutando");
    },
    async obtenerAlergiasById(id) {
      id = this.id;
      try {
        const res = await newGoalService.getAlergiasById(id);
        this.alergias = res.data;
        console.log(res);
      } catch (error) {
        console.log(error);
      }
    },
    async eliminarAlergia() {
      try {
        const id = { id_alergia_etd: this.id_alergia };
        const res = await newGoalService.deletealergia(id);
        console.log(id);
        this.obtenerAlergiasById();
        this.dialog_1 = false;
      } catch (error) {
        console.log(error);
      }
    },
  },
  computed: {
    fullName() {
      return `${this.estudiante.representante || ""} ${
        this.estudiante.apellido_representante || ""
      }`.trim();
    },
    edad() {
      if (!this.estudiante.fecha_canimiento) return "";

      const fechaNacimiento = new Date(this.estudiante.fecha_canimiento);
      const hoy = new Date();

      // Validar fecha
      if (isNaN(fechaNacimiento.getTime())) return "Fecha inválida";

      let edad = hoy.getFullYear() - fechaNacimiento.getFullYear();
      const mes = hoy.getMonth() - fechaNacimiento.getMonth();

      if (mes < 0 || (mes === 0 && hoy.getDate() < fechaNacimiento.getDate())) {
        edad--;
      }

      return edad;
    },
  },

  mounted() {
    this.obtenerEstudianteById();
    this.obtenerAlergiasById();
    this.obtenerPagosEstudiante();
    this.obtenerNotasEstudiante();
  },
};
</script>
