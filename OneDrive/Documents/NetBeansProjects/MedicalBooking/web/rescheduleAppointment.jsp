<%@ page session="true" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    if (session.getAttribute("currentPatient") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String idStr = (request.getAttribute("appointmentId") != null) 
                   ? request.getAttribute("appointmentId").toString() 
                   : request.getParameter("appointmentId");

    if (idStr == null) {
        response.sendRedirect("appointmentHistory.jsp");
        return;
    }
    int appointmentId = Integer.parseInt(idStr);
    
    // Get today's date and max date (2 months from now)
    LocalDate today = LocalDate.now();
    LocalDate maxDate = today.plusMonths(2);
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    String minDateStr = today.format(formatter);
    String maxDateStr = maxDate.format(formatter);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reschedule Appointment | Medical Booking System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e8f4ff 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px;
        }
        
        .reschedule-container {
            max-width: 600px;
            margin: 2rem auto;
            padding: 0 15px;
        }
        
        .reschedule-icon {
            text-align: center;
            margin-bottom: 1.5rem;
            color: #1a73e8;
        }
        
        .reschedule-icon i {
            font-size: 4rem;
            opacity: 0.8;
        }
        
        .medical-card {
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 115, 230, 0.08);
            border: none;
            overflow: hidden;
            border-top: 5px solid #ffc107;
        }
        
        .reschedule-header {
            background: linear-gradient(to right, #ffc107, #ffce3a);
            color: #212529;
            padding: 1.8rem 2rem;
        }
        
        .reschedule-header h3 {
            margin: 0;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .reschedule-header h3 i {
            font-size: 1.8rem;
            background: rgba(255, 255, 255, 0.3);
            padding: 12px;
            border-radius: 12px;
        }
        
        .header-subtitle {
            opacity: 0.9;
            font-size: 0.95rem;
            margin-top: 5px;
            margin-left: 45px;
        }
        
        .form-container {
            padding: 2.5rem;
        }
        
        .appointment-info {
            background: #fff9e6;
            border: 2px solid #ffeaa7;
            border-radius: 10px;
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            color: #856404;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .appointment-info i {
            font-size: 1.2rem;
        }
        
        .appointment-id {
            font-weight: 600;
            color: #856404;
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
        
        .btn-reschedule {
            background: linear-gradient(to right, #ffc107, #ffce3a);
            color: #212529;
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
        
        .btn-reschedule:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255, 193, 7, 0.3);
            color: #212529;
        }
        
        .btn-back {
            background: #ffffff;
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
        
        .date-time-info {
            background: #e8f4ff;
            padding: 15px;
            border-radius: 10px;
            margin-top: 10px;
            color: #2c3e50;
            font-size: 0.9rem;
        }
        
        .date-time-info i {
            color: #1a73e8;
            margin-right: 8px;
        }
        
        @media (max-width: 768px) {
            .reschedule-container {
                margin: 1rem auto;
            }
            
            .reschedule-header, .form-container {
                padding: 1.5rem;
            }
            
            .reschedule-header h3 {
                font-size: 1.5rem;
            }
            
            .header-subtitle {
                margin-left: 0;
            }
            
            .button-group {
                flex-direction: column;
            }
            
            .btn-reschedule, .btn-back {
                width: 100%;
                justify-content: center;
            }
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-bottom: 1rem;
        }
        
        @media (max-width: 576px) {
            .form-row {
                grid-template-columns: 1fr;
                gap: 0;
            }
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
    <div class="reschedule-container">
        <div class="reschedule-icon">
            <i class="fas fa-calendar-alt"></i>
        </div>
        
        <div class="medical-card">
            <div class="reschedule-header">
                <h3>
                    <i class="fas fa-calendar-edit"></i> Reschedule Appointment
                </h3>
                <div class="header-subtitle">Select a new date and time for your medical consultation</div>
            </div>
            
            <div class="form-container">
                <!-- Appointment Information -->
                <div class="appointment-info">
                    <i class="fas fa-calendar-check"></i>
                    <div>
                        <span class="appointment-id">Appointment ID: APPT-<%= appointmentId %></span>
                    </div>
                </div>
                
                <form action="RescheduleAppointmentServlet" method="post" id="rescheduleForm">
                    <input type="hidden" name="appointmentId" value="<%= appointmentId %>">
                    
                    <!-- Date and Time Selection -->
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-calendar-day"></i> New Date *
                            </label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="far fa-calendar"></i>
                                </span>
                                <input type="date" name="newDate" id="newDate" class="form-control" 
                                       required min="<%= minDateStr %>" max="<%= maxDateStr %>">
                            </div>
                            <div class="date-time-info">
                                <i class="fas fa-lightbulb"></i>
                                Select a date within the next 2 months
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">
                                <i class="far fa-clock"></i> New Time Slot *
                            </label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-clock"></i>
                                </span>
                                <input type="time" name="timeSlot" id="timeSlot" 
                                       class="form-control" required>
                            </div>
                            <div class="date-time-info">
                                <i class="fas fa-lightbulb"></i>
                                Select your preferred appointment time
                            </div>
                        </div>
                    </div>
                    
                    <div class="button-group">
                        <button type="submit" class="btn btn-reschedule">
                            <i class="fas fa-calendar-check"></i> Confirm Reschedule
                        </button>
                        <a href="appointmentHistory.jsp" class="btn btn-back">
                            <i class="fas fa-times"></i> Cancel
                        </a>
                    </div>
                </form>
                
                <div class="security-note">
                    <i class="fas fa-shield-alt"></i>
                    <span>Your appointment details are confidential and HIPAA compliant</span>
                </div>
            </div>
        </div>
        
        <div class="text-center mt-4" style="color: #6c757d; font-size: 0.9rem;">
            <i class="fas fa-heartbeat me-2"></i>
            Rescheduling helps us better serve your healthcare needs
        </div>
    </div>

    <script>
        // Form validation and enhancement
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('rescheduleForm');
            const dateInput = document.getElementById('newDate');
            const timeInput = document.getElementById('timeSlot');
            
            // Set default date to tomorrow
            const tomorrow = new Date();
            tomorrow.setDate(tomorrow.getDate() + 1);
            const year = tomorrow.getFullYear();
            const month = (tomorrow.getMonth() + 1).toString().padStart(2, '0');
            const day = tomorrow.getDate().toString().padStart(2, '0');
            dateInput.value = `${year}-${month}-${day}`;
            
            // Set default time to 10:00 AM
            timeInput.value = '10:00';
            
            // Form submission validation
            form.addEventListener('submit', function(e) {
                const selectedDate = new Date(dateInput.value);
                const today = new Date();
                today.setHours(0, 0, 0, 0); // Set to start of day for comparison
                
                // Check if date is not in the past
                if (selectedDate < today) {
                    e.preventDefault();
                    showValidationError('Please select a future date.');
                    dateInput.style.borderColor = '#dc3545';
                    dateInput.style.boxShadow = '0 0 0 3px rgba(220, 53, 69, 0.1)';
                    return;
                }
                
                // Check if date is not Sunday
                if (selectedDate.getDay() === 0) { // Sunday = 0
                    e.preventDefault();
                    showValidationError('Clinic is closed on Sundays. Please select a weekday or Saturday.');
                    dateInput.style.borderColor = '#dc3545';
                    dateInput.style.boxShadow = '0 0 0 3px rgba(220, 53, 69, 0.1)';
                    return;
                }
            });
            
            // Real-time date validation
            dateInput.addEventListener('change', function() {
                const selectedDate = new Date(this.value);
                const day = selectedDate.getDay();
                const today = new Date();
                today.setHours(0, 0, 0, 0);
                
                if (selectedDate < today) {
                    this.style.borderColor = '#dc3545';
                    this.style.boxShadow = '0 0 0 3px rgba(220, 53, 69, 0.1)';
                    showDateError('Please select a future date.');
                } else if (day === 0) { // Sunday
                    this.style.borderColor = '#dc3545';
                    this.style.boxShadow = '0 0 0 3px rgba(220, 53, 69, 0.1)';
                    showDateError('Clinic is closed on Sundays. Please select a weekday or Saturday.');
                } else {
                    this.style.borderColor = '#28a745';
                    this.style.boxShadow = '0 0 0 3px rgba(40, 167, 69, 0.1)';
                    hideDateError();
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
                
                // Insert after the appointment info
                const appointmentInfo = document.querySelector('.appointment-info');
                if (appointmentInfo) {
                    appointmentInfo.parentNode.insertBefore(errorDiv, appointmentInfo.nextSibling);
                }
            }
            
            function showDateError(message) {
                let errorDiv = document.getElementById('dateError');
                if (!errorDiv) {
                    errorDiv = document.createElement('div');
                    errorDiv.id = 'dateError';
                    errorDiv.className = 'medical-alert mt-2';
                    dateInput.parentNode.appendChild(errorDiv);
                }
                errorDiv.innerHTML = `<i class="fas fa-exclamation-circle"></i><span>${message}</span>`;
            }
            
            function hideDateError() {
                const errorDiv = document.getElementById('dateError');
                if (errorDiv) errorDiv.remove();
            }
            
            // Add subtle animation to form elements on focus
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