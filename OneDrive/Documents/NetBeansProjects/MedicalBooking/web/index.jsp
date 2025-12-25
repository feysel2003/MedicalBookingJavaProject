<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medical Booking System | Healthcare Portal</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e8f4ff 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .home-container {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
        }
        
        .header-section {
            text-align: center;
            margin-bottom: 3rem;
            max-width: 800px;
        }
        
        .medical-title {
            color: #1a73e8;
            font-weight: 800;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }
        
        .medical-title i {
            font-size: 3.5rem;
            background: linear-gradient(135deg, #1a73e8, #2a8bf2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .tagline {
            color: #6c757d;
            font-size: 1.3rem;
            margin-bottom: 10px;
        }
        
        .sub-tagline {
            color: #17a2b8;
            font-weight: 500;
            font-size: 1.1rem;
        }
        
        .portal-cards {
            display: flex;
            justify-content: center;
            gap: 2rem;
            flex-wrap: wrap;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .portal-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 115, 230, 0.08);
            border: none;
            width: 320px;
            transition: all 0.4s ease;
            overflow: hidden;
            border-top: 5px solid #1a73e8;
        }
        
        .portal-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 20px 40px rgba(0, 115, 230, 0.15);
        }
        
        .card-icon {
            height: 120px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 2rem 0 1rem;
        }
        
        .card-icon i {
            font-size: 4.5rem;
            background: linear-gradient(135deg, #1a73e8, #2a8bf2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .card-content {
            padding: 0 2rem 2rem;
            text-align: center;
        }
        
        .card-title {
            color: #2c3e50;
            font-weight: 700;
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }
        
        .card-description {
            color: #6c757d;
            font-size: 1rem;
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }
        
        .btn-portal {
            background: linear-gradient(to right, #1a73e8, #2a8bf2);
            color: white;
            border: none;
            padding: 14px 32px;
            border-radius: 10px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            width: 100%;
            text-decoration: none;
        }
        
        .btn-portal:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(26, 115, 232, 0.3);
            color: white;
        }
        
        /* Patient Card */
        .patient-card {
            border-top: 5px solid #1a73e8;
        }
        
        .patient-card .card-icon i {
            background: linear-gradient(135deg, #1a73e8, #2a8bf2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .patient-card .btn-portal {
            background: linear-gradient(to right, #1a73e8, #2a8bf2);
        }
        
        /* Doctor Card */
        .doctor-card {
            border-top: 5px solid #28a745;
        }
        
        .doctor-card .card-icon i {
            background: linear-gradient(135deg, #28a745, #20c997);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .doctor-card .btn-portal {
            background: linear-gradient(to right, #28a745, #20c997);
        }
        
        /* Admin Card */
        .admin-card {
            border-top: 5px solid #dc3545;
        }
        
        .admin-card .card-icon i {
            background: linear-gradient(135deg, #dc3545, #e4606d);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .admin-card .btn-portal {
            background: linear-gradient(to right, #dc3545, #e4606d);
        }
        
        .footer-section {
            text-align: center;
            margin-top: 4rem;
            color: #6c757d;
            font-size: 0.95rem;
            padding: 0 20px;
        }
        
        .footer-section i {
            color: #1a73e8;
            margin: 0 5px;
        }
        
        .features {
            display: flex;
            justify-content: center;
            gap: 2rem;
            flex-wrap: wrap;
            margin: 3rem auto;
            max-width: 900px;
        }
        
        .feature-item {
            text-align: center;
            color: #6c757d;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .feature-item i {
            color: #1a73e8;
            font-size: 1.2rem;
        }
        
        @media (max-width: 768px) {
            .home-container {
                padding: 30px 15px;
            }
            
            .header-section {
                margin-bottom: 2rem;
            }
            
            .medical-title {
                font-size: 2.2rem;
                flex-direction: column;
                gap: 10px;
            }
            
            .medical-title i {
                font-size: 3rem;
            }
            
            .tagline {
                font-size: 1.1rem;
            }
            
            .portal-cards {
                flex-direction: column;
                align-items: center;
                gap: 1.5rem;
            }
            
            .portal-card {
                width: 100%;
                max-width: 320px;
            }
            
            .features {
                flex-direction: column;
                gap: 1rem;
            }
        }
        
        .hospital-badge {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: #e8f4ff;
            padding: 10px 20px;
            border-radius: 25px;
            color: #1a73e8;
            font-weight: 600;
            margin-top: 1rem;
        }
    </style>
</head>
<body>
    <div class="home-container">
        <!-- Header Section -->
        <div class="header-section">
            <h1 class="medical-title">
                <i class="fas fa-hospital-alt"></i> Medical Booking System
            </h1>
            <p class="tagline">Your trusted partner in healthcare management</p>
            <p class="sub-tagline">Secure, fast, and reliable medical appointment scheduling</p>
            
            <div class="hospital-badge">
                <i class="fas fa-shield-alt"></i>
                <span>HIPAA Compliant & Secure</span>
            </div>
        </div>
        
        <!-- Features Section -->
        <div class="features">
            <div class="feature-item">
                <i class="fas fa-clock"></i>
                <span>24/7 Appointment Booking</span>
            </div>
            <div class="feature-item">
                <i class="fas fa-user-md"></i>
                <span>Certified Medical Professionals</span>
            </div>
            <div class="feature-item">
                <i class="fas fa-lock"></i>
                <span>Secure Data Protection</span>
            </div>
        </div>
        
        <!-- Portal Cards -->
        <div class="portal-cards">
            <!-- Patient Card -->
            <div class="portal-card patient-card">
                <div class="card-icon">
                    <i class="fas fa-user-injured"></i>
                </div>
                <div class="card-content">
                    <h3 class="card-title">Patient Portal</h3>
                    <p class="card-description">
                        Book appointments, view medical history, and manage your healthcare journey.
                        Easy access to your medical records and doctor consultations.
                    </p>
                    <a href="login.jsp" class="btn btn-portal">
                        <i class="fas fa-sign-in-alt"></i> Login / Register
                    </a>
                </div>
            </div>
            
            <!-- Doctor Card -->
            <div class="portal-card doctor-card">
                <div class="card-icon">
                    <i class="fas fa-user-md"></i>
                </div>
                <div class="card-content">
                    <h3 class="card-title">Doctor Portal</h3>
                    <p class="card-description">
                        Manage patient appointments, view schedules, and access medical records.
                        Streamlined workflow for healthcare professionals.
                    </p>
                    <a href="doctorLogin.jsp" class="btn btn-portal">
                        <i class="fas fa-stethoscope"></i> Doctor Login
                    </a>
                </div>
            </div>
            
            <!-- Admin Card -->
            <div class="portal-card admin-card">
                <div class="card-icon">
                    <i class="fas fa-user-shield"></i>
                </div>
                <div class="card-content">
                    <h3 class="card-title">Admin Portal</h3>
                    <p class="card-description">
                        System administration, manage doctors and patients, and oversee all medical operations.
                        Complete control and monitoring capabilities.
                    </p>
                    <a href="adminLogin.jsp" class="btn btn-portal">
                        <i class="fas fa-cogs"></i> System Login
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Footer Section -->
        <div class="footer-section">
            <p>
                <i class="fas fa-phone-alt"></i> Support: 1-800-MED-BOOK |
                <i class="fas fa-envelope"></i> contact@medicalbooking.com |
                <i class="fas fa-map-marker-alt"></i> Available 24/7
            </p>
            <p class="mt-2">
                <small>&copy; 2025 Medical Booking System. All rights reserved. HIPAA Compliant.</small>
            </p>
        </div>
    </div>

    <script>
        // Purely cosmetic animations
        document.addEventListener('DOMContentLoaded', function() {
            // Add staggered animation to cards
            const cards = document.querySelectorAll('.portal-card');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(30px)';
                
                setTimeout(() => {
                    card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 200);
            });
            
            // Add pulse animation to title
            const titleIcon = document.querySelector('.medical-title i');
            setInterval(() => {
                titleIcon.style.transform = 'scale(1.1)';
                setTimeout(() => {
                    titleIcon.style.transform = 'scale(1)';
                }, 300);
            }, 3000);
            
            // Add hover sound effects (visual only)
            const buttons = document.querySelectorAll('.btn-portal');
            buttons.forEach(button => {
                button.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-3px) scale(1.02)';
                });
                
                button.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0) scale(1)';
                });
            });
        });
    </script>
</body>
</html>