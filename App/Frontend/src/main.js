import { createApp } from 'vue';
import App from './App.vue';
import router from './router';

// Vuetify
import 'vuetify/styles';
import { createVuetify } from 'vuetify';
import * as components from 'vuetify/components';
import * as directives from 'vuetify/directives';
import '@mdi/font/css/materialdesignicons.css';

// SweetAlert2
/* import VueSweetalert2 from 'vue-sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
 */
const vuetify = createVuetify({
    components,
    directives,
});

const app = createApp(App);
app.use(router);
app.use(vuetify);
// app.use(VueSweetalert2);
app.mount('#app');

export default createVuetify({
    icons: {
        defaultSet: 'mdi', // This is already the default value - only for display purposes
    }
});


