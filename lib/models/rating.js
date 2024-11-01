const mongose = require('mongoose');

const ratingSchema = mongose.Schema({
    userId:{
        type:String,
        required: true,
    },
    rating:{
        type: Number,
        required: true,
    }
});

module.exports = ratingSchema;