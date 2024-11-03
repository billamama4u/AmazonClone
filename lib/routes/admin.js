const express = require('express');
const adminRouter = express.Router();
const admin = require('../middleware/admin')
const {Product} = require('../models/product')
const Order = require('../models/order')


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
});

adminRouter.get('/admin/get-orders',admin,async(req , res)=>{
  try{
    const orders = await Order.find({})
    res.json(orders)

  }catch(e){
    return res.status(500).json({ error: e.message });
  }

});

adminRouter.post('/admin/update-order-status',admin,async(req,res) => {
  try{
    const {id } = req.body
    let order = await Order.findById(id)
    order.status += 1
    order = await order.save()
    res.json(order)

  }catch(e){
    return res.status(500).json({eroor: e.message})
  }
});

adminRouter.get('/admin/analytics',admin,async(req , res)=>{
  try{
    const orders = await Order.find({})
    let totalEarnings = 0
    for(let i=0 ; i<orders.length ; i++){
      for(let j=0 ; j<orders[i].products.length; j++){
        totalEarnings += orders[i].products[j].quantity * orders[i].products[j].product.price
      }
    }
    let mobileEarnings =await getCategorywiseProducts('Mobiles')
    let appliancesEarnings =await getCategorywiseProducts('Appliances')
    let essentialsEarnings =await getCategorywiseProducts('Essentials')
    let fashionEarnings =await getCategorywiseProducts('Fashion')
    let booksEarnings =await getCategorywiseProducts('Books')

    let earnings ={
      totalEarnings,
      mobileEarnings,
      appliancesEarnings,
      fashionEarnings,
      booksEarnings,
      essentialsEarnings
    }
    res.json(earnings)

  }catch(e){
    return res.status(500).json({ error: e.message });
  }

});

 
async function getCategorywiseProducts(category)  {
  let categoryOrders = await Order.find({
    'products.product.category' : category,
  })
  let earnings = 0
    for(let i=0 ; i<categoryOrders.length ; i++){
      for(let j=0 ; j<categoryOrders[i].products.length; j++){
        earnings += categoryOrders[i].products[j].quantity * categoryOrders[i].products[j].product.price
      }
    }
  return earnings
}
  module.exports = adminRouter;

     
