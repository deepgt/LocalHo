
const productController = require('../controllers/productController');
const express = require('express');
// const authenticate = require('../../middleware/authenticate');

const productRouter = express.Router();

productRouter.get('/', productController.getAllProducts);
productRouter.get('/incategory', productController.getProductsInCategory);
// productRouter.get('/category', productController.getAllCategory);
productRouter.get('/inDepartment', productController.getProductsInDepartment);
productRouter.get('/incategory/:categoryId', productController.getProductsInCategory);
productRouter.get('/inDepartment/:departmentId', productController.getProductsInDepartment);
productRouter.get('/search', productController.searchProducts);
productRouter.get('/:product_id', productController.getSingleProduct);


module.exports = productRouter;
