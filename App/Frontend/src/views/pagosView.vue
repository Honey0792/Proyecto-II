<template>
    <div class="pagos-container">
      <!-- Formulario para crear/editar pagos -->
      <div class="pago-form">
        <h2>{{ editing ? 'Editar Pago' : 'Nuevo Pago' }}</h2>
        <form @submit.prevent="handleSubmit">
          <div class="form-row">
            <div class="form-group">
              <label>ID Estudiante:</label>
              <input v-model.number="formData.id_estudiante" type="number" min="1" required>
            </div>
            <div class="form-group">
              <label>Método de Pago:</label>
              <select v-model.number="formData.metodo_pago" required>
                <option value="1">Tarjeta Crédito</option>
                <option value="2">Transferencia</option>
                <option value="3">Efectivo</option>
              </select>
            </div>
          </div>
  
          <div class="form-row">
            <div class="form-group">
              <label>Fecha Pago:</label>
              <input v-model="formData.fecha_pago" type="date" required>
            </div>
            <div class="form-group">
              <label>Renovación:</label>
              <input v-model="formData.renovacion" type="date" required>
            </div>
          </div>
  
          <div class="form-row">
            <div class="form-group">
              <label>Monto Total ($):</label>
              <input v-model.number="formData.monto_total" type="number" step="0.01" min="0" required>
            </div>
            <div class="form-group">
              <label>Monto Cancelado ($):</label>
              <input v-model.number="formData.monto_cancelado" type="number" step="0.01" min="0" required>
            </div>
          </div>
  
          <div class="form-actions">
            <button type="submit" class="btn-primary">{{ editing ? 'Actualizar' : 'Registrar' }}</button>
            <button v-if="editing" type="button" @click="cancelEdit" class="btn-secondary">Cancelar</button>
          </div>
        </form>
      </div>
  
      <!-- Listado de pagos -->
      <div class="pagos-list">
        <h2>Registros de Pagos</h2>
        <div class="table-container">
          <table>
            <thead>
              <tr>
                <th>Estudiante</th>
                <th>Método</th>
                <th>Fecha Pago</th>
                <th>Monto Total</th>
                <th>Cancelado</th>
                <th>Renovación</th>
                <th>Acciones</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="pago in pagos" :key="pago.id_pago">
                <td>#{{ pago.id_estudiante }}</td>
                <td>{{ formatMetodo(pago.metodo_pago) }}</td>
                <td>{{ formatDate(pago.fecha_pago) }}</td>
                <td>${{ pago.monto_total.toFixed(2) }}</td>
                <td>${{ pago.monto_cancelado.toFixed(2) }}</td>
                <td>{{ formatDate(pago.renovacion) }}</td>
                <td>
                  <button @click="editPago(pago)" class="btn-edit">Editar</button>
                  <button @click="deletePago(pago.id_pago)" class="btn-delete">Eliminar</button>
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
  
  const API_URL = 'http://tu-api-url/pagos';
  const formData = ref({
    id_estudiante: null,
    metodo_pago: 1,
    fecha_pago: '',
    monto_total: 0,
    monto_cancelado: 0,
    renovacion: ''
  });
  const pagos = ref([]);
  const editing = ref(false);
  const currentId = ref(null);
  
  const getAuthHeader = () => ({
    headers: {
      Authorization: `Bearer ${localStorage.getItem('token')}`,
      'Role-Validation': true // Para el middleware de roles
    }
  });
  
  const formatDate = (dateString) => {
    return new Date(dateString).toLocaleDateString('es-ES');
  };
  
  const formatMetodo = (metodo) => {
    const metodos = {1: 'Tarjeta', 2: 'Transferencia', 3: 'Efectivo'};
    return metodos[metodo] || 'Desconocido';
  };
  
  const loadPagos = async () => {
    try {
      const response = await axios.get(API_URL, getAuthHeader());
      pagos.value = response.data;
    } catch (error) {
      console.error('Error al cargar pagos:', error);
    }
  };
  
  const handleSubmit = async () => {
    try {
      const data = editing.value 
        ? { ...formData.value, id_pago: currentId.value }
        : formData.value;
  
      const method = editing.value ? 'put' : 'post';
      await axios[method](API_URL, data, getAuthHeader());
      
      await loadPagos();
      resetForm();
    } catch (error) {
      console.error('Error al guardar:', error);
    }
  };
  
  const editPago = (pago) => {
    editing.value = true;
    currentId.value = pago.id_pago;
    formData.value = { ...pago };
  };
  
  const deletePago = async (id) => {
    if (confirm('¿Confirmar eliminación de este pago?')) {
      try {
        await axios.delete(API_URL, {
          data: { id_pago: id },
          ...getAuthHeader()
        });
        await loadPagos();
      } catch (error) {
        console.error('Error al eliminar:', error);
      }
    }
  };
  
  const cancelEdit = () => {
    editing.value = false;
    resetForm();
  };
  
  const resetForm = () => {
    formData.value = {
      id_estudiante: null,
      metodo_pago: 1,
      fecha_pago: '',
      monto_total: 0,
      monto_cancelado: 0,
      renovacion: ''
    };
    currentId.value = null;
  };
  
  onMounted(() => {
    loadPagos();
  });
  </script>
  
  <style scoped>
  .pagos-container {
    max-width: 1400px;
    margin: 2rem auto;
    padding: 25px;
    background-color: #FFFFFF;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
  }
  
  .pago-form {
    margin-bottom: 2rem;
    padding: 25px;
    background: #f8f9fa;
    border-radius: 10px;
  }
  
  .form-group {
    margin-bottom: 1.2rem;
  }
  
  .form-group label {
    display: block;
    margin-bottom: 0.5rem;
    color: #2c3e50;
    font-weight: 500;
  }
  
  input, select {
    width: 100%;
    padding: 10px;
    border: 2px solid #7eb1ba;
    border-radius: 6px;
    font-size: 14px;
  }
  
  .btn-primary {
    background-color: #ef9d4b;
    padding: 12px 25px;
    font-size: 16px;
    transition: background-color 0.3s;
  }
  
  .btn-primary:hover {
    background-color: #e68c34;
  }
  
  .btn-secondary {
    background-color: #7eb1ba;
    padding: 12px 25px;
  }
  
  table {
    margin-top: 1.5rem;
    border-radius: 8px;
    overflow: hidden;
  }
  
  th {
    background-color: #7eb1ba;
    padding: 15px;
    font-weight: 600;
  }
  
  td {
    padding: 12px;
    background-color: #f8fafb;
  }
  
  .btn-edit {
    background-color: #7eb1ba;
    padding: 8px 15px;
  }
  
  .btn-delete {
    background-color: #e74c3c;
    padding: 8px 15px;
  }
  
  @media (max-width: 768px) {
    .form-row {
      grid-template-columns: 1fr;
    }
    
    .pagos-container {
      padding: 15px;
    }
  }
  </style>