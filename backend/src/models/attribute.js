'use strict';

const { Sequelize, DataTypes } = require('sequelize');
// const sequelize = new Sequelize('sqlite::memory:');

const sequelize = require("../database/connection");



const Attribute= sequelize.define('Attribute', {
    attribute_id:{
      type: DataTypes.INTEGER,
      allowNull: false,
      autoIncrement: true,
      primaryKey: true,
    },
    name: {
        type:DataTypes.STRING(100),
        allowNull: false,
      },
  }, {
    timestamps: false,
    tableName: 'attribute'
  });

    // associations can be defined here



  module.exports = Attribute;
