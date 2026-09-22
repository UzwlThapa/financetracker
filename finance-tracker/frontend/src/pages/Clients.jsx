import { useState, useEffect } from 'react';
import api from '../utils/api';
import Sidebar from '../components/Sidebar';
import { useAuth } from '../hooks/useAuth';

const Clients = () => {
  const { hasRole } = useAuth();
  const [clients, setClients] = useState([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');
  const [statusFilter, setStatusFilter] = useState('all');
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);

  useEffect(() => {
    loadClients();
  }, [currentPage, statusFilter]);

  const loadClients = async () => {
    setLoading(true);
    try {
      const params = {
        page: currentPage,
        limit: 10,
        status: statusFilter !== 'all' ? statusFilter : undefined
      };
      
      const response = await api.get('/clients', { params });
      setClients(response.data.clients || []);
      setTotalPages(response.data.totalPages || 1);
    } catch (error) {
      console.error('Failed to load clients:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleSearch = async (e) => {
    e.preventDefault();
    try {
      const response = await api.get('/clients', {
        params: { search: searchTerm, status: statusFilter !== 'all' ? statusFilter : undefined }
      });
      setClients(response.data.clients || []);
    } catch (error) {
      console.error('Search failed:', error);
    }
  };

  const getStatusBadge = (client) => {
    const endDate = new Date(client.SubscriptionEndDate);
    const today = new Date();
    const daysRemaining = Math.ceil((endDate - today) / (1000 * 60 * 60 * 24));

    if (daysRemaining <= 0) return { class: 'status-expired', label: 'Expired' };
    if (daysRemaining <= 7) return { class: 'status-expiring', label: 'Critical' };
    if (daysRemaining <= 30) return { class: 'status-expiring', label: 'Expiring' };
    return { class: 'status-active', label: 'Active' };
  };

  const getDaysRemaining = (client) => {
    const endDate = new Date(client.SubscriptionEndDate);
    const today = new Date();
    return Math.ceil((endDate - today) / (1000 * 60 * 60 * 24));
  };

  return (
    <div className="app-container">
      <Sidebar />
      <div className="main-content">
        <div className="header">
          <h1>Client Management</h1>
          <div className="user-info">
            <span className="user-badge">Restaurants</span>
          </div>
        </div>

        <div className="content-card">
          <div className="card-header">
            <h3>All Clients</h3>
          </div>

          <form onSubmit={handleSearch} className="search-bar">
            <input
              type="text"
              className="search-input"
              placeholder="Search by restaurant name, owner, or contact..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
            />
            <select
              className="filter-select"
              value={statusFilter}
              onChange={(e) => setStatusFilter(e.target.value)}
            >
              <option value="all">All Status</option>
              <option value="active">Active</option>
              <option value="expiring">Expiring Soon</option>
              <option value="expired">Expired</option>
            </select>
            <button type="submit" className="btn btn-primary">Search</button>
          </form>

          {loading ? (
            <div className="loading">Loading clients...</div>
          ) : (
            <>
              <div className="table-container">
                <table>
                  <thead>
                    <tr>
                      <th>Restaurant Name</th>
                      <th>Owner Name</th>
                      <th>Contact</th>
                      <th>Location</th>
                      <th>Subscription End</th>
                      <th>Days Left</th>
                      <th>Status</th>
                      {hasRole(['SuperAdmin', 'FinanceManager']) && <th>Actions</th>}
                    </tr>
                  </thead>
                  <tbody>
                    {clients.length > 0 ? (
                      clients.map(client => {
                        const status = getStatusBadge(client);
                        return (
                          <tr key={client.id}>
                            <td>{client.RestaurantName}</td>
                            <td>{client.OwnerName}</td>
                            <td>{client.ContactNumber}</td>
                            <td>{client.City}, {client.State}</td>
                            <td>{new Date(client.SubscriptionEndDate).toLocaleDateString()}</td>
                            <td>{getDaysRemaining(client)}</td>
                            <td>
                              <span className={`status-badge ${status.class}`}>
                                {status.label}
                              </span>
                            </td>
                            {hasRole(['SuperAdmin', 'FinanceManager']) && (
                              <td>
                                <button 
                                  className="btn btn-primary" 
                                  style={{ padding: '5px 10px', fontSize: '0.85rem' }}
                                  onClick={() => alert('Edit feature coming soon')}
                                >
                                  Edit
                                </button>
                              </td>
                            )}
                          </tr>
                        );
                      })
                    ) : (
                      <tr>
                        <td colSpan="8" style={{ textAlign: 'center', padding: '20px' }}>
                          No clients found
                        </td>
                      </tr>
                    )}
                  </tbody>
                </table>
              </div>

              {totalPages > 1 && (
                <div className="pagination">
                  <button
                    className="page-btn"
                    disabled={currentPage === 1}
                    onClick={() => setCurrentPage(currentPage - 1)}
                  >
                    Previous
                  </button>
                  {[...Array(totalPages)].map((_, i) => (
                    <button
                      key={i + 1}
                      className={`page-btn ${currentPage === i + 1 ? 'active' : ''}`}
                      onClick={() => setCurrentPage(i + 1)}
                    >
                      {i + 1}
                    </button>
                  ))}
                  <button
                    className="page-btn"
                    disabled={currentPage === totalPages}
                    onClick={() => setCurrentPage(currentPage + 1)}
                  >
                    Next
                  </button>
                </div>
              )}
            </>
          )}
        </div>
      </div>
    </div>
  );
};

export default Clients;
