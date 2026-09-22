const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { AspNetUsers, AspNetRoles, AspNetUserRoles } = require('../models');

/**
 * POST /api/auth/login
 * Authenticate user and return JWT token
 */
router.post('/login', async (req, res) => {
  try {
    const { username, password } = req.body;

    if (!username || !password) {
      return res.status(400).json({
        success: false,
        message: 'Username and password are required.',
      });
    }

    // Find user by username
    const user = await AspNetUsers.findOne({
      where: { UserName: username },
      include: [{
        model: AspNetRoles,
        as: 'roles',
        through: { attributes: [] },
      }],
    });

    if (!user || !user.Status) {
      return res.status(401).json({
        success: false,
        message: 'Invalid credentials or account inactive.',
      });
    }

    // Verify password (ASP.NET Identity uses hashed passwords)
    const isValidPassword = await bcrypt.compare(password, user.PasswordHash);

    if (!isValidPassword) {
      return res.status(401).json({
        success: false,
        message: 'Invalid credentials.',
      });
    }

    // Generate JWT token
    const token = jwt.sign(
      { userId: user.Id, username: user.UserName },
      process.env.JWT_SECRET || 'your-secret-key-change-in-production',
      { expiresIn: process.env.JWT_EXPIRE || '7d' }
    );

    res.json({
      success: true,
      message: 'Login successful.',
      data: {
        token,
        user: {
          id: user.Id,
          username: user.UserName,
          email: user.Email,
          roles: user.roles.map(r => r.Name),
        },
      },
    });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({
      success: false,
      message: 'An error occurred during login.',
      error: error.message,
    });
  }
});

/**
 * GET /api/auth/me
 * Get current authenticated user info
 */
router.get('/me', async (req, res) => {
  try {
    // User info is attached by auth middleware
    res.json({
      success: true,
      data: {
        user: req.user,
      },
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Failed to get user info.',
      error: error.message,
    });
  }
});

module.exports = router;
