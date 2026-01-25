package com.employee.model;

/**
 * Department Model Class
 * Represents a department entity with encapsulation
 */
public class Department {
    
    private int deptId;
    private String deptName;
    private String deptCode;
    private String location;
    private String managerName;
    
    // Default Constructor
    public Department() {
    }
    
    // Parameterized Constructor
    public Department(String deptName, String deptCode, String location, String managerName) {
        this.deptName = deptName;
        this.deptCode = deptCode;
        this.location = location;
        this.managerName = managerName;
    }
    
    // Getters and Setters
    public int getDeptId() {
        return deptId;
    }
    
    public void setDeptId(int deptId) {
        this.deptId = deptId;
    }
    
    public String getDeptName() {
        return deptName;
    }
    
    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }
    
    public String getDeptCode() {
        return deptCode;
    }
    
    public void setDeptCode(String deptCode) {
        this.deptCode = deptCode;
    }
    
    public String getLocation() {
        return location;
    }
    
    public void setLocation(String location) {
        this.location = location;
    }
    
    public String getManagerName() {
        return managerName;
    }
    
    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }
    
    @Override
    public String toString() {
        return "Department{" +
                "deptId=" + deptId +
                ", deptName='" + deptName + '\'' +
                ", deptCode='" + deptCode + '\'' +
                ", location='" + location + '\'' +
                ", managerName='" + managerName + '\'' +
                '}';
    }
}