<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Medical Booking System | Your Health, Our Priority</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&family=Open+Sans:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Open Sans', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #e8f4ff 100%);
            color: #2c3e50;
            min-height: 100vh;
            overflow-x: hidden;
        }
        
        /* Hero Section */
        .hero-section {
            min-height: 100vh;
            display: flex;
            align-items: center;
            position: relative;
            overflow: hidden;
            padding: 80px 0;
        }
        
        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 60%;
            height: 100%;
            background: linear-gradient(135deg, rgba(26, 115, 232, 0.05) 0%, rgba(40, 167, 69, 0.05) 100%);
            clip-path: polygon(25% 0%, 100% 0%, 100% 100%, 0% 100%);
            z-index: 0;
        }
        
        .hero-content {
            position: relative;
            z-index: 2;
            max-width: 600px;
            padding: 0 40px;
        }
        
        .hero-tagline {
            font-family: 'Montserrat', sans-serif;
            font-size: 1rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 3px;
            color: #1a73e8;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .hero-title {
            font-family: 'Montserrat', sans-serif;
            font-size: 4rem;
            font-weight: 700;
            line-height: 1.1;
            color: #2c3e50;
            margin-bottom: 1.5rem;
        }
        
        .hero-title span {
            color: #1a73e8;
            position: relative;
        }
        
        .hero-title span::after {
            content: '';
            position: absolute;
            bottom: 5px;
            left: 0;
            width: 100%;
            height: 8px;
            background: rgba(26, 115, 232, 0.2);
            z-index: -1;
        }
        
        .hero-description {
            font-size: 1.25rem;
            line-height: 1.8;
            color: #6c757d;
            margin-bottom: 2.5rem;
            max-width: 500px;
        }
        
        .hero-stats {
            display: flex;
            gap: 3rem;
            margin-bottom: 2.5rem;
            flex-wrap: wrap;
        }
        
        .stat-item {
            text-align: center;
        }
        
        .stat-number {
            font-family: 'Montserrat', sans-serif;
            font-size: 2.5rem;
            font-weight: 700;
            color: #1a73e8;
            line-height: 1;
            margin-bottom: 5px;
        }
        
        .stat-label {
            font-size: 0.9rem;
            color: #6c757d;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        /* Navigation */
        .medical-navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 1.5rem 0;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        }
        
        .navbar-brand {
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
            font-size: 1.8rem;
            color: #1a73e8;
            display: flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
        }
        
        .navbar-brand i {
            color: #1a73e8;
            font-size: 2rem;
        }
        
        /* Buttons */
        .btn-medical-primary {
            background: linear-gradient(135deg, #1a73e8, #2a8bf2);
            color: #ffffff;
            border: none;
            padding: 16px 40px;
            border-radius: 10px;
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            font-size: 1.1rem;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            box-shadow: 0 10px 25px rgba(26, 115, 232, 0.2);
        }
        
        .btn-medical-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(26, 115, 232, 0.3);
            color: #ffffff;
        }
        
        .btn-medical-outline {
            background: transparent;
            color: #1a73e8;
            border: 2px solid #1a73e8;
            padding: 14px 30px;
            border-radius: 10px;
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            font-size: 1rem;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }
        
        .btn-medical-outline:hover {
            background: #1a73e8;
            color: #ffffff;
            transform: translateY(-3px);
        }
        
        .button-group {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }
        
        /* Hero Visual */
        .hero-visual {
            position: relative;
            z-index: 1;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .medical-illustration {
            width: 100%;
            height: 600px;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .circle-1 {
            width: 400px;
            height: 400px;
            border-radius: 50%;
            background: linear-gradient(135deg, rgba(26, 115, 232, 0.1) 0%, rgba(40, 167, 69, 0.1) 100%);
            position: absolute;
            animation: float 6s ease-in-out infinite;
        }
        
        .circle-2 {
            width: 300px;
            height: 300px;
            border-radius: 50%;
            background: linear-gradient(135deg, rgba(23, 162, 184, 0.1) 0%, rgba(111, 66, 193, 0.1) 100%);
            position: absolute;
            animation: float 8s ease-in-out infinite;
            animation-delay: 1s;
        }
        
        .doctor-avatar {
            width: 350px;
            height: 350px;
            background: linear-gradient(135deg, #1a73e8, #17a2b8);
            border-radius: 50%;
            position: relative;
            z-index: 2;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        .doctor-avatar i {
            font-size: 8rem;
            color: rgba(255, 255, 255, 0.9);
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(5deg); }
        }
        
        /* Features Section */
        .features-section {
            padding: 100px 0;
            background: #ffffff;
        }
        
        .section-title {
            text-align: center;
            margin-bottom: 60px;
        }
        
        .section-title h2 {
            font-family: 'Montserrat', sans-serif;
            font-size: 2.5rem;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 15px;
        }
        
        .section-title p {
            color: #6c757d;
            font-size: 1.1rem;
            max-width: 600px;
            margin: 0 auto;
        }
        
        .feature-card {
            background: #ffffff;
            border-radius: 20px;
            padding: 40px 30px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            height: 100%;
            border: 2px solid transparent;
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
            border-color: #1a73e8;
            box-shadow: 0 20px 40px rgba(26, 115, 232, 0.1);
        }
        
        .feature-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #1a73e8, #2a8bf2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 25px;
        }
        
        .feature-icon i {
            font-size: 2.5rem;
            color: #ffffff;
        }
        
        .feature-card h3 {
            font-family: 'Montserrat', sans-serif;
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 15px;
            color: #2c3e50;
        }
        
        .feature-card p {
            color: #6c757d;
            line-height: 1.6;
        }
        
        /* Footer */
        .medical-footer {
            background: #2c3e50;
            color: #ffffff;
            padding: 60px 0 30px;
        }
        
        .footer-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
            flex-wrap: wrap;
            gap: 30px;
        }
        
        .footer-logo {
            font-family: 'Montserrat', sans-serif;
            font-size: 1.8rem;
            font-weight: 700;
            color: #ffffff;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .footer-links {
            display: flex;
            gap: 30px;
        }
        
        .footer-links a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: color 0.3s ease;
        }
        
        .footer-links a:hover {
            color: #ffffff;
        }
        
        .footer-bottom {
            text-align: center;
            padding-top: 30px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            color: rgba(255, 255, 255, 0.6);
            font-size: 0.9rem;
        }
        
        /* Responsive Design */
        @media (max-width: 992px) {
            .hero-section {
                padding: 120px 0 60px;
            }
            
            .hero-title {
                font-size: 3rem;
            }
            
            .hero-section::before {
                width: 100%;
                clip-path: polygon(0 0, 100% 0, 100% 100%, 0% 100%);
                opacity: 0.3;
            }
            
            .hero-visual {
                margin-top: 60px;
                height: 400px;
            }
            
            .medical-illustration {
                height: 400px;
            }
            
            .circle-1, .circle-2, .doctor-avatar {
                transform: scale(0.8);
            }
        }
        
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }
            
            .hero-description {
                font-size: 1.1rem;
            }
            
            .button-group {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .btn-medical-primary, .btn-medical-outline {
                width: 100%;
                justify-content: center;
            }
            
            .hero-stats {
                gap: 2rem;
            }
            
            .stat-number {
                font-size: 2rem;
            }
            
            .section-title h2 {
                font-size: 2rem;
            }
        }
        
        /* Medical Badge */
        .medical-badge {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: rgba(255, 255, 255, 0.9);
            padding: 12px 24px;
            border-radius: 50px;
            font-weight: 600;
            color: #1a73e8;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 2rem;
        }
        
        .medical-badge i {
            font-size: 1.2rem;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="medical-navbar">
        <div class="container">
            <a href="#" class="navbar-brand">
                <i class="fas fa-hospital-alt"></i>
                <span>MedicalCare</span>
            </a>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <div class="hero-content">
                        <div class="medical-badge">
                            <i class="fas fa-shield-alt"></i>
                            <span>Trusted Healthcare Since 2025</span>
                        </div>
                        
                        <div class="hero-tagline">
                            <i class="fas fa-heartbeat"></i>
                            Compassionate Medical Care
                        </div>
                        
                        <h1 class="hero-title">
                            Your Health, <span>Our Priority</span>
                        </h1>
                        
                        <p class="hero-description">
                            Experience exceptional healthcare with our advanced medical booking system. 
                            Connect with certified specialists, schedule appointments seamlessly, and 
                            take control of your health journey.
                        </p>
                        
                        <div class="hero-stats">
                            <div class="stat-item">
                                <div class="stat-number">24/7</div>
                                <div class="stat-label">Medical Support</div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-number">50+</div>
                                <div class="stat-label">Specialists</div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-number">10K+</div>
                                <div class="stat-label">Patients Served</div>
                            </div>
                        </div>
                        
                        <div class="button-group">
                            <a href="index.jsp" class="btn-medical-primary">
                                <i class="fas fa-arrow-right"></i>
                                Enter Healthcare Portal
                            </a>
                            <a href="#features" class="btn-medical-outline">
                                <i class="fas fa-stethoscope"></i>
                                Learn More
                            </a>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-6">
                    <div class="hero-visual">
                        <div class="medical-illustration">
                            <div class="circle-1"></div>
                            <div class="circle-2"></div>
                            <div class="doctor-avatar">
                                <i class="fas fa-user-md"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features-section" id="features">
        <div class="container">
            <div class="section-title">
                <h2>Why Choose MedicalCare?</h2>
                <p>Comprehensive healthcare solutions designed for your well-being</p>
            </div>
            
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <h3>Easy Appointment Booking</h3>
                        <p>Schedule appointments with specialists in just a few clicks. Real-time availability and instant confirmation.</p>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon" style="background: linear-gradient(135deg, #28a745, #20c997);">
                            <i class="fas fa-user-md"></i>
                        </div>
                        <h3>Certified Specialists</h3>
                        <p>Access to board-certified doctors and medical professionals across various specialties.</p>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon" style="background: linear-gradient(135deg, #17a2b8, #2a8bf2);">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h3>Secure & Private</h3>
                        <p>HIPAA compliant platform ensuring your medical information remains confidential and secure.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="medical-footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-logo">
                    <i class="fas fa-hospital-alt"></i>
                    <span>MedicalCare</span>
                </div>
                
                <div class="footer-links">
                    <a href="#">
                        <i class="fas fa-phone me-2"></i>
                        Emergency: 8335
                    </a>
                    <a href="#">
                        <i class="fas fa-envelope me-2"></i>
                        support@medicalcare.com
                    </a>
                    <a href="#">
                        <i class="fas fa-clock me-2"></i>
                        24/7 Available
                    </a>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p>&copy; 2025 MedicalCare System. All rights reserved. HIPAA Compliant Healthcare Platform.</p>
            </div>
        </div>
    </footer>

    <script>
        // Purely cosmetic animations
        document.addEventListener('DOMContentLoaded', function() {
            // Add scroll animation to navbar
            const navbar = document.querySelector('.medical-navbar');
            window.addEventListener('scroll', function() {
                if (window.scrollY > 50) {
                    navbar.style.background = 'rgba(255, 255, 255, 0.98)';
                    navbar.style.boxShadow = '0 4px 20px rgba(0, 0, 0, 0.1)';
                } else {
                    navbar.style.background = 'rgba(255, 255, 255, 0.95)';
                    navbar.style.boxShadow = '0 4px 20px rgba(0, 0, 0, 0.05)';
                }
            });
            
            // Add animation to feature cards on scroll
            const featureCards = document.querySelectorAll('.feature-card');
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            }, { threshold: 0.1 });
            
            featureCards.forEach(card => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                observer.observe(card);
            });
            
            // Animate stats counting
            const statNumbers = document.querySelectorAll('.stat-number');
            statNumbers.forEach(stat => {
                if (!stat.textContent.includes('+') && !stat.textContent.includes('/')) {
                    const target = parseInt(stat.textContent);
                    let current = 0;
                    const increment = Math.ceil(target / 50);
                    const interval = setInterval(() => {
                        current += increment;
                        if (current >= target) {
                            current = target;
                            clearInterval(interval);
                        }
                        stat.textContent = current;
                    }, 30);
                }
            });
            
            // Smooth scrolling for anchor links
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function(e) {
                    e.preventDefault();
                    const targetId = this.getAttribute('href');
                    if (targetId === '#') return;
                    
                    const targetElement = document.querySelector(targetId);
                    if (targetElement) {
                        window.scrollTo({
                            top: targetElement.offsetTop - 80,
                            behavior: 'smooth'
                        });
                    }
                });
            });
            
            // Add hover effect to doctor avatar
            const doctorAvatar = document.querySelector('.doctor-avatar');
            if (doctorAvatar) {
                doctorAvatar.addEventListener('mouseenter', function() {
                    this.style.transform = 'scale(1.05) rotate(5deg)';
                });
                
                doctorAvatar.addEventListener('mouseleave', function() {
                    this.style.transform = 'scale(1) rotate(0deg)';
                });
            }
        });
    </script>
</body>
</html>