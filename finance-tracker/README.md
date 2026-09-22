# RestroOrder Finance Tracker - Complete Setup Guide

## 🎯 Project Overview

A complete **Finance & Client Billing Tracker** for RestroOrder with:
- **Separate Backend & Frontend** (Node.js/Express + React/Vite)
- **Role-Based Access Control** (5 user roles)
- **Real-time Dashboard** with KPIs
- **Client Management** with expiry tracking
- **Payment Recording** with restrictions
- **Reports & Analytics**
- **Docker-ready** for easy deployment

---

## 📁 Project Structure

```
finance-tracker/
├── backend/              # Node.js/Express API
│   ├── server.js        # Main entry point
│   ├── models/          # Sequelize models
│   ├── routes/          # API routes
│   ├── middleware/      # Auth & RBAC
│   ├── config/          # Database config
│   └── .env.example     # Environment template
├── frontend/            # React/Vite UI
│   ├── src/
│   │   ├── components/  # Reusable components
│   │   ├── pages/       # Page components
│   │   ├── hooks/       # Custom hooks
│   │   └── utils/       # API client
│   ├── package.json
│   └── vite.config.js
├── docker-compose.yml   # Docker orchestration
└── README.md           # This file
```

---

## 🚀 Quick Start

### Option 1: Local Development

#### 1. Backend Setup

```bash
cd backend

# Install dependencies
npm install

# Configure environment
cp .env.example .env
# Edit .env with your database credentials

# Start server
npm start
# Server runs on http://localhost:5000
```

#### 2. Frontend Setup

```bash
cd frontend

# Install dependencies (already done)
npm install

# Start development server
npm run dev
# Frontend runs on http://localhost:3000
```

### Option 2: Docker Deployment

```bash
# From project root
docker-compose up -d

# Services running:
# - Backend: http://localhost:5000
# - Frontend: http://localhost:3000
```

---

## 🔐 Authentication & Roles

### User Roles (Hierarchy)

1. **SuperAdmin** - Full access to everything
2. **FinanceManager** - Can view/add payments, reports, clients
3. **FinanceStaff** - Can view payments, add payments, basic reports
4. **SupportStaff** - View-only access to clients
5. **SalesTeam** - View-only access to clients

### Default Login (for testing)
```
Email: admin@restroorder.com
Password: password
```

### Access Matrix

| Feature | SuperAdmin | FinanceManager | FinanceStaff | SupportStaff | SalesTeam |
|---------|-----------|----------------|--------------|--------------|-----------|
| Dashboard | ✅ | ✅ | ✅ | ✅ | ✅ |
| View Clients | ✅ | ✅ | ✅ | ✅ | ✅ |
| Add Payment | ✅ | ✅ | ✅ | ❌ | ❌ |
| View Payments | ✅ | ✅ | ✅ | ❌ | ❌ |
| Reports | ✅ | ✅ | ✅ | ❌ | ❌ |
| Edit Clients | ✅ | ✅ | ❌ | ❌ | ❌ |

---

## 📊 Features

### Dashboard
- Monthly revenue summary
- Total active clients count
- Expiring clients (within 30 days)
- Expired clients alert
- Quick view of critical accounts

### Client Management
- Search by restaurant name, owner, or contact
- Filter by status (Active/Expiring/Expired)
- Pagination support
- Days remaining calculation
- Status badges with color coding

### Payment Tracking
- Record new payments (Finance roles only)
- Multiple payment modes (Cash, Card, UPI, Bank Transfer, Cheque)
- Payment types (Subscription, Setup Fee, Support, Other)
- Full payment history with who recorded it
- Automatic linking to client records

### Reports
- Revenue reports by date range
- Payment breakdown by type
- Expiring clients list
- Printable reports
- Export-ready data

---

## 🔧 Configuration

### Backend Environment (.env)

```env
PORT=5000
NODE_ENV=development

# Database
DB_HOST=localhost
DB_PORT=3306
DB_NAME=WaiterModuleMultiTenants
DB_USER=your_username
DB_PASSWORD=your_password

# JWT Secret
JWT_SECRET=your-super-secret-jwt-key-change-this

# CORS
FRONTEND_URL=http://localhost:3000
```

### Frontend Proxy

The frontend is configured to proxy API requests to the backend automatically via `vite.config.js`.

---

## 🛠️ API Endpoints

### Authentication
- `POST /api/auth/login` - User login

### Clients
- `GET /api/clients` - List clients (with search, filter, pagination)
- `GET /api/clients/:id` - Get single client

### Payments
- `GET /api/payments` - List all payments
- `POST /api/payments` - Record new payment (Finance roles only)

### Reports
- `GET /api/reports/dashboard` - Dashboard statistics
- `GET /api/reports/revenue` - Revenue report by date range
- `GET /api/reports/expiring-clients` - List expiring clients

---

## 💻 Tech Stack

### Backend
- **Runtime**: Node.js
- **Framework**: Express.js
- **ORM**: Sequelize
- **Auth**: JWT (jsonwebtoken)
- **Security**: Helmet, bcryptjs, express-rate-limit
- **Database**: MySQL (existing WaiterModuleMultiTenants)

### Frontend
- **Framework**: React 18
- **Build Tool**: Vite
- **Routing**: React Router v6
- **HTTP Client**: Axios
- **Icons**: Lucide React
- **Styling**: Pure CSS (no framework dependencies)

### DevOps
- **Containerization**: Docker & Docker Compose
- **Environment**: dotenv

---

## 🎨 UI Design

### Color Scheme
- Primary: #3498db (Blue)
- Success: #27ae60 (Green)
- Warning: #f39c12 (Orange)
- Danger: #e74c3c (Red)
- Dark: #2c3e50

### Layout
- Fixed sidebar navigation (260px)
- Responsive main content area
- Card-based dashboard widgets
- Clean table layouts with hover effects
- Status badges with semantic colors

---

## 📝 Usage Examples

### Recording a Payment

1. Navigate to **Payments** page
2. Click **"+ Add Payment"** button
3. Select client from dropdown
4. Enter amount
5. Choose payment mode and type
6. Add optional remarks
7. Click **"Record Payment"**

### Generating Revenue Report

1. Go to **Reports** page
2. Select "Revenue Report"
3. Choose date range
4. Click **"Generate Report"**
5. View breakdown by payment type
6. Click **"Print Report"** for PDF/export

### Finding Expiring Clients

1. Go to **Dashboard** - see quick stats
2. Or go to **Clients** page
3. Filter by "Expiring Soon" status
4. Or generate "Expiring Clients" report
5. Contact clients for renewal

---

## 🔒 Security Features

- JWT-based authentication
- Password hashing with bcryptjs
- Role-based access control (RBAC)
- Rate limiting on API endpoints
- Helmet.js security headers
- CORS configuration
- SQL injection prevention (Sequelize ORM)
- XSS protection

---

## 🐛 Troubleshooting

### Backend won't start
```bash
# Check database connection
# Verify .env file exists and has correct credentials
# Ensure MySQL server is running
```

### Frontend can't connect to API
```bash
# Ensure backend is running on port 5000
# Check vite.config.js proxy settings
# Clear browser cache
```

### Login fails
```bash
# Verify database has AspNetUsers table
# Check if user exists in database
# Ensure JWT_SECRET is set in .env
```

### Permission errors
```bash
# Verify user role in AspNetRoles table
# Check RBAC middleware implementation
# Ensure token is being sent with requests
```

---

## 📦 Deployment

### Production Build

```bash
# Backend
cd backend
npm install --production
npm start

# Frontend
cd frontend
npm run build
# Serve dist/ folder with nginx or similar
```

### Docker Production

```bash
# Build images
docker-compose -f docker-compose.yml build

# Deploy
docker-compose -f docker-compose.prod.yml up -d
```

---

## 🤝 Next Steps

1. **Customize branding** - Update logos and colors
2. **Add email notifications** - For expiring clients
3. **Implement client editing** - Currently view-only
4. **Add export features** - CSV/PDF exports
5. **Create admin panel** - User management
6. **Add charts** - Visual analytics with Recharts
7. **Mobile responsive** - Optimize for tablets/phones

---

## 📞 Support

For issues or questions:
- Check the existing database schema
- Review middleware/rbac.js for permission logic
- Inspect network tab for API errors
- Check backend logs for detailed error messages

---

**Built for RestroOrder** - Making client billing simple and organized! 🎉
