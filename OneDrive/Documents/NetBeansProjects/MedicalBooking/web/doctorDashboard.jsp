<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Appointment, model.Doctor" %>

<%
    Doctor doc = (Doctor) session.getAttribute("currentDoctor");
    
    if (doc == null) { 
        response.sendRedirect("doctorLogin.jsp"); 
        return; 
    }
    
    if ("doc123".equals(doc.getPassword())) {
        session.setAttribute("errorMsg", "Access Denied: Please change your default password first.");
        response.sendRedirect("changePassword.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Doctor Panel | <%= doc.getFullName() %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .navbar-brand { font-weight: bold; }
        .card { border-radius: 12px; }
        .badge { font-weight: 500; }
        .dropdown-menu { border-radius: 10px; }
    </style>
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm mb-4">
    <div class="container">
        <span class="navbar-brand"><i class="fas fa-user-md me-2"></i>Doctor Portal</span>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#doctorMenu" aria-controls="doctorMenu" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="doctorMenu">
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-white" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-user-circle me-1"></i> <%= doc.getFullName() %>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow border-0" aria-labelledby="navbarDropdown">
                        <li>
                            <a class="dropdown-item" href="changePassword.jsp">
                                <i class="fas fa-key me-2 text-primary"></i> Change Password
                            </a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <a class="dropdown-item text-danger" href="LogoutServlet">
                                <i class="fas fa-sign-out-alt me-2"></i> Logout
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    
    <% String succMsg = (String) session.getAttribute("succMsg");
       if (succMsg != null) { %>
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="fas fa-check-circle me-2"></i> <%= succMsg %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% session.removeAttribute("succMsg"); } %>

    <div class="row">
        <div class="col-md-12">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 text-primary"><i class="fas fa-calendar-check me-2"></i>My Appointment Requests</h5>
                    <span class="text-muted small">Real-time Patient Queue</span>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Patient Name</th>
                                    <th>Date</th>
                                    <th>Time Slot</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
        <%
            List<Appointment> apps = (List<Appointment>) request.getAttribute("appointments");
            if (apps != null && !apps.isEmpty()) {
                for (Appointment a : apps) {
        %>
        <tr>
            <td><strong><%= a.getPatientName() %></strong></td>
            <td><%= a.getAppointmentDate() %></td>
            <td><span class="badge bg-light text-dark border"><%= a.getTimeSlot() %></span></td>
            <td>
                <% if(a.getStatus().equals("PENDING")) { %>
                    <span class="badge bg-warning text-dark">Pending</span>
                <% } else if(a.getStatus().equals("CONFIRMED")) { %>
                    <span class="badge bg-success">Confirmed</span>
                <% } else { %>
                    <span class="badge bg-danger text-uppercase"><%= a.getStatus() %></span>
                <% } %>
            </td>
            <td>
                <div class="btn-group">
                    <a href="UpdateAppointmentStatusServlet?id=<%= a.getId() %>&status=CONFIRMED" 
                       class="btn btn-sm btn-outline-success">
                       <i class="fas fa-check"></i> Accept
                    </a>
                    <a href="UpdateAppointmentStatusServlet?id=<%= a.getId() %>&status=REJECTED" 
                       class="btn btn-sm btn-outline-danger">
                       <i class="fas fa-times"></i> Reject
                    </a>
                </div>
            </td>
        </tr>
        <% 
                } 
            } else { 
        %>
            <tr>
                <td colspan="5" class="text-center text-muted py-5">
                    <i class="fas fa-folder-open fa-3x mb-3 d-block"></i>
                    No appointments assigned to you.
                </td>
            </tr>
        <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>