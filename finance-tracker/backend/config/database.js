require('dotenv').config();

module.exports = {
  development: {
    username: process.env.DB_USER || 'waitermodule_admin',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'WaiterModuleMultiTenants',
    host: process.env.DB_HOST || 'localhost',
    port: process.env.DB_PORT || 1433,
    dialect: 'mssql',
    dialectOptions: {
      options: {
        encrypt: process.env.DB_ENCRYPT === 'true',
        trustServerCertificate: process.env.DB_TRUST_CERT === 'true' || true,
      },
    },
    pool: {
      max: 20,
      min: 5,
      acquire: 30000,
      idle: 10000,
    },
    logging: process.env.NODE_ENV === 'development' ? console.log : false,
  },
  production: {
    username: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    host: process.env.DB_HOST,
    port: process.env.DB_PORT || 1433,
    dialect: 'mssql',
    dialectOptions: {
      options: {
        encrypt: process.env.DB_ENCRYPT === 'true' || true,
        trustServerCertificate: process.env.DB_TRUST_CERT === 'true' || false,
      },
    },
    pool: {
      max: 50,
      min: 10,
      acquire: 60000,
      idle: 10000,
    },
    logging: false,
  },
};
