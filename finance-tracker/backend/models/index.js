const RestroUsersInfo = require('./RestroUsersInfo');
const RestroUsersPaymentLogs = require('./RestroUsersPaymentLogs');
const AspNetUsers = require('./AspNetUsers');
const AspNetRoles = require('./AspNetRoles');
const AspNetUserRoles = require('./AspNetUserRoles');

// Define associations
RestroUsersInfo.hasMany(RestroUsersPaymentLogs, {
  foreignKey: 'ApiKey',
  sourceKey: 'ApiKey',
  as: 'payments',
});

RestroUsersPaymentLogs.belongsTo(RestroUsersInfo, {
  foreignKey: 'ApiKey',
  targetKey: 'ApiKey',
  as: 'client',
});

AspNetUsers.belongsToMany(AspNetRoles, {
  through: AspNetUserRoles,
  foreignKey: 'UserId',
  otherKey: 'RoleId',
  as: 'roles',
});

AspNetRoles.belongsToMany(AspNetUsers, {
  through: AspNetUserRoles,
  foreignKey: 'RoleId',
  otherKey: 'UserId',
  as: 'users',
});

module.exports = {
  RestroUsersInfo,
  RestroUsersPaymentLogs,
  AspNetUsers,
  AspNetRoles,
  AspNetUserRoles,
};
