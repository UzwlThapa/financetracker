const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db-connection');

/**
 * AspNetRoles - User roles for RBAC
 */
const AspNetRoles = sequelize.define('AspNetRoles', {
  Id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
    allowNull: false,
    field: 'Id',
  },
  Name: {
    type: DataTypes.STRING(256),
    allowNull: true,
    field: 'Name',
  },
  NormalizedName: {
    type: DataTypes.STRING(256),
    allowNull: true,
    field: 'NormalizedName',
  },
  ConcurrencyStamp: {
    type: DataTypes.STRING,
    allowNull: true,
    field: 'ConcurrencyStamp',
  },
}, {
  tableName: 'AspNetRoles',
  schema: 'dbo',
  timestamps: false,
  freezeTableName: true,
});

module.exports = AspNetRoles;
