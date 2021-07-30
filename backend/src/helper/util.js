const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const Joi = require('joi');
require('dotenv/config');
const schema = require('./validationSchema');

const saltRounds = 10;

const helpers = {
  async hashPassword(password) {
    const hash = await bcrypt.hash(password, saltRounds);
    return hash;
  },

  async comparePasswords(password, userPassword) {
    const match = await bcrypt.compare(password, userPassword);
    return match;
  },

  createToken(user) {
    const { customer_id: customerId, name, email } = user;
    return jwt.sign({ customer_id: customerId, name, email }, process.env.SECRET, { expiresIn: 86400 });
  },

  validateRegisterDetails(user) {
    const result = schema.registerSchema.validate(user);
    return result;
  },

  validateLoginDetails(user) {
    return schema.loginSchema.validate(user);
  },

  validateCartDetails(user) {
    return schema.shoppingCartSchema.validate(user);
  },

  validateOrderDetails(user) {
    return schema.orderSchema.validate(user);
  },

  errorResponse(res, status, code, message, field) {
    return res.status(status).json({
      error: {
        status,
        code,
        message,
        field: field || ''
      }
    });
  },

  truncateDescription(products, descriptionLength) {
    const allProducts = products.map((product) => {
      const { length } = product.dataValues.description;
      if (length > descriptionLength) {
        product.dataValues.description = `${product.dataValues.description.slice(0, descriptionLength)}...`;
      }
      return product;
    });
    return allProducts;
  }
  
};

module.exports = helpers;