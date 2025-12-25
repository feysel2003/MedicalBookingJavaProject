<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password | Medical System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e8f4ff 100%);
            min-height: 100vh;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            border: none;
        }
        .card-header {
            border-radius: 15px 15px 0 0 !important;
            padding: 1.2rem;
        }
    </style>
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card mx-auto" style="max-width: 450px;">
        <div class="card-header bg-primary text-white text-center">
            <h4 class="mb-0"><i class="fas fa-key me-2"></i>Secure Your Account</h4>
        </div>
        <div class="card-body p-4">

            <%
                String errorMsg = (String) session.getAttribute("errorMsg");
                if (errorMsg != null) { 
            %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i> <%= errorMsg %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% 
                session.removeAttribute("errorMsg"); 
                } 
            %>

            <%
                String succMsg = (String) session.getAttribute("succMsg");
                if (succMsg != null) { 
            %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i> <%= succMsg %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% 
                session.removeAttribute("succMsg"); 
                } 
            %>
            <form action="UpdatePasswordServlet" method="post">
                <div class="mb-3">
                    <label class="form-label font-weight-bold">Current (Default) Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock-open"></i></span>
                        <input type="password" name="currentPassword" class="form-control" placeholder="Enter current password" required>
                    </div>
                </div>
                
                <hr class="my-4">
                
                <div class="mb-3">
                    <label class="form-label">New Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password" name="newPassword" class="form-control" placeholder="Enter new password" required>
                    </div>
                </div>
                
                <div class="mb-4">
                    <label class="form-label">Confirm New Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-shield-alt"></i></span>
                        <input type="password" name="confirmPassword" class="form-control" placeholder="Repeat new password" required>
                    </div>
                </div>
                
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-success btn-lg">
                        <i class="fas fa-save me-2"></i>Update Password
                    </button>
                    <a href="doctorDashboard.jsp" class="btn btn-light border">Cancel</a>
                </div>
            </form>
        </div>
    </div>
    
    <div class="text-center mt-4 text-muted">
        <small><i class="fas fa-info-circle me-1"></i> Changing your password helps keep patient data secure.</small>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>