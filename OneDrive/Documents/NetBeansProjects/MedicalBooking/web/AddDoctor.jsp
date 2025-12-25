<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Doctor | Medical Booking System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Color variables */
        .medical-blue { color: #1a73e8; }
        .medical-light-blue { color: #e8f4ff; }
        .medical-green { color: #34a853; }
        .medical-teal { color: #17a2b8; }
        .medical-dark { color: #2c3e50; }
        
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e8f4ff 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px;
        }
        
        .medical-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 15px;
        }
        
        .medical-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 115, 230, 0.08);
            border: none;
            overflow: hidden;
            border-top: 5px solid #1a73e8;
        }
        
        .medical-header {
            background: linear-gradient(to right, #1a73e8, #2a8bf2);
            color: white;
            padding: 1.5rem 2rem;
        }
        
        .medical-header h2 {
            margin: 0;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .medical-header h2 i { font-size: 1.8rem; }
        
        .form-container { padding: 2rem; }
        
        .form-label {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
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
        
        .input-group-text {
            background-color: #e8f4ff;
            border: 2px solid #e1e8ed;
            color: #1a73e8;
        }
        
        .btn-medical-primary {
            background: linear-gradient(to right, #1a73e8, #2a8bf2);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-medical-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(26, 115, 232, 0.3);
            color: white;
        }
        
        .btn-medical-secondary {
            background: white;
            color: #1a73e8;
            border: 2px solid #1a73e8;
            padding: 10px 28px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-medical-secondary:hover {
            background-color: #e8f4ff;
            color: #1a73e8;
            transform: translateY(-2px);
        }
        
        .btn-group-container {
            display: flex;
            gap: 15px;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid #eee;
        }
        
        .medical-icon { color: #1a73e8; font-size: 1.1rem; }
        
        .form-group { margin-bottom: 1.8rem; }
        
        .header-subtitle {
            opacity: 0.9;
            font-size: 0.95rem;
            margin-top: 5px;
            margin-left: 45px;
        }
        
        .doctor-illustration {
            text-align: center;
            margin-bottom: 1.5rem;
            color: #1a73e8;
            opacity: 0.8;
        }
        
        .security-note {
            color: #6c757d;
            font-size: 0.9rem;
            text-align: center;
            margin-top: 1.5rem;
        }

        .input-group { border-radius: 8px; }
        .input-group .input-group-text { border-right: none; }
        .input-group .form-control { border-left: none; }
    </style>
</head>
<body>
    <div class="medical-container">
        <div class="doctor-illustration">
            <i class="fas fa-user-md" style="font-size: 4rem;"></i>
        </div>
        
        <div class="medical-card">
            <div class="medical-header">
                <h2><i class="fas fa-user-plus"></i> Add New Doctor</h2>
                <div class="header-subtitle">Complete the form below to register a new doctor to the system</div>
            </div>
            
            <div class="form-container">
                <form action="AddDoctorServlet" method="post">
                    
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-user medical-icon"></i> Full Name
                        </label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-user-md"></i></span>
                            <input type="text" name="fullName" class="form-control" placeholder="Enter doctor's full name" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-envelope medical-icon"></i> Email Address
                        </label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-at"></i></span>
                            <input type="email" name="email" class="form-control" placeholder="doctor@medicalclinic.com" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-stethoscope medical-icon"></i> Specialization
                        </label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-heartbeat"></i></span>
                            <input type="text" name="specialization" class="form-control" placeholder="e.g., Cardiology, Neurology">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-phone medical-icon"></i> Phone Number
                        </label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-mobile-alt"></i></span>
                            <input type="text" name="phone" class="form-control" placeholder="+1 (234) 567-8900">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-key medical-icon"></i> Initial Password for Doctor
                        </label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                            <input type="password" name="password" class="form-control" placeholder="e.g. Welcome123" required>
                        </div>
                        <small class="text-muted mt-1 d-block">The doctor will use this password for their first login.</small>
                    </div>
                    
                    <div class="btn-group-container">
                        <button type="submit" class="btn btn-medical-primary">
                            <i class="fas fa-save"></i> Save Doctor
                        </button>
                        <a href="ManageDoctorsServlet" class="btn btn-medical-secondary">
                            <i class="fas fa-arrow-left"></i> Back to Doctors List
                        </a>
                    </div>
                </form>
            </div>
        </div>
        
        <div class="security-note">
            <i class="fas fa-shield-alt me-2"></i> All information is securely stored and HIPAA compliant
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>