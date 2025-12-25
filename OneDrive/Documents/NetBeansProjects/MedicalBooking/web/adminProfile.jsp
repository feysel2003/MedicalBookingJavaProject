<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Admin" %>
<%@ page session="true" %>
<%
    // Security Check: Ensure only logged-in Admin can access this page
    Admin admin = (Admin) session.getAttribute("currentAdmin");
    if (admin == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Profile | Medical Booking System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e8f4ff 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px;
        }
        
        .profile-container {
            max-width: 500px;
            margin: 2rem auto;
        }
        
        .medical-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 115, 230, 0.08);
            border: none;
            overflow: hidden;
            border-top: 5px solid #1a73e8;
        }
        
        .profile-header {
            background: linear-gradient(to right, #1a73e8, #2a8bf2);
            color: white;
            padding: 1.8rem 2rem;
            text-align: center;
        }
        
        .profile-header h4 {
            margin: 0;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }
        
        .profile-header h4 i {
            font-size: 1.8rem;
            background: rgba(255, 255, 255, 0.2);
            padding: 12px;
            border-radius: 12px;
        }
        
        .profile-body {
            padding: 2.5rem;
        }
        
        .admin-info {
            text-align: center;
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid #e9ecef;
        }
        
        .admin-avatar {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #1a73e8, #2a8bf2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem auto;
            color: white;
            font-size: 2rem;
        }
        
        .admin-email {
            background: #e8f4ff;
            padding: 10px 20px;
            border-radius: 25px;
            display: inline-block;
            margin-top: 10px;
            color: #1a73e8;
            font-weight: 600;
        }
        
        .section-title {
            color: #1a73e8;
            font-weight: 700;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1.2rem;
        }
        
        .section-title i {
            font-size: 1.4rem;
        }
        
        .form-label {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .form-label i {
            color: #1a73e8;
            font-size: 1rem;
        }
        
        .input-group {
            margin-bottom: 1.5rem;
        }
        
        .input-group-text {
            background-color: #e8f4ff;
            border: 2px solid #e1e8ed;
            border-right: none;
            color: #1a73e8;
            padding: 12px 15px;
        }
        
        .form-control {
            padding: 12px 15px;
            border: 2px solid #e1e8ed;
            border-left: none;
            border-radius: 0 8px 8px 0;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: #1a73e8;
            box-shadow: 0 0 0 3px rgba(26, 115, 232, 0.1);
        }
        
        .password-toggle {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #6c757d;
            cursor: pointer;
            z-index: 10;
        }
        
        .btn-update {
            background: linear-gradient(to right, #1a73e8, #2a8bf2);
            color: white;
            border: none;
            padding: 14px 30px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-top: 1.5rem;
        }
        
        .btn-update:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(26, 115, 232, 0.3);
            color: white;
        }
        
        .btn-back {
            background: white;
            color: #1a73e8;
            border: 2px solid #1a73e8;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-top: 1rem;
            text-decoration: none;
        }
        
        .btn-back:hover {
            background: #e8f4ff;
            color: #1a73e8;
            transform: translateY(-2px);
        }
        
        .medical-alert {
            background: #ffe6e6;
            border: 2px solid #ffcccc;
            border-radius: 10px;
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            color: #dc3545;
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
        
        .security-note {
            text-align: center;
            color: #6c757d;
            font-size: 0.9rem;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid #e9ecef;
        }
        
        .security-note i {
            color: #1a73e8;
            margin-right: 8px;
        }
        
        @media (max-width: 768px) {
            .profile-container {
                margin: 1rem auto;
            }
            
            .profile-header {
                padding: 1.5rem;
            }
            
            .profile-body {
                padding: 1.8rem;
            }
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <div class="medical-card">
            <div class="profile-header">
                <h4>
                    <i class="fas fa-user-shield"></i> Admin Profile Settings
                </h4>
            </div>
            
            <div class="profile-body">
                <!-- Admin Information -->
                <div class="admin-info">
                    <div class="admin-avatar">
                        <i class="fas fa-user-md"></i>
                    </div>
                    <h5 class="mb-2">System Administrator</h5>
                    <div class="admin-email">
                        <i class="fas fa-envelope me-2"></i><%= admin.getEmail() %>
                    </div>
                </div>
                
                <!-- Error Message -->
                <% 
                    String error = (String) session.getAttribute("error");
                    if (error != null) { 
                %>
                    <div class="medical-alert">
                        <i class="fas fa-exclamation-triangle"></i>
                        <span><%= error %></span>
                    </div>
                <% 
                        session.removeAttribute("error");
                    } 
                %>
                
                <!-- Password Update Form -->
                <form action="UpdateAdminProfileServlet" method="post" id="updateForm">
                    <div class="section-title">
                        <i class="fas fa-key"></i> Change Password
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-lock"></i> New Password
                        </label>
                        <div class="input-group" style="position: relative;">
                            <span class="input-group-text">
                                <i class="fas fa-lock"></i>
                            </span>
                            <input type="password" name="newPassword" id="newPassword" class="form-control" 
                                   placeholder="Enter new password" required>
                            <button type="button" class="password-toggle" onclick="togglePassword('newPassword', 'toggleNewPassword')">
                                <i class="fas fa-eye" id="toggleNewPassword"></i>
                            </button>
                        </div>
                        <small class="text-muted">Must be at least 8 characters long</small>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-lock"></i> Confirm New Password
                        </label>
                        <div class="input-group" style="position: relative;">
                            <span class="input-group-text">
                                <i class="fas fa-lock"></i>
                            </span>
                            <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" 
                                   placeholder="Re-type new password" required>
                            <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword', 'toggleConfirmPassword')">
                                <i class="fas fa-eye" id="toggleConfirmPassword"></i>
                            </button>
                        </div>
                        <small class="text-muted">Passwords must match</small>
                    </div>
                    
                    <button type="submit" class="btn btn-update">
                        <i class="fas fa-save"></i> Update Password
                    </button>
                    
                    <a href="AdminDashboardServlet" class="btn btn-back">
                        <i class="fas fa-arrow-left"></i> Back to Dashboard
                    </a>
                </form>
                
                <div class="security-note">
                    <i class="fas fa-shield-alt"></i>
                    <span>Passwords are encrypted . All changes are logged for security.</span>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Password visibility toggle
        function togglePassword(inputId, iconId) {
            const passwordInput = document.getElementById(inputId);
            const toggleIcon = document.getElementById(iconId);
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }
        
        // Form validation
        document.getElementById('updateForm').addEventListener('submit', function(e) {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const newPasswordInput = document.getElementById('newPassword');
            const confirmPasswordInput = document.getElementById('confirmPassword');
            let valid = true;
            
            // Reset styles
            newPasswordInput.style.borderColor = '#e1e8ed';
            confirmPasswordInput.style.borderColor = '#e1e8ed';
            
            // Check password length
            if (newPassword.length < 8) {
                newPasswordInput.style.borderColor = '#dc3545';
                newPasswordInput.style.boxShadow = '0 0 0 3px rgba(220, 53, 69, 0.1)';
                valid = false;
                showValidationError('Password must be at least 8 characters long');
            }
            
            // Check if passwords match
            if (newPassword !== confirmPassword) {
                confirmPasswordInput.style.borderColor = '#dc3545';
                confirmPasswordInput.style.boxShadow = '0 0 0 3px rgba(220, 53, 69, 0.1)';
                valid = false;
                showValidationError('Passwords do not match');
            }
            
            if (!valid) {
                e.preventDefault();
            }
        });
        
        function showValidationError(message) {
            // Remove any existing validation error
            const existingError = document.querySelector('.validation-error');
            if (existingError) {
                existingError.remove();
            }
            
            // Create new error message
            const errorDiv = document.createElement('div');
            errorDiv.className = 'medical-alert validation-error';
            errorDiv.innerHTML = `<i class="fas fa-exclamation-circle"></i><span>${message}</span>`;
            
            // Insert after the form title
            const formTitle = document.querySelector('.section-title');
            formTitle.parentNode.insertBefore(errorDiv, formTitle.nextSibling);
        }
        
        // Real-time password matching indicator
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = this.value;
            const confirmInput = document.getElementById('confirmPassword');
            
            if (confirmPassword === '') {
                confirmInput.style.borderColor = '#e1e8ed';
                return;
            }
            
            if (newPassword === confirmPassword && newPassword.length >= 8) {
                confirmInput.style.borderColor = '#28a745';
                confirmInput.style.boxShadow = '0 0 0 3px rgba(40, 167, 69, 0.1)';
            } else {
                confirmInput.style.borderColor = '#dc3545';
                confirmInput.style.boxShadow = '0 0 0 3px rgba(220, 53, 69, 0.1)';
            }
        });
    </script>
</body>
</html>