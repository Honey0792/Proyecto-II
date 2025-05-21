<template>
  <v-btn
    append-icon="mdi-plus"
    variant="elevated"
    class="mx-7"
    color="#B2EBF2"
    to="/registrar/cliente"
    >Añadir</v-btn
  >
  <v-card class="d-flex mx-10 ma-7">
    <v-data-table
      :loading="loadingConfig"
      :search="search"
      height="460"
      :headers="headers"
      :sort-by="[{ key: 'id_etd', order: 'desc' }]"
      :items="estudiantes"
      :items-per-page-options="itemsPerPage"
      v-model:items-per-page="paginacion.items"
      v-model:page="paginacion.pagina"
    >
      <template v-slot:top>
        <v-text-field
          v-model="search"
          placeholder="Buscar"
          prepend-inner-icon="mdi-magnify"
          clearable
          density="compact"
          single-line
          hint="Te recomendamos buscar por el número de cédula"
        ></v-text-field>
      </template>
      <template v-slot:item.id_etd="{ item }"> </template>
      <template v-slot:item.nombre_etd="{ item }">
        {{ item.nombre_etd }}
      </template>
      <template v-slot:item.estado="{ value }">
        <div class="">
          <v-icon :color="getcolor(value)" icon="mdi-circle-medium"></v-icon>
        </div>
      </template>

      <template v-slot:item.actions="{ item }">
        <div class="d-flex ga-2 justify-end">
          <v-icon
            color="medium-emphasis"
            icon="mdi-pencil"
            size="small"
            @click="edita(item.id_etd)"
          ></v-icon>
          <v-icon
            color="medium-emphasis"
            icon="mdi-eye"
            size="small"
            @click="ver(item.id_etd)"
          ></v-icon>
          <v-icon
            color="medium-emphasis"
            icon="mdi-delete"
            size="small"
            @click="eliminar(item.id_etd)"
          ></v-icon>
        </div>
      </template>
      <template v-slot:footer.prepend>
        <div class="mx-3">
          <v-btn @click="reporteEstudiante">Generar Listado</v-btn>
        </div>
      </template>
    </v-data-table>
  </v-card>

  <v-dialog v-model="this.dialog_1">
    <v-icon
      icon="mdi-close"
      class="position-absolute right-0"
      color="white"
      @click="this.dialog_1 = false"
    ></v-icon>
    <CartaEditEstudiante @actualizar_tabla="obtenerEstudiantes" :id="id_etd" />
  </v-dialog>
  <v-dialog v-model="this.dialog_2">
    <v-icon
      icon="mdi-close"
      class="position-absolute right-0"
      color="white"
      @click="this.dialog_2 = false"
    ></v-icon>
    <CartaVerEstudiante :id="id_etd" />
  </v-dialog>
  <v-dialog v-model="this.dialog_3" width="auto">
    <v-card
      max-width="400"
      prepend-icon="mdi-delete-alert"
      title="Oprimiste eliminar"
      color="warning"
    >
      <v-card-text>
        ¿Estas seguro de querer eliminar a {{ this.nombreEliminar }}
        {{ this.apellidoEliminar }}?
      </v-card-text>
      <template v-slot:actions>
        <v-spacer></v-spacer>
        <v-btn
          class="ms-auto"
          text="Cancelar"
          @click="this.dialog_3 = false"
        ></v-btn>
        <v-btn class="ms-auto" text="Ok" @click="eliminarEstudiante"></v-btn>
      </template>
    </v-card>
  </v-dialog>
</template>

<script>
import newGoalService from "@/services/newGoalService";
import { getCurrentInstance } from "vue";
import CartaEditEstudiante from "../Cards/CartaEditEstudiante.vue";
import CartaVerEstudiante from "../Cards/CartaVerEstudiante.vue";

export default {
  components: {
    CartaEditEstudiante,
    CartaVerEstudiante,
  },
  data: () => ({
    loadingConfig:true,
    search: null,
    nombreEliminar: "",
    apellidoEliminar: "",
    paginacion: {
      items: 10,
      pagina: 1,
    },
    itemsPerPage: [
      { value: 10, title: "10" },
      { value: 25, title: "25" },
      { value: 50, title: "50" },
      { value: 100, title: "100" },
    ],
    id_etd: null,
    dialog_1: false,
    dialog_2: false,
    dialog_3: false,
    estudiantes: [], // Lista de estudiantes
    headers: [
      { title: "Orden", key: "id_etd" }, // Columna para el estado
      { title: "Estado", key: "estado" }, // Columna para el estado
      { title: "Nombre", key: "nombre_etd" }, // Columna para el nombre
      { title: "Apellido", key: "apellido_etd" }, // Columna para el apellido
      { title: "Correo", key: "correo_etd" }, // Columna para el correo
      { title: "Cedula", key: "cedula_etd" }, // Columna para el correo
      { title: "Actions", key: "actions", align: "end", sortable: false }, //columna para las acciones
      // Agrega más columnas según los datos que tengas
    ],
  }),

  methods: {
    async reporteEstudiante() {
      // try {
      //   const res = await newGoalService.getReporteEstudiantes();
      //   // Abrir en nueva pestaña
      //   window.open(
      //     "http://localhost:3000/estudiantes/reporte",
      //     "_self" // <- Este es el cambio clave
      //   );
      // } catch (error) {
      //   console.error("Error abriendo reporte:", error);
      //   alert("No se pudo abrir el reporte");
      // }
       try {
        const response = await newGoalService.getReporteEstudiantes()
        console.log(response)
       // Crear un enlace temporal para descargar el archivo
  const url = window.URL.createObjectURL(new Blob([response.data]));
  const link = document.createElement("a");
  link.href = url;
  
  // Obtener el nombre del archivo desde las cabeceras (si el servidor lo envía)
  const contentDisposition = response.headers["content-disposition"];
  const fileName = contentDisposition
    ? contentDisposition.split("filename=")[1].replace(/"/g, '')
    : `reporte_estudiantes_${new Date().toISOString()}.xlsx`; // Nombre por defecto si no hay header

  link.setAttribute("download", fileName);
  document.body.appendChild(link);
  link.click();
  
  // Limpiar recursos
  document.body.removeChild(link);
  window.URL.revokeObjectURL(url);
        } catch (error) {
          console.error("Error:", error.response?.data || error.message);
        }
    },
    async obtenerEstudiantes() {
      try {
        const res = await newGoalService.getEstudiante();
        this.estudiantes = res.data;
        console.log(this.estudiantes);
        this.loadingConfig = false
      } catch (error) {
        console.log(error);
      }
    },
    edita(id) {
      this.id_etd = id;
      console.log("hola");
      this.dialog_1 = true;
    },

    ver(id) {
      this.id_etd = id;
      console.log("hola");
      this.dialog_2 = true;
    },
    eliminar(id) {
      const estudiante = this.estudiantes.find((e) => e.id_etd === id); // Busca el estudiante por ID
      this.id_etd = id;
      this.nombreEliminar = estudiante.nombre_etd; // Guarda el nombre
      this.apellidoEliminar = estudiante.apellido_etd; // Guarda el apellido
      this.dialog_3 = true;
      // console.log(this.paginacion)
      // this.id_etd = id;
      // console.log("hola");
      // this.dialog_3 = true;
      // console.log(id);
    },

    async eliminarEstudiante() {
      const id = { id_estudiante: this.id_etd };
      try {
        const res = await newGoalService.deleteEstudiante(id);
        this.dialog_3 = false;
        this.obtenerEstudiantes();
      } catch (error) {
        console.log(error);
      }
    },

    getcolor(estado) {
      if (estado == "Activo") {
        return "success";
      } else {
        return "error";
      }
    },
  },

  mounted() {
    this.obtenerEstudiantes();
  },
};
</script>
/
