const jwt = require('jsonwebtoken');
const { AspNetUsers, AspNetRoles, AspNetUserRoles } = require('../models');

const authMiddleware = async (req, res, next) => {
  try {
    const authHeader = req.headers.authorization;
    
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return res.status(401).json({ 
        success: false, 
        message: 'Access denied. No token provided.' 
      });
    }

    const token = authHeader.split(' ')[1];
    const decoded = jwt.verify(token, process.env.JWT_SECRET || 'your-secret-key-change-in-production');
    
    // Fetch user with roles
    const user = await AspNetUsers.findOne({
      where: { Id: decoded.userId },
      include: [{
        model: AspNetRoles,
        as: 'roles',
        through: { attributes: [] },
      }],
      attributes: ['Id', 'UserName', 'Email', 'Status'],
    });

    if (!user || !user.Status) {
      return res.status(401).json({ 
        success: false, 
        message: 'Invalid token or user inactive.' 
      });
    }

    req.user = {
      id: user.Id,
      username: user.UserName,
      email: user.Email,
      roles: user.roles.map(r => r.Name),
    };

    next();
  } catch (error) {
    if (error.name === 'TokenExpiredError') {
      return res.status(401).json({ 
        success: false, 
        message: 'Token expired.' 
      });
    }
    return res.status(500).json({ 
      success: false, 
      message: 'Authentication failed.',
      error: error.message 
    });
  }
};

module.exports = authMiddleware;
