<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.employee.model.Employee" %>
<%@ page import="com.employee.model.Department" %>
<%@ page import="com.employee.dao.DepartmentDAO" %>
<%@ page import="java.util.List" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    Employee employee = (Employee) request.getAttribute("employee");
    boolean isEdit = (employee != null);
    
    DepartmentDAO deptDAO = new DepartmentDAO();
    List<Department> departments = deptDAO.getAllDepartments();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= isEdit ? "Edit" : "Add" %> Employee - EMS</title>
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
                    <h2><i class="fas fa-<%= isEdit ? "edit" : "plus" %> me-2"></i>
                        <%= isEdit ? "Edit" : "Add New" %> Employee
                    </h2>
                    <a href="EmployeeServlet?action=list" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Back to List
                    </a>
                </div>

                <div class="form-container">
                    <form action="EmployeeServlet" method="post" onsubmit="return validateForm()">
                        <input type="hidden" name="action" value="<%= isEdit ? "update" : "insert" %>">
                        <% if (isEdit) { %>
                            <input type="hidden" name="empId" value="<%= employee.getEmpId() %>">
                        <% } %>

                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">First Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="firstName" 
                                       value="<%= isEdit ? employee.getFirstName() : "" %>" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Last Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="lastName" 
                                       value="<%= isEdit ? employee.getLastName() : "" %>" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Email <span class="text-danger">*</span></label>
                                <input type="email" class="form-control" name="email" 
                                       value="<%= isEdit ? employee.getEmail() : "" %>" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Phone <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="phone" 
                                       value="<%= isEdit ? employee.getPhone() : "" %>" 
                                       pattern="[+]?[0-9]{10,13}" required>
                                <small class="text-muted">Format: +94771234567 or 0771234567</small>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Department <span class="text-danger">*</span></label>
                                <select class="form-select" name="deptId" required>
                                    <option value="">Select Department</option>
                                    <% for (Department dept : departments) { %>
                                        <option value="<%= dept.getDeptId() %>" 
                                            <%= isEdit && employee.getDeptId() == dept.getDeptId() ? "selected" : "" %>>
                                            <%= dept.getDeptName() %>
                                        </option>
                                    <% } %>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Position <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="position" 
                                       value="<%= isEdit ? employee.getPosition() : "" %>" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Salary (LKR) <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" name="salary" step="0.01" 
                                       value="<%= isEdit ? employee.getSalary() : "" %>" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Hire Date <span class="text-danger">*</span></label>
                                <input type="date" class="form-control" name="hireDate" 
                                       value="<%= isEdit ? employee.getHireDate() : "" %>" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Status <span class="text-danger">*</span></label>
                                <select class="form-select" name="status" required>
                                    <option value="Active" <%= isEdit && employee.getStatus().equals("Active") ? "selected" : "" %>>Active</option>
                                    <option value="Inactive" <%= isEdit && employee.getStatus().equals("Inactive") ? "selected" : "" %>>Inactive</option>
                                </select>
                            </div>

                            <div class="col-12">
                                <hr>
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="fas fa-save me-2"></i><%= isEdit ? "Update" : "Save" %> Employee
                                </button>
                                <a href="EmployeeServlet?action=list" class="btn btn-secondary btn-lg ms-2">
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
    <script>
        function validateForm() {
            const salary = parseFloat(document.getElementsByName('salary')[0].value);
            if (salary < 0) {
                alert('Salary cannot be negative!');
                return false;
            }
            return true;
        }
    </script>
</body>
</html>