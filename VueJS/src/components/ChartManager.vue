<template>
    <div id="app">
        <h1>Donut Chart</h1>
        <donut-chart id="donut" :data="donutData" :colors="arrayColors" resize="true">
        </donut-chart>
    </div>
</template>
<script>
    import { DonutChart } from 'vue-morris'
    export default {
        data(){
            return{
                donutData: [
                    { label: 'Car', value: 40 },
                    { label: 'Motorcycle', value: 150 },
                    { label: 'airplane', value: 100 }
                ],
                arrayColors:[ "#FF6384", "#73c000", "#FFCE56" ]
            }
        },
        components:{
            DonutChart
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
</style>