<%@ page import="java.util.List" %>
<%@ page import="model.Appointment" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Master Appointment List | Medical Booking System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e8f4ff 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px;
        }
        
        .appointment-container {
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
        
        .header-info {
            color: #6c757d;
            font-size: 1.1rem;
            margin-left: 45px;
        }
        
        .appointments-table {
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
            transform: translateX(3px);
        }
        
        .patient-name, .doctor-name {
            font-weight: 600;
            color: #2c3e50;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .patient-name i {
            color: #1a73e8;
        }
        
        .doctor-name i {
            color: #28a745;
        }
        
        .appointment-date {
            font-weight: 500;
            color: #2c3e50;
        }
        
        .appointment-time {
            color: #6c757d;
            font-size: 0.9rem;
        }
        
        .status-badge {
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.85rem;
            display: inline-block;
            min-width: 100px;
            text-align: center;
        }
        
        .status-confirmed {
            background-color: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }
        
        .status-pending {
            background-color: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }
        
        .status-completed {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .status-rejected {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .status-cancelled {
            background-color: #e2e3e5;
            color: #383d41;
            border: 1px solid #d6d8db;
        }
        
        .btn-back {
            background: white;
            color: #1a73e8;
            border: 2px solid #1a73e8;
            padding: 12px 28px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }
        
        .btn-back:hover {
            background: #e8f4ff;
            color: #1a73e8;
            transform: translateY(-2px);
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
        
        .stats-summary {
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
        }
        
        .stat-total .stat-icon {
            background: linear-gradient(135deg, #1a73e8, #2a8bf2);
        }
        
        .stat-confirmed .stat-icon {
            background: linear-gradient(135deg, #28a745, #20c997);
        }
        
        .stat-pending .stat-icon {
            background: linear-gradient(135deg, #ffc107, #ffce3a);
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
        
        @media (max-width: 768px) {
            .appointment-container {
                margin: 1rem auto;
                padding: 0 10px;
            }
            
            .page-header {
                padding: 1.5rem;
            }
            
            .page-header h2 {
                font-size: 1.5rem;
            }
            
            .header-info {
                margin-left: 0;
            }
            
            thead th, tbody td {
                padding: 0.8rem;
                font-size: 0.9rem;
            }
            
            .stats-summary {
                flex-direction: column;
                gap: 1rem;
            }
        }
        
        .table-responsive {
            overflow-x: auto;
        }
    </style>
</head>
<body>
    <div class="appointment-container">
        <!-- Page Header -->
        <div class="page-header">
            <h2>
                <i class="fas fa-calendar-check"></i> Master Appointment List
            </h2>
            <div class="header-info">Comprehensive view of all hospital appointments across departments</div>
        </div>
        
        <!-- Statistics Summary -->
        <% 
            List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
            if (appointments == null) {
                appointments = new ArrayList<Appointment>();
            }
            
            int totalAppointments = appointments.size();
            int confirmedCount = 0;
            int pendingCount = 0;
            
            for (Appointment a : appointments) {
                if ("CONFIRMED".equalsIgnoreCase(a.getStatus())) {
                    confirmedCount++;
                } else if ("PENDING".equalsIgnoreCase(a.getStatus())) {
                    pendingCount++;
                }
            }
        %>
        
        <div class="stats-summary">
            <div class="stat-item stat-total">
                <div class="stat-icon">
                    <i class="fas fa-calendar-alt"></i>
                </div>
                <div>
                    <div class="stat-number"><%= totalAppointments %></div>
                    <div class="stat-label">Total Appointments</div>
                </div>
            </div>
            
            <div class="stat-item stat-confirmed">
                <div class="stat-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div>
                    <div class="stat-number"><%= confirmedCount %></div>
                    <div class="stat-label">Confirmed</div>
                </div>
            </div>
            
            <div class="stat-item stat-pending">
                <div class="stat-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div>
                    <div class="stat-number"><%= pendingCount %></div>
                    <div class="stat-label">Pending</div>
                </div>
            </div>
        </div>
        
        <!-- Appointments Table -->
        <div class="appointments-table">
            <div class="table-header">
                <h3>
                    <i class="fas fa-hospital"></i> Hospital Appointment Overview
                </h3>
            </div>
            
            <% if (appointments.isEmpty()) { %>
                <div class="empty-state">
                    <i class="far fa-calendar-times"></i>
                    <h4>No Appointments Found</h4>
                    <p>There are currently no appointments scheduled in the system.</p>
                </div>
            <% } else { %>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th><i class="fas fa-calendar-day me-2"></i>Date</th>
                                <th><i class="fas fa-clock me-2"></i>Time</th>
                                <th><i class="fas fa-user-injured me-2"></i>Patient</th>
                                <th><i class="fas fa-user-md me-2"></i>Doctor</th>
                                <th><i class="fas fa-info-circle me-2"></i>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Appointment a : appointments) { 
                                String statusClass = "";
                                switch(a.getStatus().toUpperCase()) {
                                    case "CONFIRMED": statusClass = "status-confirmed"; break;
                                    case "PENDING": statusClass = "status-pending"; break;
                                    case "COMPLETED": statusClass = "status-completed"; break;
                                    case "REJECTED": statusClass = "status-rejected"; break;
                                    case "CANCELLED": statusClass = "status-cancelled"; break;
                                    default: statusClass = "status-pending";
                                }
                            %>
                                <tr>
                                    <td>
                                        <div class="appointment-date">
                                            <%= a.getAppointmentDate() %>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="appointment-time">
                                            <i class="far fa-clock me-1"></i> <%= a.getTimeSlot() %>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="patient-name">
                                            <i class="fas fa-user"></i> <%= a.getPatientName() %>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="doctor-name">
                                            <i class="fas fa-user-md"></i> Dr. <%= a.getDoctorName() %>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="status-badge <%= statusClass %>">
                                            <%= a.getStatus() %>
                                        </span>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
        </div>
        
        <!-- Back Button -->
        <div class="text-center">
            <a href="AdminDashboardServlet" class="btn btn-back">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
        
        <!-- Footer Note -->
        <div class="text-center mt-4" style="color: #6c757d; font-size: 0.9rem;">
            <i class="fas fa-shield-alt me-2"></i>
            Master View | Medical Booking System | Updated in real-time
        </div>
    </div>

    <script>
        // Purely cosmetic animations
        document.addEventListener('DOMContentLoaded', function() {
            // Add staggered animation to table rows
            const tableRows = document.querySelectorAll('tbody tr');
            tableRows.forEach((row, index) => {
                row.style.opacity = '0';
                row.style.transform = 'translateX(20px)';
                
                setTimeout(() => {
                    row.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                    row.style.opacity = '1';
                    row.style.transform = 'translateX(0)';
                }, index * 50);
            });
            
            // Add hover effect to table rows
            tableRows.forEach(row => {
                row.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateX(5px)';
                });
                
                row.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateX(0)';
                });
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
        });
    </script>
</body>
</html>