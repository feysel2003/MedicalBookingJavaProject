package dao;

import model.Admin;
import java.sql.*;

public class AdminDAO {
    private Connection conn;

    public AdminDAO() {
        conn = DBConnection.getConnection(); // Make sure DBConnection works
    }
    
    
    

    public Admin login(String email, String password) {
        String sql = "SELECT * FROM admins WHERE email=? AND password=SHA2(?, 256)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Admin a = new Admin();
                a.setId(rs.getInt("id"));
                a.setEmail(rs.getString("email"));
                a.setPassword(rs.getString("password"));
                return a;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    
   public int getTotalCount(String tableName) {
    int count = 0;
    // Using a simple count query
    String sql = "SELECT COUNT(*) FROM " + tableName;
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        
        if (rs.next()) {
            count = rs.getInt(1);
        }
    } catch (SQLException e) {
        System.err.println("Error counting rows in " + tableName + ": " + e.getMessage());
    }
    return count;
}
   
   
  public boolean updateAdminPassword(int adminId, String newPassword) {
    // We use SHA2(?, 256) to match your login logic
    String sql = "UPDATE admins SET password = SHA2(?, 256) WHERE id = ?";
    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        
        ps.setString(1, newPassword);
        ps.setInt(2, adminId);
        
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
} 
  
  
  public boolean updateStatus(int id, String status) {
    String sql = "UPDATE appointments SET status = ? WHERE id = ?";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, status);
        ps.setInt(2, id);
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}
  
}
