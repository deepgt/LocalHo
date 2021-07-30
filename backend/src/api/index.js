const customerRouter = require('./routes/customer');
const express = require('express');
const productRouter = require('./routes/products');
const shoppingCart = require('./routes/shoppingCart');
const orderRouter = require('./routes/order');
const router = express.Router();

// router.use('/customers', customerRouter);
router.use('/customer', customerRouter);
router.use('/products', productRouter);
router.use('/shoppingcart', shoppingCart);
router.use('/order', orderRouter);

module.exports = router;