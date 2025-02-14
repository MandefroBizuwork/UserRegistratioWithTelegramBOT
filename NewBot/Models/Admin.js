const { DataTypes } = require('sequelize');
const { sequelize } = require('../database');

const Admin = sequelize.define('Admin', {
  telegramId: {
    type: DataTypes.STRING,
    primaryKey: true,
  },
  username: {
    type: DataTypes.STRING,
  },
  fullName: {
    type: DataTypes.STRING,
  },
  role: {
    type: DataTypes.STRING,
    defaultValue: 'admin', // You can change this to 'super_admin' if needed
  },
});

module.exports = Admin;