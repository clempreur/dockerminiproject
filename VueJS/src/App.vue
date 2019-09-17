<template>
  <div id="app">
    <img alt="Vue logo" src="./assets/téléchargement.png">
    <HelloWorld msg="Welcome to Your Vue.js App"/>

    <b-container class="bv-example-row" >
      <b-row>
        <b-col>
          <User msg="Welcome to Your Vue.js App"/>
        </b-col>
        <b-col>
          <ClockManager/>
        </b-col>
      </b-row>
      <b-row>
        <b-col>
          <ChartManager />
        </b-col>
        <b-col>
          <WorkingTimes />
        </b-col>
      </b-row>
    </b-container>

  </div>
</template>

<script>
import User from './components/User.vue'
import ChartManager from "@/components/ChartManager";
import WorkingTime from "@/components/WorkingTime";
import WorkingTimes from "@/components/WorkingTimes";
import ClockManager from "@/components/ClockManager";

export default {
  name: 'app',
  components: {
    ClockManager,
    WorkingTimes,
    WorkingTime,
    ChartManager,
    User
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
.col { border: 1px solid transparent; }
</style>
