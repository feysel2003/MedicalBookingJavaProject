<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login | Medical Booking System</title>
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
        
        .login-container {
            max-width: 450px;
            width: 100%;
        }
        
        .medical-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 115, 230, 0.1);
            border: none;
            overflow: hidden;
            border-top: 5px solid #1a73e8;
        }
        
        .login-header {
            background: linear-gradient(to right, #1a73e8, #2a8bf2);
            color: white;
            padding: 2.5rem 2rem;
            text-align: center;
        }
        
        .login-header h2 {
            margin: 0;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }
        
        .login-header h2 i {
            font-size: 2.2rem;
            background: rgba(255, 255, 255, 0.2);
            padding: 15px;
            border-radius: 50%;
        }
        
        .login-subtitle {
            opacity: 0.9;
            font-size: 1rem;
            margin-top: 10px;
            margin-bottom: 0;
        }
        
        .login-body {
            padding: 2.5rem;
        }
        
        .form-label {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .form-label i {
            color: #1a73e8;
            font-size: 1.1rem;
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
        
        .btn-medical-login {
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
        
        .btn-medical-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(26, 115, 232, 0.3);
            color: white;
        }
        
        .medical-alert {
            background: #ffe6e6;
            border: 2px solid #ffcccc;
            border-radius: 10px;
            padding: 1rem 1.5rem;
            margin-top: 1.5rem;
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
        
        .hospital-icon {
            text-align: center;
            margin-bottom: 2rem;
            color: #1a73e8;
        }
        
        .hospital-icon i {
            font-size: 4rem;
            opacity: 0.8;
        }
        
        @media (max-width: 768px) {
            .login-header {
                padding: 2rem 1.5rem;
            }
            
            .login-body {
                padding: 2rem 1.5rem;
            }
            
            .login-header h2 {
                font-size: 1.8rem;
            }
            
            .hospital-icon i {
                font-size: 3.5rem;
            }
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
    </style>
</head>
<body>
    <div class="login-container">
        <div class="hospital-icon">
            <i class="fas fa-hospital-alt"></i>
        </div>
        
        <div class="medical-card">
            <div class="login-header">
                <h2>
                    <i class="fas fa-lock"></i> Admin Portal
                </h2>
                <p class="login-subtitle">Secure Access to Medical Booking System</p>
            </div>
            
            <div class="login-body">
                <form method="post" action="AdminLoginServlet" id="loginForm">
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-envelope"></i> Email Address
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-user-md"></i>
                            </span>
                            <input type="email" name="email" class="form-control" placeholder="admin@medicalsystem.com" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-key"></i> Password
                        </label>
                        <div class="input-group" style="position: relative;">
                            <span class="input-group-text">
                                <i class="fas fa-lock"></i>
                            </span>
                            <input type="password" name="password" id="password" class="form-control" placeholder="Enter your password" required>
                            <button type="button" class="password-toggle" onclick="togglePassword()">
                                <i class="fas fa-eye" id="toggleIcon"></i>
                            </button>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-medical-login">
                        <i class="fas fa-sign-in-alt"></i> Login to Dashboard
                    </button>
                </form>
                
                <% if (request.getParameter("error") != null) { %>
                    <div class="medical-alert">
                        <i class="fas fa-exclamation-triangle"></i>
                        <span>Invalid email or password. Please try again.</span>
                    </div>
                <% } %>
                
                <div class="security-note">
                    <i class="fas fa-shield-alt"></i>
                    <span>This system is HIPAA compliant. All data is encrypted and secure.</span>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Password visibility toggle
        function togglePassword() {
            const passwordInput = document.getElementById('password');
            const toggleIcon = document.getElementById('toggleIcon');
            
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
        
        // Form validation animation
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const inputs = this.querySelectorAll('input[required]');
            let valid = true;
            
            inputs.forEach(input => {
                if (!input.value.trim()) {
                    input.style.borderColor = '#dc3545';
                    input.style.boxShadow = '0 0 0 3px rgba(220, 53, 69, 0.1)';
                    valid = false;
                    
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
            
            if (!valid) {
                e.preventDefault();
            }
        });
        
        // Add shake animation for error
        const style = document.createElement('style');
        style.textContent = `
            @keyframes shake {
                0%, 100% { transform: translateX(0); }
                10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
                20%, 40%, 60%, 80% { transform: translateX(5px); }
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>