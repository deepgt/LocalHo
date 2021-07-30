const express = require('express');
const customerController = require('../controllers/customerController');
const authenticate = require('../../middleware/authenticate');

const customerRouter = express.Router();

customerRouter.post('/register', customerController.register);
customerRouter.post('/login', customerController.login);
customerRouter.get('/', authenticate, customerController.getCustomer);

module.exports = customerRouter;
