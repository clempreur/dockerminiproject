<template>
    <div>

        <b-container style="margin-top: 26px" >
            <b-row v-if="pret">
                <b-col cols="12" md="12" >
                    <div style="margin-left: 22px; margin-bottom: 22px">
                        <b-button pill variant="outline-primary" @click="pret=true ; pretTeam=false">Users</b-button>
                        <b-button style="margin-left: 22px" @click="pret=false ; pretTeam=true ; funListTeam()" pill variant="outline-danger">Teams</b-button>
                    </div>
                   <vue-good-table
                            :columns="columns"
                            :rows="rows"
                            :search-options="{enabled: true}"
                            :pagination-options="{
                                enabled: true,
                                mode: 'records',
                                perPage: 5,
                                perPageDropdown: [10, 20, 30],
                                dropdownAllowAll: false,
                                setCurrentPage: 1,
                                nextLabel: 'next',
                                prevLabel: 'prev',
                                rowsPerPageLabel: 'Rows per page',
                                ofLabel: 'of',
                                pageLabel: 'page', // for 'pages' mode
                                allLabel: 'All',
                              }">

                        <template slot="table-row" slot-scope="rows">
                            <div v-if="rows.column.field === 'action'" style="text-align: center ">
                                <b-button variant="outline-info" @click="showStats(rows.row.idUser)">Stats ({{rows.row.idUser}})</b-button>
                                <b-button style="margin-left: 18px" @click="dataUserUpdate=rows.row" v-b-modal="'modal-UserUpdate'" variant="outline-success" id="show-btn" >
                                    Modify
                                </b-button>
                            </div>
                        </template>
                    </vue-good-table>
                </b-col>
            </b-row>
            <b-row v-if="pretTeam">
                <b-col cols="12" md="12" >
                    <div style="margin-left: 22px; margin-bottom: 22px">
                        <b-button pill variant="outline-primary" @click="pret=true ; pretTeam=false">Users</b-button>
                        <b-button style="margin-left: 22px" @click="pret=false ; pretTeam=true" pill variant="outline-danger">Teams</b-button>
                    </div>
                    <vue-good-table
                            :columns="columnsTeam"
                            :rows="rowsTeam"
                            :search-options="{enabled: true}"
                            :pagination-options="{
                                enabled: true,
                                mode: 'records',
                                perPage: 5,
                                perPageDropdown: [10, 20, 30],
                                dropdownAllowAll: false,
                                setCurrentPage: 1,
                                nextLabel: 'next',
                                prevLabel: 'prev',
                                rowsPerPageLabel: 'Rows per page',
                                ofLabel: 'of',
                                pageLabel: 'page', // for 'pages' mode
                                allLabel: 'All',
                              }">

                        <template slot="table-row" slot-scope="rows">
                            <div v-if="rows.column.field === 'action'" style="text-align: center ">
                                <b-button variant="outline-info" v-b-modal="'modal-Team'" @click="showTeam(rows.row.idTeam)">Show</b-button>
                                <b-button style="margin-left: 18px" v-b-modal="'modal-TeamDelete'" variant="outline-danger" @click="teamName=rows.row.name">
                                    Delete
                                </b-button>
                            </div>
                        </template>
                    </vue-good-table>
                </b-col>
            </b-row>
        </b-container>

        <div>
            <b-modal
                    size="xl"
                    id="modal-Team"
                    ref="modal"
                    title="Members of the team"
            >
                <h3>{{teamName}}</h3>
                <vue-good-table
                        :columns="columns"
                        :rows="rowsMemberTeam"
                        :search-options="{enabled: true}"
                        :pagination-options="{
                                enabled: true,
                                mode: 'records',
                                perPage: 5,
                                perPageDropdown: [10, 20, 30],
                                dropdownAllowAll: false,
                                setCurrentPage: 1,
                                nextLabel: 'next',
                                prevLabel: 'prev',
                                rowsPerPageLabel: 'Rows per page',
                                ofLabel: 'of',
                                pageLabel: 'page', // for 'pages' mode
                                allLabel: 'All',
                              }">

                    <template slot="table-row" slot-scope="rows">
                        <div v-if="rows.column.field === 'action'" style="text-align: center ">
                            <b-button pill variant="danger" @click="removeMember(rows.row)"> - Remove</b-button>
                        </div>
                    </template>
                </vue-good-table>

                <b-button style="margin-top: 18px;margin-bottom: 18px" pill variant="danger" @click="noMember" >Add other users</b-button>
                <div v-if="pretNoMember">
                    <vue-good-table
                            :columns="columns"
                            :rows="rowsNoMemberTeam"
                            :search-options="{enabled: true}"
                            :pagination-options="{
                                enabled: true,
                                mode: 'records',
                                perPage: 5,
                                perPageDropdown: [10, 20, 30],
                                dropdownAllowAll: false,
                                setCurrentPage: 1,
                                nextLabel: 'next',
                                prevLabel: 'prev',
                                rowsPerPageLabel: 'Rows per page',
                                ofLabel: 'of',
                                pageLabel: 'page', // for 'pages' mode
                                allLabel: 'All',
                              }">

                        <template slot="table-row" slot-scope="rows">
                            <div v-if="rows.column.field === 'action'" style="text-align: center ">
                                <b-button pill variant="primary" @click="addMember(rows.row)"> + Add </b-button>
                            </div>
                        </template>
                    </vue-good-table>
                </div>
                <template v-slot:modal-footer="{ ok, cancel, hide }">
                    <b-button size="xl" variant="success" @click="update">Confirm</b-button>
                </template>

            </b-modal>
        </div>

        <div>
        <b-modal

                id="modal-TeamDelete"
                ref="modal"
                title="Deleting a team"
        >
            <h4>Are you sure you want to delete this team :</h4><h3>{{teamName}}</h3>
            <template v-slot:modal-footer="{ ok, cancel, hide }">
                <b-button size="xl" variant="success" @click="deleteTeam()">Confirm</b-button>
            </template>
        </b-modal>
             </div>

        <div>
        <b-modal id="modal-UserUpdate" ref="modal" title="Update a user">

            <b-form-group label-cols="6" label-cols-lg="6"  label="First name:" >
                <b-form-input  v-model="dataUserUpdate.first_name" required
                               placeholder="Enter the first name"></b-form-input>
            </b-form-group>
            <b-form-group label-cols="6" label-cols-lg="6"  label="Last name:" >
                <b-form-input  v-model=" dataUserUpdate.last_name" required
                              placeholder="Enter the last name"></b-form-input>
            </b-form-group>
            <b-form-group label-cols="6" label-cols-lg="6"  label="Email:" >
                <b-form-input  v-model="dataUserUpdate.email " type="email" required
                              placeholder="Enter the email"></b-form-input>
            </b-form-group>
            <b-form-group label-cols="6" label-cols-lg="6"  label="Password:" >
                <b-form-input  v-model="newPassword"  required
                              placeholder="Enter the password"></b-form-input>
            </b-form-group>
            <template v-slot:modal-footer="{ ok, cancel, hide }">
                <b-button size="xl" variant="success" @click="updateUser(dataUserUpdate.idUser)">Confirm</b-button>
            </template>
        </b-modal>
             </div>

        <div v-if="ShowsStats">
            <ChartManager :idUser="idUser" :key="compositeKey"></ChartManager>
            <b-button variant="info" class="" @click="retourListe()" >Return to the list </b-button>
        </div>

    </div>
</template>

<script>
    import axios from 'axios'
    import ChartManager from "./ChartManager";

    export default {
        components:{
            ChartManager,

        },
        data(){
            return{
                addUser : false ,
                pret : false ,
                pretTeam : false ,
                pretNoMember : false ,
                affiche : false ,
                ShowsStats : false ,
                listTeam : false ,
                listUser : true ,
                compositeKey: null,
                datas : null ,
                idUser : null ,
                data : null ,
                teamName : null ,
                teamSelect : null ,
                newPassword : "" ,
                items: [],
                itemsTeam : [],
                columns: [
                    {
                        label: 'Lastname',
                        field: 'last_name',
                    },
                    {
                        label: 'Firstname',
                        field: 'first_name',
                    },
                    {
                        label: 'Email',
                        field: 'email',
                    },
                    {
                        label: 'Role',
                        field: 'role',
                    },
                    {
                        label: '',
                        field: 'action',
                    },
                ],
                columnsTeam: [
                    {
                        label: 'Name',
                        field: 'name',
                    },
                    {
                        label: '',
                        field: 'action',
                    },
                ],
                rows: [],
                rowsTeam: [],
                rowsMemberTeam: [],
                rowsNoMemberTeam: [],
                dataUpdate : [],
                dataUserUpdate : {},
            }
        },
        mounted(){
            this.$root.$on('funList', () => {
                this.funList()
            })
            this.funList()

        },
        methods :{
            updateUser(value){
                console.log(this.dataUserUpdate)

                axios.put('http://localhost:4000/api/users/'+value,
                    {
                        users:{
                            "email":this.dataUserUpdate.email,
                            "firstname": this.dataUserUpdate.first_name,
                            "lastname": this.dataUserUpdate.last_name
                        }
                    }
                )
            },
            deleteTeam(value){
                //la route api delete team n'existe pas encore
            },
            removeMember(value){
                this.rowsNoMemberTeam.push(value)

                for (let pos in this.rowsMemberTeam ) {
                    if (this.rowsMemberTeam[pos].email === value.email) {
                        this.rowsMemberTeam.splice(pos, 1);
                    }
                }
            },
            addMember(value){
                this.rowsMemberTeam.push(value)
                
                for (let pos in this.rowsNoMemberTeam ) {
                    if (this.rowsNoMemberTeam[pos].email === value.email) {
                        this.rowsNoMemberTeam.splice(pos, 1);
                    }
                }
            },
            noMember(){
                this.rowsNoMemberTeam = []
                axios.get('http://localhost:4000/api/users')
                    .then(response => {
                        console.log(response.data.data)
                        this.datas = response.data.data
                        for (let data in this.datas){
                            var add = true
                           for (let us in this.rowsMemberTeam){
                               console.log("us"+us)
                               console.log("this.datas[data].id"+this.datas[data].id)
                               if (this.rowsMemberTeam[us].idUser === this.datas[data].id){
                                   add = false
                               }
                           }
                           if (add){
                               var rol = this.datas[data].role
                               if (rol === 1 ) {
                                   rol = "Manager"
                               } else if (rol === 2) {
                                   rol = " Employe"
                               } else if (rol === 3 ) {
                                   rol = "Administrator"
                               }
                               this.rowsNoMemberTeam.push({
                                   first_name: this.datas[data].firstname,
                                   last_name: this.datas[data].lastname ,
                                   email: this.datas[data].email,
                                   idUser: this.datas[data].id,
                                   role : rol,
                               })
                           }
                        }
                    }).then(()=>{

                    this.pretNoMember = true

                })
            },
            showTeam(value){
                this.teamSelect = value
                this.rowsMemberTeam = []
                axios.get('http://localhost:4000/api/teams/'+value)
                    .then(response=> {
                        this.teamName = response.data.data.name
                        this.datas = response.data.data.users
                        for (let data in this.datas) {
                            var rol = this.datas[data].role
                            if (rol === 1) {
                                rol = "Manager"
                            } else if (rol === 2) {
                                rol = " Employe"
                            } else if (rol === 3) {
                                rol = "Administrator"
                            }
                            this.rowsMemberTeam.push({
                                first_name: this.datas[data].firstname,
                                last_name: this.datas[data].lastname,
                                email: this.datas[data].email,
                                idUser: this.datas[data].id,
                                role: rol,
                            })
                        }
                        })
            },
            update(){
                this.dataUpdate = []
                for (let us in this.rowsNoMemberTeam){
                        this.dataUpdate.push(this.rowsNoMemberTeam[us].idUser)
                }

                this.dataUpdate = this.cleanArray(this.dataUpdate)
                console.log(this.dataUpdate)
//http://localhost:4000/api/teams/suppr_user
                axios.put('http://localhost:4000/api/teams/suppr_user',
                        {
                            "id": this.teamSelect,
                            "users": this.dataUpdate
                        }).then(()=>{
                    this.dataUpdate = []
                    for (let us in this.rowsMemberTeam){
                        this.dataUpdate.push(this.rowsMemberTeam[us].idUser)
                    }
                    axios.put('http://localhost:4000/api/teams/add_user',
                        {
                            "id": this.teamSelect,
                            "users": this.dataUpdate
                        })
                })
            },
            retourListe(){
                this.pret = true
                this.ShowsStats = false
            },
            showStats(value){
                this.compositeKey++
                this.pret = false
                this.ShowsStats = true
                this.idUser = value;
            },
            funList(){
                this.affiche = true
                this.rows = []
                axios.get('http://localhost:4000/api/users')
                    .then(response => {
                        console.log(response.data.data)
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
                            this.rows.push({
                                first_name: this.datas[data].firstname,
                                last_name: this.datas[data].lastname ,
                                email: this.datas[data].email,
                                idUser: this.datas[data].id,
                                role : rol,
                            })
                        }
                    }).then(()=>{
                    this.pret = true
                    console.log(this.rows)
                })
            },
            funListTeam(){
                console.log("mdr")
                this.rowsTeam = []
                axios.get('http://localhost:4000/api/teams')
                    .then(response => {
                        console.log(response)
                        this.data = response.data.data
                        for (let data in this.data){
                            this.rowsTeam.push({
                                name: this.data[data].name,
                                idTeam : this.data[data].id
                            })
                        }
                    })


            },
            cleanArray(array) {
                var i, j, len = array.length, out = [], obj = {};
                for (i = 0; i < len; i++) {
                    obj[array[i]] = 0;
                }
                for (j in obj) {
                    out.push(j);
                }
                return out;
            }
        }
    }
</script>
<style>

</style>

