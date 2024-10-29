const express = require('express');
const productRouter = express.Router();
const Product = require('../models/product');
const auth = require('../middleware/auth');

productRouter.get('/api/get-products',auth,async(req , res) => {
    try{
        const products = await Product.find({category: req.query.category})
        res.json(products)
    }catch(e){
        return res.status(500).json({error: e.message})
    }
});

productRouter.get('/api/products/search/:name',auth,async(req , res) => {
    try{
        const product = await Product.find({
            name: {$regex: req.params.name, $options: "i" }
        })
        res.json(product)

    }catch(e){
        return res.status(500).json({error : e.message})
    }
})

module.exports = productRouter;