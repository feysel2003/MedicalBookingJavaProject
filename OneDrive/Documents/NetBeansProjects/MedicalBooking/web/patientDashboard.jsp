<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Patient" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page session="true" %>
<%
    Patient p = (Patient) session.getAttribute("currentPatient");
    if (p == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get current date and time for welcome message
    LocalDateTime now = LocalDateTime.now();
    DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("hh:mm a");
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("EEEE, MMMM dd, yyyy");
    String currentTime = now.format(timeFormatter);
    String currentDate = now.format(dateFormatter);
    
    // Determine greeting based on time of day
    String greeting;
    int hour = now.getHour();
    if (hour < 12) {
        greeting = "Good Morning";
    } else if (hour < 17) {
        greeting = "Good Afternoon";
    } else {
        greeting = "Good Evening";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Dashboard | Medical Booking System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e8f4ff 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px;
        }
        
        .dashboard-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 15px;
        }
        
        .welcome-header {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 5px 15px rgba(0, 115, 230, 0.08);
            border-left: 5px solid #1a73e8;
        }
        
        .greeting-section {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
            gap: 20px;
        }
        
        .patient-info {
            flex: 1;
        }
        
        .time-info {
            background: #e8f4ff;
            padding: 15px 20px;
            border-radius: 10px;
            text-align: center;
            min-width: 200px;
        }
        
        .greeting {
            color: #1a73e8;
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .greeting i {
            font-size: 2.2rem;
            background: rgba(26, 115, 232, 0.1);
            padding: 12px;
            border-radius: 12px;
        }
        
        .welcome-text {
            color: #6c757d;
            font-size: 1.2rem;
            margin-bottom: 15px;
        }
        
        .patient-details {
            background: #e8f4ff;
            padding: 1rem 1.5rem;
            border-radius: 10px;
            margin-top: 1rem;
            color: #2c3e50;
        }
        
        .patient-email {
            color: #6c757d;
            font-size: 1rem;
            margin-bottom: 5px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .current-time {
            color: #1a73e8;
            font-weight: 700;
            font-size: 1.8rem;
            margin-bottom: 5px;
        }
        
        .current-date {
            color: #6c757d;
            font-size: 0.95rem;
        }
        
        .action-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .action-card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 5px 15px rgba(0, 115, 230, 0.08);
            border-top: 5px solid #1a73e8;
            transition: all 0.3s ease;
            text-align: center;
            text-decoration: none;
            color: inherit;
            display: block;
        }
        
        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 115, 230, 0.15);
        }
        
        .action-card.book-appointment {
            border-top-color: #28a745;
        }
        
        .action-card.my-profile {
            border-top-color: #17a2b8;
        }
        
        .action-card.appointment-history {
            border-top-color: #6f42c1;
        }
        
        .action-card.logout {
            border-top-color: #dc3545;
        }
        
        .action-icon {
            width: 70px;
            height: 70px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
        }
        
        .action-card.book-appointment .action-icon {
            background: linear-gradient(135deg, #28a745, #20c997);
        }
        
        .action-card.my-profile .action-icon {
            background: linear-gradient(135deg, #17a2b8, #2a8bf2);
        }
        
        .action-card.appointment-history .action-icon {
            background: linear-gradient(135deg, #6f42c1, #9b6bff);
        }
        
        .action-card.logout .action-icon {
            background: linear-gradient(135deg, #dc3545, #e4606d);
        }
        
        .action-icon i {
            font-size: 2.5rem;
            color: white;
        }
        
        .action-title {
            font-weight: 700;
            color: #2c3e50;
            font-size: 1.3rem;
            margin-bottom: 10px;
        }
        
        .action-description {
            color: #6c757d;
            font-size: 0.95rem;
            margin-bottom: 1rem;
        }
        
        .patient-id {
            background: #e8f4ff;
            color: #1a73e8;
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
            display: inline-block;
        }
        
        .emergency-section {
            background: linear-gradient(135deg, #ff6b6b, #ff8e8e);
            color: white;
            border-radius: 15px;
            padding: 1.5rem;
            margin-top: 2rem;
            text-align: center;
        }
        
        .emergency-section i {
            font-size: 2rem;
            margin-bottom: 10px;
            display: block;
        }
        
        .emergency-section h4 {
            margin-bottom: 5px;
            font-weight: 600;
        }
        
        .emergency-section p {
            margin: 0;
            font-size: 0.9rem;
            opacity: 0.9;
        }
        
        @media (max-width: 768px) {
            .dashboard-container {
                margin: 1rem auto;
                padding: 0 10px;
            }
            
            .welcome-header {
                padding: 1.5rem;
            }
            
            .greeting {
                font-size: 1.5rem;
            }
            
            .greeting-section {
                flex-direction: column;
            }
            
            .time-info {
                width: 100%;
            }
            
            .action-cards {
                grid-template-columns: 1fr;
            }
        }
        
        .quick-stats {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 5px 15px rgba(0, 115, 230, 0.08);
            display: flex;
            gap: 2rem;
            flex-wrap: wrap;
            justify-content: space-around;
        }
        
        .stat-item {
            text-align: center;
        }
        
        .stat-number {
            font-weight: 700;
            font-size: 2rem;
            color: #1a73e8;
            line-height: 1;
        }
        
        .stat-label {
            color: #6c757d;
            font-size: 0.9rem;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <div class="welcome-header">
            <div class="greeting-section">
                <div class="patient-info">
                    <h1 class="greeting">
                        <i class="fas fa-heartbeat"></i> <%= greeting %>, <%= p.getFullName() %>!
                    </h1>
                    <p class="welcome-text">Welcome to your personal medical dashboard</p>
                    
                    <div class="patient-details">
                        <div class="patient-email">
                            <i class="fas fa-envelope"></i> <%= p.getEmail() %>
                        </div>
                        <div class="patient-id">
                            <i class="fas fa-id-card"></i> Patient ID: PAT-<%= p.getId() %>
                        </div>
                    </div>
                </div>
                
                <div class="time-info">
                    <div class="current-time"><%= currentTime %></div>
                    <div class="current-date"><%= currentDate %></div>
                </div>
            </div>
        </div>
        
        <div class="quick-stats">
            <div class="stat-item">
                <div class="stat-number">0</div>
                <div class="stat-label">Upcoming Appointments</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">0</div>
                <div class="stat-label">Completed Visits</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">24/7</div>
                <div class="stat-label">Medical Support</div>
            </div>
        </div>
        
        <div class="action-cards">
            <a href="bookAppointment" class="action-card book-appointment">
                <div class="action-icon">
                    <i class="fas fa-calendar-plus"></i>
                </div>
                <h3 class="action-title">Book Appointment</h3>
                <p class="action-description">Schedule a consultation with our certified medical specialists</p>
                <div class="btn btn-success" style="pointer-events: none;">
                    <i class="fas fa-plus-circle me-2"></i> Schedule Now
                </div>
            </a>
            
            <a href="ProfileServlet" class="action-card my-profile">
                <div class="action-icon">
                    <i class="fas fa-user-circle"></i>
                </div>
                <h3 class="action-title">My Profile</h3>
                <p class="action-description">View and update your personal information and medical details</p>
                <div class="btn btn-info" style="pointer-events: none; color: white;">
                    <i class="fas fa-user-edit me-2"></i> View Profile
                </div>
            </a>
            
            <a href="appointmentHistory.jsp" class="action-card appointment-history">
                <div class="action-icon">
                    <i class="fas fa-history"></i>
                </div>
                <h3 class="action-title">Appointment History</h3>
                <p class="action-description">Review past consultations and upcoming scheduled visits</p>
                <div class="btn btn-primary" style="pointer-events: none;">
                    <i class="fas fa-clipboard-list me-2"></i> View History
                </div>
            </a>
            
            <a href="index.jsp" class="action-card logout">
                <div class="action-icon">
                    <i class="fas fa-sign-out-alt"></i>
                </div>
                <h3 class="action-title">Logout</h3>
                <p class="action-description">Securely exit your medical portal session</p>
                <div class="btn btn-danger" style="pointer-events: none;">
                    <i class="fas fa-power-off me-2"></i> Sign Out
                </div>
            </a>
        </div>
        
        <div class="emergency-section">
            <i class="fas fa-ambulance"></i>
            <h4>Emergency Contact</h4>
            <p>For medical emergencies, call 8335 immediately</p>
            <p style="font-size: 0.8rem; margin-top: 10px;">24/7 Medical Support: 1-800-HELP-NOW</p>
        </div>
        
        <div class="text-center mt-4" style="color: #6c757d; font-size: 0.9rem;">
            <i class="fas fa-shield-alt me-2"></i>
            Your medical information is protected and confidential | HIPAA Compliant
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.action-card');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 100);
            });
            
            function updateTime() {
                const now = new Date();
                const timeElement = document.querySelector('.current-time');
                const dateElement = document.querySelector('.current-date');
                
                if (timeElement && dateElement) {
                    const options = { 
                        hour: '2-digit', 
                        minute: '2-digit',
                        hour12: true 
                    };
                    timeElement.textContent = now.toLocaleTimeString('en-US', options);
                    
                    const dateOptions = { 
                        weekday: 'long', 
                        year: 'numeric', 
                        month: 'long', 
                        day: 'numeric' 
                    };
                    dateElement.textContent = now.toLocaleDateString('en-US', dateOptions);
                    
                    const hour = now.getHours();
                    const greetingElement = document.querySelector('.greeting');
                    if (greetingElement) {
                        let greeting = "Good Evening";
                        if (hour < 12) greeting = "Good Morning";
                        else if (hour < 17) greeting = "Good Afternoon";
                        
                        const currentText = greetingElement.innerHTML;
                        const patientName = currentText.split(',')[1]?.split('!')[0] || '';
                        greetingElement.innerHTML = `<i class="fas fa-heartbeat"></i> ${greeting},${patientName}!`;
                    }
                }
            }
            
            updateTime();
            setInterval(updateTime, 60000);
            
            cards.forEach(card => {
                card.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-5px) scale(1.02)';
                });
                
                card.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0) scale(1)';
                });
            });
        });
    </script>
</body>
</html>