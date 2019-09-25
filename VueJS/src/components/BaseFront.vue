<template>
    <div class="">
        <div style="margin-top: 18px">
            <b-navbar  toggleable="lg"  variant="info">
                <b-navbar-brand href="/">GC</b-navbar-brand>
                <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>
                <b-collapse  id="nav-collapse" is-nav>
                    <b-navbar-nav >
                        <b-nav-item-dropdown    text="Access management" right>
                            <b-dropdown-item @click.prevent="funList">
                                <router-link     to="/listing">Listing</router-link>
                            </b-dropdown-item>
                            <b-dropdown-item  @click.prevent="funCreerUser" >
                                <router-link     to="/user">Create a User</router-link>
                            </b-dropdown-item>
                            <b-dropdown-item @click.prevent="funCreerTeam">
                                <router-link to="/user">Create a Team</router-link>
                            </b-dropdown-item>
                        </b-nav-item-dropdown>
                        <b-nav-item >
                            <router-link  to="/stats">Statistics</router-link>
                        </b-nav-item>
                    </b-navbar-nav>
                    <b-navbar-brand style="font-size: 16px; margin-left: auto">Welcome back Mr/Mme Dupond Tupont , last login on the 2019/09/16 at 11h26</b-navbar-brand>


                    <!-- Right aligned nav items -->
                    <b-navbar-nav class="ml-auto">
                        <b-nav-form>
                            <b-form-input size="sm" class="mr-sm-2" placeholder="Search"></b-form-input>
                            <b-button size="sm" class="my-2 my-sm-0" type="submit" @click.prevent="funRecherche">Search</b-button>
                        </b-nav-form>

                        <b-nav-item-dropdown right>
                            <!-- Using 'button-content' slot -->
                            <template v-slot:button-content><em>User</em></template>
                            <b-dropdown-item  @click.prevent="funModif" >
                                <router-link to="/user">Profile</router-link>
                            </b-dropdown-item>
                            <b-dropdown-item href="#">Sign Out</b-dropdown-item>
                        </b-nav-item-dropdown>
                    </b-navbar-nav>
                </b-collapse>
            </b-navbar>
        </div>

        <b-row align-h="around">
        </b-row>

        <b-container class="bv-example-row">
            <b-row>
                <b-col cols="6" md="9" ><User ref="form" v-if="cacher"/></b-col>
                <b-col cols="6" md="3"><ClockManager /></b-col>
            </b-row>
            <b-row>
                <b-col cols="6" md="9" ><Listing ref="form" v-if="cacher"/></b-col>
            </b-row>
            <b-row>
                <!--<b-col cols="6" md="9" ><ChartManager v-if="cache"/></b-col>-->
            </b-row>
        </b-container>

    </div>
</template>

<script>

    import User from './User.vue'
    //import HelloWorld from "@/components/HelloWorld";
    import WorkingTimes from "./WorkingTimes";
    import ClockManager from "./ClockManager";
    import Listing from "./Listing";
    import ChartManager from "./ChartManager";


    export default {
        name: 'BaseFront',
        components: {
            Listing,
            ClockManager,
            ChartManager,
            WorkingTimes,
            //HelloWorld,
            User,
        },
        data() {
            return {
                cacher : false ,
                cache : true ,
                clickCreer: false,
                clickCreerTeam: false,
                clickRecherche: false,
                clickModif: false,
                userConnectFirst: "Yoel",
                userConnectLast: "Laskar",
                userConnectEmail: "yoel.laskar@epitech.eu",
                userConnectPassword: "",
                info : "",
                newFirstname :"",
                newLastname :"",
                newEmail :"",
                newPassword :"",
                updateFirstname :"",
                updateLastname :"",
                updateEmail :"",
                updatePassword :"",
            };
        },
        mounted() {
            console.log("test")
        },
        methods: {
            funList(){
                this.$root.$emit('funList')
                this.cache = false
            },
            funCreerUser(){
                this.$root.$emit('funCreerUser')
                this.cache = false
            },
            funModif() {
                this.$root.$emit('funModif')
                this.cache = false
            },
            funRecherche() {
                this.$root.$emit('funRecherche')
                this.cache = false
            },
            funCreerTeam() {
                this.$root.$emit('funCreerTeam')
                this.cache = false
            },
        }
    }
</script>

<style scoped>

    a {
        text-decoration: none;
        color: black;
    }

    a:hover {
        text-decoration: none;
        color: black;
    }
    #navbar{
        background-color: #D9A679;
    }

</style>