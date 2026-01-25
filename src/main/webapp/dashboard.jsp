<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.employee.dao.*" %>
<%@ page import="java.util.*" %>
<%
    // Check if user is logged in
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get statistics
    EmployeeDAO empDAO = new EmployeeDAO();
    DepartmentDAO deptDAO = new DepartmentDAO();
    int totalEmployees = empDAO.getAllEmployees().size();
    int totalDepartments = deptDAO.getAllDepartments().size();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Employee Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f4f6f9;
        }
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .sidebar {
            min-height: calc(100vh - 56px);
            background-color: #fff;
            box-shadow: 2px 0 5px rgba(0,0,0,0.05);
        }
        .nav-link {
            color: #495057;
            padding: 12px 20px;
            transition: all 0.3s;
        }
        .nav-link:hover, .nav-link.active {
            background-color: #667eea;
            color: white;
            border-radius: 8px;
        }
        .stat-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.07);
            transition: transform 0.3s;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        .stat-icon {
            font-size: 3rem;
            opacity: 0.2;
        }
        .welcome-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="dashboard.jsp">
                <i class="fas fa-users-cog me-2"></i>EMS
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" 
                           data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle me-1"></i>
                            <%= session.getAttribute("fullName") %>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="LogoutServlet">
                                <i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav class="col-md-2 d-md-block sidebar p-3">
                <div class="position-sticky">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link active" href="dashboard.jsp">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="EmployeeServlet?action=list">
                                <i class="fas fa-users me-2"></i>Employees
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="DepartmentServlet?action=list">
                                <i class="fas fa-building me-2"></i>Departments
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main Content -->
            <main class="col-md-10 ms-sm-auto px-md-4 py-4">
                <!-- Welcome Section -->
                <div class="welcome-section">
                    <h2><i class="fas fa-hand-wave me-2"></i>Welcome back, <%= session.getAttribute("fullName") %>!</h2>
                    <p class="mb-0">Here's what's happening with your workforce today.</p>
                </div>

                <!-- Statistics Cards -->
                <div class="row g-4 mb-4">
                    <div class="col-md-6 col-lg-3">
                        <div class="card stat-card text-white bg-primary">
                            <div class="card-body position-relative">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="card-subtitle mb-2">Total Employees</h6>
                                        <h2 class="card-title mb-0"><%= totalEmployees %></h2>
                                    </div>
                                    <i class="fas fa-users stat-icon"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-lg-3">
                        <div class="card stat-card text-white bg-success">
                            <div class="card-body position-relative">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="card-subtitle mb-2">Departments</h6>
                                        <h2 class="card-title mb-0"><%= totalDepartments %></h2>
                                    </div>
                                    <i class="fas fa-building stat-icon"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-lg-3">
                        <div class="card stat-card text-white bg-warning">
                            <div class="card-body position-relative">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="card-subtitle mb-2">Active Status</h6>
                                        <h2 class="card-title mb-0">100%</h2>
                                    </div>
                                    <i class="fas fa-chart-line stat-icon"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-lg-3">
                        <div class="card stat-card text-white bg-info">
                            <div class="card-body position-relative">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="card-subtitle mb-2">System Status</h6>
                                        <h2 class="card-title mb-0">Online</h2>
                                    </div>
                                    <i class="fas fa-server stat-icon"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header bg-white">
                                <h5 class="mb-0"><i class="fas fa-bolt me-2"></i>Quick Actions</h5>
                            </div>
                            <div class="card-body">
                                <div class="row g-3">
                                    <div class="col-md-4">
                                        <a href="employee-form.jsp" class="btn btn-outline-primary w-100 p-3">
                                            <i class="fas fa-user-plus fa-2x d-block mb-2"></i>
                                            Add New Employee
                                        </a>
                                    </div>
                                    <div class="col-md-4">
                                        <a href="department-form.jsp" class="btn btn-outline-success w-100 p-3">
                                            <i class="fas fa-building fa-2x d-block mb-2"></i>
                                            Add New Department
                                        </a>
                                    </div>
                                    <div class="col-md-4">
                                        <a href="EmployeeServlet?action=list" class="btn btn-outline-info w-100 p-3">
                                            <i class="fas fa-list fa-2x d-block mb-2"></i>
                                            View All Employees
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>