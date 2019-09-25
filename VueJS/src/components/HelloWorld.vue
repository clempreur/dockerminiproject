<template>
  <div >

    <b-container class="">
      <b-row>
        <b-col md="10" offset-md="1">
          <h1 style="margin-left: 42%">Listing</h1>
          <b-button variant="outline-primary" @click="listUser = true ; listTeam = false ; ">
            Users list
          </b-button>
          <b-button style="margin-left: 13px" variant="outline-success" @click.prevent="funListTeam" @click="listUser = false ; listTeam = true ;">
            Teams list
          </b-button>
          <div v-if="listUser === true">
            <h4 style="margin-left: 42% ; color: blue">Users list</h4>
            <b-table style="margin-top: 13px" striped hover :items="items">
              <template v-slot:cell(role)="datas">
                <!--
                faire la gestion ici du changement de role via un b-button
                -->
                {{ datas.item.role }}
              </template>
            </b-table>
          </div>
          <div v-if="listTeam === true">
            <h4 style="margin-left: 42% ; color: green">Teams list</h4>
            <b-table style="margin-top: 13px" striped hover :items="itemsTeam">
              <template v-slot:cell(action)="datas">
                <!--
                faire la gestion ici du changement de role via un b-button
                -->
                <b-button style="margin-left: 13px" variant="outline-info" >
                  See the team
                </b-button>
              </template>
            </b-table>
          </div>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
  import axios from 'axios'

  export default {
    components:{
    },
    data(){
      return{
        affiche : false ,
        listTeam : false ,
        listUser : true ,
        datas : null ,
        data : null ,
        items: [],
        itemsTeam : [],
      }
    },
    mounted(){
      this.$root.$on('funList', () => {
        this.funList()
      })
      axios.get('http://localhost:4000/api/users')
              .then(response => {
                console.log(response)
                this.datas = response.data.data
                for (let data in this.datas){
                  var rol = this.datas[data].role
                  if (rol === 1 ) {
                    rol = "Manager"
                  } else if (rol === 2) {
                    rol = " Employe"
                  } else if (rol === 3 ) {
                    rol = "Administrator"
                  }
                  this.items.push({
                    first_name: this.datas[data].firstname,
                    last_name: this.datas[data].lastname ,
                    email: this.datas[data].email,
                    role : rol,
                  })
                }
              })
    },
    methods :{
      funList(){
        this.affiche = true
      },
      funListTeam(){
        console.log("mdr")
        this.itemsTeam =[
          { name : 'Epitech' ,number_of_members : '14',action :'' },
          { name : 'Epita' ,number_of_members : '8',action :'' },
          { name : 'Esgi' ,number_of_members : '18',action :''},
        ]


        /*
        axios.get('http://localhost:4000/api/team')
            .then(response => {
                console.log(response)
                this.data = response.data.data
                for (let data in this.data){
                    this.itemsTeam.push({
                        name: this.data[data].firstname,
                        number_of_members : '12'
                    })
                }
            })
                            * */

      }
    }
  }
</script>
<style>

</style>

