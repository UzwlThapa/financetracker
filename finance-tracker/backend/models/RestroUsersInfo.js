const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db-connection');

/**
 * RestroUsersInfo - Client master information
 * Maps to existing table in WaiterModuleMultiTenants database
 */
const RestroUsersInfo = sequelize.define('RestroUsersInfo', {
  ApiKey: {
    type: DataTypes.UUID,
    primaryKey: true,
    allowNull: false,
    field: 'ApiKey',
  },
  TenantName: {
    type: DataTypes.STRING,
    allowNull: false,
    field: 'TenantName',
  },
  TenantCode: {
    type: DataTypes.STRING,
    allowNull: false,
    field: 'TenantCode',
  },
  Address: {
    type: DataTypes.STRING,
    allowNull: false,
    field: 'Address',
  },
  Country: {
    type: DataTypes.STRING,
    allowNull: true,
    field: 'Country',
  },
  Phone: {
    type: DataTypes.STRING,
    allowNull: false,
    field: 'Phone',
  },
  RegsiteredDate: {
    type: DataTypes.DATE,
    allowNull: false,
    field: 'RegsiteredDate',
  },
  ValidTill: {
    type: DataTypes.DATE,
    allowNull: false,
    field: 'ValidTill',
  },
  AMCStartDate: {
    type: DataTypes.DATE,
    allowNull: true,
    field: 'AMCStartDate',
  },
  AMCEndDate: {
    type: DataTypes.DATE,
    allowNull: true,
    field: 'AMCEndDate',
  },
  IsDemoVersion: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
    field: 'IsDemoVersion',
  },
  IsCloudVersion: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
    field: 'IsCloudVersion',
  },
  PanVatNumber: {
    type: DataTypes.STRING,
    allowNull: true,
    field: 'PanVatNumber',
  },
  IsIRDVeriied: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
    field: 'IsIRDVeriied',
  },
  CBMSUsername: {
    type: DataTypes.STRING,
    allowNull: true,
    field: 'CBMSUsername',
  },
  CBMSPassword: {
    type: DataTypes.STRING,
    allowNull: true,
    field: 'CBMSPassword',
  },
  AbbreviatedValue: {
    type: DataTypes.STRING,
    allowNull: true,
    field: 'AbbreviatedValue',
  },
  IsAbbreviated: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
    field: 'IsAbbreviated',
  },
  IsActive: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: true,
    field: 'IsActive',
  },
  GracePeriodDays: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 0,
    field: 'GracePeriodDays',
  },
  EmailAddress: {
    type: DataTypes.STRING,
    allowNull: true,
    field: 'EmailAddress',
  },
  Version: {
    type: DataTypes.STRING,
    allowNull: true,
    field: 'Version',
  },
  VatName: {
    type: DataTypes.STRING,
    allowNull: true,
    field: 'VatName',
  },
}, {
  tableName: 'RestroUsersInfo',
  schema: 'dbo',
  timestamps: false,
  freezeTableName: true,
});

module.exports = RestroUsersInfo;
