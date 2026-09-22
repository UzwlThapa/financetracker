import { useNavigate } from 'react-router-dom';
import { useAuth } from '../hooks/useAuth';
import { LayoutDashboard, Users, CreditCard, FileText, LogOut } from 'lucide-react';

const Sidebar = () => {
  const navigate = useNavigate();
  const { user, logout, hasRole } = useAuth();

  const menuItems = [
    { icon: LayoutDashboard, label: 'Dashboard', path: '/', roles: ['SuperAdmin', 'FinanceManager', 'FinanceStaff', 'SupportStaff', 'SalesTeam'] },
    { icon: Users, label: 'Clients', path: '/clients', roles: ['SuperAdmin', 'FinanceManager', 'FinanceStaff', 'SupportStaff', 'SalesTeam'] },
    { icon: CreditCard, label: 'Payments', path: '/payments', roles: ['SuperAdmin', 'FinanceManager', 'FinanceStaff'] },
    { icon: FileText, label: 'Reports', path: '/reports', roles: ['SuperAdmin', 'FinanceManager', 'FinanceStaff'] }
  ];

  const handleLogout = () => {
    logout();
    navigate('/login');
  };

  return (
    <div className="sidebar">
      <div className="sidebar-header">
        <h2>RestroOrder</h2>
        <p>Finance Tracker</p>
      </div>
      
      <ul className="nav-menu">
        {menuItems.map((item) => {
          if (!hasRole(item.roles)) return null;
          
          return (
            <li key={item.path} className="nav-item">
              <a 
                className="nav-link"
                onClick={() => navigate(item.path)}
              >
                <item.icon size={20} />
                <span>{item.label}</span>
              </a>
            </li>
          );
        })}
      </ul>

      <div style={{ position: 'absolute', bottom: '20px', width: '100%', padding: '0 20px' }}>
        <div style={{ marginBottom: '15px', fontSize: '0.85rem', opacity: 0.7 }}>
          Logged in as:<br/>
          <strong>{user?.email}</strong>
        </div>
        <button className="btn logout-btn" onClick={handleLogout} style={{ width: '100%', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '8px' }}>
          <LogOut size={18} />
          Logout
        </button>
      </div>
    </div>
  );
};

export default Sidebar;
