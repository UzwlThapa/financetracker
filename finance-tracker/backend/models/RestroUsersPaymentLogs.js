const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db-connection');

/**
 * RestroUsersPaymentLogs - Payment transaction records
 * Maps to existing table in WaiterModuleMultiTenants database
 */
const RestroUsersPaymentLogs = sequelize.define('RestroUsersPaymentLogs', {
  Id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
    allowNull: false,
    field: 'Id',
  },
  ApiKey: {
    type: DataTypes.UUID,
    allowNull: false,
    references: {
      model: 'RestroUsersInfo',
      key: 'ApiKey',
    },
    field: 'ApiKey',
  },
  TenantCode: {
    type: DataTypes.STRING,
    allowNull: false,
    field: 'TenantCode',
  },
  AmountRecived: {
    type: DataTypes.DECIMAL(18, 2),
    allowNull: false,
    field: 'AmountRecived',
  },
  PaymentType: {
    type: DataTypes.INTEGER,
    allowNull: false,
    field: 'PaymentType',
    comment: '1=Cash, 2=Cheque, 3=Bank Transfer, 4=Online',
  },
  ChequeBankName: {
    type: DataTypes.STRING,
    allowNull: true,
    field: 'ChequeBankName',
  },
  IsPaymentSuccessfull: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
    field: 'IsPaymentSuccessfull',
  },
  PaymentDate: {
    type: DataTypes.DATE,
    allowNull: false,
    field: 'PaymentDate',
  },
  CreatedBy: {
    type: DataTypes.STRING,
    allowNull: false,
    field: 'CreatedBy',
  },
  DateUpdateLogId: {
    type: DataTypes.INTEGER,
    allowNull: true,
    references: {
      model: 'RestroUsersDateUpdateLogs',
      key: 'Id',
    },
    field: 'DateUpdateLogId',
  },
}, {
  tableName: 'RestroUsersPaymentLogs',
  schema: 'dbo',
  timestamps: false,
  freezeTableName: true,
});

module.exports = RestroUsersPaymentLogs;
