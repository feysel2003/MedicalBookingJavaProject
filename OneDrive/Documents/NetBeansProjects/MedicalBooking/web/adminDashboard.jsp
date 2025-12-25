<%@ page session="true" %>
<%@ page import="model.Admin" %>
<%
    Admin admin = (Admin) session.getAttribute("currentAdmin");
    if (admin == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
    
    // Get the counts passed from AdminDashboardServlet
    Integer totalDoctors = (Integer) request.getAttribute("totalDoctors");
    Integer totalPatients = (Integer) request.getAttribute("totalPatients");
    Integer totalAppointments = (Integer) request.getAttribute("totalAppointments");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Medical Booking System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e8f4ff 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #2c3e50;
        }
        
        /* Navbar Styling */
        .medical-navbar {
            background: linear-gradient(to right, #1a73e8, #2a8bf2);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 1rem 0;
        }
        
        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
            color: white;
        }
        
        .navbar-brand i {
            background: rgba(255, 255, 255, 0.2);
            padding: 10px;
            border-radius: 10px;
        }
        
        .btn-admin-outline {
            background: transparent;
            border: 2px solid rgba(255, 255, 255, 0.5);
            color: white;
            padding: 8px 20px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .btn-admin-outline:hover {
            background: rgba(255, 255, 255, 0.1);
            border-color: white;
            transform: translateY(-2px);
            color: white;
        }
        
        .btn-admin-logout {
            background: rgba(255, 255, 255, 0.15);
            border: 2px solid rgba(255, 255, 255, 0.3);
            color: white;
            padding: 8px 20px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .btn-admin-logout:hover {
            background: rgba(220, 53, 69, 0.8);
            border-color: #dc3545;
            transform: translateY(-2px);
            color: white;
        }
        
        /* Dashboard Content */
        .dashboard-container {
            max-width: 1400px;
            margin: 2rem auto;
            padding: 0 20px;
        }
        
        .welcome-header {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 5px 15px rgba(0, 115, 230, 0.08);
            border-left: 5px solid #1a73e8;
        }
        
        .welcome-header h2 {
            color: #1a73e8;
            font-weight: 700;
            margin-bottom: 5px;
        }
        
        .welcome-header p {
            color: #6c757d;
            font-size: 1.1rem;
        }
        
        /* Stats Cards */
        .stats-card {
            border-radius: 15px;
            border: none;
            box-shadow: 0 5px 15px rgba(0, 115, 230, 0.08);
            transition: all 0.3s ease;
            overflow: hidden;
            height: 100%;
            position: relative;
        }
        
        .stats-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 10px 25px rgba(0, 115, 230, 0.15);
        }
        
        .stats-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
        }
        
        .stats-card-doctor::before {
            background: linear-gradient(to right, #1a73e8, #2a8bf2);
        }
        
        .stats-card-patient::before {
            background: linear-gradient(to right, #28a745, #20c997);
        }
        
        .stats-card-appointment::before {
            background: linear-gradient(to right, #fd7e14, #fd9843);
        }
        
        .stats-card-body {
            padding: 1.8rem;
            background: white;
        }
        
        .stats-icon {
            width: 70px;
            height: 70px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
        }
        
        .stats-icon i {
            font-size: 2rem;
        }
        
        .stats-number {
            font-size: 2.5rem;
            font-weight: 800;
            margin: 10px 0;
            line-height: 1;
        }
        
        .stats-label {
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #6c757d;
        }
        
        .stats-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: inherit;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.9rem;
            padding: 8px 0;
            transition: all 0.3s;
        }
        
        .stats-link:hover {
            gap: 12px;
            text-decoration: none;
        }
        
        /* Quick Actions */
        .actions-section {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            margin-top: 2rem;
            box-shadow: 0 5px 15px rgba(0, 115, 230, 0.08);
        }
        
        .actions-title {
            color: #1a73e8;
            font-weight: 700;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .action-btn {
            background: white;
            border: 2px solid #e8f4ff;
            border-radius: 12px;
            padding: 1.5rem;
            text-align: left;
            transition: all 0.3s;
            height: 100%;
            text-decoration: none;
            display: block;
            color: #2c3e50;
        }
        
        .action-btn:hover {
            border-color: #1a73e8;
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 115, 230, 0.08);
            text-decoration: none;
            color: #2c3e50;
        }
        
        .action-icon {
            width: 60px;
            height: 60px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
        }
        
        .action-title {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 5px;
        }
        
        .action-desc {
            color: #6c757d;
            font-size: 0.9rem;
            margin: 0;
        }
        
        /* Footer */
        .medical-footer {
            background: white;
            border-top: 1px solid #e8f4ff;
            padding: 1.5rem 0;
            margin-top: 3rem;
            color: #6c757d;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .dashboard-container {
                padding: 0 15px;
                margin: 1rem auto;
            }
            
            .welcome-header {
                padding: 1.5rem;
            }
            
            .stats-card-body {
                padding: 1.5rem;
            }
            
            .stats-number {
                font-size: 2rem;
            }
            
            .navbar-brand span {
                display: none;
            }
            
            .btn-admin-outline, .btn-admin-logout {
                padding: 6px 15px;
                font-size: 0.9rem;
            }
        }
        
        .admin-email {
            background: rgba(255, 255, 255, 0.1);
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            margin-left: 15px;
            color: white;
        }
        
        /* Text Colors */
        .text-primary {
            color: #1a73e8 !important;
        }
        
        .text-success {
            color: #28a745 !important;
        }
        
        .text-warning {
            color: #fd7e14 !important;
        }
        
        .text-muted {
            color: #6c757d !important;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg medical-navbar">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-hospital-alt"></i>
                <span>Medical Booking Admin</span>
            </a>
            
            <div class="d-flex align-items-center">
                <div class="admin-email text-white">
                    <i class="fas fa-user-circle me-2"></i><%= admin.getEmail() %>
                </div>
                <a href="adminProfile.jsp" class="btn btn-admin-outline me-2">
                    <i class="fas fa-cog me-2"></i>Settings
                </a>
                <a href="AdminLogoutServlet" class="btn btn-admin-logout">
                    <i class="fas fa-sign-out-alt me-2"></i>Logout
                </a>
            </div>
        </div>
    </nav>

    <!-- Dashboard Content -->
    <div class="dashboard-container">
        <!-- Welcome Header -->
        <div class="welcome-header">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2><i class="fas fa-tachometer-alt me-3"></i>Admin Dashboard</h2>
                    <p>Monitor system performance and manage medical operations</p>
                </div>
                <div class="col-md-4 text-md-end">
                    <div class="text-muted">
                        <i class="fas fa-calendar-day me-2"></i>
                        <%= new java.text.SimpleDateFormat("EEEE, MMMM dd, yyyy").format(new java.util.Date()) %>
                    </div>
                </div>
            </div>
        </div>

        <!-- Statistics Cards -->
        <div class="row g-4 mb-4">
            <!-- Doctors Card -->
            <div class="col-lg-4 col-md-6">
                <div class="stats-card stats-card-doctor">
                    <div class="stats-card-body">
                        <div class="stats-icon" style="background: rgba(26, 115, 232, 0.1); color: #1a73e8;">
                            <i class="fas fa-user-md"></i>
                        </div>
                        <div class="stats-label text-muted">TOTAL DOCTORS</div>
                        <div class="stats-number text-primary"><%= (totalDoctors != null) ? totalDoctors : 0 %></div>
                        <p class="text-muted mb-3">Registered medical professionals</p>
                        <a href="ManageDoctorsServlet" class="stats-link text-primary">
                            Manage Doctors <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Patients Card -->
            <div class="col-lg-4 col-md-6">
                <div class="stats-card stats-card-patient">
                    <div class="stats-card-body">
                        <div class="stats-icon" style="background: rgba(40, 167, 69, 0.1); color: #28a745;">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stats-label text-muted">TOTAL PATIENTS</div>
                        <div class="stats-number text-success"><%= (totalPatients != null) ? totalPatients : 0 %></div>
                        <p class="text-muted mb-3">Active patient records</p>
                        <a href="ManagePatientsServlet" class="stats-link text-success">
                            View Registry <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Appointments Card -->
            <div class="col-lg-4 col-md-6">
                <div class="stats-card stats-card-appointment">
                    <div class="stats-card-body">
                        <div class="stats-icon" style="background: rgba(253, 126, 20, 0.1); color: #fd7e14;">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div class="stats-label text-muted">APPOINTMENTS</div>
                        <div class="stats-number text-warning"><%= (totalAppointments != null) ? totalAppointments : 0 %></div>
                        <p class="text-muted mb-3">Scheduled consultations</p>
                        <a href="ViewAllAppointmentsServlet" class="stats-link text-warning">
                            Manage Bookings <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Actions Section -->
        <div class="actions-section">
            <h3 class="actions-title">
                <i class="fas fa-bolt"></i> Quick Management Actions
            </h3>
            
            <div class="row g-4">
                <div class="col-lg-3 col-md-6">
                    <a href="ManageDoctorsServlet" class="action-btn">
                        <div class="action-icon" style="background: rgba(26, 115, 232, 0.1); color: #1a73e8;">
                            <i class="fas fa-user-md fa-2x"></i>
                        </div>
                        <h5 class="action-title">Manage Doctors</h5>
                        <p class="action-desc">Add, edit, or deactivate medical staff members</p>
                    </a>
                </div>
                
                <div class="col-lg-3 col-md-6">
                    <a href="ManagePatientsServlet" class="action-btn">
                        <div class="action-icon" style="background: rgba(40, 167, 69, 0.1); color: #28a745;">
                            <i class="fas fa-user-injured fa-2x"></i>
                        </div>
                        <h5 class="action-title">Manage Patients</h5>
                        <p class="action-desc">View and manage patient records and history</p>
                    </a>
                </div>
                
                <div class="col-lg-3 col-md-6">
                    <a href="ViewAllAppointmentsServlet" class="action-btn">
                        <div class="action-icon" style="background: rgba(111, 66, 193, 0.1); color: #6f42c1;">
                            <i class="fas fa-calendar-alt fa-2x"></i>
                        </div>
                        <h5 class="action-title">Appointments</h5>
                        <p class="action-desc">Schedule and manage patient consultations</p>
                    </a>
                </div>
                
                <div class="col-lg-3 col-md-6">
                    <a href="adminProfile.jsp" class="action-btn">
                        <div class="action-icon" style="background: rgba(23, 162, 184, 0.1); color: #17a2b8;">
                            <i class="fas fa-cogs fa-2x"></i>
                        </div>
                        <h5 class="action-title">System Settings</h5>
                        <p class="action-desc">Configure admin account and system preferences</p>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="medical-footer">
        <div class="container text-center">
            <p class="mb-2">
                <i class="fas fa-shield-alt me-2"></i>
                <strong>Secure Medical Admin Portal</strong>
            </p>
            <small>&copy; 2025 Medical Booking System | HIPAA Compliant | v2.1.0</small>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Add smooth loading animation for cards
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.stats-card, .action-btn');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });
    </script>
</body>
</html>