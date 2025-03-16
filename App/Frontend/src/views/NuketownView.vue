<template>
  <div class="periodos-container">
    <!-- Formulario para crear/editar -->
    <div class="periodo-form">
      <h2>{{ editing ? 'Editar Periodo' : 'Nuevo Periodo' }}</h2>
      <form @submit.prevent="handleSubmit">
        <div class="form-group">
          <label>Nombre:</label>
          <input v-model="formData.nombre" type="text" required>
        </div>
        
        <div class="form-row">
          <div class="form-group">
            <label>Fecha Inicio:</label>
            <input v-model="formData.fecha_inicio" type="date" required>
          </div>
          <div class="form-group">
            <label>Fecha Fin:</label>
            <input v-model="formData.fecha_fin" type="date" required>
          </div>
        </div>

        <div class="form-row">
          <div class="form-group">
            <label>Año Académico:</label>
            <input v-model="formData.anio_academico" type="number" min="2000" required>
          </div>
          <div class="form-group">
            <label>Estado:</label>
            <select v-model="formData.id_estado" required>
              <option value="1">Activo</option>
              <option value="2">Inactivo</option>
            </select>
          </div>
        </div>

        <div class="form-actions">
          <button type="submit" class="btn-primary">{{ editing ? 'Actualizar' : 'Crear' }}</button>
          <button v-if="editing" type="button" @click="cancelEdit" class="btn-secondary">Cancelar</button>
        </div>
      </form>
    </div>

    <!-- Listado de periodos -->
    <div class="periodos-list">
      <h2>Periodos Académicos</h2>
      <div class="table-container">
        <table>
          <thead>
            <tr>
              <th>Nombre</th>
              <th>Fecha Inicio</th>
              <th>Fecha Fin</th>
              <th>Año</th>
              <th>Estado</th>
              <th>Acciones</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="periodo in periodos" :key="periodo.id_periodo">
              <td>{{ periodo.nombre_periodo }}</td>
              <td>{{ formatDate(periodo.fecha_inicio) }}</td>
              <td>{{ formatDate(periodo.fecha_fin) }}</td>
              <td>{{ periodo.year_academico }}</td>
              <td>{{ periodo.nombre_estado }}</td>
              <td>
                <button @click="editPeriodo(periodo)" class="btn-edit">Editar</button>
                <button @click="deletePeriodo(periodo.id_periodo)" class="btn-delete">Eliminar</button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
  <div class="d-flex justify-center">
<RegPeriodo />
</div>
</template>

<script>
import axios from 'axios';
import RegPeriodo from '@/components/Forms/RegPeriodo.vue';
export default {

components :{
  RegPeriodo,
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

<style scoped>
.periodos-container {
  max-width: 1200px;
  margin: 2rem auto;
  padding: 20px;
  background-color: #FFFFFF;
  border-radius: 10px;
  box-shadow: 0 2px 15px rgba(0,0,0,0.1);
}

.periodo-form {
  margin-bottom: 2rem;
  padding: 20px;
  background: #f8f9fa;
  border-radius: 8px;
}

.form-group {
  margin-bottom: 1rem;
}

.form-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
}

input, select {
  width: 100%;
  padding: 8px;
  border: 1px solid #7eb1ba;
  border-radius: 4px;
}

.btn-primary {
  background-color: #ef9d4b;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.btn-secondary {
  background-color: #7eb1ba;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  margin-left: 10px;
}

.periodos-list {
  margin-top: 2rem;
}

table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 1rem;
}

th, td {
  padding: 12px;
  text-align: left;
  border-bottom: 1px solid #ddd;
}

th {
  background-color: #7eb1ba;
  color: white;
}

.btn-edit {
  background-color: #7eb1ba;
  color: white;
  padding: 5px 10px;
  border: none;
  border-radius: 3px;
  margin-right: 5px;
}

.btn-delete {
  background-color: #e74c3c;
  color: white;
  padding: 5px 10px;
  border: none;
  border-radius: 3px;
}

@media (max-width: 768px) {
  .form-row {
    grid-template-columns: 1fr;
  }
  
  .table-container {
    overflow-x: auto;
  }
}
</style>
<!-- <template>
  <CartaEstudiante />
</template>

<script>
import CartaEstudiante from "@/components/Cards/CartaEstudiante.vue";

export default {
  components: {
    CartaEstudiante,
  },

  data: () => ({

  }),
};
 
</script> -->
