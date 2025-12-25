<%@ page import="java.util.List" %>
<%@ page import="model.Doctor" %>
<%@ page import="model.Admin" %>
<%@ page import="java.util.ArrayList" %>
<%@ page session="true" %>
<%
    Admin admin = (Admin) session.getAttribute("currentAdmin");
    if (admin == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    List<Doctor> doctors = (List<Doctor>) request.getAttribute("doctors");
    if (doctors == null) {
        doctors = new ArrayList<Doctor>();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Doctors | Medical Booking System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e8f4ff 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px;
        }
        
        .manage-container {
            max-width: 1400px;
            margin: 2rem auto;
            padding: 0 15px;
        }
        
        .page-header {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 5px 15px rgba(0, 115, 230, 0.08);
            border-left: 5px solid #1a73e8;
        }
        
        .page-header h2 {
            color: #1a73e8;
            font-weight: 700;
            margin-bottom: 5px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .page-header h2 i {
            font-size: 1.8rem;
            background: rgba(26, 115, 232, 0.1);
            padding: 12px;
            border-radius: 12px;
        }
        
        .header-subtitle {
            color: #6c757d;
            font-size: 1.1rem;
            margin-left: 45px;
        }
        
        .action-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 15px;
        }
        
        .btn-add-doctor {
            background: linear-gradient(to right, #28a745, #20c997);
            color: white;
            border: none;
            padding: 12px 28px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }
        
        .btn-add-doctor:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(40, 167, 69, 0.3);
            color: white;
        }
        
        .btn-back-dashboard {
            background: white;
            color: #1a73e8;
            border: 2px solid #1a73e8;
            padding: 10px 25px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }
        
        .btn-back-dashboard:hover {
            background: #e8f4ff;
            color: #1a73e8;
            transform: translateY(-2px);
        }
        
        .doctors-table {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 115, 230, 0.08);
            overflow: hidden;
            margin-bottom: 2rem;
        }
        
        .table-header {
            background: linear-gradient(to right, #1a73e8, #2a8bf2);
            color: white;
            padding: 1.5rem;
        }
        
        .table-header h3 {
            margin: 0;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        table {
            margin: 0;
            border-collapse: separate;
            border-spacing: 0;
        }
        
        thead th {
            background: #e8f4ff;
            color: #1a73e8;
            font-weight: 600;
            padding: 1rem 1.5rem;
            border-bottom: 2px solid #dee2e6;
            border-top: none;
        }
        
        tbody td {
            padding: 1.2rem 1.5rem;
            vertical-align: middle;
            border-bottom: 1px solid #e9ecef;
        }
        
        tbody tr {
            transition: all 0.3s ease;
        }
        
        tbody tr:hover {
            background-color: #f8f9fa;
        }
        
        .doctor-id {
            font-weight: 600;
            color: #6c757d;
        }
        
        .doctor-name {
            font-weight: 600;
            color: #2c3e50;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .doctor-name i {
            color: #1a73e8;
        }
        
        .doctor-email {
            color: #6c757d;
            font-size: 0.95rem;
        }
        
        .doctor-specialization {
            background: #e8f4ff;
            color: #1a73e8;
            padding: 6px 12px;
            border-radius: 15px;
            font-weight: 500;
            font-size: 0.85rem;
            display: inline-block;
        }
        
        .doctor-phone {
            color: #2c3e50;
            font-weight: 500;
        }
        
        .status-badge {
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.85rem;
            display: inline-block;
            min-width: 80px;
            text-align: center;
        }
        
        .status-active {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .status-inactive {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .action-buttons {
            display: flex;
            gap: 8px;
        }
        
        .btn-deactivate {
            background: linear-gradient(to right, #dc3545, #e4606d);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 0.85rem;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            text-decoration: none;
        }
        
        .btn-deactivate:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(220, 53, 69, 0.2);
            color: white;
        }
        
        .btn-activate {
            background: linear-gradient(to right, #28a745, #20c997);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 0.85rem;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            text-decoration: none;
        }
        
        .btn-activate:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.2);
            color: white;
        }
        
        .medical-alert {
            background: #d1ecf1;
            border: 2px solid #bee5eb;
            border-radius: 10px;
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            color: #0c5460;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: fadeIn 0.5s ease;
        }
        
        .medical-alert i {
            font-size: 1.2rem;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #6c757d;
        }
        
        .empty-state i {
            font-size: 4rem;
            color: #e8f4ff;
            margin-bottom: 1rem;
        }
        
        .empty-state h4 {
            color: #1a73e8;
            margin-bottom: 10px;
        }
        
        .empty-state .btn-add-doctor {
            margin-top: 1rem;
        }
        
        @media (max-width: 768px) {
            .manage-container {
                margin: 1rem auto;
                padding: 0 10px;
            }
            
            .page-header {
                padding: 1.5rem;
            }
            
            .page-header h2 {
                font-size: 1.5rem;
            }
            
            .header-subtitle {
                margin-left: 0;
            }
            
            .action-bar {
                flex-direction: column;
                align-items: stretch;
            }
            
            .btn-add-doctor, .btn-back-dashboard {
                width: 100%;
                justify-content: center;
            }
            
            thead th, tbody td {
                padding: 0.8rem;
                font-size: 0.9rem;
            }
            
            .action-buttons {
                flex-direction: column;
                gap: 5px;
            }
            
            .btn-deactivate, .btn-activate {
                width: 100%;
                justify-content: center;
                font-size: 0.8rem;
                padding: 6px 12px;
            }
        }
        
        .table-responsive {
            overflow-x: auto;
        }
        
        .doctor-stats {
            background: #e8f4ff;
            padding: 1.5rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            display: flex;
            gap: 2rem;
            flex-wrap: wrap;
        }
        
        .stat-item {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #2c3e50;
        }
        
        .stat-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            background: linear-gradient(135deg, #1a73e8, #2a8bf2);
        }
        
        .stat-number {
            font-weight: 700;
            font-size: 1.5rem;
            line-height: 1;
        }
        
        .stat-label {
            font-size: 0.9rem;
            color: #6c757d;
        }
    </style>
</head>
<body>
    <div class="manage-container">
        <div class="page-header">
            <h2>
                <i class="fas fa-user-md"></i> Manage Doctors
            </h2>
            <div class="header-subtitle">Administer medical staff and specialist information</div>
        </div>
        
        <%
            String message = (String) session.getAttribute("message");
            if (message != null) {
        %>
            <div class="medical-alert alert-dismissible fade show">
                <i class="fas fa-info-circle"></i>
                <span><%= message %></span>
                <button type="button" class="btn-close" data-bs-dismiss="alert" style="margin-left: auto;"></button>
            </div>
        <%
                session.removeAttribute("message");
            }
        %>
        
        <div class="action-bar">
            <a href="AddDoctor.jsp" class="btn btn-add-doctor">
                <i class="fas fa-user-plus"></i> Add New Doctor
            </a>
            <a href="adminDashboard.jsp" class="btn btn-back-dashboard">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
        
        <% 
            int totalDoctors = doctors.size();
            int activeDoctors = 0;
            int inactiveDoctors = 0;
            
            for (Doctor d : doctors) {
                if (d.isActive()) {
                    activeDoctors++;
                } else {
                    inactiveDoctors++;
                }
            }
        %>
        
        <div class="doctor-stats">
            <div class="stat-item">
                <div class="stat-icon">
                    <i class="fas fa-user-md"></i>
                </div>
                <div>
                    <div class="stat-number"><%= totalDoctors %></div>
                    <div class="stat-label">Total Doctors</div>
                </div>
            </div>
            
            <div class="stat-item">
                <div class="stat-icon" style="background: linear-gradient(135deg, #28a745, #20c997);">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div>
                    <div class="stat-number"><%= activeDoctors %></div>
                    <div class="stat-label">Active</div>
                </div>
            </div>
            
            <div class="stat-item">
                <div class="stat-icon" style="background: linear-gradient(135deg, #dc3545, #e4606d);">
                    <i class="fas fa-ban"></i>
                </div>
                <div>
                    <div class="stat-number"><%= inactiveDoctors %></div>
                    <div class="stat-label">Inactive</div>
                </div>
            </div>
        </div>
        
        <div class="doctors-table">
            <div class="table-header">
                <h3>
                    <i class="fas fa-list-alt"></i> Medical Staff Directory
                </h3>
            </div>
            
            <% if (doctors.isEmpty()) { %>
                <div class="empty-state">
                    <i class="fas fa-user-md"></i>
                    <h4>No Doctors Found</h4>
                    <p>There are currently no doctors registered in the system.</p>
                    <a href="AddDoctor.jsp" class="btn btn-add-doctor">
                        <i class="fas fa-user-plus"></i> Add Your First Doctor
                    </a>
                </div>
            <% } else { %>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th><i class="fas fa-id-card me-2"></i>ID</th>
                                <th><i class="fas fa-user me-2"></i>Full Name</th>
                                <th><i class="fas fa-envelope me-2"></i>Email</th>
                                <th><i class="fas fa-stethoscope me-2"></i>Specialization</th>
                                <th><i class="fas fa-phone me-2"></i>Phone</th>
                                <th><i class="fas fa-info-circle me-2"></i>Status</th>
                                <th><i class="fas fa-cogs me-2"></i>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Doctor d : doctors) { %>
                                <tr>
                                    <td>
                                        <span class="doctor-id">DOC-<%= d.getId() %></span>
                                    </td>
                                    <td>
                                        <div class="doctor-name">
                                            <i class="fas fa-user-md"></i> Dr. <%= d.getFullName() %>
                                        </div>
                                    </td>
                                    <td class="doctor-email">
                                        <i class="fas fa-envelope me-1"></i> <%= d.getEmail() %>
                                    </td>
                                    <td>
                                        <span class="doctor-specialization">
                                            <%= d.getSpecialization() %>
                                        </span>
                                    </td>
                                    <td class="doctor-phone">
                                        <i class="fas fa-phone me-1"></i> <%= d.getPhone() %>
                                    </td>
                                    <td>
                                        <% if (d.isActive()) { %>
                                            <span class="status-badge status-active">
                                                <i class="fas fa-check-circle me-1"></i> Active
                                            </span>
                                        <% } else { %>
                                            <span class="status-badge status-inactive">
                                                <i class="fas fa-ban me-1"></i> Inactive
                                            </span>
                                        <% } %>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <% if (d.isActive()) { %>
                                                <a href="ToggleDoctorStatusServlet?id=<%=d.getId()%>&action=deactivate" 
                                                   class="btn-deactivate"
                                                   onclick="return confirm('Are you sure you want to deactivate Dr. <%= d.getFullName() %>? This will prevent them from receiving new appointments.')">
                                                     <i class="fas fa-user-slash"></i> Deactivate
                                                </a>
                                            <% } else { %>
                                                <a href="ToggleDoctorStatusServlet?id=<%=d.getId()%>&action=activate" 
                                                   class="btn-activate"
                                                   onclick="return confirm('Activate Dr. <%= d.getFullName() %>? They will be able to receive appointments again.')">
                                                     <i class="fas fa-user-check"></i> Activate
                                                </a>
                                            <% } %>
                                        </div>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
        </div>
        
        <div class="text-center mt-4" style="color: #6c757d; font-size: 0.9rem;">
            <i class="fas fa-shield-alt me-2"></i>
            Medical Staff Management | HIPAA Compliant Data Handling
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Purely cosmetic animations
        document.addEventListener('DOMContentLoaded', function() {
            // Add staggered animation to table rows
            const tableRows = document.querySelectorAll('tbody tr');
            tableRows.forEach((row, index) => {
                row.style.opacity = '0';
                row.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    row.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                    row.style.opacity = '1';
                    row.style.transform = 'translateY(0)';
                }, index * 50);
            });
            
            // Update statistics animation
            const statNumbers = document.querySelectorAll('.stat-number');
            statNumbers.forEach(stat => {
                const originalNumber = parseInt(stat.textContent);
                let currentNumber = 0;
                const increment = Math.ceil(originalNumber / 20);
                const interval = setInterval(() => {
                    currentNumber += increment;
                    if (currentNumber >= originalNumber) {
                        currentNumber = originalNumber;
                        clearInterval(interval);
                    }
                    stat.textContent = currentNumber;
                }, 50);
            });
            
            // Add confirmation for deactivation
            const deactivateButtons = document.querySelectorAll('.btn-deactivate');
            deactivateButtons.forEach(button => {
                button.addEventListener('click', function(e) {
                    if (!confirm('Are you sure you want to deactivate this doctor?\nThey will no longer receive new appointments.')) {
                        e.preventDefault();
                    }
                });
            });
        });
    </script>
</body>
</html>