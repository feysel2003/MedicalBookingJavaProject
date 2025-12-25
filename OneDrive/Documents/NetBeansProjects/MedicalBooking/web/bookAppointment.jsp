<%@ page import="java.util.List" %>
<%@ page import="model.Doctor" %>
<%@ page import="java.util.ArrayList" %>
<%@ page session="true" %>

<%
    if (session.getAttribute("currentPatient") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Doctor> doctors = (List<Doctor>) request.getAttribute("doctors");    // Check if doctors list is null and provide empty list as fallback
    if (doctors == null) {
        doctors = new ArrayList<Doctor>();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Appointment | Medical Booking System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e8f4ff 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 30px 20px;
        }
        
        .booking-container {
            max-width: 800px;
            margin: 0 auto;
        }
        
        .booking-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 115, 230, 0.08);
            padding: 30px;
            margin-bottom: 25px;
            border-top: 5px solid #1a73e8;
        }
        
        .page-title {
            color: #1a73e8;
            font-weight: 700;
            margin-bottom: 5px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .page-subtitle {
            color: #6c757d;
            font-size: 1.1rem;
            margin-bottom: 30px;
        }
        
        .medical-alert {
            background: #ffe6e6;
            border: 2px solid #ffcccc;
            border-radius: 10px;
            padding: 15px 20px;
            margin-bottom: 25px;
            color: #dc3545;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .medical-alert i {
            font-size: 1.2rem;
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
        
        .form-control, .form-select {
            padding: 12px 15px;
            border: 2px solid #e1e8ed;
            border-radius: 8px;
            transition: all 0.3s;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: #1a73e8;
            box-shadow: 0 0 0 3px rgba(26, 115, 232, 0.1);
        }
        
        .mb-3 {
            margin-bottom: 1.5rem !important;
        }
        
        .btn-primary {
            background: linear-gradient(to right, #1a73e8, #2a8bf2);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(26, 115, 232, 0.3);
            color: white;
        }
        
        .btn-secondary {
            background: white;
            color: #1a73e8;
            border: 2px solid #1a73e8;
            padding: 10px 25px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            margin-right: 10px;
            margin-top: 10px;
        }
        
        .btn-secondary:hover {
            background: #e8f4ff;
            color: #1a73e8;
            transform: translateY(-2px);
        }
        
        .button-container {
            margin-top: 25px;
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }
        
        .doctor-option {
            font-weight: 500;
            color: #2c3e50;
        }
        
        .doctor-specialization {
            color: #6c757d;
            font-style: italic;
        }
        
        @media (max-width: 768px) {
            body {
                padding: 20px 15px;
            }
            
            .booking-card {
                padding: 20px;
            }
            
            .button-container {
                flex-direction: column;
            }
            
            .btn-primary, .btn-secondary {
                width: 100%;
                justify-content: center;
            }
        }
        
        .input-group-icon {
            position: relative;
        }
        
        .input-group-icon i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
            z-index: 10;
        }
        
        .input-group-icon .form-control {
            padding-left: 45px;
        }
        
        .input-group-icon .form-select {
            padding-left: 45px;
        }
        
        .hospital-icon {
            text-align: center;
            margin-bottom: 25px;
            color: #1a73e8;
        }
        
        .hospital-icon i {
            font-size: 4rem;
            opacity: 0.8;
        }
        
        .no-doctors-alert {
            background: #fff3cd;
            border: 2px solid #ffeaa7;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 25px;
            color: #856404;
            text-align: center;
        }
        
        .no-doctors-alert i {
            font-size: 2rem;
            margin-bottom: 10px;
            display: block;
        }
    </style>
</head>
<body>
    <div class="booking-container">
        <div class="hospital-icon">
            <i class="fas fa-hospital-alt"></i>
        </div>
        
        <div class="booking-card">
            <h2 class="page-title">
                <i class="fas fa-calendar-plus"></i> Book an Appointment
            </h2>
            <p class="page-subtitle">Schedule your medical consultation with our specialists</p>
            
            <% if (request.getParameter("error") != null) { %>
                <div class="medical-alert">
                    <i class="fas fa-exclamation-triangle"></i>
                    <span>Selected time slot is not available. Please choose another.</span>
                </div>
            <% } %>
            
            <% if (doctors.isEmpty()) { %>
                <div class="no-doctors-alert">
                    <i class="fas fa-user-md"></i>
                    <h4>No Doctors Available</h4>
                    <p>There are currently no doctors available for booking. Please check back later or contact the clinic.</p>
                    <a href="patientDashboard.jsp" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Return to Dashboard
                    </a>
                </div>
            <% } else { %>
                <form action="AppointmentServlet" method="post">
                    <div class="mb-3">
                        <label for="doctorId" class="form-label">
                            <i class="fas fa-user-md"></i> Select Doctor
                        </label>
                        <div class="input-group-icon">
                            <i class="fas fa-stethoscope"></i>
                            <select name="doctorId" id="doctorId" class="form-select" required>
                                <% for (Doctor d : doctors) { %>
                                    <option value="<%= d.getId() %>">
                                        Dr. <%= d.getFullName() %> - <%= d.getSpecialization() %>
                                    </option>
                                <% } %>
                            </select>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="appointmentDate" class="form-label">
                            <i class="far fa-calendar"></i> Select Date
                        </label>
                        <div class="input-group-icon">
                            <i class="fas fa-calendar-day"></i>
                            <input type="date" name="appointmentDate" id="appointmentDate" 
                                   class="form-control" required min="<%= java.time.LocalDate.now() %>">
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="timeSlot" class="form-label">
                            <i class="far fa-clock"></i> Time Slot
                        </label>
                        <div class="input-group-icon">
                            <i class="fas fa-clock"></i>
                            <input type="time" name="timeSlot" id="timeSlot" class="form-control" required>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="symptoms" class="form-label">
                            <i class="fas fa-file-medical"></i> Symptoms / Reason
                        </label>
                        <div class="input-group-icon">
                            <i class="fas fa-notes-medical"></i>
                            <textarea name="symptoms" id="symptoms" class="form-control" rows="3" 
                                      placeholder="Describe your symptoms or reason for consultation..."></textarea>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-check-circle"></i> Book Appointment
                    </button>
                </form>
            <% } %>
            
            <div class="button-container">
                <a href="patientDashboard.jsp" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
                <a href="appointmentHistory.jsp" class="btn btn-secondary">
                    <i class="fas fa-history"></i> View Appointment History
                </a>
            </div>
        </div>
        
        <div class="text-center" style="color: #6c757d; font-size: 0.9rem;">
            <i class="fas fa-shield-alt me-2"></i>
            Your medical information is protected and confidential
        </div>
    </div>

    <script>
        // Purely cosmetic script - no functional changes
        document.addEventListener('DOMContentLoaded', function() {
            // Only run if doctors are available
            <% if (!doctors.isEmpty()) { %>
                // Add subtle animation to form elements on focus
                const inputs = document.querySelectorAll('.form-control, .form-select');
                inputs.forEach(input => {
                    input.addEventListener('focus', function() {
                        this.style.transform = 'translateY(-2px)';
                    });
                    
                    input.addEventListener('blur', function() {
                        this.style.transform = 'translateY(0)';
                    });
                });
                
                // Set default time to current time + 1 hour (purely for UX)
                const now = new Date();
                now.setHours(now.getHours() + 1);
                const hours = now.getHours().toString().padStart(2, '0');
                const minutes = now.getMinutes().toString().padStart(2, '0');
                document.getElementById('timeSlot').value = `${hours}:${minutes}`;
                
                // Set default date to tomorrow (purely for UX)
                const tomorrow = new Date();
                tomorrow.setDate(tomorrow.getDate() + 1);
                const year = tomorrow.getFullYear();
                const month = (tomorrow.getMonth() + 1).toString().padStart(2, '0');
                const day = tomorrow.getDate().toString().padStart(2, '0');
                document.getElementById('appointmentDate').value = `${year}-${month}-${day}`;
            <% } %>
        });
    </script>
</body>
</html>