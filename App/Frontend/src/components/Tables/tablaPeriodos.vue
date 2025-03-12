<template>
<v-data-table
:headers="headers">
</v-data-table>
</template>

<script>
export default {

    data: () => ({
        headers: [
          { title: 'Nombre', align: 'start', key: 'name' },
          { title: 'Fecha Inicio', align: 'end', key: 'speed' },
          { title: 'Fecha de Culminacion', align: 'end', key: 'length' },
          { title: 'Año', align: 'end', key: 'length' },
          { title: 'Estado', align: 'end', key: 'price', value: item => formatPrice(item.price) },
          { title: 'Acciones', align: 'end', key: 'year' },
        ],
    }), 
}
</script>

<style scoped>
/* Aplica un color de fondo a los headers */
.v-data-table-virtual >>> .v-data-table-header {
  background-color: #7eb1ba; /* Cambia este color según tus necesidades */
  color: white; /* Cambia el color del texto si es necesario */
}
</style>