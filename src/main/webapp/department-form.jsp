<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.employee.model.Department" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    Department department = (Department) request.getAttribute("department");
    boolean isEdit = (department != null);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= isEdit ? "Edit" : "Add" %> Department - EMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f4f6f9; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .sidebar { min-height: calc(100vh - 56px); background-color: #fff; box-shadow: 2px 0 5px rgba(0,0,0,0.05); }
        .nav-link { color: #495057; padding: 12px 20px; transition: all 0.3s; }
        .nav-link:hover, .nav-link.active { background-color: #667eea; color: white; border-radius: 8px; }
        .form-container { background: white; border-radius: 12px; padding: 30px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
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
                        <a class="nav-link" href="EmployeeServlet?action=list">
                            <i class="fas fa-users me-2"></i>Employees
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="DepartmentServlet?action=list">
                            <i class="fas fa-building me-2"></i>Departments
                        </a>
                    </li>
                </ul>
            </nav>

            <!-- Main Content -->
            <main class="col-md-10 ms-sm-auto px-md-4 py-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-<%= isEdit ? "edit" : "plus" %> me-2"></i>
                        <%= isEdit ? "Edit" : "Add New" %> Department
                    </h2>
                    <a href="DepartmentServlet?action=list" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Back to List
                    </a>
                </div>

                <div class="form-container">
                    <form action="DepartmentServlet" method="post">
                        <input type="hidden" name="action" value="<%= isEdit ? "update" : "insert" %>">
                        <% if (isEdit) { %>
                            <input type="hidden" name="deptId" value="<%= department.getDeptId() %>">
                        <% } %>

                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Department Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="deptName" 
                                       value="<%= isEdit ? department.getDeptName() : "" %>" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Department Code <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="deptCode" 
                                       value="<%= isEdit ? department.getDeptCode() : "" %>" 
                                       maxlength="20" required>
                                <small class="text-muted">e.g., IT, HR, FIN</small>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Location <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="location" 
                                       value="<%= isEdit ? department.getLocation() : "" %>" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Manager Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="managerName" 
                                       value="<%= isEdit ? department.getManagerName() : "" %>" required>
                            </div>

                            <div class="col-12">
                                <hr>
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="fas fa-save me-2"></i><%= isEdit ? "Update" : "Save" %> Department
                                </button>
                                <a href="DepartmentServlet?action=list" class="btn btn-secondary btn-lg ms-2">
                                    <i class="fas fa-times me-2"></i>Cancel
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>