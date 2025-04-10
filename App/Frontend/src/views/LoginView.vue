<template>
  <Header />
  <v-dialog
      v-model="alert.show"
      width="auto"
      class="justify-center align-center"
    >
      <v-alert
        v-model="alert.show"
        :color="alert.color"
        variant="elevated"
        prominent
        closable
        width="400px"
        >{{ alert.message }}</v-alert
      >
    </v-dialog>
  <v-container >
    <v-form @submit.prevent="login" class="d-flex">
      <v-row align="center" justify="center">
        <v-col cols="12" sm="10">
          <v-card class="elevation-6 mt-10">
            <v-row>
              <v-col cols="12" md="6">
                <v-card-text class="mt-12">
                  <h4 class="text-center">Login in to Your Account</h4>
                  <v-row align="center" justify="center">
                    <v-col cols="12" sm="8">
                      <v-text-field
                        v-model="user.usuario"
                        :rules="usernameRules"
                        label="User"
                        outlined
                        dense
                        color="blue"
                        autocomplete="false"
                        class="mt-16"
                      />
                      <v-text-field
                        v-model="user.password"
                        :rules="contrasenaRules"
                        label="Password"
                        outlined
                        dense
                        color="blue"
                        autocomplete="false"
                        type="password"
                      />
                      <v-row>
                        <v-col cols="12" sm="7"> </v-col>
                      </v-row>
                      <v-btn
                        type="submit"
                        color="cyan"
                        dark
                        block
                        tile
                        @click="login"
                        >Log in</v-btn
                      >
                    </v-col>
                  </v-row>
                </v-card-text>
              </v-col>
              <v-col cols="12" md="6" class="kbg">
                <div style="text-align: center; padding: 290px 0"></div>
              </v-col>
            </v-row>
          </v-card>
        </v-col>
      </v-row>
    </v-form>
  </v-container>
</template>

<script>
import Header from "@/components/Header.vue";
import newGoalService from "@/services/newGoalService";
export default {
  components: {
    Header,
  },
  data: () => ({
    dialog: false,
    visible: false,
    loading: false,
    alert: { show: false, message: "" },
    user: {
      usuario: "",
      password: "",
    },
    usernameRules: [
      (value) => !!value || "Éste campo es requerido",
      (value) =>
        !value.includes(" ") ||
        "El nombre de usuario no puede contener espacios en blanco",
      (value) =>
        /^[A-Za-z\s.\d]+$/.test(value) ||
        "No se permiten caracteres especiales",
      (value) =>
        value.length <= 14 ||
        "El nombre de usuario no puede contener más de 14 caracteres",
      (value) =>
        value.length >= 4 ||
        "El nombre de usuario no puede contener menos de 4 caracteres",
    ],
    contrasenaRules: [
      (value) => !!value || "La contrasena es requerida",
      (value) =>
        !value.includes(" ") || "La contraseña no puede contener espacios",
      (value) =>
        /^[a-zA-Z0-9\._-]*$/.test(value) ||
        "La contraseña solo puede contener letras, números, guiones bajos y puntos",
      (value) =>
        value.length <= 14 ||
        "La contraseña no puede tener más de 18 caracteres",
      (value) =>
        value.length >= 4 ||
        "La contraseña no puede tener menos de 4 caracteres",
    ],
  }),
  methods: {
    async login() {
      try {
        const res = await newGoalService.userLog(this.user)
        const token = res.data.token;
        const role = res.data.role
        console.log(res) // Asegúrate de que tu API retorne el token en esta propiedad
        sessionStorage.setItem("token", token);
        sessionStorage.setItem("role", role)
        console.log(res)
        // this.alert = {
        //   show: true,
        //   color: 'success',
        //   message: "Sesion Iniciada Exitosamente",
        // }
        this.$router.push('/main')
        
      } catch (err) {
        this.alert = {
          show: true,
          color: 'warning',
          message: "Error al iniciar sesión. Verifica tus credenciales." ,
        }
        this.error = "Error al iniciar sesión. Verifica tus credenciales.";
        console.error(err);
      }
    },
  },
};
</script>

<style scoped>
.kbg {
  background-image: url(../assets/Login_img.webp);
  background-size: cover;
  background-repeat: no-repeat;
  background-position: center;
}

.v-application .rounded-bl-xl {
  border-bottom-left-radius: 300px !important;
}
.v-application .rounded-br-xl {
  border-bottom-right-radius: 300px !important;
}
</style>
