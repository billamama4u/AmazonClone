const mongoose = require('mongoose')
const {productSchema}= require('./product')


const userSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true,
    },
    email:{
        type: String,
        required: true,
        trim: true,
        validate:{
            validator: (value) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message:'Enter a valid E-mail address'
        },
    },
    password:{
        type: String,
        required: true,
        validate:{
            validator: (value) => {
                return value.length>=6
            },
            message:'Enter atleast 6 digit password'
    },
       
    },
    address:{
        type: String,
        default: '',            
    },
    type:{
        type: String,
        default:'user',
    },
    
    cart:[
        {
            product: productSchema,
            quantity:{
                type: Number,
                require: true,
            }
        }
    ]


});

const User = mongoose.model("User", userSchema);
module.exports= User