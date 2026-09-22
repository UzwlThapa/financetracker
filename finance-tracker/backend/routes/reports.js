const express = require('express');
const router = express.Router();
const { Op, fn, col, literal } = require('sequelize');
const { RestroUsersPaymentLogs, RestroUsersInfo } = require('../models');
const authMiddleware = require('../middleware/auth');

// Apply authentication to all routes
router.use(authMiddleware);

/**
 * GET /api/reports/dashboard-kpis
 * Get dashboard KPIs
 */
router.get('/dashboard-kpis', async (req, res) => {
  try {
    const today = new Date();
    const currentMonthStart = new Date(today.getFullYear(), today.getMonth(), 1);
    const sevenDaysFromNow = new Date(today);
    sevenDaysFromNow.setDate(today.getDate() + 7);

    // Total revenue this month
    const monthlyRevenueResult = await RestroUsersPaymentLogs.findOne({
      attributes: [
        [fn('SUM', col('AmountRecived')), 'totalRevenue'],
      ],
      where: {
        PaymentDate: { [Op.gte]: currentMonthStart },
        IsPaymentSuccessfull: true,
      },
      raw: true,
    });

    // Count of expiring clients (within 7 days)
    const expiringClientsCount = await RestroUsersInfo.count({
      where: {
        ValidTill: {
          [Op.lte]: sevenDaysFromNow,
          [Op.gte]: today,
        },
        IsActive: true,
      },
    });

    // Count of expired clients
    const expiredClientsCount = await RestroUsersInfo.count({
      where: {
        ValidTill: { [Op.lt]: today },
        IsActive: true,
      },
    });

    // Total payments count this month
    const paymentsCountThisMonth = await RestroUsersPaymentLogs.count({
      where: {
        PaymentDate: { [Op.gte]: currentMonthStart },
      },
    });

    res.json({
      success: true,
      data: {
        monthlyRevenue: parseFloat(monthlyRevenueResult?.totalRevenue || 0),
        expiringClients: expiringClientsCount,
        expiredClients: expiredClientsCount,
        paymentsThisMonth: paymentsCountThisMonth,
      },
    });
  } catch (error) {
    console.error('Error fetching dashboard KPIs:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch dashboard KPIs.',
      error: error.message,
    });
  }
});

/**
 * GET /api/reports/revenue
 * Revenue report with date range
 */
router.get('/revenue', async (req, res) => {
  try {
    const { from, to, groupBy = 'month' } = req.query;

    if (!from || !to) {
      return res.status(400).json({
        success: false,
        message: 'From and To dates are required.',
      });
    }

    const fromDate = new Date(from);
    const toDate = new Date(to);

    let dateFormat;
    if (groupBy === 'day') {
      dateFormat = 'YYYY-MM-DD';
    } else if (groupBy === 'month') {
      dateFormat = 'YYYY-MM';
    } else {
      dateFormat = 'YYYY';
    }

    const revenue = await RestroUsersPaymentLogs.findAll({
      attributes: [
        [literal(`FORMAT(PaymentDate, '${dateFormat}')`), 'period'],
        [fn('SUM', col('AmountRecived')), 'total'],
        [fn('COUNT', col('Id')), 'count'],
      ],
      where: {
        PaymentDate: {
          [Op.gte]: fromDate,
          [Op.lte]: toDate,
        },
        IsPaymentSuccessfull: true,
      },
      group: [literal(`FORMAT(PaymentDate, '${dateFormat}')`)],
      order: [[literal(`FORMAT(PaymentDate, '${dateFormat}')`), 'ASC']],
      raw: true,
    });

    res.json({
      success: true,
      data: revenue,
    });
  } catch (error) {
    console.error('Error fetching revenue report:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch revenue report.',
      error: error.message,
    });
  }
});

/**
 * GET /api/reports/expiring
 * List clients with expiring subscriptions
 */
router.get('/expiring', async (req, res) => {
  try {
    const { days = 30 } = req.query;
    const daysNum = parseInt(days, 10);
    const today = new Date();
    const thresholdDate = new Date(today);
    thresholdDate.setDate(today.getDate() + daysNum);

    const expiringClients = await RestroUsersInfo.findAll({
      where: {
        ValidTill: {
          [Op.lte]: thresholdDate,
          [Op.gte]: today,
        },
        IsActive: true,
      },
      order: [['ValidTill', 'ASC']],
      raw: true,
    });

    // Add days remaining calculation
    const clientsWithDays = expiringClients.map(client => ({
      ...client,
      DaysRemaining: Math.ceil((new Date(client.ValidTill) - today) / (1000 * 60 * 60 * 24)),
    }));

    res.json({
      success: true,
      data: clientsWithDays,
    });
  } catch (error) {
    console.error('Error fetching expiring clients:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch expiring clients.',
      error: error.message,
    });
  }
});

module.exports = router;
