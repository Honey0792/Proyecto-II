import axios from "axios";

export default()=>{
    const  token = `bearer ${sessionStorage.getItem('token')}`
    return axios.create({
        baseURL: `http://${window.location.hostname}:3000`,
        headers: {
            'authorization' : token, 
            'Accept': 'application/json',
            "Content-Type": 'application/json',
        }
    })
}