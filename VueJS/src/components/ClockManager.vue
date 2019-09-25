<template>
    <div style="margin-top: 10px" class="">
        <h2>Status</h2>

        <b-button variant="outline-success" @click="makeToastS('success')">Start</b-button>
        <b-button style="margin-left: 18px" variant="outline-danger" @click="makeToastD('danger')">Stop</b-button>
    </div>
</template>

<script>
    import axios from 'axios'

    export default {
        name: "ClockManager",
        data(){
            return {
                lastCo: "2019/09/10 12:45",
                datas : null,
                resultT : null,
                resultF : null,
                workingtimeStart : null,
                workingtimeEnd : null,
            }
        },
        methods:{
            toast(etat) {
                var status
                if (etat === true) {
                    status = "You are already working"
                } else status = "You're already paused"
                var append = false
                var toaster = 'b-toaster-top-center'
                this.counter++
                this.$bvToast.toast(status, {
                    title: `WARNING`,
                    toaster: toaster,
                    variant : 'warning',
                    solid: true,
                    appendToast: append
                })
            },
            makeToastS(variant = null) {
                this.resultF = 0 ;
                this.resultT = 0 ;
                var dateZone = new Date();
                var decalage = dateZone.getTimezoneOffset() / 60;
                var currentDate = dateZone
                currentDate.setHours(currentDate.getHours()-decalage)
                axios.get('http://localhost:4000/api/clocks/2')
                    .then(response => {
                        this.datas = response.data.data
                        for (let data in this.datas){
                            if(this.datas[data].status === false ){
                                this.resultF ++
                            } else this.resultT ++
                        }
                    }).catch(error => console.log(error))
                    .then(()=>{
                        if (this.resultT === this.resultF) {
                            axios.post(' http://localhost:4000/api/clocks',{
                                clocks:{
                                    "time": currentDate,
                                    "status": true,
                                    "user": 2
                                }
                            }).then(()=>{
                                var currentDate = new Date()
                                this.$bvToast.toast(''+currentDate, {
                                    title: `Heure d'arrivée`,
                                    variant: variant,
                                    solid: true
                                })
                            })
                        }
                        else {
                            this.toast(true)
                        }
                    })


            },
            makeToastD(variant = null) {
                this.resultF = 0 ;
                this.resultT = 0 ;
                var dateZone = new Date();
                var decalage = dateZone.getTimezoneOffset() / 60;
                var currentDate = dateZone
                currentDate.setHours(currentDate.getHours()-decalage)
                axios.get('http://localhost:4000/api/clocks/2')
                    .then(response => {
                        this.datas = response.data.data
                        for (let data in this.datas){
                            if(this.datas[data].status === false ){
                                this.resultF ++
                            } else this.resultT ++
                        }
                    }).catch(error => console.log(error))
                    .then(()=>{
                        if (this.resultT > this.resultF) {

                            axios.post(' http://localhost:4000/api/clocks',{
                                clocks:{
                                    "time": currentDate,
                                    //"time": "2019-09-22T22:03:43.885Z",
                                    "status": false,
                                    "user": 2
                                }

                            }).then(()=>{
                                var currentDate = new Date()
                                this.$bvToast.toast(''+currentDate, {
                                    title: `Heure de départ`,
                                    variant: variant,
                                    solid: true
                                })
                            }).then(()=>{
                               this.datas.sort(this.compare)
                                console.log(this.datas)
                            }).then(()=>{
                               axios.post('http://localhost:4000/api/workingtimes/',{
                                    workingtimes:{
                                        "start": this.datas[this.datas.length-1].time,
                                        //"end": "2019-09-22T22:03:43.885Z",//BAD
                                        "end": currentDate,
                                        "user": 2
                                    }
                                })
                            })
                        } else {
                            this.toast(false)
                        }
                    })


            },
            compare(a, b) {
                const idA = a.id;
                const idB = b.id;

                let comparison = 0;
                if (idA > idB) {
                    comparison = 1;
                } else if (idA < idB) {
                    comparison = -1;
                }

                return comparison;

            }
        }
    }
</script>

<style scoped>

</style>