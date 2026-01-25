package com.employee.servlet;

import com.employee.dao.DepartmentDAO;
import com.employee.model.Department;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Department Servlet - Handles all department CRUD operations
 */
@WebServlet("/DepartmentServlet")
public class DepartmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DepartmentDAO departmentDAO;
    
    @Override
    public void init() throws ServletException {
        departmentDAO = new DepartmentDAO();
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
                    listDepartments(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteDepartment(request, response);
                    break;
                default:
                    listDepartments(request, response);
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
                    insertDepartment(request, response);
                    break;
                case "update":
                    updateDepartment(request, response);
                    break;
                default:
                    listDepartments(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
    
    private void listDepartments(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Department> departments = departmentDAO.getAllDepartments();
        request.setAttribute("departments", departments);
        request.getRequestDispatcher("department-list.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int deptId = Integer.parseInt(request.getParameter("id"));
        Department department = departmentDAO.getDepartmentById(deptId);
        request.setAttribute("department", department);
        request.getRequestDispatcher("department-form.jsp").forward(request, response);
    }
    
    private void insertDepartment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String deptName = request.getParameter("deptName");
        String deptCode = request.getParameter("deptCode");
        String location = request.getParameter("location");
        String managerName = request.getParameter("managerName");
        
        Department department = new Department(deptName, deptCode, location, managerName);
        
        boolean success = departmentDAO.insertDepartment(department);
        
        if (success) {
            request.setAttribute("successMessage", "Department added successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to add department!");
        }
        
        listDepartments(request, response);
    }
    
    private void updateDepartment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int deptId = Integer.parseInt(request.getParameter("deptId"));
        String deptName = request.getParameter("deptName");
        String deptCode = request.getParameter("deptCode");
        String location = request.getParameter("location");
        String managerName = request.getParameter("managerName");
        
        Department department = new Department(deptName, deptCode, location, managerName);
        department.setDeptId(deptId);
        
        boolean success = departmentDAO.updateDepartment(department);
        
        if (success) {
            request.setAttribute("successMessage", "Department updated successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to update department!");
        }
        
        listDepartments(request, response);
    }
    
    private void deleteDepartment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int deptId = Integer.parseInt(request.getParameter("id"));
        boolean success = departmentDAO.deleteDepartment(deptId);
        
        if (success) {
            request.setAttribute("successMessage", "Department deleted successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to delete department!");
        }
        
        listDepartments(request, response);
    }
}