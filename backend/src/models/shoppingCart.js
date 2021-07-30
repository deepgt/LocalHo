'use strict';

const { Sequelize, DataTypes } = require('sequelize');
// const sequelize = new Sequelize('sqlite::memory:');
const Product = require("../models/product");
const sequelize = require("../database/connection");

const ShoppingCart = sequelize.define('ShoppingCart', {
    item_id:{
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true
    },
    cart_id:{
        type: DataTypes.STRING(32),
        allowNull: false,
      },
    product_id:{
        type: DataTypes.INTEGER,
        allowNull: false,
      },
    attributes:{
        type: DataTypes.STRING(1000),
        allowNull: false,
      },
    quantity:{
        type: DataTypes.INTEGER,
        allowNull: false,
      },
    buy_now:{
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue:true
      },
    added_on:{
        type: DataTypes.DATE,
        allowNull: false
      },
  }, {
    timestamps: false,
    tableName: 'shopping_cart'
  });
  
    // associations can be defined here
    ShoppingCart.belongsTo(Product, {
      foreignKey: 'product_id',
      targetKey: 'product_id',
      onDelete: 'CASCADE'
    });

module.exports = ShoppingCart;
