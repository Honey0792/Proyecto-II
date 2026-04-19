<template>
  <v-data-table
    :loading="loadingConfig"
    :items="pagosFormateados"
    :headers
    :items-per-page-options="itemsPerPage"
    v-model:items-per-page="paginacion.items"
    v-model:page="paginacion.pagina"
    :search="search"
  >
    <template v-slot:top>
      <div class="d-flex ga-3 align-center">
        <v-text-field
          variant="outlined"
          v-model="search"
          placeholder="Buscar"
          prepend-inner-icon="mdi-magnify"
          clearable
          density="compact"
          class="ma-2"
          single-line
        />

        <v-select
          class="ma-2"
          v-model="modoMoneda"
          :items="modosMoneda"
          variant="outlined"
          item-title="title"
          item-value="value"
          label="Mostrar montos en"
          density="compact"
          style="max-width: 220px"
        />
      </div>
    </template>
    <template v-slot:item.fecha_pago="{ item }">
  {{ item.fecha_pago.split("T")[0] }}
</template>


    <template v-slot:item.monto_total_pago="{ item }">
  <div class="d-flex flex-column">
    
    <!-- principal -->
    <span>
      {{ formatoMoneda(item.monto_total_visual, item.moneda_base) }}
    </span>

    <!-- 🔥 dual -->
    <small v-if="modoMoneda === 'dual'" class="text-grey">
      {{ item.moneda_base === 'USD'
        ? formatoMoneda(item.monto_total_bs, 'BS')
        : formatoMoneda(item.monto_total_pago, 'USD')
      }}
    </small>

  </div>
</template>

    <template v-slot:item.monto_cancelado_pago="{ item }">
  <div
    class="pa-2 rounded"
    :class="{
      'bg-success': item.monto_cancelado_visual === item.monto_total_visual,
      'bg-warning': item.monto_cancelado_visual !== item.monto_total_visual,
    }"
  >
    <div>
      {{ formatoMoneda(item.monto_cancelado_visual, item.moneda_base) }}
    </div>

    <small v-if="modoMoneda === 'dual'" class="text-grey">
      {{ item.moneda_base === 'USD'
        ? formatoMoneda(item.monto_cancelado_bs, 'BS')
        : formatoMoneda(item.monto_cancelado_pago, 'USD')
      }}
    </small>
  </div>
</template>


    <template v-slot:item.restante="{ item }">
  <div class="pa-2 rounded">
    
    <div>
      {{ formatoMoneda(item.restante_visual, item.moneda_base) }}
    </div>

    <small v-if="modoMoneda === 'dual'" class="text-grey">
      {{
        item.moneda_base === "USD"
          ? formatoMoneda(item.monto_total_bs - item.monto_cancelado_bs, "BS")
          : formatoMoneda(item.monto_total_pago - item.monto_cancelado_pago, "USD")
      }}
    </small>

  </div>
</template>

    <template v-slot:item.id_pago="{ item }"> </template>
    <template v-slot:item.actions="{ item }">
      <div class="d-flex ga-2 justify-end">
        <v-icon
          color="medium-emphasis"
          icon="mdi-pencil"
          size="small"
          @click="edita(item.id_pago)"
        ></v-icon>
        <v-icon
          color="medium-emphasis"
          icon="mdi-eye"
          size="small"
          @click="ver(item.id_pago)"
        ></v-icon>
        <v-icon
          color="medium-emphasis"
          icon="mdi-delete"
          size="small"
          @click="eliminar(item.id_pago)"
        ></v-icon>
      </div>
    </template>
    <!-- <template v-slot:bottom>
      <div class="text-center pt-2">
        <v-pagination
          length="5"
        ></v-pagination>
      </div>
    </template> -->
    <template v-slot:footer.prepend>
      <div class="mx-3">
        <v-btn @click="reporte">Generar reporte</v-btn>
      </div>
    </template>
  </v-data-table>

  <v-dialog v-model="this.dialog_1">
    <v-icon
      icon="mdi-close"
      class="position-absolute right-0"
      color="white"
      @click="this.dialog_1 = false"
    ></v-icon>
    <CartaEditPago @actualizar_tabla="obtenerPagos" :id="id_pago" />
  </v-dialog>
  <v-dialog v-model="this.dialog_2">
    <v-icon
      icon="mdi-close"
      class="position-absolute right-0"
      color="white"
      @click="this.dialog_2 = false"
    ></v-icon>
    <CartaVerPago :id="id_pago" />
  </v-dialog>
  <v-dialog v-model="this.dialog_3" width="auto">
    <v-card
      max-width="400"
      prepend-icon="mdi-delete-alert"
      text="¿Estas Seguro/a de querer eliminar a este Pago?"
      title="Oprimiste eliminar"
      color="warning"
    >
      <template v-slot:actions>
        <v-spacer></v-spacer>
        <v-btn
          class="ms-auto"
          text="Cancelar"
          @click="this.dialog_3 = false"
        ></v-btn>
        <v-btn class="ms-auto" text="Ok" @click="eliminarPago"></v-btn>
      </template>
    </v-card>
  </v-dialog>
  <v-dialog v-model="this.dialog_4">
    <v-icon
      icon="mdi-close"
      class="position-absolute right-0"
      color="white"
      @click="this.dialog_4 = false"
    ></v-icon>
    <CartaReportePagos />
  </v-dialog>
</template>

<script>
import newGoalService from "@/services/newGoalService";
import { ref } from "vue";
import CartaVerPago from "../Cards/CartaVerPago.vue";
import CartaEditPago from "../Cards/CartaEditPago.vue";
import CartaReportePagos from "../Cards/CartaReportePagos.vue";

const METODOS_USD = [5, 6, 7, 8, 9];
// Zelle, Divisas, Binance, Banesco Panama, Mercantil Panama

const METODOS_BS = [1, 2, 3, 4];
// Efectivo, Pago Móvil, Punto, Transferencia

export default {
  components: {
    CartaVerPago,
    CartaEditPago,
    CartaReportePagos,
  },
  data: () => ({
    loadingConfig: true,
    search: null,
    dialog_1: false,
    dialog_2: false,
    dialog_3: false,
    dialog_4: false,
    paginacion: {
      items: 10,
      pagina: 1,
    },
    modoMoneda: "default",
    modosMoneda: [
      { title: "Según método de pago", value: "metodo" },
      { title: "Todo en USD", value: "usd" },
      { title: "Todo en Bs", value: "bs" },
      { title: "Ambas monedas", value: "dual" }, // 🔥 PRO
    ],
    itemsPerPage: [
      { value: 10, title: "10" },
      { value: 25, title: "25" },
      { value: 50, title: "50" },
      { value: 100, title: "100" },
    ],
    headers: [
      { title: "ID", key: "id_pago" },
      { title: "Nombre", key: "nombre_etd" },
      { title: "Apellido", key: "apellido_etd" },
      { title: "Fecha", key: "fecha_pago" },
      { title: "Método de Pago", key: "nombre_metodo_pago" },
      { title: "Tasa (Bs)", key: "tasa_bolivares" },
      { title: "Monto Total ($)", key: "monto_total_pago" },
      { title: "Monto Cancelado ($)", key: "monto_cancelado_pago" },
      { title: "Restante ($)", key: "restante" },
      { title: "Acciones", key: "actions", sortable: false },
    ],

    id_pago: null,
    pago: {
      id_estudiante: null,
      metodo_pago: null,
      fecha_pago: "",
      monto_total: null,
      monto_cancelado: null,
      tasa_bolivares: null,
    },
    pagos: [],
  }),
  methods: {
  
    async obtenerPagos() {
      try {
        const res = await newGoalService.getPagos();
        this.pagos = res.data;
        console.log(res);
        this.loadingConfig = false;
      } catch (error) {
        console.log(error);
      }
    },
    async eliminarPago() {
      const id = { id_pago: this.id_pago };
      try {
        const res = await newGoalService.deletePago(id);
        this.dialog_3 = false;
        this.obtenerPagos();
      } catch (error) {
        console.log(error);
      }
    },

    // async reportePagos() {
    //   try {
    //     const response = await newGoalService.getReportePagos();
    //     const url = window.URL.createObjectURL(new Blob([response.data]));
    //     const link = document.createElement("a");
    //     link.href = url;

    //     // Obtener el nombre del archivo desde las cabeceras (si el servidor lo envía)
    //     const contentDisposition = response.headers["content-disposition"];
    //     const fileName = contentDisposition
    //       ? contentDisposition.split("filename=")[1].replace(/"/g, "")
    //       : `Reporte_Pagos_${new Date().toISOString()}.xlsx`; // Nombre por defecto si no hay header

    //     link.setAttribute("download", fileName);
    //     document.body.appendChild(link);
    //     link.click();

    //     // Limpiar recursos
    //     document.body.removeChild(link);
    //     window.URL.revokeObjectURL(url);
    //   } catch (error) {
    //     console.error("Error:", error.response?.data || error.message);
    //   }
    // },

    formatoMoneda(valor, monedaBase) {
      let simbolo = "";

      if (this.modoMoneda === "default") {
        simbolo = monedaBase === "USD" ? "$" : "Bs";
      } else if (this.modoMoneda === "usd") {
        simbolo = "$";
      } else {
        simbolo = "Bs";
      }

      return `${simbolo} ${Number(valor).toFixed(2)}`;
    },

    edita(id) {
      this.id_pago = id;
      console.log("hola");
      this.dialog_1 = true;
    },

    reporte() {
      console.log("hola");
      this.dialog_4 = true;
    },

    ver(id) {
      this.id_pago = id;
      console.log(id);
      this.dialog_2 = true;
    },
    eliminar(id) {
      this.id_pago = id;
      console.log("hola");
      this.dialog_3 = true;
      console.log(id);
    },
  },

  computed: {
    pagosFormateados() {
      return this.pagos.map((p) => {
        const esUSD = METODOS_USD.includes(p.id_metodo_pago);

        const montoTotalUSD = p.monto_total_pago;
        const montoCanceladoUSD = p.monto_cancelado_pago;

        const tasa = p.tasa_bolivares;

        let montoTotalVisual = montoTotalUSD;
        let montoCanceladoVisual = montoCanceladoUSD;
        let moneda = "USD";

        // 🔁 MODO SEGÚN MÉTODO
        if (this.modoMoneda === "metodo") {
          if (!esUSD) {
            montoTotalVisual = montoTotalUSD * tasa;
            montoCanceladoVisual = montoCanceladoUSD * tasa;
            moneda = "BS";
          }
        }

        // 🔁 TODO USD
        if (this.modoMoneda === "usd") {
          moneda = "USD";
        }

        // 🔁 TODO BS
        if (this.modoMoneda === "bs") {
          montoTotalVisual = montoTotalUSD * tasa;
          montoCanceladoVisual = montoCanceladoUSD * tasa;
          moneda = "BS";
        }

        // 🔥 MODO DUAL (NO cambia valores base)
        return {
          ...p,
          monto_total_visual: montoTotalVisual,
          monto_cancelado_visual: montoCanceladoVisual,
          restante_visual: montoTotalVisual - montoCanceladoVisual,


          monto_total_bs: montoTotalUSD * tasa,
          monto_cancelado_bs: montoCanceladoUSD * tasa,

          moneda_base: moneda,
          esUSD,
        };
      });
    },
  },

  mounted() {
    this.obtenerPagos();
    // Escuchar evento global de pago actualizado
    window.addEventListener("pagoActualizado", () => {
      this.obtenerPagos();
    });
  },
};
</script>
