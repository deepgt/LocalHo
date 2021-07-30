'use strict';
const { Sequelize, DataTypes } = require('sequelize');
// const sequelize = new Sequelize('sqlite::memory:');

const sequelize = require("../database/connection");

const Department = sequelize.define('Department', {
    department_id:{
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true
    },
    name: {
      type:DataTypes.STRING(100),
      allowNull: false,
    },
    description: DataTypes.STRING(1000)
  }, {
    timestamps: false,
    tableName: 'department'
  });
  
  module.exports= Department;

