'use strict';

const { Sequelize, DataTypes } = require('sequelize');
// const sequelize = new Sequelize('sqlite::memory:');

const sequelize = require("../database/connection");
const Attribute = require('../models/attribute');


const AttributeValue= sequelize.define('AttributeValue', {
    attribute_value_id:{
      type: DataTypes.INTEGER,
      allowNull: false,
      autoIncrement: true,
      primaryKey: true,
    },
    attribute_id:{
        type: DataTypes.INTEGER,
        allowNull: false
      },
      value: {
        type:DataTypes.STRING(100),
        allowNull: false,
      },
  }, {
    timestamps: false,
    tableName: 'attribute_value'
  });

    // associations can be defined here
    AttributeValue.belongsTo(Attribute, {
        foreignKey: 'attribute_id',
        sourceKey: 'attribute_id',
        as: 'attribute'
      })


  module.exports = AttributeValue;
