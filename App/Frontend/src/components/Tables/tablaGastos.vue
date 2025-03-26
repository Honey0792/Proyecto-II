<template>
    <v-data-table :headers>
    
    </v-data-table>
    
    </template>
    
    <script>
    import newGoalService from '@/services/newGoalService';
    
    export default {
      data: () => ({
    
        headers: [
          { title: "ID", align: "start", key: "id_periodo" },
          { title: "Nombre", align: "start", key: "nombre_periodo" },
          { title: "Fecha Inicio", align: "end", key: "fecha_ini_periodo" },
          { title: "Fecha de Culminacion", align: "end", key: "fecha_fin_periodo" },
          { title: "Año", align: "end", key: "year_academico" },
          { title: "Estado", align: "end", key: "nombre_estado" },
          { title: "Acciones", align: "end", key: "actions" },
        ],
        pago: {
          id_estudiante: null,
          metodo_pago: null,
          fecha_pago: "",
          monto_total: null,
          monto_cancelado: null,
          renovacion: "",
        },
      }),
      methods: {
     
      },
    
    
    };
    </script>
    