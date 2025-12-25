<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Registration | Medical Booking System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e8f4ff 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .register-container {
            max-width: 600px;
            width: 100%;
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
            box-shadow: 0 15px 35px rgba(0, 115, 230, 0.1);
            border: none;
            overflow: hidden;
            border-top: 5px solid #1a73e8;
        }
        
        .register-header {
            background: linear-gradient(to right, #1a73e8, #2a8bf2);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        
        .register-header h3 {
            margin: 0;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }
        
        .register-header h3 i {
            font-size: 2rem;
            background: rgba(255, 255, 255, 0.2);
            padding: 12px;
            border-radius: 50%;
        }
        
        .register-subtitle {
            opacity: 0.9;
            font-size: 1rem;
            margin-top: 10px;
            margin-bottom: 0;
        }
        
        .register-body {
            padding: 2.5rem;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-bottom: 1rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-label {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .form-label i {
            color: #1a73e8;
            font-size: 1.1rem;
        }
        
        .input-group {
            margin-bottom: 1rem;
        }
        
        .input-group-text {
            background-color: #e8f4ff;
            border: 2px solid #e1e8ed;
            border-right: none;
            color: #1a73e8;
            padding: 12px 15px;
        }
        
        .form-control, .form-select {
            padding: 12px 15px;
            border: 2px solid #e1e8ed;
            border-left: none;
            border-radius: 0 8px 8px 0;
            transition: all 0.3s;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: #1a73e8;
            box-shadow: 0 0 0 3px rgba(26, 115, 232, 0.1);
        }
        
        .form-control:not(.input-group .form-control), 
        .form-select:not(.input-group .form-select) {
            border: 2px solid #e1e8ed;
            border-radius: 8px;
        }
        
        .btn-register {
            background: linear-gradient(to right, #1a73e8, #2a8bf2);
            color: white;
            border: none;
            padding: 14px 30px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-top: 1.5rem;
        }
        
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(26, 115, 232, 0.3);
            color: white;
        }
        
        .login-link {
            text-align: center;
            color: #6c757d;
            font-size: 1rem;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid #e9ecef;
        }
        
        .login-link a {
            color: #1a73e8;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        
        .login-link a:hover {
            text-decoration: underline;
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
        
        @media (max-width: 768px) {
            .register-container {
                padding: 0 10px;
            }
            
            .register-header {
                padding: 1.5rem;
            }
            
            .register-body {
                padding: 1.5rem;
            }
            
            .register-header h3 {
                font-size: 1.5rem;
            }
            
            .patient-icon i {
                font-size: 3.5rem;
            }
            
            .form-row {
                grid-template-columns: 1fr;
                gap: 0;
            }
            
            .form-group {
                margin-bottom: 1rem;
            }
        }
        
        .dob-info {
            color: #6c757d;
            font-size: 0.85rem;
            margin-top: 5px;
            margin-left: 5px;
        }
        
        .form-requirements {
            background: #e8f4ff;
            padding: 1rem;
            border-radius: 8px;
            margin-top: 1rem;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            color: #2c3e50;
        }
        
        .form-requirements h6 {
            color: #1a73e8;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .form-requirements ul {
            margin: 0;
            padding-left: 1.2rem;
        }
        
        .form-requirements li {
            margin-bottom: 4px;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="patient-icon">
            <i class="fas fa-user-plus"></i>
        </div>
        
        <div class="medical-card">
            <div class="register-header">
                <h3>
                    <i class="fas fa-hospital-user"></i> Patient Registration
                </h3>
                <p class="register-subtitle">Create your medical account to access healthcare services</p>
            </div>
            
            <div class="register-body">
                <!-- Form Requirements Info -->
                <div class="form-requirements">
                    <h6><i class="fas fa-info-circle"></i> Please Note:</h6>
                    <ul>
                        <li>All fields marked with * are required</li>
                        <li>Use a valid email for appointment notifications</li>
                        <li>Date of birth is required for medical records</li>
                    </ul>
                </div>
                
                <form action="RegisterServlet" method="post" id="registerForm">
                    <!-- Personal Information Row -->
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-user"></i> Full Name *
                            </label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-id-card"></i>
                                </span>
                                <input type="text" name="fullName" class="form-control" 
                                       placeholder="Enter your full name" required>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-envelope"></i> Email Address *
                            </label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-at"></i>
                                </span>
                                <input type="email" name="email" class="form-control" 
                                       placeholder="your.email@example.com" required>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Contact Information Row -->
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-phone"></i> Phone Number
                            </label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-mobile-alt"></i>
                                </span>
                                <input type="text" name="phone" class="form-control" 
                                       placeholder="+1 (234) 567-8900">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-calendar"></i> Date of Birth *
                            </label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-birthday-cake"></i>
                                </span>
                                <input type="date" name="dob" class="form-control" required>
                            </div>
                            <div class="dob-info">Required for medical records</div>
                        </div>
                    </div>
                    
                    <!-- Password Row -->
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-key"></i> Password *
                        </label>
                        <div class="input-group" style="position: relative;">
                            <span class="input-group-text">
                                <i class="fas fa-lock"></i>
                            </span>
                            <input type="password" name="password" id="password" class="form-control" 
                                   placeholder="Create a secure password" required>
                            <button type="button" class="password-toggle" onclick="togglePassword('password', 'togglePasswordIcon')">
                                <i class="fas fa-eye" id="togglePasswordIcon"></i>
                            </button>
                        </div>
                    </div>
                    
                    <!-- Address -->
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-map-marker-alt"></i> Address
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-home"></i>
                            </span>
                            <textarea name="address" class="form-control" rows="3" 
                                      placeholder="Enter your complete address"></textarea>
                        </div>
                    </div>
                    
                    <!-- Gender Selection -->
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-venus-mars"></i> Gender *
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-user-tag"></i>
                            </span>
                            <select name="gender" class="form-select" required>
                                <option value="">Select Gender</option>
                                <option value="MALE">Male</option>
                                <option value="FEMALE">Female</option>
                            </select>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-register">
                        <i class="fas fa-user-plus"></i> Create Medical Account
                    </button>
                </form>
                
                <div class="login-link">
                    Already have a medical account? 
                    <a href="login.jsp">
                        <i class="fas fa-sign-in-alt"></i> Login Here
                    </a>
                </div>
                
                <div class="security-note">
                    <i class="fas fa-shield-alt"></i>
                    <span>Your personal and medical information is protected and confidential</span>
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
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('registerForm');
            const dobInput = document.querySelector('input[name="dob"]');
            
            // Set max date to today for DOB
            const today = new Date().toISOString().split('T')[0];
            if (dobInput) {
                dobInput.max = today;
            }
            
            // Phone number formatting
            const phoneInput = document.querySelector('input[name="phone"]');
            if (phoneInput) {
                phoneInput.addEventListener('input', function(e) {
                    let value = e.target.value.replace(/\D/g, '');
                    
                    if (value.length > 0) {
                        if (value.length <= 3) {
                            value = value;
                        } else if (value.length <= 6) {
                            value = value.slice(0, 3) + '-' + value.slice(3);
                        } else {
                            value = value.slice(0, 3) + '-' + value.slice(3, 6) + '-' + value.slice(6, 10);
                        }
                    }
                    
                    e.target.value = value;
                });
            }
            
            // Form submission validation
            form.addEventListener('submit', function(e) {
                const requiredInputs = this.querySelectorAll('input[required], select[required]');
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
                        
                        // Specific validations
                        if (input.type === 'email') {
                            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                            if (!emailPattern.test(input.value)) {
                                input.style.borderColor = '#dc3545';
                                input.style.boxShadow = '0 0 0 3px rgba(220, 53, 69, 0.1)';
                                allValid = false;
                                showValidationError('Please enter a valid email address');
                            }
                        }
                        
                        if (input.name === 'dob') {
                            const dob = new Date(input.value);
                            const today = new Date();
                            if (dob >= today) {
                                input.style.borderColor = '#dc3545';
                                input.style.boxShadow = '0 0 0 3px rgba(220, 53, 69, 0.1)';
                                allValid = false;
                                showValidationError('Date of birth must be in the past');
                            }
                        }
                    }
                });
                
                // Check password strength (cosmetic only)
                const passwordInput = document.getElementById('password');
                if (passwordInput && passwordInput.value.length > 0 && passwordInput.value.length < 6) {
                    showValidationError('Password should be at least 6 characters long');
                    allValid = false;
                }
                
                if (!allValid) {
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
                
                // Insert after the form requirements
                const formRequirements = document.querySelector('.form-requirements');
                if (formRequirements) {
                    formRequirements.parentNode.insertBefore(errorDiv, formRequirements.nextSibling);
                }
            }
            
            // Real-time password strength indicator
            const passwordInput = document.getElementById('password');
            if (passwordInput) {
                passwordInput.addEventListener('input', function() {
                    const strengthDiv = document.getElementById('passwordStrength') || createPasswordStrengthIndicator();
                    const password = this.value;
                    
                    let strength = 0;
                    let message = '';
                    let color = '#dc3545';
                    
                    if (password.length >= 8) strength++;
                    if (/[A-Z]/.test(password)) strength++;
                    if (/[0-9]/.test(password)) strength++;
                    if (/[^A-Za-z0-9]/.test(password)) strength++;
                    
                    switch(strength) {
                        case 0: message = 'Very Weak'; color = '#dc3545'; break;
                        case 1: message = 'Weak'; color = '#fd7e14'; break;
                        case 2: message = 'Fair'; color = '#ffc107'; break;
                        case 3: message = 'Good'; color = '#28a745'; break;
                        case 4: message = 'Strong'; color = '#20c997'; break;
                    }
                    
                    strengthDiv.innerHTML = `<span style="color: ${color}; font-weight: 600;">${message}</span>`;
                });
            }
            
            function createPasswordStrengthIndicator() {
                const indicator = document.createElement('div');
                indicator.id = 'passwordStrength';
                indicator.style.fontSize = '0.85rem';
                indicator.style.marginTop = '5px';
                indicator.style.color = '#6c757d';
                passwordInput.parentNode.appendChild(indicator);
                return indicator;
            }
            
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
        });
    </script>
</body>
</html>