<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Patient" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Registry | Medical Booking System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e8f4ff 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px;
        }
        
        .registry-container {
            max-width: 1400px;
            margin: 2rem auto;
            padding: 0 15px;
        }
        
        .page-header {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 5px 15px rgba(0, 115, 230, 0.08);
            border-left: 5px solid #28a745;
        }
        
        .page-header h4 {
            color: #28a745;
            font-weight: 700;
            margin-bottom: 5px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .page-header h4 i {
            font-size: 1.8rem;
            background: rgba(40, 167, 69, 0.1);
            padding: 12px;
            border-radius: 12px;
        }
        
        .header-subtitle {
            color: #6c757d;
            font-size: 1.1rem;
            margin-left: 45px;
        }
        
        .registry-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 115, 230, 0.08);
            overflow: hidden;
            margin-bottom: 2rem;
        }
        
        .table-header {
            background: linear-gradient(to right, #28a745, #20c997);
            color: white;
            padding: 1.5rem;
        }
        
        .table-header h3 {
            margin: 0;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        table {
            margin: 0;
            border-collapse: separate;
            border-spacing: 0;
        }
        
        thead th {
            background: #e8f4ff;
            color: #28a745;
            font-weight: 600;
            padding: 1rem 1.5rem;
            border-bottom: 2px solid #dee2e6;
            border-top: none;
        }
        
        tbody td {
            padding: 1.2rem 1.5rem;
            vertical-align: middle;
            border-bottom: 1px solid #e9ecef;
        }
        
        tbody tr {
            transition: all 0.3s ease;
        }
        
        tbody tr:hover {
            background-color: #f8f9fa;
            transform: translateX(3px);
        }
        
        .patient-id {
            font-weight: 600;
            color: #6c757d;
            background: #f8f9fa;
            padding: 6px 12px;
            border-radius: 15px;
            display: inline-block;
        }
        
        .patient-name {
            font-weight: 600;
            color: #2c3e50;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .patient-name i {
            color: #1a73e8;
        }
        
        .patient-email {
            color: #6c757d;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .patient-email i {
            color: #17a2b8;
        }
        
        .patient-phone {
            color: #2c3e50;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .patient-phone i {
            color: #28a745;
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
            margin-top: 1.5rem;
        }
        
        .btn-back:hover {
            background: #e8f4ff;
            color: #1a73e8;
            transform: translateY(-2px);
        }
        
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #6c757d;
        }
        
        .empty-state i {
            font-size: 4rem;
            color: #e8f4ff;
            margin-bottom: 1rem;
        }
        
        .empty-state h4 {
            color: #1a73e8;
            margin-bottom: 10px;
        }
        
        .stats-summary {
            background: #e8f4ff;
            padding: 1.5rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            display: flex;
            gap: 2rem;
            flex-wrap: wrap;
        }
        
        .stat-item {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #2c3e50;
        }
        
        .stat-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }
        
        .stat-total .stat-icon {
            background: linear-gradient(135deg, #28a745, #20c997);
        }
        
        .stat-new .stat-icon {
            background: linear-gradient(135deg, #17a2b8, #2a8bf2);
        }
        
        .stat-number {
            font-weight: 700;
            font-size: 1.5rem;
            line-height: 1;
        }
        
        .stat-label {
            font-size: 0.9rem;
            color: #6c757d;
        }
        
        @media (max-width: 768px) {
            .registry-container {
                margin: 1rem auto;
                padding: 0 10px;
            }
            
            .page-header {
                padding: 1.5rem;
            }
            
            .page-header h4 {
                font-size: 1.5rem;
            }
            
            .header-subtitle {
                margin-left: 0;
            }
            
            thead th, tbody td {
                padding: 0.8rem;
                font-size: 0.9rem;
            }
            
            .stats-summary {
                flex-direction: column;
                gap: 1rem;
            }
        }
        
        .table-responsive {
            overflow-x: auto;
        }
        
        .patient-actions {
            display: flex;
            gap: 8px;
        }
        
        .btn-view {
            background: linear-gradient(to right, #17a2b8, #2a8bf2);
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 0.85rem;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            text-decoration: none;
        }
        
        .btn-view:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(23, 162, 184, 0.2);
            color: white;
        }
    </style>
</head>
<body>
    <div class="registry-container">
        <!-- Page Header -->
        <div class="page-header">
            <h4>
                <i class="fas fa-users"></i> Patient Registry
            </h4>
            <div class="header-subtitle">Complete directory of registered patients and medical records</div>
        </div>
        
        <!-- Statistics -->
        <% 
            List<Patient> patientList = (List<Patient>) request.getAttribute("patients");
            if (patientList == null) {
                patientList = new ArrayList<Patient>();
            }
            
            int totalPatients = patientList.size();
        %>
        
        <div class="stats-summary">
            <div class="stat-item stat-total">
                <div class="stat-icon">
                    <i class="fas fa-user-injured"></i>
                </div>
                <div>
                    <div class="stat-number"><%= totalPatients %></div>
                    <div class="stat-label">Total Patients</div>
                </div>
            </div>
            
            <div class="stat-item stat-new">
                <div class="stat-icon">
                    <i class="fas fa-user-plus"></i>
                </div>
                <div>
                    <div class="stat-number"><%= totalPatients %></div>
                    <div class="stat-label">Registered Patients</div>
                </div>
            </div>
        </div>
        
        <!-- Patient Table -->
        <div class="registry-card">
            <div class="table-header">
                <h3>
                    <i class="fas fa-hospital-user"></i> Patient Directory
                </h3>
            </div>
            
            <% if (patientList.isEmpty()) { %>
                <div class="empty-state">
                    <i class="fas fa-user-injured"></i>
                    <h4>No Patients Found</h4>
                    <p>There are currently no patients registered in the system.</p>
                </div>
            <% } else { %>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th><i class="fas fa-id-card me-2"></i>Patient ID</th>
                                <th><i class="fas fa-user me-2"></i>Full Name</th>
                                <th><i class="fas fa-envelope me-2"></i>Email Address</th>
                                <th><i class="fas fa-phone me-2"></i>Phone Number</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Patient p : patientList) { %>
                                <tr>
                                    <td>
                                        <span class="patient-id">PAT-<%= p.getId() %></span>
                                    </td>
                                    <td>
                                        <div class="patient-name">
                                            <i class="fas fa-user-circle"></i> <%= p.getFullName() %>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="patient-email">
                                            <i class="fas fa-envelope"></i> <%= p.getEmail() %>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="patient-phone">
                                            <i class="fas fa-phone"></i> <%= p.getPhone() %>
                                        </div>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
        </div>
        
        <!-- Back Button -->
        <div class="text-center">
            <a href="AdminDashboardServlet" class="btn btn-back">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
        
        <!-- Footer Note -->
        <div class="text-center mt-4" style="color: #6c757d; font-size: 0.9rem;">
            <i class="fas fa-shield-alt me-2"></i>
            Patient Registry | Medical Booking System | HIPAA Compliant
        </div>
    </div>

    <script>
        // Purely cosmetic animations
        document.addEventListener('DOMContentLoaded', function() {
            // Add staggered animation to table rows
            const tableRows = document.querySelectorAll('tbody tr');
            tableRows.forEach((row, index) => {
                row.style.opacity = '0';
                row.style.transform = 'translateX(20px)';
                
                setTimeout(() => {
                    row.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                    row.style.opacity = '1';
                    row.style.transform = 'translateX(0)';
                }, index * 50);
            });
            
            // Add hover effect to table rows
            tableRows.forEach(row => {
                row.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateX(5px)';
                });
                
                row.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateX(0)';
                });
            });
            
            // Update statistics animation
            const statNumbers = document.querySelectorAll('.stat-number');
            statNumbers.forEach(stat => {
                const originalNumber = parseInt(stat.textContent);
                let currentNumber = 0;
                const increment = Math.ceil(originalNumber / 20);
                const interval = setInterval(() => {
                    currentNumber += increment;
                    if (currentNumber >= originalNumber) {
                        currentNumber = originalNumber;
                        clearInterval(interval);
                    }
                    stat.textContent = currentNumber;
                }, 50);
            });
            
            // Add search functionality (cosmetic only, doesn't affect data)
            const addSearchBar = () => {
                const header = document.querySelector('.table-header');
                const searchDiv = document.createElement('div');
                searchDiv.className = 'mt-3';
                searchDiv.innerHTML = `
                    <div class="input-group" style="max-width: 300px;">
                        <span class="input-group-text">
                            <i class="fas fa-search"></i>
                        </span>
                        <input type="text" id="patientSearch" class="form-control" placeholder="Search patients...">
                        <button class="btn btn-outline-light" type="button" onclick="clearSearch()">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                `;
                header.appendChild(searchDiv);
            };
            
            addSearchBar();
        });
        
        // Search functionality (client-side only)
        function searchPatients() {
            const searchTerm = document.getElementById('patientSearch').value.toLowerCase();
            const rows = document.querySelectorAll('tbody tr');
            
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                if (text.includes(searchTerm)) {
                    row.style.display = '';
                    row.style.opacity = '1';
                } else {
                    row.style.display = 'none';
                }
            });
        }
        
        function clearSearch() {
            document.getElementById('patientSearch').value = '';
            const rows = document.querySelectorAll('tbody tr');
            rows.forEach(row => {
                row.style.display = '';
                row.style.opacity = '1';
            });
        }
        
        // Add event listener for search
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('patientSearch');
            if (searchInput) {
                searchInput.addEventListener('input', searchPatients);
            }
        });
    </script>
</body>
</html>