const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db-connection');

/**
 * AspNetUsers - System users for authentication
 * Maps to existing ASP.NET Identity table
 */
const AspNetUsers = sequelize.define('AspNetUsers', {
  Id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
    allowNull: false,
    field: 'Id',
  },
  ApiKey: {
    type: DataTypes.STRING,
    allowNull: false,
    field: 'ApiKey',
  },
  RegDate: {
    type: DataTypes.DATE,
    allowNull: false,
    field: 'RegDate',
  },
  Status: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: true,
    field: 'Status',
  },
  UserName: {
    type: DataTypes.STRING(256),
    allowNull: true,
    field: 'UserName',
  },
  NormalizedUserName: {
    type: DataTypes.STRING(256),
    allowNull: true,
    field: 'NormalizedUserName',
  },
  Email: {
    type: DataTypes.STRING(256),
    allowNull: true,
    field: 'Email',
  },
  NormalizedEmail: {
    type: DataTypes.STRING(256),
    allowNull: true,
    field: 'NormalizedEmail',
  },
  EmailConfirmed: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
    field: 'EmailConfirmed',
  },
  PasswordHash: {
    type: DataTypes.STRING,
    allowNull: true,
    field: 'PasswordHash',
  },
  SecurityStamp: {
    type: DataTypes.STRING,
    allowNull: true,
    field: 'SecurityStamp',
  },
  ConcurrencyStamp: {
    type: DataTypes.STRING,
    allowNull: true,
    field: 'ConcurrencyStamp',
  },
  PhoneNumber: {
    type: DataTypes.STRING,
    allowNull: true,
    field: 'PhoneNumber',
  },
  PhoneNumberConfirmed: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
    field: 'PhoneNumberConfirmed',
  },
  TwoFactorEnabled: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
    field: 'TwoFactorEnabled',
  },
  LockoutEnd: {
    type: DataTypes.DATE,
    allowNull: true,
    field: 'LockoutEnd',
  },
  LockoutEnabled: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
    field: 'LockoutEnabled',
  },
  AccessFailedCount: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 0,
    field: 'AccessFailedCount',
  },
}, {
  tableName: 'AspNetUsers',
  schema: 'dbo',
  timestamps: false,
  freezeTableName: true,
});

module.exports = AspNetUsers;
