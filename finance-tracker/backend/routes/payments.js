const express = require('express');
const router = express.Router();
const { Op } = require('sequelize');
const { RestroUsersPaymentLogs, RestroUsersInfo } = require('../models');
const authMiddleware = require('../middleware/auth');
const { rbacMiddleware, hasRole } = require('../middleware/rbac');

// Apply authentication to all routes
router.use(authMiddleware);

/**
 * GET /api/payments
 * List payments with filters
 */
router.get('/', async (req, res) => {
  try {
    const { 
      apiKey,
      fromDate,
      toDate,
      paymentType,
      page = 1, 
      limit = 50,
    } = req.query;

    const offset = (page - 1) * limit;
    const where = {};

    if (apiKey) {
      where.ApiKey = apiKey;
    }

    if (fromDate || toDate) {
      where.PaymentDate = {};
      if (fromDate) where.PaymentDate[Op.gte] = new Date(fromDate);
      if (toDate) where.PaymentDate[Op.lte] = new Date(toDate);
    }

    if (paymentType) {
      where.PaymentType = parseInt(paymentType, 10);
    }

    const { count, rows } = await RestroUsersPaymentLogs.findAndCountAll({
      where,
      include: [{
        model: RestroUsersInfo,
        as: 'client',
        attributes: ['ApiKey', 'TenantName', 'TenantCode'],
      }],
      limit: parseInt(limit, 10),
      offset: parseInt(offset, 10),
      order: [['PaymentDate', 'DESC']],
    });

    res.json({
      success: true,
      data: {
        payments: rows,
        pagination: {
          total: count,
          page: parseInt(page, 10),
          limit: parseInt(limit, 10),
          totalPages: Math.ceil(count / limit),
        },
      },
    });
  } catch (error) {
    console.error('Error fetching payments:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch payments.',
      error: error.message,
    });
  }
});

/**
 * POST /api/payments
 * Record a new payment
 * Requires: FinanceManager or SuperAdmin role
 */
router.post('/', async (req, res) => {
  try {
    // Check if user has permission
    if (!hasRole(req.user, 'SuperAdmin') && !hasRole(req.user, 'FinanceManager')) {
      return res.status(403).json({
        success: false,
        message: 'You do not have permission to record payments.',
      });
    }

    const { 
      ApiKey, 
      AmountRecived, 
      PaymentType, 
      PaymentDate, 
      ChequeBankName,
      IsPaymentSuccessfull = true,
    } = req.body;

    // Validate required fields
    if (!ApiKey || !AmountRecived || !PaymentType || !PaymentDate) {
      return res.status(400).json({
        success: false,
        message: 'ApiKey, AmountRecived, PaymentType, and PaymentDate are required.',
      });
    }

    // Verify client exists
    const client = await RestroUsersInfo.findOne({ where: { ApiKey } });
    if (!client) {
      return res.status(404).json({
        success: false,
        message: 'Client not found.',
      });
    }

    // Create payment record
    const payment = await RestroUsersPaymentLogs.create({
      ApiKey,
      TenantCode: client.TenantCode,
      AmountRecived,
      PaymentType,
      ChequeBankName: ChequeBankName || null,
      IsPaymentSuccessfull,
      PaymentDate,
      CreatedBy: req.user.username,
    });

    res.status(201).json({
      success: true,
      message: 'Payment recorded successfully.',
      data: payment,
    });
  } catch (error) {
    console.error('Error recording payment:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to record payment.',
      error: error.message,
    });
  }
});

/**
 * GET /api/payments/:id
 * Get single payment details
 */
router.get('/:id', async (req, res) => {
  try {
    const payment = await RestroUsersPaymentLogs.findOne({
      where: { Id: req.params.id },
      include: [{
        model: RestroUsersInfo,
        as: 'client',
        attributes: ['ApiKey', 'TenantName', 'TenantCode', 'Phone', 'EmailAddress'],
      }],
    });

    if (!payment) {
      return res.status(404).json({
        success: false,
        message: 'Payment not found.',
      });
    }

    res.json({
      success: true,
      data: payment,
    });
  } catch (error) {
    console.error('Error fetching payment:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch payment.',
      error: error.message,
    });
  }
});

module.exports = router;
