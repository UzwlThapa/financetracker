/**
 * Role-Based Access Control Middleware
 * Usage: requireAuth(['SuperAdmin', 'FinanceManager'])
 */

const rbacMiddleware = (allowedRoles) => {
  return (req, res, next) => {
    if (!req.user || !req.user.roles) {
      return res.status(401).json({
        success: false,
        message: 'Authentication required.',
      });
    }

    const userRoles = req.user.roles;
    const hasAccess = allowedRoles.some(role => userRoles.includes(role));

    if (!hasAccess) {
      return res.status(403).json({
        success: false,
        message: 'You do not have permission to access this resource.',
      });
    }

    next();
  };
};

// Helper function to check if user has role
const hasRole = (user, role) => {
  return user && user.roles && user.roles.includes(role);
};

module.exports = {
  rbacMiddleware,
  hasRole,
};
