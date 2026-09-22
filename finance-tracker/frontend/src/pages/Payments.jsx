import { useState, useEffect } from 'react';
import api from '../utils/api';
import Sidebar from '../components/Sidebar';
import { useAuth } from '../hooks/useAuth';

const Payments = () => {
  const { hasRole, user } = useAuth();
  const [payments, setPayments] = useState([]);
  const [clients, setClients] = useState([]);
  const [loading, setLoading] = useState(true);
  const [showForm, setShowForm] = useState(false);
  const [formData, setFormData] = useState({
    RestroUserId: '',
    Amount: '',
    PaymentMode: 'Cash',
    PaymentType: 'Subscription',
    Remarks: ''
  });
  const [message, setMessage] = useState(null);

  useEffect(() => {
    loadPayments();
    if (hasRole(['SuperAdmin', 'FinanceManager', 'FinanceStaff'])) {
      loadClients();
    }
  }, []);

  const loadPayments = async () => {
    setLoading(true);
    try {
      const response = await api.get('/payments');
      setPayments(response.data.payments || []);
    } catch (error) {
      console.error('Failed to load payments:', error);
    } finally {
      setLoading(false);
    }
  };

  const loadClients = async () => {
    try {
      const response = await api.get('/clients?limit=100');
      setClients(response.data.clients || []);
    } catch (error) {
      console.error('Failed to load clients:', error);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setMessage(null);

    try {
      await api.post('/payments', formData);
      setMessage({ type: 'success', text: 'Payment recorded successfully!' });
      setShowForm(false);
      setFormData({
        RestroUserId: '',
        Amount: '',
        PaymentMode: 'Cash',
        PaymentType: 'Subscription',
        Remarks: ''
      });
      loadPayments();
    } catch (error) {
      setMessage({ 
        type: 'error', 
        text: error.response?.data?.message || 'Failed to record payment' 
      });
    }
  };

  const canAddPayment = hasRole(['SuperAdmin', 'FinanceManager', 'FinanceStaff']);

  return (
    <div className="app-container">
      <Sidebar />
      <div className="main-content">
        <div className="header">
          <h1>Payment Tracking</h1>
          <div className="user-info">
            {canAddPayment && (
              <button 
                className="btn btn-success"
                onClick={() => setShowForm(!showForm)}
              >
                {showForm ? 'Cancel' : '+ Add Payment'}
              </button>
            )}
          </div>
        </div>

        {showForm && canAddPayment && (
          <div className="content-card">
            <div className="card-header">
              <h3>Record New Payment</h3>
            </div>
            
            {message && (
              <div className={`alert alert-${message.type}`}>
                {message.text}
              </div>
            )}

            <form onSubmit={handleSubmit}>
              <div className="form-group">
                <label>Select Client *</label>
                <select
                  className="form-control"
                  value={formData.RestroUserId}
                  onChange={(e) => setFormData({...formData, RestroUserId: e.target.value})}
                  required
                >
                  <option value="">Choose a restaurant...</option>
                  {clients.map(client => (
                    <option key={client.id} value={client.id}>
                      {client.RestaurantName} - {client.OwnerName}
                    </option>
                  ))}
                </select>
              </div>

              <div className="form-group">
                <label>Amount (₹) *</label>
                <input
                  type="number"
                  className="form-control"
                  value={formData.Amount}
                  onChange={(e) => setFormData({...formData, Amount: e.target.value})}
                  required
                  min="1"
                />
              </div>

              <div className="form-group">
                <label>Payment Mode *</label>
                <select
                  className="form-control"
                  value={formData.PaymentMode}
                  onChange={(e) => setFormData({...formData, PaymentMode: e.target.value})}
                  required
                >
                  <option value="Cash">Cash</option>
                  <option value="Card">Card</option>
                  <option value="UPI">UPI</option>
                  <option value="Bank Transfer">Bank Transfer</option>
                  <option value="Cheque">Cheque</option>
                </select>
              </div>

              <div className="form-group">
                <label>Payment Type *</label>
                <select
                  className="form-control"
                  value={formData.PaymentType}
                  onChange={(e) => setFormData({...formData, PaymentType: e.target.value})}
                  required
                >
                  <option value="Subscription">Subscription Renewal</option>
                  <option value="Setup Fee">Setup Fee</option>
                  <option value="Support">Support Charges</option>
                  <option value="Other">Other</option>
                </select>
              </div>

              <div className="form-group">
                <label>Remarks</label>
                <textarea
                  className="form-control"
                  value={formData.Remarks}
                  onChange={(e) => setFormData({...formData, Remarks: e.target.value})}
                  rows="3"
                  placeholder="Optional notes..."
                />
              </div>

              <button type="submit" className="btn btn-success">
                Record Payment
              </button>
            </form>
          </div>
        )}

        <div className="content-card">
          <div className="card-header">
            <h3>Payment History</h3>
          </div>

          {loading ? (
            <div className="loading">Loading payments...</div>
          ) : (
            <div className="table-container">
              <table>
                <thead>
                  <tr>
                    <th>Date</th>
                    <th>Restaurant</th>
                    <th>Amount</th>
                    <th>Mode</th>
                    <th>Type</th>
                    <th>Recorded By</th>
                    <th>Remarks</th>
                  </tr>
                </thead>
                <tbody>
                  {payments.length > 0 ? (
                    payments.map(payment => (
                      <tr key={payment.id}>
                        <td>{new Date(payment.CreatedAt).toLocaleDateString()}</td>
                        <td>{payment.client?.RestaurantName || 'N/A'}</td>
                        <td style={{ fontWeight: '600', color: '#27ae60' }}>
                          ₹{payment.Amount?.toLocaleString()}
                        </td>
                        <td>{payment.PaymentMode}</td>
                        <td>{payment.PaymentType}</td>
                        <td>{payment.recordedBy?.email || payment.UserEmail || 'N/A'}</td>
                        <td>{payment.Remarks || '-'}</td>
                      </tr>
                    ))
                  ) : (
                    <tr>
                      <td colSpan="7" style={{ textAlign: 'center', padding: '20px' }}>
                        No payment records found
                      </td>
                    </tr>
                  )}
                </tbody>
              </table>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default Payments;
