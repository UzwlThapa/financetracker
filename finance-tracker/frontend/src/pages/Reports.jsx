import { useState, useEffect } from 'react';
import api from '../utils/api';
import Sidebar from '../components/Sidebar';
import { useAuth } from '../hooks/useAuth';

const Reports = () => {
  const { hasRole } = useAuth();
  const [reportType, setReportType] = useState('revenue');
  const [startDate, setStartDate] = useState('');
  const [endDate, setEndDate] = useState('');
  const [reportData, setReportData] = useState(null);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    // Set default dates for current month
    const now = new Date();
    const firstDay = new Date(now.getFullYear(), now.getMonth(), 1);
    const lastDay = new Date(now.getFullYear(), now.getMonth() + 1, 0);
    
    setStartDate(firstDay.toISOString().split('T')[0]);
    setEndDate(lastDay.toISOString().split('T')[0]);
  }, []);

  const generateReport = async () => {
    if (!startDate || !endDate) return;
    
    setLoading(true);
    try {
      let endpoint = '';
      let params = { startDate, endDate };

      if (reportType === 'revenue') {
        endpoint = '/reports/revenue';
      } else if (reportType === 'expiring') {
        endpoint = '/reports/expiring-clients';
        params = { days: 30 };
      }

      const response = await api.get(endpoint, { params });
      setReportData(response.data);
    } catch (error) {
      console.error('Failed to generate report:', error);
    } finally {
      setLoading(false);
    }
  };

  const handlePrint = () => {
    window.print();
  };

  if (!hasRole(['SuperAdmin', 'FinanceManager', 'FinanceStaff'])) {
    return (
      <div className="app-container">
        <Sidebar />
        <div className="main-content">
          <div className="header">
            <h1>Reports</h1>
          </div>
          <div className="content-card">
            <p>You don't have permission to view reports.</p>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="app-container">
      <Sidebar />
      <div className="main-content">
        <div className="header">
          <h1>Reports & Analytics</h1>
          <button className="btn btn-primary" onClick={handlePrint}>
            Print Report
          </button>
        </div>

        <div className="content-card">
          <div className="card-header">
            <h3>Generate Report</h3>
          </div>

          <div style={{ display: 'flex', gap: '20px', flexWrap: 'wrap', alignItems: 'flex-end' }}>
            <div className="form-group" style={{ flex: 1, minWidth: '200px' }}>
              <label>Report Type</label>
              <select
                className="form-control"
                value={reportType}
                onChange={(e) => setReportType(e.target.value)}
              >
                <option value="revenue">Revenue Report</option>
                <option value="expiring">Expiring Clients</option>
              </select>
            </div>

            {reportType === 'revenue' && (
              <>
                <div className="form-group">
                  <label>Start Date</label>
                  <input
                    type="date"
                    className="form-control"
                    value={startDate}
                    onChange={(e) => setStartDate(e.target.value)}
                  />
                </div>

                <div className="form-group">
                  <label>End Date</label>
                  <input
                    type="date"
                    className="form-control"
                    value={endDate}
                    onChange={(e) => setEndDate(e.target.value)}
                  />
                </div>
              </>
            )}

            <button 
              className="btn btn-primary" 
              onClick={generateReport}
              disabled={loading}
            >
              {loading ? 'Generating...' : 'Generate Report'}
            </button>
          </div>
        </div>

        {reportData && (
          <>
            {reportType === 'revenue' && (
              <div className="content-card">
                <div className="card-header">
                  <h3>Revenue Report</h3>
                  <span style={{ color: '#7f8c8d', fontSize: '0.9rem' }}>
                    {new Date(startDate).toLocaleDateString()} - {new Date(endDate).toLocaleDateString()}
                  </span>
                </div>

                <div className="dashboard-grid">
                  <div className="stat-card green">
                    <div className="stat-label">Total Revenue</div>
                    <div className="stat-value">₹{reportData.totalRevenue?.toLocaleString() || '0'}</div>
                  </div>

                  <div className="stat-card blue">
                    <div className="stat-label">Total Payments</div>
                    <div className="stat-value">{reportData.paymentCount || 0}</div>
                  </div>

                  <div className="stat-card orange">
                    <div className="stat-label">Average Payment</div>
                    <div className="stat-value">₹{reportData.averagePayment?.toLocaleString() || '0'}</div>
                  </div>
                </div>

                {reportData.paymentsByType && (
                  <div style={{ marginTop: '20px' }}>
                    <h4 style={{ marginBottom: '15px' }}>Breakdown by Payment Type</h4>
                    <div className="table-container">
                      <table>
                        <thead>
                          <tr>
                            <th>Type</th>
                            <th>Count</th>
                            <th>Total Amount</th>
                            <th>Percentage</th>
                          </tr>
                        </thead>
                        <tbody>
                          {Object.entries(reportData.paymentsByType).map(([type, data]) => (
                            <tr key={type}>
                              <td>{type}</td>
                              <td>{data.count}</td>
                              <td>₹{data.total?.toLocaleString()}</td>
                              <td>{data.percentage}%</td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    </div>
                  </div>
                )}
              </div>
            )}

            {reportType === 'expiring' && (
              <div className="content-card">
                <div className="card-header">
                  <h3>Clients Expiring Within {reportData.days || 30} Days</h3>
                </div>

                <div className="table-container">
                  <table>
                    <thead>
                      <tr>
                        <th>Restaurant Name</th>
                        <th>Owner</th>
                        <th>Contact</th>
                        <th>Expiry Date</th>
                        <th>Days Left</th>
                        <th>Status</th>
                      </tr>
                    </thead>
                    <tbody>
                      {reportData.clients && reportData.clients.length > 0 ? (
                        reportData.clients.map(client => (
                          <tr key={client.id}>
                            <td>{client.RestaurantName}</td>
                            <td>{client.OwnerName}</td>
                            <td>{client.ContactNumber}</td>
                            <td>{new Date(client.SubscriptionEndDate).toLocaleDateString()}</td>
                            <td style={{ fontWeight: '600', color: client.daysRemaining <= 7 ? '#e74c3c' : '#f39c12' }}>
                              {client.daysRemaining}
                            </td>
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
                          <td colSpan="6" style={{ textAlign: 'center', padding: '20px' }}>
                            No clients expiring in this period
                          </td>
                        </tr>
                      )}
                    </tbody>
                  </table>
                </div>
              </div>
            )}
          </>
        )}
      </div>
    </div>
  );
};

export default Reports;
