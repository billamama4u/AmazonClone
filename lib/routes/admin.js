const express = require('express');
const adminRouter = express.Router();
const admin = require('../middleware/admin')
const Product = require('../models/product')

adminRouter.post('/admin/addproduct', admin,async (req, res) => {
    try {
      const { name, description,price,quantity,category,images} = req.body
      let product = new Product({
        name,
        description,
        images,
        quantity,
        price,
        category,
      })
      product = await product.save()
      res.json(product)
    } catch (e) {
      return res.status(500).json({ error: e.message });
    }
    
  });

adminRouter.get('/admin/getproducts',admin,async(req , res)=>{
  try{
    const products = await Product.find({})
    res.json(products)

  }catch(e){
    return res.status(500).json({ error: e.message });
  }

});

adminRouter.post('/admin/deleteproduct',admin,async(req , res)=>{
  try{
    const {id} =req.body
    let product = await Product.findByIdAndDelete(id);
    res.json(product)

  }catch(e){
    return response.status(500).json({error: e.message});  
  }
})


  module.exports = adminRouter;

     