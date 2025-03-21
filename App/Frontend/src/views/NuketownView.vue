<template>
  <CartaVerRepresentante />
  <div class="d-flex justify-center">
<RegPeriodo />
</div>
</template>

<script>
import axios from 'axios';
import RegPeriodo from '@/components/Forms/RegPeriodo.vue';
import CartaVerRepresentante from '@/components/Cards/CartaVerRepresentante.vue';
export default {

components :{
  RegPeriodo,
  CartaVerRepresentante,
},
  data() {
    return {
      API_URL: 'http://localhost:3000/periodos',
      formData: {
        nombre: '',
        fecha_inicio: '',
        fecha_fin: '',
        anio_academico: null,
        id_estado: 1
      },
      periodos: [],
      editing: false,
      currentId: null
    }
  },
  mounted() {
    this.loadPeriodos();
  },
  methods: {
    getAuthHeader() {
      const token = sessionStorage.getItem('token');
      return { headers: { Authorization: `Bearer ${token}` } };
    },
    formatDate(dateString) {
      const options = { year: 'numeric', month: 'long', day: 'numeric' };
      return new Date(dateString).toLocaleDateString('es-ES', options);
    },
    async loadPeriodos() {
      try {
        const response = await axios.get(this.API_URL, this.getAuthHeader());
        this.periodos = response.data;
        console.log(response)
      } catch (error) {
        console.error('Error al cargar periodos:', error);
      }
    },
    async handleSubmit() {
      try {
        if (this.editing) {
          await axios.put(
            this.API_URL,
            { ...this.formData, id_periodo: this.currentId },
            this.getAuthHeader()
          );
        } else {
          await axios.post(this.API_URL, this.formData, this.getAuthHeader());
        }
        await this.loadPeriodos();
        this.resetForm();
      } catch (error) {
        console.error('Error al guardar:', error);
      }
    },
    editPeriodo(periodo) {
      this.editing = true;
      this.currentId = periodo.id_periodo;
      this.formData = { ...periodo };
    },
    cancelEdit() {
      this.editing = false;
      this.resetForm();
    },
    async deletePeriodo(id) {
      if (confirm('¿Estás seguro de eliminar este periodo?')) {
        try {
          await axios.delete(this.API_URL, {
            data: { id_periodo: id },
            ...this.getAuthHeader()
          });
          await this.loadPeriodos();
        } catch (error) {
          console.error('Error al eliminar:', error);
        }
      }
    },
    resetForm() {
      this.formData = {
        nombre: '',
        fecha_inicio: '',
        fecha_fin: '',
        anio_academico: null,
        id_estado: 1
      };
      this.editing = false;
      this.currentId = null;
    }
  }
}
</script>

