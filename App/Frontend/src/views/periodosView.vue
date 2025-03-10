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
  </template>
  
  <script setup>
  import { ref, onMounted } from 'vue';
  import axios from 'axios';
  
  const API_URL = 'http://localhost:3000/periodos';
  const formData = ref({
    nombre: '',
    fecha_inicio: '',
    fecha_fin: '',
    anio_academico: null,
    id_estado: 1
  });
  const periodos = ref([]);
  const editing = ref(false);
  const currentId = ref(null);
  
  // Obtener token de autenticación
  const getAuthHeader = () => {
    const token = sessionStorage.getItem('token');
    return { headers: { Authorization: `Bearer ${token}` } };
  };
  
  // Formatear fecha
  const formatDate = (dateString) => {
    const options = { year: 'numeric', month: 'long', day: 'numeric' };
    return new Date(dateString).toLocaleDateString('es-ES', options);
  };
  
  // Cargar periodos
  const loadPeriodos = async () => {
    try {
      const response = await axios.get(API_URL, getAuthHeader());
      periodos.value = response.data;
      console.log('Periodos cargados:', periodos.value);
    } catch (error) {
      console.error('Error al cargar periodos:', error);
    }
  };
  
  // Manejar envío del formulario
  const handleSubmit = async () => {
    try {
      if (editing.value) {
        await axios.put(API_URL, 
          { ...formData.value, id_periodo: currentId.value },
          getAuthHeader()
        );
      } else {
        await axios.post(API_URL, formData.value, getAuthHeader());
      }
      await loadPeriodos();
      resetForm();
    } catch (error) {
      console.error('Error al guardar:', error);
    }
  };
  
  // Editar periodo
  const editPeriodo = (periodo) => {
    editing.value = true;
    currentId.value = periodo.id_periodo;
    formData.value = { ...periodo };
  };
  
  // Cancelar edición
  const cancelEdit = () => {
    editing.value = false;
    resetForm();
  };
  
  // Eliminar periodo
  const deletePeriodo = async (id) => {
    if (confirm('¿Estás seguro de eliminar este periodo?')) {
      try {
        await axios.delete(API_URL, {
          data: { id_periodo: id },
          ...getAuthHeader()
        });
        await loadPeriodos();
      } catch (error) {
        console.error('Error al eliminar:', error);
      }
    }
  };
  
  // Reiniciar formulario
  const resetForm = () => {
    formData.value = {
      nombre: '',
      fecha_inicio: '',
      fecha_fin: '',
      anio_academico: null,
      id_estado: 1
    };
    editing.value = false;
    currentId.value = null;
  };
  
  // Cargar datos iniciales
  onMounted(() => {
    loadPeriodos();
  });
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