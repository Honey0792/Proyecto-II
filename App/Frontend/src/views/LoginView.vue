<template>
  <Header />

  <v-container>
    <v-form>
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
                      :rules="usernameRules"
                      label="User"
                      outlined
                      dense
                      color="blue"
                      autocomplete="false"
                      class="mt-16"
                    />
                    <v-text-field
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
                      @click="loading = true"
                      >Log in</v-btn
                    >
                  </v-col>
                </v-row>
              </v-card-text>
            </v-col>
            <v-col cols="12" md="6" class="kbg rounded-bl-xl">
              <div style="text-align: center; padding: 275px 0"></div>
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

export default {
  components: {
    Header,
  },
  data: () => ({
    dialog: false,
    visible: false,
    loading: false,
    alert: { show: false, message: "" },
    usuario: {
      username: "",
      contrasena: "",
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
};
</script>

<style scoped>
.kbg {
  background-image: url(../assets/portada.jpg);
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
