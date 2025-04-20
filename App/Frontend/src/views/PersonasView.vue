<template>
    <RegPersona />
    </template>
    
    <script>
    import axios from 'axios';
    import RegPersona from '@/components/Forms/RegPersona.vue';
    import CartaVerRepresentante from '@/components/Cards/CartaVerRepresentante.vue';
    export default {
    
    components :{
      RegPersona,
      CartaVerRepresentante,
    },
    
    data: ()=>({
    
    }),
    }
    </script>