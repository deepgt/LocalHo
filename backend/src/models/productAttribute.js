'use strict';


const { Sequelize, DataTypes } = require('sequelize');
// const sequelize = new Sequelize('sqlite::memory:');

const sequelize = require("../database/connection");

const ProductAttribute= sequelize.define('ProductAttribute', {
    product_id:{
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
    },
    attribute_value_id:{
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true,
      },
  }, {
    timestamps: false,
    tableName: 'product_attribute'
  });
  
  module.exports = ProductAttribute;

