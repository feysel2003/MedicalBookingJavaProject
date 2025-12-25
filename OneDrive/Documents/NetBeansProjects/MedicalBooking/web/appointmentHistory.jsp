<%@ page import="java.util.List" %>
<%@ page import="model.Appointment" %>
<%@ page import="dao.AppointmentDAO" %>
<%@ page import="model.Patient" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page session="true" %>

<%
    Patient patient = (Patient) session.getAttribute("currentPatient");
    if (patient == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    AppointmentDAO dao = new AppointmentDAO();
    List<Appointment> appointments = dao.getAppointmentsByPatient(patient.getId());
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointment History | Medical Booking System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e8f4ff 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px;
        }
        
        .history-container {
            max-width: 1200px;
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
        
        .page-header p {
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
            transform: translateX(5px);
        }
        
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.85rem;
            display: inline-block;
        }
        
        .status-pending {
            background-color: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }
        
        .status-confirmed {
            background-color: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }
        
        .status-completed {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
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
        
        .appointment-date {
            font-weight: 500;
            color: #2c3e50;
        }
        
        .appointment-time {
            color: #6c757d;
            font-size: 0.9rem;
        }
        
        .symptoms {
            max-width: 200px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        
        .action-buttons {
            display: flex;
            gap: 10px;
        }
        
        .btn-cancel {
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
        
        .btn-cancel:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(220, 53, 69, 0.2);
            color: white;
        }
        
        .btn-reschedule {
            background: linear-gradient(to right, #ffc107, #ffce3a);
            color: #212529;
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
        
        .btn-reschedule:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 193, 7, 0.2);
            color: #212529;
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
        
        @media (max-width: 768px) {
            .history-container {
                margin: 1rem auto;
                padding: 0 10px;
            }
            
            .page-header {
                padding: 1.5rem;
            }
            
            .page-header h2 {
                font-size: 1.5rem;
            }
            
            .page-header p {
                margin-left: 0;
            }
            
            thead th, tbody td {
                padding: 0.8rem;
                font-size: 0.9rem;
            }
            
            .action-buttons {
                flex-direction: column;
                gap: 5px;
            }
            
            .btn-cancel, .btn-reschedule {
                width: 100%;
                justify-content: center;
                font-size: 0.8rem;
                padding: 6px 12px;
            }
        }
        
        .patient-info {
            background: #e8f4ff;
            padding: 1rem 1.5rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 15px;
            color: #2c3e50;
        }
        
        .patient-info i {
            color: #1a73e8;
            font-size: 1.2rem;
        }
        
        .patient-name {
            font-weight: 600;
        }
        
        .patient-id {
            color: #6c757d;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="history-container">
        <!-- Page Header -->
        <div class="page-header">
            <h2>
                <i class="fas fa-calendar-check"></i> Your Medical Appointments
            </h2>
            <p>View, manage, and track all your scheduled medical appointments</p>
        </div>
        
        <!-- Patient Information -->
        <div class="patient-info">
            <i class="fas fa-user-injured"></i>
            <div>
                <span class="patient-name">Patient: <%= patient.getFullName() %></span>
                <span class="patient-id ms-3">ID: PAT-<%= patient.getId() %></span>
            </div>
        </div>
        
        <!-- Appointments Table -->
        <div class="appointments-table">
            <div class="table-header">
                <h3>
                    <i class="fas fa-history"></i> Appointment History
                </h3>
            </div>
            
            <% if (appointments.isEmpty()) { %>
                <div class="empty-state">
                    <i class="far fa-calendar-times"></i>
                    <h4>No Appointments Found</h4>
                    <p>You haven't booked any appointments yet.</p>
                    <a href="BookAppointmentServlet" class="btn btn-back mt-3">
                        <i class="fas fa-plus-circle"></i> Book Your First Appointment
                    </a>
                </div>
            <% } else { %>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th><i class="fas fa-user-md me-2"></i>Doctor</th>
                                <th><i class="fas fa-calendar-day me-2"></i>Date</th>
                                <th><i class="fas fa-clock me-2"></i>Time</th>
                                <th><i class="fas fa-stethoscope me-2"></i>Symptoms</th>
                                <th><i class="fas fa-info-circle me-2"></i>Status</th>
                                <th><i class="fas fa-cogs me-2"></i>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Appointment a : appointments) { 
                                String statusClass = "";
                                switch(a.getStatus().toUpperCase()) {
                                    case "PENDING": statusClass = "status-pending"; break;
                                    case "CONFIRMED": statusClass = "status-confirmed"; break;
                                    case "COMPLETED": statusClass = "status-completed"; break;
                                    case "CANCELLED": statusClass = "status-cancelled"; break;
                                    default: statusClass = "status-pending";
                                }
                            %>
                                <tr>
                                    <td>
                                        <div class="doctor-name">
                                            <i class="fas fa-user-md"></i> <%= a.getDoctorName() %>
                                        </div>
                                    </td>
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
                                    <td class="symptoms" title="<%= a.getSymptoms() %>">
                                        <%= a.getSymptoms() %>
                                    </td>
                                    <td>
                                        <span class="status-badge <%= statusClass %>">
                                            <%= a.getStatus() %>
                                        </span>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <% if(a.getStatus().equals("PENDING") || a.getStatus().equals("CONFIRMED")) { %>
                                                <a href="CancelAppointmentServlet?id=<%=a.getId()%>" class="btn-cancel" 
                                                   onclick="return confirm('Are you sure you want to cancel this appointment?')">
                                                    <i class="fas fa-times-circle"></i> Cancel
                                                </a>
                                                <a href="RescheduleAppointmentServlet?id=<%=a.getId()%>" class="btn-reschedule">
                                                    <i class="fas fa-calendar-alt"></i> Reschedule
                                                </a>
                                            <% } else { %>
                                                <span class="text-muted" style="font-size: 0.9rem;">
                                                    <i class="fas fa-ban"></i> No actions available
                                                </span>
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
        
        <!-- Back Button -->
        <div class="text-center">
            <a href="patientDashboard.jsp" class="btn btn-back">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
        
        <!-- Footer Note -->
        <div class="text-center mt-4" style="color: #6c757d; font-size: 0.9rem;">
            <i class="fas fa-info-circle me-2"></i>
            Need help? Contact support at support@medicalbooking.com
        </div>
    </div>

    <script>
        // Add confirmation for cancellation
        document.addEventListener('DOMContentLoaded', function() {
            const cancelButtons = document.querySelectorAll('.btn-cancel');
            cancelButtons.forEach(button => {
                button.addEventListener('click', function(e) {
                    if (!confirm('Are you sure you want to cancel this appointment?\nThis action cannot be undone.')) {
                        e.preventDefault();
                    }
                });
            });
            
            // Add hover effect to table rows
            const tableRows = document.querySelectorAll('tbody tr');
            tableRows.forEach(row => {
                row.addEventListener('mouseenter', function() {
                    this.style.transition = 'all 0.3s ease';
                });
            });
        });
    </script>
</body>
</html>