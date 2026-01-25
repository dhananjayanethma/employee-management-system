package com.employee.servlet;

import com.employee.dao.EmployeeDAO;
import com.employee.model.Employee;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

/**
 * Employee Servlet - Handles all employee CRUD operations
 */
@WebServlet("/EmployeeServlet")
public class EmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EmployeeDAO employeeDAO;
    
    @Override
    public void init() throws ServletException {
        employeeDAO = new EmployeeDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        try {
            switch (action) {
                case "list":
                    listEmployees(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteEmployee(request, response);
                    break;
                case "search":
                    searchEmployees(request, response);
                    break;
                default:
                    listEmployees(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "insert":
                    insertEmployee(request, response);
                    break;
                case "update":
                    updateEmployee(request, response);
                    break;
                default:
                    listEmployees(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
    
    private void listEmployees(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Employee> employees = employeeDAO.getAllEmployees();
        request.setAttribute("employees", employees);
        request.getRequestDispatcher("employee-list.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int empId = Integer.parseInt(request.getParameter("id"));
        Employee employee = employeeDAO.getEmployeeById(empId);
        request.setAttribute("employee", employee);
        request.getRequestDispatcher("employee-form.jsp").forward(request, response);
    }
    
    private void insertEmployee(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        int deptId = Integer.parseInt(request.getParameter("deptId"));
        String position = request.getParameter("position");
        double salary = Double.parseDouble(request.getParameter("salary"));
        Date hireDate = Date.valueOf(request.getParameter("hireDate"));
        String status = request.getParameter("status");
        
        Employee employee = new Employee(firstName, lastName, email, phone, deptId, 
                                         position, salary, hireDate, status);
        
        boolean success = employeeDAO.insertEmployee(employee);
        
        if (success) {
            request.setAttribute("successMessage", "Employee added successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to add employee!");
        }
        
        listEmployees(request, response);
    }
    
    private void updateEmployee(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int empId = Integer.parseInt(request.getParameter("empId"));
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        int deptId = Integer.parseInt(request.getParameter("deptId"));
        String position = request.getParameter("position");
        double salary = Double.parseDouble(request.getParameter("salary"));
        Date hireDate = Date.valueOf(request.getParameter("hireDate"));
        String status = request.getParameter("status");
        
        Employee employee = new Employee(firstName, lastName, email, phone, deptId, 
                                         position, salary, hireDate, status);
        employee.setEmpId(empId);
        
        boolean success = employeeDAO.updateEmployee(employee);
        
        if (success) {
            request.setAttribute("successMessage", "Employee updated successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to update employee!");
        }
        
        listEmployees(request, response);
    }
    
    private void deleteEmployee(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int empId = Integer.parseInt(request.getParameter("id"));
        boolean success = employeeDAO.deleteEmployee(empId);
        
        if (success) {
            request.setAttribute("successMessage", "Employee deleted successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to delete employee!");
        }
        
        listEmployees(request, response);
    }
    
    private void searchEmployees(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String searchTerm = request.getParameter("searchTerm");
        List<Employee> employees = employeeDAO.searchEmployees(searchTerm);
        request.setAttribute("employees", employees);
        request.setAttribute("searchTerm", searchTerm);
        request.getRequestDispatcher("employee-list.jsp").forward(request, response);
    }
}