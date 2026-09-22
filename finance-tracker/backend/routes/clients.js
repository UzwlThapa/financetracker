const express = require('express');
const router = express.Router();
const { Op } = require('sequelize');
const { RestroUsersInfo, RestroUsersPaymentLogs } = require('../models');
const authMiddleware = require('../middleware/auth');
const { rbacMiddleware, hasRole } = require('../middleware/rbac');

// Apply authentication to all routes
router.use(authMiddleware);

/**
 * GET /api/clients
 * List all clients with optional filters
 */
router.get('/', async (req, res) => {
  try {
    const { 
      search, 
      status, 
      expiryDays, 
      page = 1, 
      limit = 20,
      sortBy = 'TenantName',
      order = 'ASC'
    } = req.query;

    const offset = (page - 1) * limit;
    const where = {};

    // Search filter
    if (search) {
      where[Op.or] = [
        { TenantName: { [Op.like]: `%${search}%` } },
        { TenantCode: { [Op.like]: `%${search}%` } },
        { Phone: { [Op.like]: `%${search}%` } },
      ];
    }

    // Status filter
    if (status !== undefined) {
      where.IsActive = status === 'true';
    }

    // Calculate expiry date threshold
    let expiryThreshold = null;
    if (expiryDays) {
      const days = parseInt(expiryDays, 10);
      expiryThreshold = new Date();
      expiryThreshold.setDate(expiryThreshold.getDate() + days);
      where.ValidTill = { [Op.lte]: expiryThreshold };
    }

    const { count, rows } = await RestroUsersInfo.findAndCountAll({
      where,
      include: [{
        model: RestroUsersPaymentLogs,
        as: 'payments',
        attributes: ['Id', 'AmountRecived', 'PaymentDate', 'PaymentType'],
        required: false,
      }],
      limit: parseInt(limit, 10),
      offset: parseInt(offset, 10),
      order: [[sortBy, order]],
    });

    // Calculate days remaining for each client
    const clientsWithDaysRemaining = rows.map(client => {
      const validTill = new Date(client.ValidTill);
      const today = new Date();
      const daysRemaining = Math.ceil((validTill - today) / (1000 * 60 * 60 * 24));
      
      return {
        ...client.toJSON(),
        DaysRemaining: daysRemaining,
        IsExpired: daysRemaining < 0,
        IsExpiringSoon: daysRemaining >= 0 && daysRemaining <= 7,
      };
    });

    res.json({
      success: true,
      data: {
        clients: clientsWithDaysRemaining,
        pagination: {
          total: count,
          page: parseInt(page, 10),
          limit: parseInt(limit, 10),
          totalPages: Math.ceil(count / limit),
        },
      },
    });
  } catch (error) {
    console.error('Error fetching clients:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch clients.',
      error: error.message,
    });
  }
});

/**
 * GET /api/clients/:apiKey
 * Get single client details
 */
router.get('/:apiKey', async (req, res) => {
  try {
    const { apiKey } = req.params;

    const client = await RestroUsersInfo.findOne({
      where: { ApiKey: apiKey },
      include: [{
        model: RestroUsersPaymentLogs,
        as: 'payments',
        order: [['PaymentDate', 'DESC']],
      }],
    });

    if (!client) {
      return res.status(404).json({
        success: false,
        message: 'Client not found.',
      });
    }

    const validTill = new Date(client.ValidTill);
    const today = new Date();
    const daysRemaining = Math.ceil((validTill - today) / (1000 * 60 * 60 * 24));

    res.json({
      success: true,
      data: {
        ...client.toJSON(),
        DaysRemaining: daysRemaining,
        IsExpired: daysRemaining < 0,
        IsExpiringSoon: daysRemaining >= 0 && daysRemaining <= 7,
      },
    });
  } catch (error) {
    console.error('Error fetching client:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch client details.',
      error: error.message,
    });
  }
});

module.exports = router;
