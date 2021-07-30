const express = require('express');
const orderController = require('../controllers/orderController');
const authenticate = require('../../middleware/authenticate') ;

const orderRouter = express.Router();

orderRouter.post('/', authenticate, orderController.createOrder);
orderRouter.get('/:orderId', orderController.getOrderInfo);

module.exports = orderRouter;
