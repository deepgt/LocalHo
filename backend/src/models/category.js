'use strict';

const { Sequelize, DataTypes } = require('sequelize');
// const sequelize = new Sequelize('sqlite::memory:');

const sequelize = require("../database/connection");
const Product = require("../models/product");


const Category = sequelize.define('Category', {
    category_id:{
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true,
    },
    department_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
      },
    name: {
      type:DataTypes.STRING(100),
      allowNull: false,
    },
    description: DataTypes.STRING(1000),
  }, {
    timestamps: false,
    tableName: 'category'
  });

  // Category.belongsToMany(Product, {
  //   foreignKey: 'category_id',
  //   through: 'product_category',
  // });
    // associations can be defined here
    // Category.belongsTo(models.Department, {
    //     foreignKey: 'department_id',
    //     sourceKey: 'department_id',
    //     as: 'department'
    //   })

  module.exports = Category;
