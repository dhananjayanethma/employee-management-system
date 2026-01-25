package com.employee.dao;

import com.employee.model.Admin;
import com.employee.util.DBConnectionUtil;
import java.sql.*;

/**
 * Admin Data Access Object
 * Handles authentication and admin operations
 */
public class AdminDAO {
    
    /**
     * Validate admin login credentials
     * @param username Username
     * @param password Password
     * @return Admin object if valid, null otherwise
     */
    public Admin validateLogin(String username, String password) {
        String sql = "SELECT * FROM admin WHERE username = ? AND password = ?";
        
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            stmt.setString(2, password);
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Admin admin = new Admin();
                admin.setAdminId(rs.getInt("admin_id"));
                admin.setUsername(rs.getString("username"));
                admin.setEmail(rs.getString("email"));
                admin.setFullName(rs.getString("full_name"));
                return admin;
            }
            
        } catch (SQLException e) {
            System.err.println("Error validating login: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Get admin by username
     * @param username Username
     * @return Admin object or null
     */
    public Admin getAdminByUsername(String username) {
        String sql = "SELECT * FROM admin WHERE username = ?";
        
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Admin admin = new Admin();
                admin.setAdminId(rs.getInt("admin_id"));
                admin.setUsername(rs.getString("username"));
                admin.setEmail(rs.getString("email"));
                admin.setFullName(rs.getString("full_name"));
                return admin;
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting admin: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
}