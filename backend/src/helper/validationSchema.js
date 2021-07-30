const Joi = require('joi');

const loginSchema = Joi.object().keys({
  email: Joi.string().min(5).max(100).required()
    .email(),
  password: Joi.string().min(5).max(50).required()
});

const customerSchema = Joi.object().keys({
  email: Joi.string().min(5).max(100).email(),
  password: Joi.string().min(5).max(50),
  name: Joi.string().min(1).max(50),
  day_phone: Joi.string(),
  eve_phone: Joi.string(),
  mob_phone: Joi.string()
});

const registerSchema = Joi.object().keys({
  email: Joi.string().min(5).max(100).required().email(),
  password: Joi.string().min(5).max(50).required(),
  name: Joi.string().min(1).max(50).required(),
  address_1: Joi.string().min(1).max(50).required(),
});

const shoppingCartSchema = Joi.object().keys({
  cart_id: Joi.required(),
  product_id: Joi.number().required(),
  attributes: Joi.required()
});

const orderSchema = Joi.object().keys({
  cart_id: Joi.required(),
  shipping_id: Joi.number().required(),
  tax_id: Joi.number().required(),
  status: Joi.number(),
  reference: Joi.string(),
  auth_code: Joi.string(),
  comments: Joi.string(),
  shipped_on: Joi.date()
});

module.exports = {
  loginSchema,
  registerSchema,
  customerSchema,
  shoppingCartSchema,
  orderSchema
};
