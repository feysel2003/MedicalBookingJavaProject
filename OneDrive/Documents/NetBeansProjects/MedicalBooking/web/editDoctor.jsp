<%@ page import="model.Doctor" %>
<%
    Doctor d = (Doctor) request.getAttribute("doctor");
    // If someone tries to access this page directly, d will be null.
    // Redirect them back to the management page.
    if (d == null) {
        response.sendRedirect("ManageDoctorsServlet");
        return; 
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Doctor | Medical Booking System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e8f4ff 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px;
        }
        
        .edit-container {
            max-width: 700px;
            margin: 2rem auto;
            padding: 0 15px;
        }
        
        .doctor-icon {
            text-align: center;
            margin-bottom: 1.5rem;
            color: #1a73e8;
        }
        
        .doctor-icon i {
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
        
        .edit-header {
            background: linear-gradient(to right, #1a73e8, #2a8bf2);
            color: white;
            padding: 1.8rem 2rem;
        }
        
        .edit-header h2 {
            margin: 0;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .edit-header h2 i {
            font-size: 1.8rem;
            background: rgba(255, 255, 255, 0.2);
            padding: 12px;
            border-radius: 12px;
        }
        
        .form-container {
            padding: 2.5rem;
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
        
        .btn-cancel {
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
        
        .btn-cancel:hover {
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
            .edit-container {
                margin: 1rem auto;
            }
            
            .edit-header, .form-container {
                padding: 1.5rem;
            }
            
            .button-group {
                flex-direction: column;
            }
            
            .btn-update, .btn-cancel {
                width: 100%;
                justify-content: center;
            }
        }
        
        .doctor-info {
            background: #e8f4ff;
            padding: 1rem 1.5rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            color: #2c3e50;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .doctor-info i {
            color: #1a73e8;
            font-size: 1.2rem;
        }
        
        .doctor-id {
            color: #6c757d;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="edit-container">
        <div class="doctor-icon">
            <i class="fas fa-user-md"></i>
        </div>
        
        <div class="medical-card">
            <div class="edit-header">
                <h2>
                    <i class="fas fa-edit"></i> Edit Doctor Profile
                </h2>
            </div>
            
            <div class="form-container">
                <!-- Doctor Info -->
                <div class="doctor-info">
                    <i class="fas fa-id-card"></i>
                    <div>
                        <span class="doctor-id">Doctor ID: DOC-<%= d.getId() %></span>
                    </div>
                </div>
                
                <form action="EditDoctorServlet" method="post">
                    <input type="hidden" name="id" value="<%= d.getId() %>">
                    
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-user"></i> Full Name
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-user-md"></i>
                            </span>
                            <input type="text" name="fullName" value="<%= d.getFullName() %>" 
                                   class="form-control" placeholder="Enter doctor's full name">
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
                            <input type="email" name="email" value="<%= d.getEmail() %>" 
                                   class="form-control" placeholder="doctor@medicalclinic.com">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-stethoscope"></i> Specialization
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-heartbeat"></i>
                            </span>
                            <input type="text" name="specialization" value="<%= d.getSpecialization() %>" 
                                   class="form-control" placeholder="e.g., Cardiology, Neurology, Pediatrics">
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
                            <input type="text" name="phone" value="<%= d.getPhone() %>" 
                                   class="form-control" placeholder="+1 (234) 567-8900">
                        </div>
                    </div>
                    
                    <div class="button-group">
                        <button type="submit" class="btn btn-update">
                            <i class="fas fa-save"></i> Update Doctor
                        </button>
                        <a href="ManageDoctorsServlet" class="btn btn-cancel">
                            <i class="fas fa-times"></i> Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
        
        <div class="text-center mt-4" style="color: #6c757d; font-size: 0.9rem;">
            <i class="fas fa-shield-alt me-2"></i>
            All doctor information is securely stored and HIPAA compliant
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
        });
    </script>
</body>
</html>