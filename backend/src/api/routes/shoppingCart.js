const express = require('express');
const ShoppingCartController =require('../controllers/shoppingCartController');

const shoppingCart = express.Router();

shoppingCart.get('/generateUniqueId', ShoppingCartController.generateUniqueId);
shoppingCart.post('/add', ShoppingCartController.addProductToCart);
shoppingCart.get('/:cart_id', ShoppingCartController.getProductsInCart);
shoppingCart.delete('/empty/:cart_id', ShoppingCartController.emptyCart);
shoppingCart.delete('/removeProduct/:item_id', ShoppingCartController.removeProduct);


module.exports = shoppingCart;
