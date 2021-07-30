require("dotenv/config");

const {Sequelize} = require("sequelize");

const sequelize = new Sequelize("localho", "root",'', {host:"localhost", dialect:"mysql"});

module.exports = sequelize;
global.sequelize = sequelize;
