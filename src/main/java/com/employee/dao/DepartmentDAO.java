package com.employee.dao;

import com.employee.model.Department;
import com.employee.util.DBConnectionUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Department Data Access Object
 * Handles all database operations for Department entity
 */
public class DepartmentDAO {
    
    /**
     * Insert a new department
     * @param dept Department object to insert
     * @return true if successful, false otherwise
     */
    public boolean insertDepartment(Department dept) {
        String sql = "INSERT INTO department (dept_name, dept_code, location, manager_name) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, dept.getDeptName());
            stmt.setString(2, dept.getDeptCode());
            stmt.setString(3, dept.getLocation());
            stmt.setString(4, dept.getManagerName());
            
            int result = stmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error inserting department: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Retrieve all departments
     * @return List of all departments
     */
    public List<Department> getAllDepartments() {
        List<Department> departments = new ArrayList<>();
        String sql = "SELECT * FROM department ORDER BY dept_id DESC";
        
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Department dept = new Department();
                dept.setDeptId(rs.getInt("dept_id"));
                dept.setDeptName(rs.getString("dept_name"));
                dept.setDeptCode(rs.getString("dept_code"));
                dept.setLocation(rs.getString("location"));
                dept.setManagerName(rs.getString("manager_name"));
                departments.add(dept);
            }
            
        } catch (SQLException e) {
            System.err.println("Error retrieving departments: " + e.getMessage());
            e.printStackTrace();
        }
        
        return departments;
    }
    
    /**
     * Get department by ID
     * @param deptId Department ID
     * @return Department object or null if not found
     */
    public Department getDepartmentById(int deptId) {
        String sql = "SELECT * FROM department WHERE dept_id = ?";
        
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, deptId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Department dept = new Department();
                dept.setDeptId(rs.getInt("dept_id"));
                dept.setDeptName(rs.getString("dept_name"));
                dept.setDeptCode(rs.getString("dept_code"));
                dept.setLocation(rs.getString("location"));
                dept.setManagerName(rs.getString("manager_name"));
                return dept;
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting department by ID: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Update department information
     * @param dept Department object with updated information
     * @return true if successful, false otherwise
     */
    public boolean updateDepartment(Department dept) {
        String sql = "UPDATE department SET dept_name=?, dept_code=?, location=?, manager_name=? WHERE dept_id=?";
        
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, dept.getDeptName());
            stmt.setString(2, dept.getDeptCode());
            stmt.setString(3, dept.getLocation());
            stmt.setString(4, dept.getManagerName());
            stmt.setInt(5, dept.getDeptId());
            
            int result = stmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating department: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Delete department by ID
     * @param deptId Department ID to delete
     * @return true if successful, false otherwise
     */
    public boolean deleteDepartment(int deptId) {
        String sql = "DELETE FROM department WHERE dept_id = ?";
        
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, deptId);
            int result = stmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error deleting department: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}