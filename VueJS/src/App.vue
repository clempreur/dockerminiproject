<template>
  <div >
    <img style="margin-top: 10px;margin-left: 45%" alt="Vue logo" src="./assets/logo1.png">

    <BaseFront></BaseFront>

    <router-view></router-view>

  </div>
</template>




<script>
/*
import User from './components/User.vue'
import ChartManager from "@/components/ChartManager";
import HelloWorld from "@/components/HelloWorld";
import WorkingTimes from "@/components/WorkingTimes";
import ClockManager from "@/components/ClockManager";
*/
import BaseFront from "@/components/BaseFront";

export default {
  name: 'app',
  components: {
    /*
    ClockManager,
    WorkingTimes,
    //HelloWorld,
    ChartManager,
    User,*/
    BaseFront,

  },
  mounted(){},
  methods: {
    funModif() {
      this.$refs.form.funModif()
    },
    funRecherche() {
      this.$refs.form.funRecherche()
    },
    funCreerUser() {
      this.$refs.form.funCreerUser()
    },
    funCreerTeam() {
      this.$refs.form.funCreerTeam()
    },
  }
}
</script>

<style>

</style>
