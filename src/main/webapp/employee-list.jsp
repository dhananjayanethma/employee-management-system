<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.employee.model.Employee" %>
<%@ page import="java.util.List" %>
<%
    // Check if user is logged in
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Safely retrieve employees list from request attribute
    Object obj = request.getAttribute("employees");
    @SuppressWarnings("unchecked")
    List<Employee> employees = (List<Employee>) obj;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee List - EMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f4f6f9; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .sidebar { min-height: calc(100vh - 56px); background-color: #fff; box-shadow: 2px 0 5px rgba(0,0,0,0.05); }
        .nav-link { color: #495057; padding: 12px 20px; transition: all 0.3s; }
        .nav-link:hover, .nav-link.active { background-color: #667eea; color: white; border-radius: 8px; }
        .table-container { background: white; border-radius: 12px; padding: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .badge-active { background-color: #28a745; }
        .badge-inactive { background-color: #dc3545; }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="dashboard.jsp">
                <i class="fas fa-users-cog me-2"></i>EMS
            </a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle me-1"></i><%= session.getAttribute("fullName") %>
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
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard.jsp">
                            <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="EmployeeServlet?action=list">
                            <i class="fas fa-users me-2"></i>Employees
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="DepartmentServlet?action=list">
                            <i class="fas fa-building me-2"></i>Departments
                        </a>
                    </li>
                </ul>
            </nav>

            <!-- Main Content -->
            <main class="col-md-10 ms-sm-auto px-md-4 py-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-users me-2"></i>Employee Management</h2>
                    <a href="employee-form.jsp" class="btn btn-primary">
                        <i class="fas fa-plus me-2"></i>Add New Employee
                    </a>
                </div>

                <% if (request.getAttribute("successMessage") != null) { %>
                    <div class="alert alert-success alert-dismissible fade show">
                        <i class="fas fa-check-circle me-2"></i>
                        <%= request.getAttribute("successMessage") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>

                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        <%= request.getAttribute("errorMessage") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>

                <!-- Search Bar -->
                <div class="table-container mb-4">
                    <form action="EmployeeServlet" method="get" class="row g-3">
                        <input type="hidden" name="action" value="search">
                        <div class="col-md-10">
                            <input type="text" class="form-control" name="searchTerm" 
                                   placeholder="Search by name or email..." 
                                   value="<%= request.getAttribute("searchTerm") != null ? request.getAttribute("searchTerm") : "" %>">
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-search me-2"></i>Search
                            </button>
                        </div>
                    </form>
                </div>

                <!-- Employee Table -->
                <div class="table-container">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Department</th>
                                    <th>Position</th>
                                    <th>Salary</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (employees != null && !employees.isEmpty()) {
                                    for (Employee emp : employees) { %>
                                        <tr>
                                            <td><%= emp.getEmpId() %></td>
                                            <td><%= emp.getFullName() %></td>
                                            <td><%= emp.getEmail() %></td>
                                            <td><%= emp.getPhone() %></td>
                                            <td><%= emp.getDeptName() != null ? emp.getDeptName() : "N/A" %></td>
                                            <td><%= emp.getPosition() %></td>
                                            <td>LKR <%= String.format("%,.2f", emp.getSalary()) %></td>
                                            <td>
                                                <span class="badge <%= emp.getStatus().equals("Active") ? "badge-active" : "badge-inactive" %>">
                                                    <%= emp.getStatus() %>
                                                </span>
                                            </td>
                                            <td>
                                                <a href="EmployeeServlet?action=edit&id=<%= emp.getEmpId() %>" 
                                                   class="btn btn-sm btn-warning" title="Edit">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <a href="EmployeeServlet?action=delete&id=<%= emp.getEmpId() %>" 
                                                   class="btn btn-sm btn-danger" title="Delete"
                                                   onclick="return confirm('Are you sure you want to delete this employee?')">
                                                    <i class="fas fa-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    <% }
                                } else { %>
                                    <tr>
                                        <td colspan="9" class="text-center">No employees found</td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
