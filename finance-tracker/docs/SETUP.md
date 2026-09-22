# RestroOrder Finance Tracker - Setup Guide

## Prerequisites

Before you begin, ensure you have the following installed:

- **Node.js** (v18 or higher)
- **npm** or **yarn**
- **Microsoft SQL Server** (existing database: WaiterModuleMultiTenants)
- **Docker** and **Docker Compose** (optional, for containerized deployment)

## Quick Start

### Option 1: Docker Deployment (Recommended)

1. **Clone the repository**
   ```bash
   cd /workspace/finance-tracker
   ```

2. **Create environment file**
   ```bash
   cp backend/.env.example backend/.env
   # Edit backend/.env with your database credentials
   ```

3. **Start all services**
   ```bash
   docker-compose up -d
   ```

4. **Verify deployment**
   ```bash
   docker-compose ps
   curl http://localhost:5000/health
   ```

5. **Access the application**
   - API: http://localhost:5000
   - Frontend: http://localhost

### Option 2: Manual Installation

#### Backend Setup

1. **Navigate to backend directory**
   ```bash
   cd backend
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Configure environment**
   ```bash
   cp .env.example .env
   # Edit .env with your settings
   ```

4. **Update database credentials in .env**
   ```env
   DB_HOST=your-sql-server-host
   DB_NAME=WaiterModuleMultiTenants
   DB_USER=waitermodule_admin
   DB_PASSWORD=your_password
   ```

5. **Start the server**
   ```bash
   # Development mode
   npm run dev
   
   # Production mode
   npm start
   ```

6. **Test the API**
   ```bash
   curl http://localhost:5000/health
   ```

#### Frontend Setup

1. **Navigate to frontend directory**
   ```bash
   cd frontend
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Configure API URL**
   Create `.env` file:
   ```env
   REACT_APP_API_URL=http://localhost:5000/api
   ```

4. **Start development server**
   ```bash
   npm start
   ```

5. **Build for production**
   ```bash
   npm run build
   ```

## Database Configuration

The application uses your existing `WaiterModuleMultiTenants` database. Ensure the following tables exist:

- `RestroUsersInfo` - Client information
- `RestroUsersPaymentLogs` - Payment records
- `AspNetUsers` - System users
- `AspNetRoles` - User roles
- `AspNetUserRoles` - User-role mappings

### Creating Initial Admin User

You'll need to create an initial admin user in the database. Here's a sample SQL script:

```sql
-- First, create the SuperAdmin role if it doesn't exist
IF NOT EXISTS (SELECT * FROM AspNetRoles WHERE Name = 'SuperAdmin')
BEGIN
    INSERT INTO AspNetRoles (Name, NormalizedName) 
    VALUES ('SuperAdmin', 'SUPERADMIN');
END

-- Get the role ID
DECLARE @RoleId INT;
SELECT @RoleId = Id FROM AspNetRoles WHERE Name = 'SuperAdmin';

-- Create admin user (password should be hashed using bcrypt)
-- You can use the seed script provided in scripts/seed-admin.js
```

## Environment Variables

### Required Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `DB_HOST` | SQL Server host | localhost |
| `DB_PORT` | SQL Server port | 1433 |
| `DB_NAME` | Database name | WaiterModuleMultiTenants |
| `DB_USER` | Database username | waitermodule_admin |
| `DB_PASSWORD` | Database password | (required) |
| `JWT_SECRET` | JWT signing secret | (required) |

### Optional Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `NODE_ENV` | Environment | development |
| `PORT` | Server port | 5000 |
| `FRONTEND_URL` | Frontend URL for CORS | http://localhost:3000 |
| `SMTP_*` | Email configuration | - |

## API Testing

### Login Endpoint
```bash
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"yourpassword"}'
```

### Get Clients (requires authentication)
```bash
curl http://localhost:5000/api/clients \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

### Get Dashboard KPIs
```bash
curl http://localhost:5000/api/reports/dashboard-kpis \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

## User Roles

| Role | Permissions |
|------|-------------|
| `SuperAdmin` | Full system access |
| `FinanceManager` | View/add payments, reports, manage clients |
| `FinanceStaff` | View assigned clients, record payments |
| `SupportStaff` | View client info only |
| `SalesTeam` | View prospects, renewal dates |

## Troubleshooting

### Database Connection Issues
- Verify SQL Server is running
- Check firewall settings for port 1433
- Ensure credentials in `.env` are correct
- Test connection: `telnet DB_HOST DB_PORT`

### Authentication Issues
- Ensure JWT_SECRET is set and matches across deployments
- Check that AspNetUsers table has proper data
- Verify password hashing algorithm matches

### CORS Errors
- Update FRONTEND_URL in backend `.env`
- Ensure frontend is making requests to correct API URL

## Next Steps

1. **Import existing client data** from Excel sheets
2. **Create user accounts** for your team
3. **Configure email notifications** (optional)
4. **Set up backup procedures** for database
5. **Deploy to production** server

## Support

For issues or questions, contact the RestroOrder development team.
