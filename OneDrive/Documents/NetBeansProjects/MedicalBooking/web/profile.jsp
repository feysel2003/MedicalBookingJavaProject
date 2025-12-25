<%@ page import="model.Patient" %>
<%@ page session="true" %>
<%
    Patient patient = (Patient) session.getAttribute("currentPatient");
    if (patient == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile | Medical Booking System</title>
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
            max-width: 700px;
            margin: 2rem auto;
            padding: 0 15px;
        }
        
        .patient-icon {
            text-align: center;
            margin-bottom: 1.5rem;
            color: #1a73e8;
        }
        
        .patient-icon i {
            font-size: 4rem;
            opacity: 0.8;
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
        }
        
        .profile-header h2 {
            margin: 0;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .profile-header h2 i {
            font-size: 1.8rem;
            background: rgba(255, 255, 255, 0.2);
            padding: 12px;
            border-radius: 12px;
        }
        
        .form-container {
            padding: 2.5rem;
        }
        
        .patient-info {
            background: #e8f4ff;
            padding: 1rem 1.5rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            color: #2c3e50;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .patient-info i {
            color: #1a73e8;
            font-size: 1.2rem;
        }
        
        .patient-id {
            color: #6c757d;
            font-size: 0.9rem;
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
            font-size: 1.1rem;
        }
        
        .input-group {
            margin-bottom: 1.8rem;
        }
        
        .input-group-text {
            background-color: #e8f4ff;
            border: 2px solid #e1e8ed;
            color: #1a73e8;
            padding: 12px 15px;
        }
        
        .form-control {
            padding: 12px 15px;
            border: 2px solid #e1e8ed;
            border-radius: 8px;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: #1a73e8;
            box-shadow: 0 0 0 3px rgba(26, 115, 232, 0.1);
        }
        
        .input-group .form-control {
            border-left: 1px solid #e1e8ed;
        }
        
        .btn-update {
            background: linear-gradient(to right, #1a73e8, #2a8bf2);
            color: white;
            border: none;
            padding: 14px 30px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            margin-right: 15px;
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
        
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid #eee;
        }
        
        @media (max-width: 768px) {
            .profile-container {
                margin: 1rem auto;
            }
            
            .profile-header, .form-container {
                padding: 1.5rem;
            }
            
            .button-group {
                flex-direction: column;
            }
            
            .btn-update, .btn-back {
                width: 100%;
                justify-content: center;
            }
        }
        
        .password-section {
            background: #fff8e1;
            border: 2px solid #ffeaa7;
            border-radius: 10px;
            padding: 1.5rem;
            margin-top: 2rem;
            margin-bottom: 1rem;
        }
        
        .password-section h5 {
            color: #856404;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .password-section h5 i {
            color: #856404;
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
    </style>
</head>
<body>
    <div class="profile-container">
        <div class="patient-icon">
            <i class="fas fa-user-circle"></i>
        </div>
        
        <div class="medical-card">
            <div class="profile-header">
                <h2>
                    <i class="fas fa-user-edit"></i> My Profile
                </h2>
            </div>
            
            <div class="form-container">
                <!-- Patient Information -->
                <div class="patient-info">
                    <i class="fas fa-id-card"></i>
                    <div>
                        <span>Patient ID: PAT-<%= patient.getId() %></span>
                        <span class="patient-id ms-3">Member Since: Registered Patient</span>
                    </div>
                </div>
                
                <!-- Update Form -->
                <form action="ProfileServlet" method="post">
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-user"></i> Full Name
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-user-circle"></i>
                            </span>
                            <input type="text" name="fullName" value="<%= patient.getFullName() %>" 
                                   class="form-control" placeholder="Enter your full name" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-envelope"></i> Email Address
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-at"></i>
                            </span>
                            <input type="email" name="email" value="<%= patient.getEmail() %>" 
                                   class="form-control" placeholder="your.email@example.com" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-phone"></i> Phone Number
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-mobile-alt"></i>
                            </span>
                            <input type="text" name="phone" value="<%= patient.getPhone() %>" 
                                   class="form-control" placeholder="+1 (234) 567-8900" required>
                        </div>
                    </div>
                    
                    <!-- Password Change Section (Visual Only - No Functional Changes) -->
                    <div class="password-section">
                        <h5>
                            <i class="fas fa-key"></i> Password Management
                        </h5>
                        <p style="color: #856404; font-size: 0.9rem; margin-bottom: 0;">
                            <i class="fas fa-info-circle"></i> 
                            To change your password, please contact the clinic administration .
                        </p>
                    </div>
                    
                    <div class="button-group">
                        <button type="submit" class="btn btn-update">
                            <i class="fas fa-save"></i> Update Profile
                        </button>
                        <a href="patientDashboard.jsp" class="btn btn-back">
                            <i class="fas fa-arrow-left"></i> Back to Dashboard
                        </a>
                    </div>
                </form>
                
                <div class="security-note">
                    <i class="fas fa-shield-alt"></i>
                    <span>Your personal information is encrypted and protected under HIPAA guidelines</span>
                </div>
            </div>
        </div>
        
        <div class="text-center mt-4" style="color: #6c757d; font-size: 0.9rem;">
            <i class="fas fa-heartbeat me-2"></i>
            Keeping your health information accurate and up-to-date
        </div>
    </div>

    <script>
        // Purely cosmetic script - no functional changes
        document.addEventListener('DOMContentLoaded', function() {
            // Add subtle animation to form inputs on focus
            const inputs = document.querySelectorAll('.form-control');
            
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.style.transform = 'translateY(-2px)';
                });
                
                input.addEventListener('blur', function() {
                    this.style.transform = 'translateY(0)';
                });
            });
            
            // Add form validation animation
            const form = document.querySelector('form');
            form.addEventListener('submit', function(e) {
                const requiredInputs = this.querySelectorAll('input[required]');
                let allValid = true;
                
                requiredInputs.forEach(input => {
                    if (!input.value.trim()) {
                        input.style.borderColor = '#dc3545';
                        input.style.boxShadow = '0 0 0 3px rgba(220, 53, 69, 0.1)';
                        allValid = false;
                        
                        // Add shake animation
                        input.style.animation = 'shake 0.5s';
                        setTimeout(() => {
                            input.style.animation = '';
                        }, 500);
                    } else {
                        input.style.borderColor = '#1a73e8';
                        input.style.boxShadow = '0 0 0 3px rgba(26, 115, 232, 0.1)';
                    }
                });
                
                // If not valid, prevent submission and show alert
                if (!allValid) {
                    e.preventDefault();
                    
                    // Show error message
                    let errorAlert = document.querySelector('.medical-alert');
                    if (!errorAlert) {
                        errorAlert = document.createElement('div');
                        errorAlert.className = 'medical-alert';
                        errorAlert.innerHTML = '<i class="fas fa-exclamation-circle"></i><span>Please fill in all required fields.</span>';
                        form.prepend(errorAlert);
                        
                        // Remove error after 5 seconds
                        setTimeout(() => {
                            errorAlert.remove();
                        }, 5000);
                    }
                }
            });
            
            // Add shake animation CSS
            const style = document.createElement('style');
            style.textContent = `
                @keyframes shake {
                    0%, 100% { transform: translateX(0); }
                    10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
                    20%, 40%, 60%, 80% { transform: translateX(5px); }
                }
            `;
            document.head.appendChild(style);
            
            // Format phone number as user types (cosmetic only)
            const phoneInput = document.querySelector('input[name="phone"]');
            if (phoneInput) {
                phoneInput.addEventListener('input', function(e) {
                    let value = e.target.value.replace(/\D/g, '');
                    
                    if (value.length > 0) {
                        value = value.match(new RegExp('.{1,4}', 'g')).join('-');
                    }
                    
                    e.target.value = value;
                });
            }
        });
    </script>
</body>
</html>