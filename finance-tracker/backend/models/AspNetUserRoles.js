const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db-connection');

/**
 * AspNetUserRoles - User-Role mapping
 */
const AspNetUserRoles = sequelize.define('AspNetUserRoles', {
  UserId: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    allowNull: false,
    references: {
      model: 'AspNetUsers',
      key: 'Id',
    },
    field: 'UserId',
  },
  RoleId: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    allowNull: false,
    references: {
      model: 'AspNetRoles',
      key: 'Id',
    },
    field: 'RoleId',
  },
}, {
  tableName: 'AspNetUserRoles',
  schema: 'dbo',
  timestamps: false,
  freezeTableName: true,
});

module.exports = AspNetUserRoles;
