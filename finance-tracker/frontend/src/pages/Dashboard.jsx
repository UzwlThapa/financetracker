import { useState, useEffect } from 'react';
import api from '../utils/api';
import Sidebar from '../components/Sidebar';

const Dashboard = () => {
  const [stats, setStats] = useState(null);
  const [expiringClients, setExpiringClients] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadDashboardData();
  }, []);

  const loadDashboardData = async () => {
    try {
      const [statsRes, expiringRes] = await Promise.all([
        api.get('/reports/dashboard'),
        api.get('/clients?status=expiring&limit=5')
      ]);
      
      setStats(statsRes.data);
      setExpiringClients(expiringRes.data.clients || []);
    } catch (error) {
      console.error('Failed to load dashboard:', error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <div className="app-container">
        <Sidebar />
        <div className="main-content">
          <div className="loading">Loading dashboard...</div>
        </div>
      </div>
    );
  }

  return (
    <div className="app-container">
      <Sidebar />
      <div className="main-content">
        <div className="header">
          <h1>Dashboard</h1>
          <div className="user-info">
            <span className="user-badge">Finance Tracker</span>
          </div>
        </div>

        <div className="dashboard-grid">
          <div className="stat-card blue">
            <div className="stat-label">Monthly Revenue</div>
            <div className="stat-value">₹{stats?.monthlyRevenue?.toLocaleString() || '0'}</div>
            <div className="stat-label">This month</div>
          </div>

          <div className="stat-card green">
            <div className="stat-label">Active Clients</div>
            <div className="stat-value">{stats?.totalClients || 0}</div>
            <div className="stat-label">Total restaurants</div>
          </div>

          <div className="stat-card orange">
            <div className="stat-label">Expiring Soon</div>
            <div className="stat-value">{stats?.expiringCount || 0}</div>
            <div className="stat-label">Within 30 days</div>
          </div>

          <div className="stat-card red">
            <div className="stat-label">Expired</div>
            <div className="stat-value">{stats?.expiredCount || 0}</div>
            <div className="stat-label">Need renewal</div>
          </div>
        </div>

        <div className="content-card">
          <div className="card-header">
            <h3>Clients Expiring Soon</h3>
          </div>
          <div className="table-container">
            <table>
              <thead>
                <tr>
                  <th>Restaurant Name</th>
                  <th>Contact</th>
                  <th>Expiry Date</th>
                  <th>Days Left</th>
                  <th>Status</th>
                </tr>
              </thead>
              <tbody>
                {expiringClients.length > 0 ? (
                  expiringClients.map(client => (
                    <tr key={client.id}>
                      <td>{client.RestaurantName || client.name}</td>
                      <td>{client.ContactNumber || client.contact}</td>
                      <td>{new Date(client.SubscriptionEndDate).toLocaleDateString()}</td>
                      <td>{client.daysRemaining}</td>
                      <td>
                        <span className={`status-badge ${
                          client.daysRemaining <= 0 ? 'status-expired' : 
                          client.daysRemaining <= 7 ? 'status-expiring' : 'status-active'
                        }`}>
                          {client.daysRemaining <= 0 ? 'Expired' : 
                           client.daysRemaining <= 7 ? 'Critical' : 'Expiring'}
                        </span>
                      </td>
                    </tr>
                  ))
                ) : (
                  <tr>
                    <td colSpan="5" style={{ textAlign: 'center', padding: '20px' }}>
                      No expiring clients
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;
