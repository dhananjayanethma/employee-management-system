package com.employee.dao;

import com.employee.model.Employee;
import com.employee.util.DBConnectionUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Employee Data Access Object
 * Handles all database operations for Employee entity
 */
public class EmployeeDAO {
    
    /**
     * Insert a new employee
     * @param employee Employee object to insert
     * @return true if successful, false otherwise
     */
    public boolean insertEmployee(Employee employee) {
        String sql = "INSERT INTO employee (first_name, last_name, email, phone, dept_id, position, salary, hire_date, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, employee.getFirstName());
            stmt.setString(2, employee.getLastName());
            stmt.setString(3, employee.getEmail());
            stmt.setString(4, employee.getPhone());
            stmt.setInt(5, employee.getDeptId());
            stmt.setString(6, employee.getPosition());
            stmt.setDouble(7, employee.getSalary());
            stmt.setDate(8, employee.getHireDate());
            stmt.setString(9, employee.getStatus());
            
            int result = stmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error inserting employee: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Retrieve all employees with department names
     * @return List of all employees
     */
    public List<Employee> getAllEmployees() {
        List<Employee> employees = new ArrayList<>();
        String sql = "SELECT e.*, d.dept_name FROM employee e " +
                     "LEFT JOIN department d ON e.dept_id = d.dept_id " +
                     "ORDER BY e.emp_id DESC";
        
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Employee emp = new Employee();
                emp.setEmpId(rs.getInt("emp_id"));
                emp.setFirstName(rs.getString("first_name"));
                emp.setLastName(rs.getString("last_name"));
                emp.setEmail(rs.getString("email"));
                emp.setPhone(rs.getString("phone"));
                emp.setDeptId(rs.getInt("dept_id"));
                emp.setDeptName(rs.getString("dept_name"));
                emp.setPosition(rs.getString("position"));
                emp.setSalary(rs.getDouble("salary"));
                emp.setHireDate(rs.getDate("hire_date"));
                emp.setStatus(rs.getString("status"));
                employees.add(emp);
            }
            
        } catch (SQLException e) {
            System.err.println("Error retrieving employees: " + e.getMessage());
            e.printStackTrace();
        }
        
        return employees;
    }
    
    /**
     * Get employee by ID
     * @param empId Employee ID
     * @return Employee object or null if not found
     */
    public Employee getEmployeeById(int empId) {
        String sql = "SELECT e.*, d.dept_name FROM employee e " +
                     "LEFT JOIN department d ON e.dept_id = d.dept_id " +
                     "WHERE e.emp_id = ?";
        
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, empId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Employee emp = new Employee();
                emp.setEmpId(rs.getInt("emp_id"));
                emp.setFirstName(rs.getString("first_name"));
                emp.setLastName(rs.getString("last_name"));
                emp.setEmail(rs.getString("email"));
                emp.setPhone(rs.getString("phone"));
                emp.setDeptId(rs.getInt("dept_id"));
                emp.setDeptName(rs.getString("dept_name"));
                emp.setPosition(rs.getString("position"));
                emp.setSalary(rs.getDouble("salary"));
                emp.setHireDate(rs.getDate("hire_date"));
                emp.setStatus(rs.getString("status"));
                return emp;
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting employee by ID: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Update employee information
     * @param employee Employee object with updated information
     * @return true if successful, false otherwise
     */
    public boolean updateEmployee(Employee employee) {
        String sql = "UPDATE employee SET first_name=?, last_name=?, email=?, phone=?, " +
                     "dept_id=?, position=?, salary=?, hire_date=?, status=? WHERE emp_id=?";
        
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, employee.getFirstName());
            stmt.setString(2, employee.getLastName());
            stmt.setString(3, employee.getEmail());
            stmt.setString(4, employee.getPhone());
            stmt.setInt(5, employee.getDeptId());
            stmt.setString(6, employee.getPosition());
            stmt.setDouble(7, employee.getSalary());
            stmt.setDate(8, employee.getHireDate());
            stmt.setString(9, employee.getStatus());
            stmt.setInt(10, employee.getEmpId());
            
            int result = stmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating employee: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Delete employee by ID
     * @param empId Employee ID to delete
     * @return true if successful, false otherwise
     */
    public boolean deleteEmployee(int empId) {
        String sql = "DELETE FROM employee WHERE emp_id = ?";
        
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, empId);
            int result = stmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error deleting employee: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Search employees by name
     * @param searchTerm Search term for name
     * @return List of matching employees
     */
    public List<Employee> searchEmployees(String searchTerm) {
        List<Employee> employees = new ArrayList<>();
        String sql = "SELECT e.*, d.dept_name FROM employee e " +
                     "LEFT JOIN department d ON e.dept_id = d.dept_id " +
                     "WHERE e.first_name LIKE ? OR e.last_name LIKE ? OR e.email LIKE ?";
        
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String pattern = "%" + searchTerm + "%";
            stmt.setString(1, pattern);
            stmt.setString(2, pattern);
            stmt.setString(3, pattern);
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Employee emp = new Employee();
                emp.setEmpId(rs.getInt("emp_id"));
                emp.setFirstName(rs.getString("first_name"));
                emp.setLastName(rs.getString("last_name"));
                emp.setEmail(rs.getString("email"));
                emp.setPhone(rs.getString("phone"));
                emp.setDeptId(rs.getInt("dept_id"));
                emp.setDeptName(rs.getString("dept_name"));
                emp.setPosition(rs.getString("position"));
                emp.setSalary(rs.getDouble("salary"));
                emp.setHireDate(rs.getDate("hire_date"));
                emp.setStatus(rs.getString("status"));
                employees.add(emp);
            }
            
        } catch (SQLException e) {
            System.err.println("Error searching employees: " + e.getMessage());
            e.printStackTrace();
        }
        
        return employees;
    }
}